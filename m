From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: H8/300 target support patch
Date: Mon, 16 Feb 2004 17:40:08 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402161740.08383.bzolnier@elka.pw.edu.pl>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp> <200402151540.56377.bzolnier@elka.pw.edu.pl> <m265e7dn02.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25219 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265652AbUBPQfK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2004 11:35:10 -0500
In-Reply-To: <m265e7dn02.wl%ysato@users.sourceforge.jp>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-ide@vger.kernel.org

On Monday 16 of February 2004 17:09, Yoshinori Sato wrote:
> > +static void _outsw(unsigned long addr, void *buf, u32 len)
> > +{
> > +	unsigned volatile short *ap = (unsigned volatile short *)addr;
> > +	unsigned short *bp = (unsigned short *)buf;
> > +	unsigned short d;
> > +	while(len--) {
> > +		d = *bp++;
> > +		*ap = (d << 8) | (d >> 8);
> > +	}
> > +}
> > +
> > +static void _insw(unsigned long addr, void *buf, u32 len)
> > +{
> > +	unsigned volatile short *ap = (unsigned volatile short *)addr;
> > +	unsigned short *bp = (unsigned short *)buf;
> > +	unsigned short d;
> > +	while(len--) {
> > +		d = *ap;
> > +		*bp++ = (d << 8) | (d >> 8);
> > +	}
> > +}
> >
> > why you don't use outsw() and insw() from include/asm-h8300/io.h?
>
> Because bus turns over, insw/outsw is not usable.

Please explain.  I don't understand why outsw()/insw()
from io.h can't be assigned to hwif->OUTSW/hwif->INSW.

> > +	ide_setup_ports(&hw, IDE_BASE, (int *)offsets,
> > +                             IDE_CTRL, 0, NULL,IDE_IRQ);
> >
> > ide_setup_ports() is deprecated, please do not use it.
> >
> > +		hwif->mmio  = 0;
> >
> > Your driver is doing MMIO, it should request and release resources itself
> > and set hwif->mmio to 2.
> >
> > +void __init h8300_ide_print_resource(char *name, hw_regs_t *hw)
> > +{
> > +	printk("%s at 0x%08x-0x%08x,0x%08x on irq %d", name,
> > +		(unsigned int)hw->io_ports[IDE_DATA_OFFSET],
> > +		(unsigned int)hw->io_ports[IDE_DATA_OFFSET]+15,
> > +		(unsigned int)hw->io_ports[IDE_CONTROL_OFFSET],
> > +		hw->irq);
> > +}
> >
> > Is this necessary (this is a reason for extra #ifdefs in ide-probe.c)?
> > Can't we do what m68k is doing (print only address and IRQ) for now?
>
> I can use it.
> But there is the problem that resource to use cannot output justly.
> I think that solved if　can define a part of +7 with #define.

That's what I'm talking about.  Do not print all resources but just base
address and IRQ (you can still get rest from /proc/ioports if you want).
Nevermind it is minor issue, we can live with one more #ifdef in ide-probe.c.

> > Both drivers use same IO ops so they can be moved to some include file
> > or both drivers can be merged (preferred solution) - they are for
> > different boards and can't work together (plus MAX_HWIFS is defined to 1
> > for h8300).
> >
> > Here is patch (not tested) addressing some of these issues...
>
> I identified operation.
> MMIO and print_resource examine a correction method.

Thanks.
--bart

