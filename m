From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sat, 5 Jun 2004 22:36:32 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200406052236.32766.bzolnier@elka.pw.edu.pl>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <20040605194959.GA13228@buici.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26531 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261880AbUFEUcz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Jun 2004 16:32:55 -0400
In-Reply-To: <20040605194959.GA13228@buici.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: linux-ide@vger.kernel.org

On Saturday 05 of June 2004 21:49, Marc Singer wrote:
> On Sat, May 15, 2004 at 07:23:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > - IDE is going into full host driver model
> >   so write host driver for your interface
>
> Can you tell me what this means?  Is arm/rapide.c an example?  If not,
> what *is* and example?  Is the arm/ide_arm.c *not* the right way?

This was supposed to mean to not hide your code in <asm/ide.h> and abuse
ide_init_default_hwifs() (which is gone).  I'll make this more verbose.

arm/rapide.c and arm/ide_arm.c are both okay.
Bad example is <asm-arm/arch-sa1100/ide.h>.

> > - see drivers in drivers/ide/arm and drivers/ide/legacy for examples
> >   (especially m68k and arm specific drivers)
> >
> > - do not use ide_setup_ports()
>
> Hmm.  macide in legacy does.  Is this, then, a bad bad example legacy?
>
> The piece I'm missing is how to replace the ioops functions for my
> platform.  I could implement something in ide-iops.c.  Is that the way?

No, your host driver should do it:

If you call ide_register_hw(&hw, &hwif) you should get a valid pointer to
hwif so you can then replace standard ioops by your custom ones if needed.

hwif->OUT* = ...
hwif->IN* = ...

hwif->ata_[input,output]_data = ...
hwif->atapi_[input,output]_bytes = ...

Thanks,
Bartlomiej

