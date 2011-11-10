From: Jeff Garzik <jeff@garzik.org>
Subject: Re: linux-next: Tree for Oct 11 (ata/pata_of_platform.c)
Date: Thu, 10 Nov 2011 13:18:58 -0500
Message-ID: <4EBC1592.2060307@garzik.org>
References: <20111011201127.455df266dcbffb1d621f8576@canb.auug.org.au> <4E94A920.40503@xenotime.net> <4E987829.3080104@xenotime.net> <20111110135703.GA23609@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20111110135703.GA23609@elte.hu>
Sender: linux-next-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On 11/10/2011 08:57 AM, Ingo Molnar wrote:
>
> * Randy Dunlap<rdunlap@xenotime.net>  wrote:
>
>> On 10/11/2011 01:37 PM, Randy Dunlap wrote:
>>> On 10/11/11 02:11, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> The linux-next tree is now available from
>>>> git://github.com/sfrothwell/linux-next.git as a temporary measure while
>>>> the kernel.org servers are unavailable.
>>>>
>>>> It may also turn up on git.kernel.org (depending on the mirroring).  The
>>>> patch set is still absent, however.
>>>>
>>>> Changes since 20111007:
>>>>
>>>> Removed tree: ide (at the maintainer's request)
>>>
>>>
>>> drivers/ata/pata_of_platform.c:55:13: error: 'NO_IRQ' undeclared (first use in this function)
>>
>>
>> [adding Author: Anton]
>>
>> Build error still present in linux-next of 20111014.
>
> This build failure regression report was ignored twice and then
> pushed upstream and is still unfixed a month after the initial
> report. Upstream now fails to build on like 25% of x86 configs.
>
> What's going on with this bug guys?


Hum, I missed it in my LKML scans, and never got a CC.

Will merge Anton's patch immediately...

	Jeff
