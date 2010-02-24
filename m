From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: bad performance with SSD since kernel version 2.6.32
Date: Wed, 24 Feb 2010 20:05:43 +0100
Message-ID: <20100224190543.GE1025@kernel.dk>
References: <20100221225544.5a9ded51@pluto-lenny.milky.way> <51f3faa71002211400u2177660ei1c0dc3d9306b146e@mail.gmail.com> <20100222141802.2bcbf607@pluto-lenny.milky.way> <20100222190522.GD1025@kernel.dk> <4B82FBF4.10702@teksavvy.com> <51f3faa71002221522p74744f28ue1bb3db4558818c9@mail.gmail.com> <20100223062123.GG1025@kernel.dk> <4B854136.5080305@teksavvy.com> <20100224153409.GC1025@kernel.dk> <4B854A4C.3060702@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 0122700014.0.fullrate.dk ([95.166.99.235]:43787 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757579Ab0BXTFp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Feb 2010 14:05:45 -0500
Content-Disposition: inline
In-Reply-To: <4B854A4C.3060702@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "Benjamin S." <sbenni@gmx.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Wed, Feb 24 2010, Mark Lord wrote:
> On 02/24/10 10:34, Jens Axboe wrote:
>> On Wed, Feb 24 2010, Mark Lord wrote:
>>> On 02/23/10 01:21, Jens Axboe wrote:
>>>> On Mon, Feb 22 2010, Robert Hancock wrote:
>>>>> On Mon, Feb 22, 2010 at 3:49 PM, Mark Lord<kernel@teksavvy.com>   wrote:
>>>>>> On 02/22/10 14:05, Jens Axboe wrote:
>>>>>>
>>>>>> --- a/block/blk-core.c
>>>>>> +++ b/block/blk-core.c
>>>>>> ...
>>>>>> @@ -1857,8 +1857,15 @@ void blk_dequeue_request(struct request *rq)
>>>>>>           * and to it is freed is accounted as io that is in progress at
>>>>>>           * the driver side.
>>>>>>           */
>>>>>> -       if (blk_account_rq(rq))
>>>>>> +       if (blk_account_rq(rq)) {
>>>>>>                  q->in_flight[rq_is_sync(rq)]++;
>>>>>> +               /*
>>>>>> +                * Mark this device as supporting hardware queuing, if
>>>>>> +                * we have more IOs in flight than 4.
>>>>>> +                */
>>>>>> +               if (!blk_queue_queuing(q)&&   queue_in_flight(q)>   4)
>>>>>> +                       set_bit(QUEUE_FLAG_CQ,&q->queue_flags);
>>>>>> +       }
>>>>>>    }
>>>>>> ...
>>>>>>
>>>>>> Mmm.. So is this code actually trying to rely upon the software being quick
>>>>>> enough to queue five or more commands before the drive completes one of
>>>>>> them?
>>>>
>>>> Yes, it'll trigger easily. If it's the boot drive, it'll be on before
>>>> booting has completed.
>>> ...
>>>
>>> Mmm.. but that all assumes (1) a fast CPU and (2) a slow mechanical drive.
>>> Neither of which are true in many modern systems.
>>
>> No, that's simply not true. I didn't base the above comment on
>> speculation, it's observed behaviour. Granted it's a heuristic and as
>> such not infallible, but it works much better than you seem to assume.
>>
>> FWIW, on both my desktop and laptop with SSD drives it's on before on
>> before you log in. Besides, the code wont have any effect on a
>> mechanical drive (slow or not), since it's specifically only on for
>> non-rotation drives.
> ..
>
> Okay, so it works for you, and fails for others.

You are misunderstanding the issue completely, it's not about that
particular piece of logic working of failing. As a matter of fact, it's
most definitely working for the reporter of the issue as well, or he
would not see the performance regression he's seeing. The issue (and the
reason for the revert) is the plugging itself, which is altered by the
logic having triggered.

> Good to see it reverted for now in 2.6.33, but what about 2.6.32 as well ?

I'll make sure it gets to stable as well, of course.

-- 
Jens Axboe

