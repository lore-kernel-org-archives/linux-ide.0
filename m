From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Tue, 6 Dec 2011 11:20:49 -0800
Message-ID: <CA+55aFwZBr+3_S9kU-+m8zN8iwOvn2miuuAy-zt7sUjW_+abBg@mail.gmail.com>
References: <20111202192618.GC3037@localhost.localdomain> <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop> <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home> <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home> <20111205192605.GD29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051443190.2357@xanadu.home> <20111206093709.GB2274@linaro.org>
 <20111206104654.GN14542@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20111206104654.GN14542@n2100.arm.linux.org.uk>
Sender: linux-next-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Martin <dave.martin@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@redhat.com>, Pawel Moll <pawel.moll@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Tue, Dec 6, 2011 at 2:46 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> But.. let's make one thing clear: Alan Cox and Linus have been going =
on
> about how IRQ0 should not be used. =A0Let's be crystal clear: even x8=
6
> uses IRQ0.

Not for any device driver, though.

It's used entirely internally, and it doesn't even use
"request_irq()". It uses the magic internal "setup_irq()" and never
*ever* exposes irq0 as anything that a driver can see.

That's what matters. You can use irq0 in ARM land all you like, AS
LONG AS IT'S SOME HIDDEN INTERNAL USE. No drivers. No *nothing* that
ever uses that absolutely *idiotic* NO_IRQ crap.

In fact, you may be *forced* to use what is "physically" irq0 - it's
just that you should never expose it as such to drivers. And x86
doesn't.

So Russell, if you think this has anything to do with NO_IRQ, and how
x86 isn't doing things right, you're wrong. It's just like the
internal exception thing, or the magical "cascade interrupt", or the
"x87 exception mapped through the PIC". They are magic hidden
interrupts that are set up in one place (well, one place *each*), and
are never exposed anywhere else.

The problem with NO_IRQ is that stupid "we expose our mind-numbingly
stupid interfaces across the whole kernel".

x86 never did that.  ARM still does. x86 doesn't have to fix anything. =
ARM does.

                Linus
