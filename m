From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Tue, 6 Dec 2011 11:25:45 +0000
Message-ID: <20111206112545.GQ14542@n2100.arm.linux.org.uk>
References: <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
 <20111205192605.GD29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051443190.2357@xanadu.home>
 <20111206093709.GB2274@linaro.org>
 <20111206104654.GN14542@n2100.arm.linux.org.uk>
 <20111206110554.53bddd14@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111206110554.53bddd14-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jeff Garzik <jgarzik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Tue, Dec 06, 2011 at 11:05:54AM +0000, Alan Cox wrote:
> > Even better.  Avoid the first 16 IRQ numbers altogether - so that ISA
> > drivers which have these numbers hard-encoded in them will see failures
> > if they're expecting standard ISA IRQ numbering.
> 
> The ISA bus space is non-discoverable so that doesn't make any sense.
> 
> > But.. let's make one thing clear: Alan Cox and Linus have been going on
> > about how IRQ0 should not be used.  Let's be crystal clear: even x86
> > uses IRQ0.  It happens to be the PIC timer, and that gets claimed early
> > on during the x86 boot.  So please don't tell me that x86 avoids IRQ0.
> > It doesn't.  It just happens that x86 never shows IRQ0 to anything but
> > the i8253 PIC driver.
> 
> x86 has an internal invisible IRQ 0 on some platforms. It's never exposed
> beyond the arch code.
> 
> > So lets see how x86 squeels if we make the i8253 PIC driver reject IRQ0.
> > I bet that there'd be absolute fury at such a suggestion.
> 
> Actually it would be about ten minutes work to remap it to some other
> number that isn't used. It never goes via request_irq or via any core or
> driver layer code however.
> 
> In the ARM case the same is going to be true. If you have IRQ 0 plumbing
> that only goes internally in the arch/arm code - eg an ARM with IRQ 0
> wired to something totally arch specific and non-driver then it's not
> going to break and like the internals of x86 doesn't matter.
> 
> > When x86 sorts this out, there _might_ be some more motivation to take
> > such comments seriously.  Until then it's more like a joke.
> 
> Pity you feel that way, but if ARM wants to continue to break more and
> more as we clean up NO_IRQ for everything else that's your privilege, but
> don't expect any sympathy.

For the platforms I care about, it probably won't break.  For those which
do break, it's a matter of fixing their include/mach/irqs.h and the code
in their irqchips to convert the IRQ number to the correct bitmask for
the register.

However, I have suggested in the past that new platforms _should_ avoid
not just IRQ0 but IRQ0-15 (for a completely different reason to that of
'IRQ0 means no IRQ'.)  But such comments just get ignored, so I just
don't see the point in doing anything about this.  If people experience
breakage, so be it.  I too will have little sympathy but not for the same
reason.
