## Resultado de analise do meu laotop

```
=== Verificação de Compatibilidade para LLMs ===

📊 MEMÓRIA RAM:
  Total: 7520MB
  Disponível: 3113MB

💻 PROCESSADOR:
  Modelo: Intel(R) Pentium(R) CPU B960 @ 2.20GHz
  Cores: 2

🎮 GPU:
  GPU NVIDIA: Não detectada

💾 ESPAÇO EM DISCO:
  Disponível em /: 76G

=== ANÁLISE DE COMPATIBILIDADE ===

✅ Phi-3 Mini (3.8B):
   ✓ RAM suficiente (requer 4-8GB)

✅ Llama 3 8B:
   ⚠ RAM no limite (8GB recomendado, você tem ~6GB)

✅ Llama 3 70B:
   ✗ RAM insuficiente (requer mínimo 40GB)

=== RECOMENDAÇÕES ===

✓ Seu sistema pode rodar Phi-3 Mini
⚠ Llama 3 8B pode ficar lento
✓ Recomendação: Comece com Phi-3 Mini
ℹ Sem GPU NVIDIA - modelos rodarão apenas em CPU (mais lento)

=== COMANDOS SUGERIDOS PARA INSTALAÇÃO ===

# Instalar Ollama (mais fácil):
curl -fsSL https://ollama.com/install.sh | sh

# Rodar Phi-3:
ollama run phi3

# Rodar Llama 3 8B:
ollama run llama3


```
