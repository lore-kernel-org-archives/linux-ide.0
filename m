From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [2.6 patch] ARM: always select HAVE_IDE
Date: Thu, 17 Apr 2008 12:00:05 +0100
Message-ID: <20080417110005.GE1449@flint.arm.linux.org.uk>
References: <20080414141659.GF6695@cs181133002.pp.htv.fi> <20080415221002.GL1677@cs181133002.pp.htv.fi> <20080415223928.GH5676@flint.arm.linux.org.uk> <200804160126.11116.bzolnier@gmail.com> <20080417093753.GF1677@cs181133002.pp.htv.fi> <20080417095916.GD1449@flint.arm.linux.org.uk> <20080417104836.GH1677@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48034 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765596AbYDQLAe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Apr 2008 07:00:34 -0400
Content-Disposition: inline
In-Reply-To: <20080417104836.GH1677@cs181133002.pp.htv.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org

On Thu, Apr 17, 2008 at 01:48:36PM +0300, Adrian Bunk wrote:
> On Thu, Apr 17, 2008 at 10:59:16AM +0100, Russell King wrote:
> > On Thu, Apr 17, 2008 at 12:37:53PM +0300, Adrian Bunk wrote:
> > > Any objections against the patch below?
> > 
> > Let's look at the rest of the situation surrounding HAVE_IDE first.
> > It's something of a mess:
> > 
> > avr32, m68knommu, ppc, s390 and v850 do not have asm/ide.h
> > 
> > avr32, m68knommu, ppc, v850 all set HAVE_IDE, arch/s390/Kconfig contains
> > no reference.
> > 
> > avr32 supports PATA (which is IDE).
> > 
> > Everything else provides an asm/ide.h and sets HAVE_IDE.
> > 
> > So:
> > 
> > Q1. Do avr32, m68knommu, ppc, v850 have IDE support or do they not?
> 
> avr32 is fixed in 2.6.25 (no more HAVE_IDE)

avr32 has ATA, so the only reason it doesn't actually use IDE is because
they're using libata entirely.  This is NO different from the situation
on ARM - some machine classes use entirely libata, others use IDE, and
some others are trying to give up IDE in favour of libata.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
