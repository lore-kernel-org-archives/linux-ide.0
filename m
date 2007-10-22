From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: BUG: sata_nv swncq cannot be disabled
Date: Sun, 21 Oct 2007 19:34:11 -0700
Message-ID: <471C0C23.5080806@vc.cvut.cz>
References: <200710220406.23790.gd@spherenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:47989 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbXJVDDa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Oct 2007 23:03:30 -0400
In-Reply-To: <200710220406.23790.gd@spherenet.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Gerhard Dirschl <gd@spherenet.de>

Gerhard Dirschl wrote:
> Hi,
> 
> I stumbled over a bug in the sata_nv swncq code of the current
> 2.6.23-git kernel. ata_port_info.flags is always initialised with the
> ATA_FLAG_NCQ flag set, but nv_swncq_host_init(...) is only called
> if "swncq=1" is passed to the driver (default is swncq=0).
> I can can observe ata link resets under high load if I don't pass
> sata_nv.swncq=1 to my kernel.

Seeing this, are there any guarantees about SWNCQ and MSI compatibility? 
  I have sata_nv patched to use MSI, and since SWNCQ patch arrived to 
the kernel (and I've enabled it to work around Gerhard's problem) my 
root filesystem remounts read-only or disk completely disappears every 
now and then :-(

> --- linux-2.6/drivers/ata/sata_nv.c	2007-10-22 00:07:40.000000000 +0200
> +++ linux-2.4.24/drivers/ata/sata_nv.c	2007-10-22 03:40:06.132619662 +0200
> @@ -1878,6 +1884,9 @@ static void nv_swncq_host_init(struct at
>  	VPRINTK("HOST_CTL:0x%X\n", tmp);
>  	writel(tmp | NV_CTL_PRI_SWNCQ | NV_CTL_SEC_SWNCQ, mmio + NV_CTL_MCP55);
>  
> +	for (i = 0; i < host->n_ports; i++)
> +		host->ports[i]->flags |= ATA_FLAG_NCQ;
> +
>  	/* enable irq intr */
>  	tmp = readl(mmio + NV_INT_ENABLE_MCP55);
>  	VPRINTK("HOST_ENABLE:0x%X\n", tmp);

I believe that ATA_FLAG_NCQ should be set before call to 
ata_pci_prepare_sff_host so you do not play with flags after host was 
created.  I cannot find any other reason...
							Petr

