From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ata: Don't use NO_IRQ in pata_of_platform driver
Date: Mon, 05 Dec 2011 13:16:39 -0600
Message-ID: <4EDD1897.4030208@gmail.com>
References: <20111110162859.GA7088@oksana.dev.rtsoft.ru>
 <20111202192618.GC3037@localhost.localdomain>
 <CA+55aFwekNWz+V4440f=2iu_BfOxSg0NjVogv4cZZDFbJBNoAQ@mail.gmail.com>
 <1322867573.11728.22.camel@pasglop>
 <20111205161157.GA27550@localhost.localdomain>
 <alpine.LFD.2.02.1112051236350.2357@xanadu.home>
 <20111205180253.GB29812@localhost.localdomain>
 <alpine.LFD.2.02.1112051310150.2357@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <alpine.LFD.2.02.1112051310150.2357-QuJgVwGFrdf/9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jeff Garzik <jgarzik-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On 12/05/2011 12:18 PM, Nicolas Pitre wrote:
> On Mon, 5 Dec 2011, Dave Martin wrote:
> 
>> On Mon, Dec 05, 2011 at 12:40:16PM -0500, Nicolas Pitre wrote:
>>> On Mon, 5 Dec 2011, Dave Martin wrote:
>>>> On Sat, Dec 03, 2011 at 10:12:53AM +1100, Benjamin Herrenschmidt wrote:
>>>>> On Fri, 2011-12-02 at 11:28 -0800, Linus Torvalds wrote:
>>>>>> Don't *change* NO_IRQ to zero (that whole #define is broken - leave it
>>>>>> around as a marker of brokenness), just start removing it from all the
>>>>>> ARM drivers that use the OF infrastructure. Which is presumably not
>>>>>> all that many yet.
>>>>>>
>>>>>> So whenever you find breakage, the fix now is to just remove NO_IRQ
>>>>>> tests, and replace them with "!irq".
>>>>>
>>>>
>>>> Russell, do you know whether it would make sense to set a timeline for 
>>>> removing NO_IRQ from ARM platforms and migrating to 0 for the no-interrupt
>>>> case?  I'm assuming that this mainly involves migrating existing hard-wired
>>>> code that deals with interrupt numbers to use irq domains.
>>>
>>> How many drivers do use IRQ #0 to start with?  We might discover that in 
>>> practice there is only a very few cases where this is an issue if 0 
>>> would mean no IRQ.
>>
>> The total number of files referring to NO_IRQ is not that huge:
>>
>> arch/arm/	188 matches in 39 files
>> drivers/	174 matches in 84 files
>>
>> Unfortunately, NO_IRQ is often not spelled "NO_IRQ".  It looks like the assumption
>> "irq < 0 === no irq" may be quite a lot more widespread than "NO_IRQ === no irq".
>> Since there's no specific thing we can grep for (and simply due to volume)
>> finding all such instances may be quite a bit harder.
> [...]
> 
> ARgh.
> 
> My point was about current actual usage of the IRQ numbered 0 which 
> probably prompted the introduction of NO_IRQ in the first place.  What I 
> was saying is that the number of occurrences where IRQ #0 is currently 
> used into drivers that would get confused if 0 would mean no IRQ is 
> probably quite small.
> 
> But as you illustrated, there is a large number of drivers that already 
> assume no IRQ is < 0, even if they don't use any IRQ #0 themselves.  
> That is a much bigger problem to fix.
> 

At least for DT enabled platforms, we could force "no irq" to be 0 in
the DT irq code. Searching the dts files, I found 2 occurrences of IRQ0.
Prima2 has timer on IRQ0, and VersatileAB has watchdog on IRQ0. Prima2
should be fine currently as it doesn't use the of_irq_* functions to get
the timer irq, but that is an issue as it skips any translation.
VersatileAB should be okay with the VIC irqdomain support.

Changing it would also affect microblaze and openrisc which have NO_IRQ
set to -1. From what I can tell, they would both be fine at least in
terms of not using IRQ0.

Also, there's roughly 50 irq_chips that need irq_domain support under
arch/arm. So that's not a simple solution either.

Rob
