From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: add a module parameter to ignore the SSS flags
 for async scanning
Date: Mon, 02 Feb 2009 22:42:49 -0500
Message-ID: <4987BD39.6090806@garzik.org>
References: <20090126162856.0720ce17@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34423 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312AbZBCDmy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 22:42:54 -0500
In-Reply-To: <20090126162856.0720ce17@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-ide@vger.kernel.org

Arjan van de Ven wrote:
>>From f1adba17389764dd6f2ff654d61e8c32dbedbbef Mon Sep 17 00:00:00 2001
> From: Arjan van de Ven <arjan@linux.intel.com>
> Date: Mon, 26 Jan 2009 02:05:44 -0800
> Subject: [PATCH] ahci: add a module parameter to ignore the SSS flags for async scanning
> 
> The SSS flag, which directs the OS to spin up one disk at a time
> to not have the PSU blow out, sometimes gets set even when not needed.
> The effect of this is a longer-than-needed boot time.
> 
> This patch adds a module parameter that makes the driver ignore SSS
> at least as far as the parallel scan during boot is concerned...
> 
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  drivers/ata/ahci.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 9603967..969c5e1 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -61,9 +61,14 @@
>  #define EM_MSG_LED_VALUE_ON           0x00010000
>  
>  static int ahci_skip_host_reset;
> +static int ahci_ignore_sss;
> +
>  module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
>  MODULE_PARM_DESC(skip_host_reset, "skip global host reset (0=don't skip, 1=skip)");
>  
> +module_param_named(ignore_sss, ahci_ignore_sss, int, 0444);
> +MODULE_PARM_DESC(ignore_sss, "Ignore staggered spinup flag (0=don't ignore, 1=ignore)");
> +
>  static int ahci_enable_alpm(struct ata_port *ap,
>  		enum link_pm policy);
>  static void ahci_disable_alpm(struct ata_port *ap);
> @@ -2660,8 +2665,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	host->iomap = pcim_iomap_table(pdev);
>  	host->private_data = hpriv;
>  
> -	if (!(hpriv->cap & HOST_CAP_SSS))
> +	if (!(hpriv->cap & HOST_CAP_SSS) || ahci_ignore_sss)
>  		host->flags |= ATA_HOST_PARALLEL_SCAN;
> +	else
> +		printk(KERN_INFO "ahci: SSS flag set, parallel bus scan disabled\n");
>  
>  	if (pi.flags & ATA_FLAG_EM)

applied


