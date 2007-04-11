From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 08/12] libata: convert drivers with combined SATA/PATA ports to new init model
Date: Wed, 11 Apr 2007 10:58:05 +0200 (MEST)
Message-ID: <200704110858.l3B8w5As003102@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38123 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517AbXDKI6Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Apr 2007 04:58:25 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk, brking@linux.vnet.ibm.com, htejun@gmail.com, jeff@garzik.org, linux-ide@vger.kernel.org

On Wed, 11 Apr 2007 15:42:05 +0900, Tejun Heo wrote:
...
> diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
> index baa8368..8e8fe59 100644
> --- a/drivers/ata/sata_promise.c
> +++ b/drivers/ata/sata_promise.c
...
> @@ -333,7 +349,7 @@ static struct pci_driver pdc_ata_pci_driver = {
>  };
>  
>  
> -static int pdc_common_port_start(struct ata_port *ap)
> +static int pdc_pata_port_start(struct ata_port *ap)
>  {
>  	struct device *dev = ap->host->dev;
>  	struct pdc_port_priv *pp;
> @@ -358,15 +374,14 @@ static int pdc_common_port_start(struct ata_port *ap)
>  
>  static int pdc_sata_port_start(struct ata_port *ap)
>  {
> -	struct pdc_host_priv *hp = ap->host->private_data;
>  	int rc;
>  
> -	rc = pdc_common_port_start(ap);
> +	rc = pdc_pata_port_start(ap);

NAK this rename. It's conceptually wrong to unconditionally
invoke a PATA operation from a SATA operation. The old name
made it clear that that operation was common for all types
of ports.

The rest looks good, but I'll have to take a closer look
to verify the details.

/Mikael
