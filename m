From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Tue, 3 Apr 2012 20:08:00 +0000
Message-ID: <201204032008.00509.arnd@arndb.de>
References: <4F7B0C54.8010804@metasoft.pl> <4F7B0CEF.2040307@metasoft.pl> <ADE657CA350FB648AAC2C43247A983F0020698409E29@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61788 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab2DCUIQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Apr 2012 16:08:16 -0400
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698409E29@AUSP01VMBX24.collaborationhost.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Rafal Prylowski <prylowski@metasoft.pl>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>, "rmallon@gmail.com" <rmallon@gmail.com>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>

On Tuesday 03 April 2012, H Hartley Sweeten wrote:
> On Tuesday, April 03, 2012 7:45 AM, Rafal Prylowski wrote:
> > +
> > +     /* UDMA Debug Status Register */
> > +     IDEUDMADEBUG                    = 0x2c,
> > +};
> 
> I prefer defines for these. But, the enum usage seems common in the ata drivers
> so...

I like the enum ;-)

> > +
> > +static int ep93xx_pata_check_iordy(void __iomem *base)
> > +{
> > +     return !!(readl(base + IDECTRL) & IDECTRL_IORDY);
> > +}

This one could return a bool.

> > +static void ep93xx_pata_wait_for_iordy(void __iomem *base)
> > +{
> > +     unsigned long deadline = jiffies + msecs_to_jiffies(1000);
> > +     while (!ep93xx_pata_check_iordy(base) &&
> > +             time_is_before_jiffies(deadline))
> > +             cpu_relax();
> > +}

Much better for a delay than the previous version. However, it's
still a busy wait, which is bad for realtime behavior, especially
since this can potentially take many milliseconds. If possible,
it should have an msleep() or at least cond_resched() instead of
the cpu_relax(). Obviously that will only work when no spinlocks
are held.

> > +     if (is_addr) {
> > +             ep93xx_pata_write(drv_data, tf->feature,
> > +                     IDECTRL_ADDR_FEATURE, t);
> > +             ep93xx_pata_write(drv_data, tf->nsect, IDECTRL_ADDR_NSECT, t);
> > +             ep93xx_pata_write(drv_data, tf->lbal, IDECTRL_ADDR_LBAL, t);
> > +             ep93xx_pata_write(drv_data, tf->lbam, IDECTRL_ADDR_LBAM, t);
> > +             ep93xx_pata_write(drv_data, tf->lbah, IDECTRL_ADDR_LBAH, t);
> > +             VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
> > +                     tf->feature, tf->nsect, tf->lbal, tf->lbam, tf->lbah);
> > +     }
> > +
> > +     if (tf->flags & ATA_TFLAG_DEVICE) {
> > +             ep93xx_pata_write(drv_data, tf->device, IDECTRL_ADDR_DEVICE, t);
> > +             VPRINTK("device 0x%X\n", tf->device);
> > +     }

Although VPRINTK is used in other ATA drivers, I would not recommend it
in new drivers. Instead, I suggest you use dev_err() and similar helpers
that are not specific to one subsystem.

> > +/* Note: original code is ata_sff_data_xfer */
> > +unsigned int ep93xx_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
> > +                                unsigned int buflen, int rw)

This should be a static function. A device driver with just a single file should 
not need any non-static symbols. Same thing for ep93xx_pata_drain_fifo and
possibly a few others.

> > +static int __devinit ep93xx_pata_probe(struct platform_device *pdev)
> > +{
> > +     struct ep93xx_pata_data *drv_data;
> > +     struct ata_host *host;
> > +     struct ata_port *ap;
> > +     unsigned int irq;
> > +     struct resource *mem_res;
> > +     void __iomem *ide_base;
> > +     int err;
> > +
> > +     err = ep93xx_ide_acquire_gpio(pdev);
> > +     if (err)
> > +             return err;

Calling into platform code like this is going to make the transition to
device tree harder. I would suggest moving the code from patch 2 here,
and subsequently putting the gpio lines into device tree properties.
when the driver gets converted.

> > @@ -43,6 +43,7 @@ obj-$(CONFIG_PATA_CS5535)   += pata_cs5535
> >  obj-$(CONFIG_PATA_CS5536)    += pata_cs5536.o
> >  obj-$(CONFIG_PATA_CYPRESS)   += pata_cypress.o
> >  obj-$(CONFIG_PATA_EFAR)              += pata_efar.o
> > +obj-$(CONFIG_PATA_EP93XX)    += pata_ep93xx.o
> >  obj-$(CONFIG_PATA_HPT366)    += pata_hpt366.o
> >  obj-$(CONFIG_PATA_HPT37X)    += pata_hpt37x.o
> >  obj-$(CONFIG_PATA_HPT3X2N)   += pata_hpt3x2n.o
> 
> Overall, this looks pretty good. I'll try to examine it more closely later.

I agree. The driver is ok on the whole, my comments are largely nitpicking.

	Arnd
