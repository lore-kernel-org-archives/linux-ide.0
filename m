From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Tue, 6 Dec 2011 20:00:52 +0000
Message-ID: <20111206200052.GU14542@n2100.arm.linux.org.uk>
References: <1322867573.11728.22.camel@pasglop> <20111205161157.GA27550@localhost.localdomain> <alpine.LFD.2.02.1112051236350.2357@xanadu.home> <20111205180253.GB29812@localhost.localdomain> <alpine.LFD.2.02.1112051310150.2357@xanadu.home> <20111205192605.GD29812@localhost.localdomain> <alpine.LFD.2.02.1112051443190.2357@xanadu.home> <20111206093709.GB2274@linaro.org> <20111206104654.GN14542@n2100.arm.linux.org.uk> <CA+55aFwZBr+3_S9kU-+m8zN8iwOvn2miuuAy-zt7sUjW_+abBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37804 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1LFUBf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Dec 2011 15:01:35 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFwZBr+3_S9kU-+m8zN8iwOvn2miuuAy-zt7sUjW_+abBg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>, Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org

On Tue, Dec 06, 2011 at 11:20:49AM -0800, Linus Torvalds wrote:
> Not for any device driver, though.
> 
> It's used entirely internally, and it doesn't even use
> "request_irq()". It uses the magic internal "setup_irq()" and never
> *ever* exposes irq0 as anything that a driver can see.
> 
> That's what matters. You can use irq0 in ARM land all you like, AS
> LONG AS IT'S SOME HIDDEN INTERNAL USE. No drivers. No *nothing* that
> ever uses that absolutely *idiotic* NO_IRQ crap.
> 
> In fact, you may be *forced* to use what is "physically" irq0 - it's
> just that you should never expose it as such to drivers. And x86
> doesn't.
> 
> So Russell, if you think this has anything to do with NO_IRQ, and how
> x86 isn't doing things right, you're wrong. It's just like the
> internal exception thing, or the magical "cascade interrupt", or the
> "x87 exception mapped through the PIC". They are magic hidden
> interrupts that are set up in one place (well, one place *each*), and
> are never exposed anywhere else.
> 
> The problem with NO_IRQ is that stupid "we expose our mind-numbingly
> stupid interfaces across the whole kernel".
> 
> x86 never did that.  ARM still does. x86 doesn't have to fix anything. ARM does.

Remember you said that I shouldn't take things personally?  Well,
this is one issue I really don't care about.  I don't think any
platform I _actually_ have will be impacted by any change in this
area.  Other platform maintainers may have their own issues but
that's not _my_ problem.
