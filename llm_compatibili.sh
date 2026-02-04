#!/bin/bash

echo "=== Verificação de Compatibilidade para LLMs ==="
echo ""

# RAM
echo "📊 MEMÓRIA RAM:"
total_ram=$(grep MemTotal /proc/meminfo | awk '{print int($2/1024)}')
available_ram=$(grep MemAvailable /proc/meminfo | awk '{print int($2/1024)}')
echo "  Total: ${total_ram}MB"
echo "  Disponível: ${available_ram}MB"
echo ""

# CPU
echo "💻 PROCESSADOR:"
cpu_model=$(grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)
cpu_cores=$(nproc)
echo "  Modelo: ${cpu_model}"
echo "  Cores: ${cpu_cores}"
echo ""

# GPU
echo "🎮 GPU:"
if lspci | grep -i nvidia &>/dev/null; then
    gpu_info=$(lspci | grep -i nvidia | head -1)
    echo "  NVIDIA detectada: ${gpu_info}"
    if command -v nvidia-smi &>/dev/null; then
        echo "  CUDA disponível: SIM"
        nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits 2>/dev/null | head -1 | xargs -I {} echo "  VRAM: {}MB"
    else
        echo "  CUDA disponível: NÃO (nvidia-smi não encontrado)"
    fi
else
    echo "  GPU NVIDIA: Não detectada"
fi
echo ""

# Disco
echo "💾 ESPAÇO EM DISCO:"
disk_available=$(df -h / | awk 'NR==2 {print $4}')
echo "  Disponível em /: ${disk_available}"
echo ""

# Análise de compatibilidade
echo "=== ANÁLISE DE COMPATIBILIDADE ==="
echo ""

# Phi-3 Mini (3.8B)
echo "✅ Phi-3 Mini (3.8B):"
if [ $total_ram -ge 4096 ]; then
    echo "   ✓ RAM suficiente (requer 4-8GB)"
else
    echo "   ✗ RAM insuficiente (requer mínimo 4GB)"
fi
echo ""

# Llama 3 8B
echo "✅ Llama 3 8B:"
if [ $total_ram -ge 8192 ]; then
    echo "   ✓ RAM suficiente (requer 8-16GB)"
elif [ $total_ram -ge 6144 ]; then
    echo "   ⚠ RAM no limite (8GB recomendado, você tem ~6GB)"
else
    echo "   ✗ RAM insuficiente (requer mínimo 8GB)"
fi
echo ""

# Llama 3 70B
echo "✅ Llama 3 70B:"
if [ $total_ram -ge 40960 ]; then
    echo "   ✓ RAM suficiente (requer 40GB+)"
else
    echo "   ✗ RAM insuficiente (requer mínimo 40GB)"
fi
echo ""

# Recomendações
echo "=== RECOMENDAÇÕES ==="
echo ""

if [ $total_ram -ge 8192 ]; then
    echo "✓ Seu sistema pode rodar Llama 3 8B e Phi-3"
    echo "✓ Recomendação: Use Ollama ou llama.cpp"
elif [ $total_ram -ge 4096 ]; then
    echo "✓ Seu sistema pode rodar Phi-3 Mini"
    echo "⚠ Llama 3 8B pode ficar lento"
    echo "✓ Recomendação: Comece com Phi-3 Mini"
else
    echo "✗ RAM insuficiente para modelos completos"
    echo "ℹ Considere usar modelos quantizados menores"
fi

if lspci | grep -i nvidia &>/dev/null; then
    echo "✓ GPU NVIDIA detectada - performance será melhor"
else
    echo "ℹ Sem GPU NVIDIA - modelos rodarão apenas em CPU (mais lento)"
fi

echo ""
echo "=== COMANDOS SUGERIDOS PARA INSTALAÇÃO ==="
echo ""
echo "# Instalar Ollama (mais fácil):"
echo "curl -fsSL https://ollama.com/install.sh | sh"
echo ""
echo "# Rodar Phi-3:"
echo "ollama run phi3"
echo ""
echo "# Rodar Llama 3 8B:"
echo "ollama run llama3"
echo ""
