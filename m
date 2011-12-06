From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Tue, 6 Dec 2011 11:05:54 +0000
Message-ID: <20111206110554.53bddd14@lxorguk.ukuu.org.uk>
References: <20111202192618.GC3037@localhost.localdomain>
	<CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
	<1322867573.11728.22.camel@pasglop>
	<20111205161157.GA27550@localhost.localdomain>
	<alpine.LFD.2.02.1112051236350.2357@xanadu.home>
	<20111205180253.GB29812@localhost.localdomain>
	<alpine.LFD.2.02.1112051310150.2357@xanadu.home>
	<20111205192605.GD29812@localhost.localdomain>
	<alpine.LFD.2.02.1112051443190.2357@xanadu.home>
	<20111206093709.GB2274@linaro.org>
	<20111206104654.GN14542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49493 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933147Ab1LFLFQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Dec 2011 06:05:16 -0500
In-Reply-To: <20111206104654.GN14542@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>, Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org

> Even better.  Avoid the first 16 IRQ numbers altogether - so that ISA
> drivers which have these numbers hard-encoded in them will see failures
> if they're expecting standard ISA IRQ numbering.

The ISA bus space is non-discoverable so that doesn't make any sense.

> But.. let's make one thing clear: Alan Cox and Linus have been going on
> about how IRQ0 should not be used.  Let's be crystal clear: even x86
> uses IRQ0.  It happens to be the PIC timer, and that gets claimed early
> on during the x86 boot.  So please don't tell me that x86 avoids IRQ0.
> It doesn't.  It just happens that x86 never shows IRQ0 to anything but
> the i8253 PIC driver.

x86 has an internal invisible IRQ 0 on some platforms. It's never exposed
beyond the arch code.

> So lets see how x86 squeels if we make the i8253 PIC driver reject IRQ0.
> I bet that there'd be absolute fury at such a suggestion.

Actually it would be about ten minutes work to remap it to some other
number that isn't used. It never goes via request_irq or via any core or
driver layer code however.

In the ARM case the same is going to be true. If you have IRQ 0 plumbing
that only goes internally in the arch/arm code - eg an ARM with IRQ 0
wired to something totally arch specific and non-driver then it's not
going to break and like the internals of x86 doesn't matter.

> When x86 sorts this out, there _might_ be some more motivation to take
> such comments seriously.  Until then it's more like a joke.

Pity you feel that way, but if ARM wants to continue to break more and
more as we clean up NO_IRQ for everything else that's your privilege, but
don't expect any sympathy.

Alan
