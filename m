From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: Commit 7eaceaccab5f40 causing boot hang.
Date: Thu, 31 Mar 2011 11:02:37 +0200
Message-ID: <4D94432D.5080601@fusionio.com>
References: <201103291551.p2TFpDqZ001692@clem.clem-digital.net> <4D92C874.7040104@parallels.com> <4D931634.5030807@fusionio.com> <4D933584.5050005@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.fusionio.com ([64.244.102.30]:46810 "EHLO mx1.fusionio.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607Ab1CaJCl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Mar 2011 05:02:41 -0400
In-Reply-To: <4D933584.5050005@parallels.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Landley <rlandley@parallels.com>
Cc: Pete Clements <clem@clem.clem-digital.net>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 2011-03-30 15:52, Rob Landley wrote:
> On 03/30/2011 06:38 AM, Jens Axboe wrote:
>> On 2011-03-30 08:06, Rob Landley wrote:
>>> On 03/29/2011 10:51 AM, Pete Clements wrote:
>>>> Quoting Jens Axboe
>>>>   > 
>>>>   > On 2011-03-29 16:13, Rob Landley wrote:
>>>>   > > On 03/29/2011 08:59 AM, Jens Axboe wrote:
>>>>   > >> On 2011-03-29 10:52, Rob Landley wrote:
>>>>   > >>> I'm booting all this under kvm or qemu, by the way:
>>>>   > >>>
>>>>   > >>> qemu-system-x86_64 -m 1024 -kernel arch/x86/boot/bzImage \
>>>>   > >>>   -hda ~/sid.ext3 -append "root=/dev/hda rw"
>>>>   > >>>
>>>>   > >>> Sometimes with init=/bin/bash in that last quoted bit.  The root
>>>>   > >>> filesystem's debian sid but that's probably not relevant because it
>>>>   > >>> worked fine with .38.
>>>>   > >>
>>>>   > >> Does this help?
>>>>   > >>
>>>>   > >> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
>>>>   > >> index 0e406d73..ca27d30 100644
>>>>   > >> --- a/drivers/ide/ide-io.c
>>>>   > >> +++ b/drivers/ide/ide-io.c
>>>>   > >> @@ -570,8 +570,7 @@ void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
>>>>   > >>  	spin_unlock_irqrestore(q->queue_lock, flags);
>>>>   > >>  
>>>>   > >>  	/* Use 3ms as that was the old plug delay */
>>>>   > >> -	if (rq)
>>>>   > >> -		blk_delay_queue(q, 3);
>>>>   > >> +	blk_delay_queue(q, 3);
>>>>   > >>  }
>>>>   > >>  
>>>>   > >>  static int drive_is_ready(ide_drive_t *drive)
>>>>   > >>
>>>>   > > 
>>>>   > > Nope, still hung the same way.
>>>>   > 
>>>>   > Funky. I'll try and reproduce this tonight.
>>>>   > 
>>>>   > -- 
>>>>   > Jens Axboe
>>>>   > 
>>>>
>>>> I have had a similiar problem (reported earlier) unable to boot.
>>>> With git15-18 hung with IDE drives (hda), git19-21 moved the hang down to
>>>> the IDE CDROM (hdc). Applied the above patch and now booted into git21 without
>>>> any hang and all appears ok.
>>>
>>> It may have made it better for me, it's hard to tell.
>>>
>>> I did a fresh pull, re-applied the patch, and tried again with
>>> init=/bin/sh and it booted to the shell prompt... which then hung when I
>>> did "ls -l /".
>>>
>>> If I let it boot normally, init announces itself, gives a spurious
>>> warning about a fstab field (which it's been doing for a while, my fault
>>> but harmless), then hangs.
>>>
>>>> This is i386, UP.
>>>
>>> I'm doing x86-64 SMP.
>>
>> I think we have the same issue the other location. How about this, then:
>>
>> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
>> index 0e406d73..4978ec3 100644
>> --- a/drivers/ide/ide-io.c
>> +++ b/drivers/ide/ide-io.c
>> @@ -549,12 +549,11 @@ plug_device:
>>  	spin_unlock_irq(&hwif->lock);
>>  	ide_unlock_host(host);
>>  plug_device_2:
>> +	blk_delay_queue(q, queue_run_ms);
>>  	spin_lock_irq(q->queue_lock);
>>  
>> -	if (rq) {
>> +	if (rq)
>>  		blk_requeue_request(q, rq);
>> -		blk_delay_queue(q, queue_run_ms);
>> -	}
>>  }
>>  
>>  void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
>> @@ -570,8 +569,7 @@ void ide_requeue_and_plug(ide_drive_t *drive, struct request *rq)
>>  	spin_unlock_irqrestore(q->queue_lock, flags);
>>  
>>  	/* Use 3ms as that was the old plug delay */
>> -	if (rq)
>> -		blk_delay_queue(q, 3);
>> +	blk_delay_queue(q, 3);
>>  }
>>  
>>  static int drive_is_ready(ide_drive_t *drive)
>>
> 
> Did a fresh pull and applied that patch.  (It conflicts with your
> previous one, but looks like it includes it.)
> 
> Now it hangs after the "EXT3-fs: barriers not enabled" line, doesn't
> make it to init.

I have tried hard to reproduce this, but even stock 2.6.39-rc1 works
fine for me here. Setup a KVM image with a debian 6 install, then
converted it to IDE and booting it with a custom kernel like you are.
Works fine, boots and I can do disk activity tests and it all works.

Can you send me your .config?

-- 
Jens Axboe

