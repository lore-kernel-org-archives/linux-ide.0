From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Tue, 6 Dec 2011 21:59:55 +0100
Message-ID: <20111206205955.GH4585@pengutronix.de>
References: <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205192605.GD29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051443190.2357@xanadu.home>
 <20111206093709.GB2274@linaro.org>
 <20111206104654.GN14542@n2100.arm.linux.org.uk>
 <CA+55aFwZBr+3_S9kU-+m8zN8iwOvn2miuuAy-zt7sUjW_+abBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwZBr+3_S9kU-+m8zN8iwOvn2miuuAy-zt7sUjW_+abBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jeff Garzik <jgarzik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hello Linus,

On Tue, Dec 06, 2011 at 11:20:49AM -0800, Linus Torvalds wrote:
> On Tue, Dec 6, 2011 at 2:46 AM, Russell King - ARM Linux
> <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> >
> > But.. let's make one thing clear: Alan Cox and Linus have been going on
> > about how IRQ0 should not be used. =A0Let's be crystal clear: even x86
> > uses IRQ0.
> =

> Not for any device driver, though.
> =

> It's used entirely internally, and it doesn't even use
> "request_irq()". It uses the magic internal "setup_irq()" and never
> *ever* exposes irq0 as anything that a driver can see.
> =

> That's what matters. You can use irq0 in ARM land all you like, AS
> LONG AS IT'S SOME HIDDEN INTERNAL USE. No drivers. No *nothing* that
> ever uses that absolutely *idiotic* NO_IRQ crap.
> =

> In fact, you may be *forced* to use what is "physically" irq0 - it's
> just that you should never expose it as such to drivers. And x86
> doesn't.
> =

> So Russell, if you think this has anything to do with NO_IRQ, and how
> x86 isn't doing things right, you're wrong. It's just like the
> internal exception thing, or the magical "cascade interrupt", or the
> "x87 exception mapped through the PIC". They are magic hidden
> interrupts that are set up in one place (well, one place *each*), and
> are never exposed anywhere else.
Well there is try_misrouted_irq in kernel/irq/spurious.c that assumes
irq0 to be something that it never is on ARM (and maybe all other
platforms apart from x86). So at least it's not internal to a single
(x86 specific) place.

I tried to patch that two years ago, but that only ended in people
saying "don't use irq0". I don't know if try_misrouted_irq sees hardware
irqs, but if it does it's a bug even on archs !=3D X86 that use virtual
irqs.

(Note that this doesn't oppose to your statement that using NO_IRQ is
crap.)

> The problem with NO_IRQ is that stupid "we expose our mind-numbingly
> stupid interfaces across the whole kernel".
> =

> x86 never did that.  ARM still does. x86 doesn't have to fix anything. AR=
M does.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
