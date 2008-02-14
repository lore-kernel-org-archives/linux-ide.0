From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: add CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS
Date: Thu, 14 Feb 2008 22:24:22 +0100
Message-ID: <200802142224.22621.bzolnier@gmail.com>
References: <200802142155.50893.bzolnier@gmail.com> <20080214205500.GE21894@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.237]:22011 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765221AbYBNVKa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 16:10:30 -0500
Received: by hu-out-0506.google.com with SMTP id 19so10270841hue.21
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 13:10:29 -0800 (PST)
In-Reply-To: <20080214205500.GE21894@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Thursday 14 February 2008, Sam Ravnborg wrote:
> Hi Bart.
> 
> On Thu, Feb 14, 2008 at 09:55:50PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Add CONFIG_IDE_ARCH_OBSOLETE_DEFAULTS to drivers/ide/Kconfig and use
> > it instead of defining IDE_ARCH_OBSOLETE_DEFAULTS in <arch/ide.h>.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/Kconfig                 |    3 +++
> >  drivers/ide/ide.c                   |    5 +++++
> >  include/asm-alpha/ide.h             |    3 ---
> >  include/asm-ia64/ide.h              |    2 --
> >  include/asm-m32r/ide.h              |    2 --
> >  include/asm-mips/mach-generic/ide.h |    2 --
> >  include/asm-powerpc/ide.h           |    2 --
> >  include/asm-x86/ide.h               |    2 --
> >  include/linux/ide.h                 |    7 -------
> >  9 files changed, 8 insertions(+), 20 deletions(-)
> > 
> > Index: b/drivers/ide/Kconfig
> > ===================================================================
> > --- a/drivers/ide/Kconfig
> > +++ b/drivers/ide/Kconfig
> > @@ -1099,6 +1099,9 @@ config BLK_DEV_IDEDMA
> >  config IDE_ARCH_OBSOLETE_INIT
> >  	def_bool ALPHA || (ARM && !ARCH_L7200) || BLACKFIN || X86 || IA64 || M32R || MIPS || PARISC || PPC || (SUPERH64 && BLK_DEV_IDEPCI) || SPARC
> >  
> > +config IDE_ARCH_OBSOLETE_DEFAULTS
> > +	def_bool ALPHA || X86 || IA64 || M32R || MIPS || PPC32
> > +
> >  endif
> 
> 
> This time it is maybe borderline as it makes sense to see a list of
> archs that uses this.
> But still I would prefer you did like this:
> 
> drivers/ide/Kconfig:
> 
> config HAVE_IDE_ARCH_OBSOLETE_DEFAULTS
> 	bool
> 
> config IDE_ARCH_OBSOLETE_DEFAULTS
> 	depends on HAVE_IDE_ARCH_OBSOLETE_DEFAULTS
> 
> And then in each arch Kconfig include:
> 
> arch/alpha/Kconfig:
> config ALPHA
> 	select HAVE_ARCH_OBSOLETE_DEFAULTS
> 
> And the same for the others.

I agree but this option is meant to be only temporary to ease the cleanup
process.  We can think about the proper solution after default IDE ports
initialization gets moved to ide_generic host driver.

Thanks,
Bart
