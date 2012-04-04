From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH v2 1/3] PATA host controller driver for ep93xx
Date: Wed, 04 Apr 2012 17:16:30 +0200
Message-ID: <4F7C65CE.6000309@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl> <201204032008.00509.arnd@arndb.de> <4F7C4142.1010709@metasoft.pl> <201204041323.36695.arnd@arndb.de> <4F7C64B8.5000909@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:59903 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756672Ab2DDPRa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Apr 2012 11:17:30 -0400
In-Reply-To: <4F7C64B8.5000909@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, H Hartley Sweeten <hartleys@visionengravers.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Sergei Shtylyov <sshtylyov@mvista.com>, "bzolnier@gmail.com" <bzolnier@gmail.com>, "rmallon@gmail.com" <rmallon@gmail.com>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>

On 2012-04-04 17:11, Rafal Prylowski wrote:
> On 2012-04-04 15:23, Arnd Bergmann wrote:
>> On Wednesday 04 April 2012, Rafal Prylowski wrote:
>>> On 2012-04-03 22:08, Arnd Bergmann wrote:
>>>>>> +static void ep93xx_pata_wait_for_iordy(void __iomem *base)
>>>>>> +{
>>>>>> +     unsigned long deadline = jiffies + msecs_to_jiffies(1000);
>>>>>> +     while (!ep93xx_pata_check_iordy(base) &&
>>>>>> +             time_is_before_jiffies(deadline))
>>>>>> +             cpu_relax();
>>>>>> +}
>>>>
>>>> Much better for a delay than the previous version. However, it's
>>>> still a busy wait, which is bad for realtime behavior, especially
>>>> since this can potentially take many milliseconds. If possible,
>>>> it should have an msleep() or at least cond_resched() instead of
>>>> the cpu_relax(). Obviously that will only work when no spinlocks
>>>> are held.
>>>>
>>>
>>> Unfortunately, we can't use msleep() or cond_resched() here
>>> - ep93xx_pata_wait_for_iordy() is called from interrupt handler.
>>
>> Well, it also seems inappropriate to have a one second delay timeout
>> inside of the interrupt handler.
>>
>> I suppose if you are emulating what a regular read of the status
>> register does, there isn't much to improve here though.
>>
>> 	Arnd
> 
> According to ATA specification, maximum IORDY pulse width is 1250ns,
> so I'll set timeout to 2ms (I should check this before posting the driver..).

2ms is far too big value... Should be 2us.

RP
