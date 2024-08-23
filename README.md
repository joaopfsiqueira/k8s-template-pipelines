# k8s-template-pipelines

Este é um modelo de implantação baseado em AWS ECR e K8S via Bitbucket Pipelines.

## Funcionamento geral

As variáveis de repositório abaixo não precisam ser definidas, isso se deve ao fato de que serão automaticamente herdadas da configuração global Workspace variables:

  * *DOCKER_ECR_REPO_URL*
  * *AWS_DEFAULT_REGION*
  * *AWS_ACCESS_KEY_ID*
  * *AWS_SECRET_ACCESS_KEY*

> Todas as imagens Docker (production e stage) são enviadas para o mesmo Elastic Container Registry (ECR) da conta Techworks, ou seja, essas credenciais são gerenciadas globalmente.

### Build e deploy

Qualquer commit realizado nas branchs **main**, **master** ou **stage** irá disparar o processo de build e deploy da respectiva branch

### Repositório no ECR

A pipeline `custom: create-ecr-repository` está configurada como ação manual, quando disparada ela irá:

  * Criar um repositório no ECR (nome do repositório=$BITBUCKET_REPO_SLUG) caso ainda não exista
  * Configurar as permissões do repositório
    * Aplicar um lifecycle para as imagens:
      * master: mantém as 10 últimas
      * stage: mantém as 2 últimas

### Recomendações

De modo a manter a organização e facilitar o entendimento, é sugerido que as variáveis de ambiente e de repositório sejam prefixadas (prefixo = nome do serviço onde será utilizada). Ex:

  * Repository variables:
    * K8S_NAMESPACE
    * K8S_NODEGROUP_SUFFIX
  * Production:
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
    * K8S_APP_URL
    * K8S_NUMBER_OF_REPLICAS
    * K8S_REQUESTS_CPU
    * K8S_REQUESTS_MEMORY
    * K8S_LIMITS_CPU
    * K8S_LIMITS_MEMORY
  * Staging:
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
    * K8S_APP_URL
    * K8S_NUMBER_OF_REPLICAS
    * K8S_REQUESTS_CPU
    * K8S_REQUESTS_MEMORY
    * K8S_LIMITS_CPU
    * K8S_LIMITS_MEMORY

> **Dica**: se por exemplo a variável `K8S_APP_URL` não for utilizada exclusivamente dentro de arquivos do K8S, a semântica pode ser melhor ao considerar `APP_URL`.

Caso não queira preencher variável por variável na UI do Bitbucket, considere utilizar o script: [Bacalhau](https://bitbucket.org/adminpontal/bacalhau/src/master/bitbucket/create_variables/README.md).

## Considerações

Este é somente uma sugestão de template de deploy, deste modo, sua estrutura deve mudar conforme necessidade.
