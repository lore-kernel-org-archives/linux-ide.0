From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: implement ATA_FLAG_IGN_SIMPLEX and use it in
 sata_uli
Date: Thu, 25 Jan 2007 17:26:37 -0500
Message-ID: <45B92E9D.9010507@pobox.com>
References: <20070116055551.GN10987@htj.dyndns.org> <20070125104005.GB8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40579 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030638AbXAYW0j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Jan 2007 17:26:39 -0500
In-Reply-To: <20070125104005.GB8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Some uli controllers have stuck SIMPLEX bit which can't be cleared
> with ata_pci_clear_simplex(), but the controller is capable of doing
> DMAs on both channels simultaneously.  Implement ATA_FLAG_IGN_SIMPLEX
> which makes libata ignore the simplex bit and use it in sata_uli.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, implemented as ATA_FLAG_* as requested.  The patch is against
> #upstream-fixes and should probably included in 2.6.20.  Thanks.
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 623cec9..71e6ddd 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -870,7 +870,8 @@ ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int
>  			pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
>  		bmdma = pci_resource_start(pdev, 4);
>  		if (bmdma) {
> -			if (inb(bmdma + 2) & 0x80)
> +			if (!(port[p]->flags & ATA_FLAG_IGN_SIMPLEX) &&
> +			    inb(bmdma + 2) & 0x80)
>  				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
>  			probe_ent->port[p].bmdma_addr = bmdma;
>  		}
> @@ -886,7 +887,8 @@ ata_pci_init_native_mode(struct pci_dev *pdev, struct ata_port_info **port, int
>  		bmdma = pci_resource_start(pdev, 4);
>  		if (bmdma) {
>  			bmdma += 8;
> -			if(inb(bmdma + 2) & 0x80)
> +			if (!(port[p]->flags & ATA_FLAG_IGN_SIMPLEX) &&
> +			    inb(bmdma + 2) & 0x80)
>  				probe_ent->_host_flags |= ATA_HOST_SIMPLEX;
>  			probe_ent->port[p].bmdma_addr = bmdma;
>  		}

applied to #upstream-fixes, after adding some additional parens for 
readability


