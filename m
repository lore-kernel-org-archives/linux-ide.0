From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Thu, 09 Mar 2017 15:52:11 +0100
Message-ID: <2925309.c9ir13Bff9@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <20170309135714.GJ21222@n2100.armlinux.org.uk> <3285453.g1rFzTv5DW@amdc3058>
 <CGME20170309145219epcas5p38b1af654dd0a4b04bd02a488051c065f@epcas5p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52834 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbdCIOwX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2017 09:52:23 -0500
In-reply-to: <3285453.g1rFzTv5DW@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Sekhar Nori <nsekhar@ti.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org

On Thursday, March 09, 2017 03:42:49 PM Bartlomiej Zolnierkiewicz wrote:

> > Yes, it's very obscure - but what it comes down to is the silly way the
> > "ISA" IO is handled on the platform (which depends whether it's an 8-bit
> > or 16-bit ISA-style peripheral.)  The old IDE CS driver _could_ be bent
> > to work via a patch like this:
> > 
> > ARM: EBSA110: Enable 16-bit IO type for ide-iops
> > 
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 047a20780fc1..2eb501d6b5fe 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -217,7 +217,8 @@ ifeq ($(CONFIG_ARCH_EBSA110),y)
> >  # This is what happens if you forget the IOCS16 line.
> >  # PCMCIA cards stop working.
> >  CFLAGS_3c589_cs.o :=-DISA_SIXTEEN_BIT_PERIPHERAL
> > -export CFLAGS_3c589_cs.o
> > +CFLAGS_ide-io-std.o :=-DISA_SIXTEEN_BIT_PERIPHERAL
> > +export CFLAGS_3c589_cs.o CFLAGS_ide-io-std.o
> >  endif
> 
> As I've already explained in the past, the proper fix for the problem
> (for both old IDE and libata) is to define custom transport ops in
> ide-cs.c/ata_pcmcia.c and use them on affected platforms.
> 
> >  # The byte offset of the kernel image in RAM from the start of RAM.
> > 
> > but the PATA driver is much harder.
> 
> There are a lot examples of using your own transport operations in
> existing code (i.e. pata_octeon_cf.c or drivers/ata/sata_rcar.c).

Basically it should come down to copypasting all transport ops
from libata-sff.c and replacing all ioread8()/iowrite8() with
__inb16()__outb16(). Then you need to add detection of EBSA1100
which should also be as simple as using machine_is_ebsa110() in
the proper place.

If you ever get to running current upstream on your EBSA110
I can provide you with the draft patch doing this.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

