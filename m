From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 01/15] ide: include <asm/ide.h> only when needed
Date: Mon, 2 Feb 2009 19:27:25 +0100
Message-ID: <200902021927.25177.bzolnier@gmail.com>
References: <20090201174909.19144.67767.sendpatchset@localhost.localdomain> <20090201174916.19144.11318.sendpatchset@localhost.localdomain> <Pine.LNX.4.64.0902020847410.11930@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:29413 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084AbZBBSg5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Feb 2009 13:36:57 -0500
In-Reply-To: <Pine.LNX.4.64.0902020847410.11930@anakin>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>

On Monday 02 February 2009, Geert Uytterhoeven wrote:
> On Sun, 1 Feb 2009, Bartlomiej Zolnierkiewicz wrote:
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: include <asm/ide.h> only when needed
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-io-std.c |    7 +++++++
> >  drivers/ide/tx4938ide.c  |    2 ++
> >  drivers/ide/tx4939ide.c  |    2 ++
> >  include/linux/ide.h      |    7 -------
> >  4 files changed, 11 insertions(+), 7 deletions(-)
> > 
> > Index: b/drivers/ide/ide-io-std.c
> > ===================================================================
> > --- a/drivers/ide/ide-io-std.c
> > +++ b/drivers/ide/ide-io-std.c
> > @@ -2,6 +2,13 @@
> >  #include <linux/kernel.h>
> >  #include <linux/ide.h>
> >  
> > +#if defined(CONFIG_ARM) || defined(CONFIG_M68K) || defined(CONFIG_MIPS) || \
> > +    defined(CONFIG_PARISC) || defined(CONFIG_PPC) || defined(CONFIG_SPARC)
> > +#include <asm/ide.h>
> > +#else
> > +#include <asm-generic/ide_iops.h>
> > +#endif
> > +
> >  /*
> >   *	Conventional PIO operations for ATA devices
> >   */
> > Index: b/drivers/ide/tx4938ide.c
> > ===================================================================
> > --- a/drivers/ide/tx4938ide.c
> > +++ b/drivers/ide/tx4938ide.c
> > @@ -15,6 +15,8 @@
> >  #include <linux/init.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> > +
> > +#include <asm/ide.h>
> 
> Did you try checkpatch.pl?

Sure.

This driver uses stuff from <asm-mips/ide.h>.

[ I guess I could put '-mips' there to silence warnings on tx493{8,9}.c,
  however I don't know of the way to get rid of ide-io-std.c's one... ]

>     [...]
> 
> > Index: b/include/linux/ide.h
> > ===================================================================
> > --- a/include/linux/ide.h
> > +++ b/include/linux/ide.h
> > @@ -193,13 +193,6 @@ static inline void ide_std_init_ports(hw
> >  	hw->io_ports.ctl_addr = ctl_addr;
> >  }
> >  
> > -#if defined(CONFIG_ARM) || defined(CONFIG_M68K) || defined(CONFIG_MIPS) || \
> > -    defined(CONFIG_PARISC) || defined(CONFIG_PPC) || defined(CONFIG_SPARC)
> > -#include <asm/ide.h>
> > -#else
> > -#include <asm-generic/ide_iops.h>
> > -#endif
> > -
> >  #define MAX_HWIFS	10
> >  
> >  /*
> 
> As checkpatch.pl complains about any include of asm/*.h where the corresponding
> linux/*.h exists, this `fix' is incompatible with it.

checkpatch.pl gives false positives when it comes to some asm/*.h usages

This fix is such example -- it makes <asm/ide.h> pulled in only when really
needed (ide-io-std.c and tx493{8,9}.c) instead of being pulled in indirectly
by every file including <linux/ide.h>.

[ Long-term we want <asm/ide.h> removed but this is not possible yet so
  I'm trying to limit its scope in the meantime... ]

Thanks,
Bart
