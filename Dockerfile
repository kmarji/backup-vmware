FROM mcr.microsoft.com/powershell:latest

ARG server

ARG username

ARG password

RUN pwsh -c 'Set-PSRepository -Name PSGallery -InstallationPolicy Trusted'

RUN pwsh -c 'install-Module VMware.PowerCLI -Scope CurrentUser'

RUN pwsh -c 'Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false -confirm:$false'

RUN pwsh -c 'Set-PowerCLIConfiguration -InvalidCertificateAction ignore -confirm:$false'

COPY backup-script.ps1 backup-script.ps1

CMD pwsh -c ./backup-script.ps1

