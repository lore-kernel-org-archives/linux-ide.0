From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Tue, 21 Sep 2004 19:06:14 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040922020614.GA148273@sgi.com>
References: <8746466a04092114163b3c0618@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.20]:12682 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267683AbUIVCJJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Sep 2004 22:09:09 -0400
Content-Disposition: inline
In-Reply-To: <8746466a04092114163b3c0618@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Dave <dave.jiang@gmail.com>
Cc: jeremy.higdon@sgi.com, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Tue, Sep 21, 2004 at 02:16:46PM -0700, Dave wrote:
> Signed-off-by: Dave Jiang (dave.jiang@gmail.com)
> Patch attached, diffed against 2.6.8.1.
> 
> I was trying to get the Vitesse SATA driver running on XScale platform
> and encountered the problem during identify device where when
> vsc_intr_mask_update() was called the irq mask register never seem to
> change. It seems that on certain XScale platforms doing a writeb() to
> a 32bit register (instead of writel()) doesn't seem to do anything.  I
> updated the code to do writel() instead so that other platforms
> besides IA32 would work.

It actually does work already on IA64.
Why would a writeb not work?  All it does is set the appropriate byte
selects.  The platform doesn't care what the register size is, and the
target (PCI chip) seems to be able to figure it out, so there must be
something else wrong.

What is an XScale, btw?

> After getting that working I noticed that the last_ctl value gets
> changed back by the LIBATA core and the Vitesse SATA driver depends on
> the previous value in order to unmask the interrupt. So it seems that
> there's no need to set/unset the interrupt masks in the first place if
> we set the CTL register with ATA_NIEN directly, which I believe is
> probably the way LIBATA intended the driver to do. After doing that
> everything seems to be working great. So I suppose
> vsc_intr_mask_update() is no longer needed probably.

The chip specification says not to set it that way.  Are you using
the chip in DPA mode or PCI-IDE mode?  The driver assumes the former.  I
don't know why anyone would use the chip in PCI-IDE mode.

> I also added some code to enable the per port LEDs on the HBA during
> initialization. Perviously all activities goes to port 0 LED.
> 
> -- 
> -= Dave =-
> 
> Software Engineer - Advanced Development Engineering Team 
> Storage Component Division - Intel Corp. 
> ----
> The views expressed in this email are
> mine alone and do not necessarily 
> reflect the views of my employer
> (Intel Corp.).

> --- linux-2.6.8.1-iop3/drivers/scsi/sata_vsc.c	2004-08-14 03:55:33.000000000 -0700
> +++ dj_bktree-2.6.8.1/drivers/scsi/sata_vsc.c	2004-09-17 15:43:12.688212928 -0700
> @@ -80,6 +80,7 @@
>  
>  static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
>  {
> +#if 0
>  	unsigned long mask_addr;
>  	u8 mask;
>  
> @@ -91,6 +92,26 @@
>  	else
>  		mask &= 0x7F;
>  	writeb(mask, mask_addr);
> +#endif 
> +    u32 mask = 0;
> +    u32 regval; 
> +
> +    regval = readl(ap->host_set->mmio_base + VSC_SATA_INT_MASK_OFFSET);
> +    
> +
> +    mask = (0x80 << (8 * ap->port_no));
> +    
> +    if(ctl & ATA_NIEN)
> +    {
> +        mask = ~mask;
> +        mask = regval & mask;
> +    }
> +    else
> +    {
> +        mask = regval | mask;
> +    }
> +
> +    writel(mask, ap->host_set->mmio_base + VSC_SATA_INT_MASK_OFFSET);
>  }
>  
>  
> @@ -105,8 +126,10 @@
>  	 * However, if ATA_NIEN is changed, then we need to change the interrupt register.
>  	 */
>  	if ((tf->ctl & ATA_NIEN) != (ap->last_ctl & ATA_NIEN)) {
> +        writeb(tf->ctl, ioaddr->ctl_addr);
>  		ap->last_ctl = tf->ctl;
> -		vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
> +        ata_wait_idle(ap);
> +//      vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
>  	}
>  	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
>  		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
> @@ -330,6 +353,19 @@
>  
>  	pci_set_master(pdev);
>  
> +    /* set per port LEDs */
> +    {
> +        unsigned long mask; 
> +        unsigned int regval;
> +
> +        set_bit(28, &mask);
> +        mask = ~mask;
> +        
> +        pci_read_config_dword(pdev, 0x98, &regval);
> +        regval = regval & mask;
> +        pci_write_config_dword(pdev, 0x98, regval);
> +    }
> +

That's a somewhat wordy way of doing it.  You could just do:

	pci_read_config_dword(pdev, 0x98, &regval);
	regval = regval & ~(1 << 28)
	pci_write_config_dword(pdev, 0x98, regval);

and since the driver is DPA only, we can just do:

	pci_write_config_dword(pdev, 0x98, 0);

If anyone ever adds PCI-IDE support, then we're probably before
the point that we're trying to select channel 0/1, so I think that's
still safe.

>  	/* FIXME: check ata_device_add return value */
>  	ata_device_add(probe_ent);
>  	kfree(probe_ent);

Also, jgarzik is the maintainer of this driver.  I'll cc him.

jeremy
