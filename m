From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] ARM{26} IDE cleanups
Date: Wed, 21 Apr 2004 01:30:29 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404210130.29757.bzolnier@elka.pw.edu.pl>
References: <200404202335.59291.bzolnier@elka.pw.edu.pl> <20040420233323.F16428@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14521 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263963AbUDUAHA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Apr 2004 20:07:00 -0400
In-Reply-To: <20040420233323.F16428@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ian Molton <spyro@f2s.com>, linux-ide@vger.kernel.org

On Wednesday 21 of April 2004 00:33, Russell King wrote:
> On Tue, Apr 20, 2004 at 11:35:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > This patch is incremental to the
> > "sanitize ARM26 A5K and ARM CLPS7500/RPC/Shark IDE support" patch.
> >
> > I tried to fix SA1100 IDE support but I failed. :-)
> >
> > It seems it is broken since 2.5.16 when PCMCIA_IO_0_BASE define
> > was removed from <asm-arm/arch-sa1100/hardware.h>.
>
> Ok, this is something which either needs dropping or fixing in a
> sane way (to use ioremap + mmio).
>
> > - Fix arch/arm/Kconfig to allow IDE only on platforms supporting it.
>
> I'd rather not start doing this with IDE.  I've recently killed it on
> the sound stuff because it was becoming silly.  Consider that we have
> 516 machine types registered and you'll realise that one line containing
> even 32 identifiers in Kconfig is rather unmaintainable.

I did this to prevent build time breakage, i.e. currently you can select
CONFIG_IDE etc. and it will break during build time (i.e. no <asm/ide.h>).

What is the proper way to fix this?

BTW with current Kconfig it is possible to create zillions of
    non-buildable configs 8)

> > - Remove no longer needed ide_init_default_hwifs() call from ide.c.
>
> Good.
>
> > - Use generic ide_init_hwif_ports() on ARM26 and ARM.  Some platforms
> > were clearing hw in ide_init_hwif_ports() - it makes sense only in
> > setup-pci.c as all other users that can be build on ARM clear hw
> > themselves.
> >
> > - Kill <asm-arm/arch-*/ide.h> (except broken
> > <asm-arm/arch-sa1100/ide.h>).
>
> How are you handling the different register increments between the
> machines?  Some have registers placed at +4 offsets, others +1.
> Others even +32.

Just make a simple driver for your interface and add it to drivers/ide.

> I don't see any provision for this.  Sure, the majority  have used
> increments of one, but SA1100 doesn't, and I can see PXA being the
> same - and this is the why architectures were given control over
> the address initialisation.

Please reread the patch - I think I was very, very careful. :-)
All platforms except SA1100 (broken since 2.5.16) have registers
placed at +1 offsets (including PXA).

Please note that ide_init_hwif_ports() is a total design mistake
- on the same arch you can have various interfaces with different
register offsets and even different IO methods.

Not to mention that doing interface initialization in
ide_init_hwif_ports() effectively "locks" generic IDE code
(arch specific code is inlined into ide.c etc.).

Also there is no <asm/scsi.h>... :-)

Cheers,
Bartlomiej

