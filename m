From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Mon, 5 Dec 2011 17:41:32 +0000
Message-ID: <20111205174132.564e0bb0@lxorguk.ukuu.org.uk>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20111205161157.GA27550-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jeff Garzik <jgarzik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

> Russell, do you know whether it would make sense to set a timeline for 
> removing NO_IRQ from ARM platforms and migrating to 0 for the no-interrupt
> case?  I'm assuming that this mainly involves migrating existing hard-wired
> code that deals with interrupt numbers to use irq domains.

The timelime was several years ago. Several years of complete inaction
later the chickens have come home to roost.

I refer you to Linus mail of 26 Sept 2006 to linux-kernel ('restore
libata build on frv')

Quoting Linus email:

>> That's fine -- but don't use zero to mean none. We have NO_IRQ for
>> that, and zero isn't an appropriate choice.
>
> Zero _is_ an appropriate choice, dammit!
>
> That NO_IRQ thing should be zero, and any architecture that thinks that
>zero is a valid IRQ just needs to fix its own irq mapping so that the
> "cookie" doesn't work.
>
> The thing is, it's zero. Get over it. It can't be "-1" or some other
> random value like people have indicated, because that thing is often read
> from places where "-1" simply isn't a possible value (eg it gets its
> default value initialized from a "unsigned char" in MMIO space on x86).
>
> So instead of making everybody and their dog to silly things with some
> NO_IRQ define that they haven't historically done, the rule is simple: "0"
> means "no irq", so that you can test for it with obvious code like
>
>	if (!dev->irq)
>		..
>
> and then, if your actual _hardware_ things that the bit-pattern with all
> bits clear is a valid irq that can be used for normal devices, then what
> you do is you add a irq number translation layer (WHICH WE NEED AND HAVE
> _ANYWAY_) and make sure that nobody sees that on a _software_ level.

----------

On 15th October 2008 Linus said the following to linux-next

> Grr. Can we please just get rid of that IDIOTIC thing instead?
> 
> NO_IRQ was a bad idea to begin with. Let's not add more.
> 
> I assume that broken driver is some ARM-specific thing. I certainly don't 
> want to see NO_IRQ in any general drivers. So instead of having that 
> NO_IRQ insanity spread any more, I'd much rather see the driver either 
> fixed to not use it, or just marked ARM-only.
>
> The proper way to test for whether an interrupt is valid or not is to do
>
> 	if (dev->irq) {
>		...
> and no other. There is no spoon. That NO_IRQ was insane. And
> architectures or drivers that still think otherwise should fix themselves.

------------

So there we are.. ARM spent years ignoring clear direction. If ARM breaks
for a release now so be it. You've had *YEARS* to get off your collective
backsides and sort it out.

> I worry that if we just change the convention for the OF case, we'll end
> up with OF-ised platform drivers which have to deal with a different no-
> irq convention depending on whether they are probed as platform drivers
> or through the OF framework ... and these ported or semi-ported drivers
> will be intermixed with unported drivers, confusing maintainers

All drivers should assume that  if (!dev->irq) works. Zero is not an IRQ
except in certain buried internal invisible cases in arch code (legacy PC
timer being the obvious one).

Come to think about it we had a prior discussion about NO_IRQ in 2005
even!

The core kernel generic IRQ code knows about zero being special, many
common driver layer components such as serial and network phylib do, so
if anything it's going to fix bugs sorting the mess out on ARM.

Jut fix it. Other platforms have done so without problem.

Alan
