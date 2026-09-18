# Infraestructura-Assessment
Repositorio versionable para la infraestrutura que se pide crear en el assessmet enviado el 16-09-2026

Filtro de rutas (paths): Solo se disparará si hay cambios dentro de la carpeta terraform/.

El pipeline está modularizado mediante plantillas reutilizables ubicadas en la carpeta templates/:

terraform-init.yml: Inicializa el directorio de trabajo, descarga los proveedores necesarios y configura el backend remoto de Terraform.
terraform-plan.yml: Ejecuta el plan de cambios para previsualizar los recursos que se van a crear, modificar o destruir en Azure.
terraform-apply.yml: Aplica los cambios aprobados en el plan para desplegar la infraestructura real.
terraform-destroy.yml: Plantilla disponible para destruir la infraestructura en caso de ser necesario.

Prerrequisitos y Configuración

Para que este pipeline funcione correctamente, se debe tener en Azure DevOps:

Variables Group, El pipeline consume un grupo de variables llamado:
vg-aks-liq: Debe contener las credenciales necesarias que se utilizan y se pasan como variables en las diferentes etapas del pipeline, desde Service Connection hasta environments (Para aprobación de ejecución de Deployments Jobs)

En el directorio terraform están los diferentes recursos a crear, incluyendo el backend que utiliza un stroge account en Azure. Se utiliza autenticación Workload Identity federation para evitar tener secretos que caduquen.

Este repositorio y el pipeline permiten crear desde el Grupo de Recursos hasta el ingress_nginx, que es la infraestructura donde se desplegarán los contenedores con la imagen construída que será tomada desde el ACR.

