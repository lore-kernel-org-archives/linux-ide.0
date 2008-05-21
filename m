From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] ata: fix sleep-while-holding-spinlock in sata_nv
Date: Wed, 21 May 2008 08:31:26 -0600
Message-ID: <4834323E.1060608@shaw.ca>
References: <fa.m+kShlzXY/wmFlvZXsE0W7wQIxU@ifi.uio.no>
 <48338624.3000304@shaw.ca> <20080520214311.2d2aa8d3@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935491AbYEUOdt@vger.kernel.org>
In-reply-to: <20080520214311.2d2aa8d3@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

rjan van de Ven wrote:
>> I'm not certain this is safe to do it quite this way. It would be
>> better to keep that spinlock held so that no operations could be in
>> progress on either port while these operations are happening.
> 
> blk_bounce_limit can sleep. that's just a fact of life ;(

Now it can, for no reason. Under the conditions it was used before, it 
never could.

> 
>> It would be better to fix the regression from 
>> 419c434c35614609fd0c79d335c134bf4b88b30b in block/blk_settings.c that 
>> resulted in the blk_queue_bounce_limit allocation wrongly allocating 
>> emergency ISA pages in the first place as a 32-bit DMA mask does not 
>> need them.
> 
> the condition under which it sleeps might be slightly buggy on your
> exact x86 machine... but that doesn't mean that that is guaranteed to
> be so forever going forward.... it's still a sleeping function.

More than slightly buggy, I think.. It seems like it is going to be 
bouncing block layer accesses to devices with 32-bit DMA masks through 
the 16MB ZONE_DMA. If that's what's actually going on, I'm surprised 
there haven't been more regression reports. The fact that the function 
now sleeps when it didn't before is the least of the problems here..
