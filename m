From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Tue, 6 Dec 2011 10:55:03 +0000
Message-ID: <20111206105503.GO14542@n2100.arm.linux.org.uk>
References: <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home> <4EDD1897.4030208@gmail.com>
 <20111205202125.GA32592@oksana.dev.rtsoft.ru> <4EDD2DE1.1050606@gmail.com>
 <20111206093000.GA2274@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20111206093000.GA2274-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jeff Garzik <jgarzik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Tue, Dec 06, 2011 at 09:30:00AM +0000, Dave Martin wrote:
> Do we expect there to be any platform drivers which are shared between
> legacy platforms and newer DT-ised platforms?
> 
> Those drivers would be pain points since they would need to understand
> both conventions.
> 
> So far as I can see, only boards which are not DT-ised, which do not use
> DT-ised drivers and which do not use drivers which use interrupts and
> are either used by DT-ised boards or by arches with a non-zero NO_IRQ
> could safely carry on using a non-zero NO_IRQ.  Tracking down exactly
> which boards and drivers this applies to could be hard.  We could have a
> CONFIG_NO_IRQ and make them depend on it, but we still have to find that
> list of boards and drivers in the first place.

You're digging too deeply into this.

Drivers which need to know whether an IRQ is valid need to know this if
they wish to do something different for 'this device doesn't have an IRQ
wired'.  These are the drivers which have problems because of the -1 vs
0 thing.

That is different from 'this is an invalid IRQ number', which is what
you find out when you call request_irq().

So please, stop thinking 'we need to convert drivers to check for <= 0'.
We don't.  We just need to make sure that we're not passing a zero IRQ
number to any driver.

On platforms where IRQ0 is special like x86, request_irq() will fail
with -EBUSY on drivers which don't care (or other kind of refusal to
initialize), and will cause 'polling mode' with the 8250 driver.

So, all that we need to do is to ensure that all the IRQ chip stuff is
fixed up so that IRQ0 is only used for the same purpose as x86 - the
PIC timer on systems with an ISA 8253 timer.  Everything else should
not pass IRQ0 outside core platform code.
