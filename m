From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2.6 patch] ARM: always select HAVE_IDE
Date: Sun, 27 Apr 2008 19:53:55 +0200
Message-ID: <200804271953.55295.bzolnier@gmail.com>
References: <20080414141659.GF6695@cs181133002.pp.htv.fi> <200804160126.11116.bzolnier@gmail.com> <20080417093753.GF1677@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:24698 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790AbYD0TyM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Apr 2008 15:54:12 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4628215fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Apr 2008 12:54:08 -0700 (PDT)
In-Reply-To: <20080417093753.GF1677@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org

On Thursday 17 April 2008, Adrian Bunk wrote:
> On Wed, Apr 16, 2008 at 01:26:10AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 16 April 2008, Russell King wrote:
> > > On Wed, Apr 16, 2008 at 01:10:02AM +0300, Adrian Bunk wrote:
> > > > On Tue, Apr 15, 2008 at 11:03:45PM +0100, Russell King wrote:
> > > > > On Wed, Apr 16, 2008 at 12:52:23AM +0300, Adrian Bunk wrote:
> > > > >...
> > > > > So this is a only impacting ARM wrt. PCMCIA, and given that ARM supplies
> > > > > an asm/ide.h, it's _entirely_ reasonable that if a platform has PCMCIA
> > > > > then it supports IDE.
> > > > > 
> > > > > > We could simply always select HAVE_IDE on arm instead of manually 
> > > > > > setting which platforms could possibly get IDE support (e.g. are there
> > > > > > any boards with PCI slots for which HAVE_IDE is currently not 
> > > > > > selected?).
> > > > > 
> > > > > You could, if there was a demand for it.  As no one has added that,
> > > > > I conclude that its less common for people to stick an IDE controller
> > > > > into a PCI backplane.
> > > > 
> > > > People can always enable code for stuff they don't use.
> > > > 
> > > > But instead of having 14 ARM platforms plus PCMCIA (which is offered 
> > > > unconditionally on all ARM platforms...) select HAVE_IDE it's simpler
> > > > to select it once for all ARM platforms.
> > 
> > Please send me a patch doing this, it should be safe for current IDE tree.
> > 
> > > That would seem logical, but Bart objects to that idea.
> > 
> > I don't remember the background but I think it was needed because of badly
> > perplexed ide_init_hwif_ports() and friends in <asm/ide.h> vs <linux/ide.h>
> > (almost all this stuff is gone in IDE tree for 2.6.26)...
> > 
> > Ok, I found the patch:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/tglx/history.git;a=commitdiff;h=4b3b8ee5db374b76608537e061f2efd90e21179d
> > 
> > [ tglx's history tree since it is from May 2004. ]
> > 
> > > However, consider that we're gradually transitioning over to being
> > > exclusively libata only.
> > > 
> > > > > In fact, there are only three classes of ARM platforms which have PCI
> > > > > selected but not HAVE_IDE - IOP13xx, IXP2000, and Orion.  I suspect
> > > > > the only reason they don't select it because they now use the ATA code
> > > > > rather than the old IDE code - that's certainly true of Orion.
> > > > 
> > > > The libata options are offered unconditionally on all platforms...
> > > 
> > > It wasn't *my* choice to restrict IDE on ARM.  See Bart for that
> > > decision.
> > 
> > It could be that I did the poor job of explaining things back then
> > but I also didn't like the fact that I needed to restrict the IDE
> > choice on ARM - the change in question was _necessary_ to start
> > converting IDE drivers to become real, independent, modular host
> > drivers and as a preparation for adding proper warm-plug support.
> 
> Any objections against the patch below?
> 
> > Thanks,
> > Bart
> 
> cu
> Adrian
> 
> 
> <--  snip  -->
> 
> 
> It's plain wrong for PCMCIA to select HAVE_IDE that implies e.g. the
> availability of an asm/ide.h
> 
> It turns out this was done for ARM, and we can simply always select 
> HAVE_IDE on ARM instead of manually tracking which platforms might 
> possible have an IDE controller directly or indirectly.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

thanks, applied

[ Russell: I plan to put it into next IDE update, please ping me if you
  prefer to merge it through ARM tree ]
