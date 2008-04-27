From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] ARM: always select HAVE_IDE
Date: Sun, 27 Apr 2008 20:32:44 +0200
Message-ID: <200804272032.44273.bzolnier@gmail.com>
References: <20080414141659.GF6695@cs181133002.pp.htv.fi> <20080417110005.GE1449@flint.arm.linux.org.uk> <20080417132507.GA9314@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:25372 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585AbYD0TyM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Apr 2008 15:54:12 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4628224fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Apr 2008 12:54:10 -0700 (PDT)
In-Reply-To: <20080417132507.GA9314@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org

On Thursday 17 April 2008, Adrian Bunk wrote:
> On Thu, Apr 17, 2008 at 12:00:05PM +0100, Russell King wrote:
> > On Thu, Apr 17, 2008 at 01:48:36PM +0300, Adrian Bunk wrote:
> > > On Thu, Apr 17, 2008 at 10:59:16AM +0100, Russell King wrote:
> > > > On Thu, Apr 17, 2008 at 12:37:53PM +0300, Adrian Bunk wrote:
> > > > > Any objections against the patch below?
> > > > 
> > > > Let's look at the rest of the situation surrounding HAVE_IDE first.
> > > > It's something of a mess:
> > > > 
> > > > avr32, m68knommu, ppc, s390 and v850 do not have asm/ide.h
> > > > 
> > > > avr32, m68knommu, ppc, v850 all set HAVE_IDE, arch/s390/Kconfig contains
> > > > no reference.
> > > > 
> > > > avr32 supports PATA (which is IDE).
> > > > 
> > > > Everything else provides an asm/ide.h and sets HAVE_IDE.
> > > > 
> > > > So:
> > > > 
> > > > Q1. Do avr32, m68knommu, ppc, v850 have IDE support or do they not?
> > > 
> > > avr32 is fixed in 2.6.25 (no more HAVE_IDE)
> > 
> > avr32 has ATA, so the only reason it doesn't actually use IDE is because
> > they're using libata entirely.  This is NO different from the situation
> > on ARM - some machine classes use entirely libata, others use IDE, and
> > some others are trying to give up IDE in favour of libata.
> 
> You have a point that one might argue that avr32 should also select 
> HAVE_IDE and get an asm/ide.h .
> 
> The main difference between avr32 and arm is that on arm there are a 
> bunch of platforms that actually want to use drivers/ide/ at the moment, 
> and the fine-grained select's we have at the moment don't bring any real 
> gain.
> 
> I do actually not care much how this gets resolved (we could even 
> ditch HAVE_IDE and provide asm/ide.h on all architectures) if there's 
> general agreement that this is the way to go.

Seems like a way to go now that all crazy IDE core code vs arch code
inter-dependiences have been fixed (the ideal solution would be to ditch
asm/ide.h completely but this requires some more time/work).

Thanks,
Bart
