From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] ARM{26} IDE cleanups
Date: Tue, 20 Apr 2004 23:33:23 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040420233323.F16428@flint.arm.linux.org.uk>
References: <200404202335.59291.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15630 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264544AbUDTWd1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Apr 2004 18:33:27 -0400
Content-Disposition: inline
In-Reply-To: <200404202335.59291.bzolnier@elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Tue, Apr 20, 2004 at 11:35:59PM +0200
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Ian Molton <spyro@f2s.com>, linux-ide@vger.kernel.org

On Tue, Apr 20, 2004 at 11:35:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
> This patch is incremental to the
> "sanitize ARM26 A5K and ARM CLPS7500/RPC/Shark IDE support" patch.
> 
> I tried to fix SA1100 IDE support but I failed. :-)
> 
> It seems it is broken since 2.5.16 when PCMCIA_IO_0_BASE define
> was removed from <asm-arm/arch-sa1100/hardware.h>.

Ok, this is something which either needs dropping or fixing in a
sane way (to use ioremap + mmio).

> - Fix arch/arm/Kconfig to allow IDE only on platforms supporting it.

I'd rather not start doing this with IDE.  I've recently killed it on
the sound stuff because it was becoming silly.  Consider that we have
516 machine types registered and you'll realise that one line containing
even 32 identifiers in Kconfig is rather unmaintainable.

> - Remove no longer needed ide_init_default_hwifs() call from ide.c.

Good.

> - Use generic ide_init_hwif_ports() on ARM26 and ARM.  Some platforms were
>   clearing hw in ide_init_hwif_ports() - it makes sense only in setup-pci.c
>   as all other users that can be build on ARM clear hw themselves.
> 
> - Kill <asm-arm/arch-*/ide.h> (except broken <asm-arm/arch-sa1100/ide.h>).

How are you handling the different register increments between the
machines?  Some have registers placed at +4 offsets, others +1.
Others even +32.

I don't see any provision for this.  Sure, the majority  have used
increments of one, but SA1100 doesn't, and I can see PXA being the
same - and this is the why architectures were given control over
the address initialisation.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
