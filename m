From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Tue, 8 May 2007 19:35:01 +1000 (EST)
Message-ID: <41255.7661.qm@web52612.mail.re2.yahoo.com>
References: <46403732.3000507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52612.mail.re2.yahoo.com ([206.190.48.215]:43913 "HELO
	web52612.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934614AbXEHJfE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 05:35:04 -0400
In-Reply-To: <46403732.3000507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

--- Tejun Heo <htejun@gmail.com> wrote:
> Hello,

Hello,

> It just seems sb600 claims that it can do DMA above 4G while it actually
> can't.  Can you test the attached patch?

Makes sense now. Gladly check the patch. Checking ...

Great news: everything just works without any parameters :-)). True genious.

With your patch, with 4 GB of RAM, all SATA drives are detected & working
normally. For the record dmesg is attached.

There's always a catch isn't it? Now no DMA over 32 bit memory space for SATA,
right? CPU will have to work harder, I presume. Perhaps putting more pressure.
While with 4 GB that might not be a problem, perhaps when I upgrade it to over
4 GB, it might be?? I see, even now, because a chunk of 512 MB is mapped over
4 GB (starting at 0x100000000), those are no good for the SATA's DMA access.
If so, too sad :-(.

> Thanks.

Thank you.

(I'll leave the patch for the poor souls stumble upon these emails some far
future :-))

PS: if this turns out to a hardware limitation, then perhaps may I request
this patch in better form (as not to impact on other ahci users) find its way
to mainstream? Even to -stable if I'm lucky, such that Fedora 7 etc. might
work out of the box for poor souls (not counting me; I'm used to quirky
things) trying out Linux on this chipset.

> -- 
> tejun
> > ---
>  drivers/ata/ahci.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Index: tree0/drivers/ata/ahci.c
> ===================================================================
> --- tree0.orig/drivers/ata/ahci.c
> +++ tree0/drivers/ata/ahci.c
> @@ -170,6 +170,7 @@ enum {
>  	AHCI_FLAG_IGN_IRQ_IF_ERR	= (1 << 25), /* ignore IRQ_IF_ERR */
>  	AHCI_FLAG_HONOR_PI		= (1 << 26), /* honor PORTS_IMPL */
>  	AHCI_FLAG_IGN_SERR_INTERNAL	= (1 << 27), /* ignore SERR_INTERNAL */
> +	AHCI_FLAG_32BIT_ONLY		= (1 << 28), /* force 32bit */
>  };
>  
>  struct ahci_cmd_hdr {
> @@ -370,7 +371,8 @@ static const struct ata_port_info ahci_p
>  		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>  				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
>  				  ATA_FLAG_SKIP_D2H_BSY |
> -				  AHCI_FLAG_IGN_SERR_INTERNAL,
> +				  AHCI_FLAG_IGN_SERR_INTERNAL |
> +				  AHCI_FLAG_32BIT_ONLY,
>  		.pio_mask	= 0x1f, /* pio0-4 */
>  		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
>  		.port_ops	= &ahci_ops,
> @@ -1579,6 +1581,12 @@ static int ahci_host_init(struct ata_pro
>  		probe_ent->n_ports = cap_n_ports;
>  
>  	using_dac = hpriv->cap & HOST_CAP_64;
> +	if (using_dac && (probe_ent->port_flags & AHCI_FLAG_32BIT_ONLY)) {
> +		dev_printk(KERN_INFO, &pdev->dev,
> +			   "controller can't do 64bit DMA, forcing 32bit\n");
> +		using_dac = 0;
> +	}
> +
>  	if (using_dac &&
>  	    !pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
>  		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
> 


Send instant messages to your online friends http://au.messenger.yahoo.com 
