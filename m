From: Dave <dave.jiang@gmail.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Wed, 22 Sep 2004 08:59:06 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <8746466a0409220859ed0682f@mail.gmail.com>
References: <8746466a04092114163b3c0618@mail.gmail.com>
	 <20040922020614.GA148273@sgi.com>
Reply-To: Dave <dave.jiang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.202]:13658 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266183AbUIVP7K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Sep 2004 11:59:10 -0400
Received: by mproxy.gmail.com with SMTP id 73so1675334rnk
        for <linux-ide@vger.kernel.org>; Wed, 22 Sep 2004 08:59:06 -0700 (PDT)
In-Reply-To: <20040922020614.GA148273@sgi.com>
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Tue, 21 Sep 2004 19:06:14 -0700, Jeremy Higdon <jeremy@sgi.com> wrote:
> On Tue, Sep 21, 2004 at 02:16:46PM -0700, Dave wrote:
> > Signed-off-by: Dave Jiang (dave.jiang@gmail.com )
> > Patch attached, diffed against 2.6.8.1 .
> >
> > I was trying to get the Vitesse SATA driver running on XScale platform
> > and encountered the problem during identify device where when
> > vsc_intr_mask_update() was called the irq mask register never seem to
> > change. It seems that on certain XScale platforms doing a writeb() to
> > a 32bit register (instead of writel()) doesn't seem to do anything.  I
> > updated the code to do writel() instead so that other platforms
> > besides IA32 would work.
> 
> It actually does work already on IA64.
> Why would a writeb not work?  All it does is set the appropriate byte
> selects.  The platform doesn't care what the register size is, and the
> target (PCI chip) seems to be able to figure it out, so there must be
> something else wrong.
> 
> What is an XScale, btw?

XScale is a CPU branched off from the ARM family by Intel. Mostly you
will see them in PDAs. However, there are other XScale platforms that
are used as network processors or I/O processors.  I probably need to
do some PCI-X sniffing but all I know currently is that after the
writeb the mask register remains unchanged. However if I do a writel
it changes. So currently if I load the driver as it is, I get
infinitely interrupt calls because the irq isn't masked and the irq
handler doesn't know what to do with the interrupt. Since this isn't
really a fast path routine anyhow, wouldn't it be better to make all
platforms happy?
 
> > After getting that working I noticed that the last_ctl value gets
> > changed back by the LIBATA core and the Vitesse SATA driver depends on
> > the previous value in order to unmask the interrupt. So it seems that
> > there's no need to set/unset the interrupt masks in the first place if
> > we set the CTL register with ATA_NIEN directly, which I believe is
> > probably the way LIBATA intended the driver to do. After doing that
> > everything seems to be working great. So I suppose
> > vsc_intr_mask_update() is no longer needed probably.
> 
> The chip specification says not to set it that way.  Are you using
> the chip in DPA mode or PCI-IDE mode?  The driver assumes the former.  I
> don't know why anyone would use the chip in PCI-IDE mode.

Hmmm...I did not see it in the spec. Can you provide the pointer to
the spec please? Thanks! I am using it in DPA mode. If you are in
PCI-IDE mode, all registers would reside in different BARs and the
card wouldn't work anyways with that driver. I copied the section from
sata_svw.c. And it seems to work just fine. I don't see how the
previous method would be working. In vsc_sata_tf_load a compare is
done between the tf->ctl and the ap->last_ctl. However, if I do it
with the current method, I continue to see ap->last_ctl with ATA_NIEN
cleared even though the previous value was set. Therefore the driver
never unmask the IDE interrupt and thus hang.  What happened was, host
1, dev 0 was probed and was okay. Then it attempted to probe host 1,
dev 1, which of course does not exist, so at exit, ata_irq_on() was
called. With that the last_ctl was reset with ATA_NIEN cleared.
Therefore when the driver does the compare of ctl with last_ctl, it
sees no difference, and therefore interrupt mask never changed.
 
> 
> > --- linux-2.6.8.1-iop3/drivers/scsi/sata_vsc.c        2004-08-14 03:55:33.000000000 -0700
> > +++ dj_bktree-2.6.8.1/drivers/scsi/sata_vsc.c 2004-09-17 15:43:12.688212928 -0700
> > @@ -80,6 +80,7 @@
> >
> >  static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
> >  {
> > +#if 0
> >       unsigned long mask_addr;
> >       u8 mask;
> >
> > @@ -91,6 +92,26 @@
> >       else
> >               mask &= 0x7F;
> >       writeb(mask, mask_addr);
> > +#endif
> > +    u32 mask = 0;
> > +    u32 regval;
> > +
> > +    regval = readl(ap->host_set->mmio_base + VSC_SATA_INT_MASK_OFFSET);
> > +
> > +
> > +    mask = (0x80 << (8 * ap->port_no));
> > +
> > +    if(ctl & ATA_NIEN)
> > +    {
> > +        mask = ~mask;
> > +        mask = regval & mask;
> > +    }
> > +    else
> > +    {
> > +        mask = regval | mask;
> > +    }
> > +
> > +    writel(mask, ap->host_set->mmio_base + VSC_SATA_INT_MASK_OFFSET);
> >  }
> >
> >
> > @@ -105,8 +126,10 @@
> >        * However, if ATA_NIEN is changed, then we need to change the interrupt register.
> >        */
> >       if ((tf->ctl & ATA_NIEN) != (ap->last_ctl & ATA_NIEN)) {
> > +        writeb(tf->ctl, ioaddr->ctl_addr);
> >               ap->last_ctl = tf->ctl;
> > -             vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
> > +        ata_wait_idle(ap);
> > +//      vsc_intr_mask_update(ap, tf->ctl & ATA_NIEN);
> >       }
> >       if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> >               writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
> > @@ -330,6 +353,19 @@
> >
> >       pci_set_master(pdev);
> >
> > +    /* set per port LEDs */
> > +    {
> > +        unsigned long mask;
> > +        unsigned int regval;
> > +
> > +        set_bit(28, &mask);
> > +        mask = ~mask;
> > +
> > +        pci_read_config_dword(pdev, 0x98, &regval);
> > +        regval = regval & mask;
> > +        pci_write_config_dword(pdev, 0x98, regval);
> > +    }
> > +
> 
> That's a somewhat wordy way of doing it.  You could just do:
> 
>         pci_read_config_dword(pdev, 0x98, &regval);
>         regval = regval & ~(1 << 28)
>         pci_write_config_dword(pdev, 0x98, regval);
> 
> and since the driver is DPA only, we can just do:
> 
>         pci_write_config_dword(pdev, 0x98, 0);
> 
> If anyone ever adds PCI-IDE support, then we're probably before
> the point that we're trying to select channel 0/1, so I think that's
> still safe.
> 
> >       /* FIXME: check ata_device_add return value */
> >       ata_device_add(probe_ent);
> >       kfree(probe_ent);
> 
> Also, jgarzik is the maintainer of this driver.  I'll cc him.
> 
> jeremy
>
