From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] libata: Fix NULL pointer of scsi_host in ata_port
Date: Wed, 23 Jul 2014 10:37:35 +0800
Message-ID: <53CF1FEF.7050704@linux.vnet.ibm.com>
References: <1406040688-1762-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406040688-1762-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, tj@kernel.org, haokexin@gmail.com
List-Id: linux-ide@vger.kernel.org

On 07/22/2014 10:51 PM, Mike Qiu wrote:
> In ata_sas_port_alloc(), it haven't initialized scsi_host field in
> ata_port, although scsi_host is in parameters list and unused in this
> function.
>
> With commit 1871ee134b73 ("libata: support the ata host which implements a queue depth less than 32")
> ata_qc_new() try to use scsi_host, while it
> is a NULL pointer for ipr IOA and error message shows below:
...
>
> While scsi_host is unused in ata_sas_port_alloc(), better to set it
> in ata_sas_port_alloc() instead of in driver.
>
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>   drivers/ata/libata-scsi.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 0586f66..a472b6f 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4070,6 +4070,7 @@ struct ata_port *ata_sas_port_alloc(struct ata_host *host,
>   	ap->flags |= port_info->flags;
>   	ap->ops = port_info->port_ops;
>   	ap->cbl = ATA_CBL_SATA;
> +	ap->scsi_host = shost;

What about my patch itself, ata_sas_port_alloc() has "shot" in 
parameters list, but unused.

Maybe better to set ap->scsi_host here, it is very convenient, and 
drivers, like ipr, may forget to set this field, otherwise "shot" need 
to be removed from parameters list I think.

Thanks,
Mike
>   	return ap;
>   }
