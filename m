From: Marc Singer <elf@buici.com>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sat, 5 Jun 2004 15:13:22 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040605221322.GB15933@buici.com>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <20040605194959.GA13228@buici.com> <200406052236.32766.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:28311 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261252AbUFEWNX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 5 Jun 2004 18:13:23 -0400
Content-Disposition: inline
In-Reply-To: <200406052236.32766.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

On Sat, Jun 05, 2004 at 10:36:32PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 05 of June 2004 21:49, Marc Singer wrote:
> > On Sat, May 15, 2004 at 07:23:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > - IDE is going into full host driver model
> > >   so write host driver for your interface
> >
> > Can you tell me what this means?  Is arm/rapide.c an example?  If not,
> > what *is* and example?  Is the arm/ide_arm.c *not* the right way?
> 
> This was supposed to mean to not hide your code in <asm/ide.h> and abuse
> ide_init_default_hwifs() (which is gone).  I'll make this more verbose.
> 
> arm/rapide.c and arm/ide_arm.c are both okay.
> Bad example is <asm-arm/arch-sa1100/ide.h>.
> 
> > > - see drivers in drivers/ide/arm and drivers/ide/legacy for examples
> > >   (especially m68k and arm specific drivers)
> > >
> > > - do not use ide_setup_ports()
> >
> > Hmm.  macide in legacy does.  Is this, then, a bad bad example legacy?
> >
> > The piece I'm missing is how to replace the ioops functions for my
> > platform.  I could implement something in ide-iops.c.  Is that the way?
> 
> No, your host driver should do it:
> 
> If you call ide_register_hw(&hw, &hwif) you should get a valid pointer to
> hwif so you can then replace standard ioops by your custom ones if needed.
> 
> hwif->OUT* = ...
> hwif->IN* = ...
> 
> hwif->ata_[input,output]_data = ...
> hwif->atapi_[input,output]_bytes = ...
> 

OK.  I see how this can work.  What chafes me about ide_arm.c is that
it takes an overly generic view of *all* ARM platforms.  I'd prefer to
see a generic version and the platform specific versions that replace
the generic when appropriate.

Thanks for the guidance.

