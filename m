From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc5] ahci: fix PORTS_IMPL override
Date: Wed, 20 Jun 2007 19:57:16 -0400
Message-ID: <4679BEDC.7060404@garzik.org>
References: <20070619095256.GQ29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45901 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757594AbXFTX5S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jun 2007 19:57:18 -0400
In-Reply-To: <20070619095256.GQ29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> If PORTS_IMPL register is zero, ahci initialize it to full mask
> corresponding to nr_ports in the CAP register.  hpriv->cap, which is
> initialized at the end of the function, is incorrectly used as value
> of CAP causing ahci to always override PORTS_IMPL to 0x1 if it's zero.
> Fix it.
> 
> This fixes a bug where early ich6 ahci can only access the first port.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 545f330..ca5229d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -527,7 +527,7 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
>  
>  	/* fixup zero port_map */
>  	if (!port_map) {
> -		port_map = (1 << ahci_nr_ports(hpriv->cap)) - 1;
> +		port_map = (1 << ahci_nr_ports(cap)) - 1;
>  		dev_printk(KERN_WARNING, &pdev->dev,

good catch, applied


