From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 02 Aug 2005 14:40:13 +0200
Message-ID: <42EF69AD.30201@imc-berlin.de>
References: <42EA1AB0.6070001@imc-berlin.de> <42EF439C.5000903@imc-berlin.de> <20050802104859.GG22569@suse.de> <42EF5488.9020802@imc-berlin.de> <20050802111302.GH22569@suse.de> <42EF5651.1040905@imc-berlin.de> <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de> <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de> <20050802122609.GM22569@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:54277 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S261500AbVHBMkP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2005 08:40:15 -0400
In-Reply-To: <20050802122609.GM22569@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Jens Axboe wrote:

>>>No, those waiters will be woken up when ide does an end_request for
>>>requests coming in for a device which no longer exists.
>>
>>But that would mean generating requests for devices, drives and hwifs that 
>>no longer exists. But exactly there it will crash! In do_ide_request() and 
>>ide_do_request().
> 
> 
> ide doesn't generate the requests, it just receives them for processing.
I know.

> And you want to halt that at the earliest stage possible.
Agreed.

Problems seems to be:

A refererenc to the request queue is stored in struct gendisk. Thus if you 
unregister a block device you should make sure that noone can still try to 
access that request queue, right?

>>~ # umount /mnt/pcmcia/
>>sys_umount(494)
>>generic_make_request(2859) q=c02d3040
>>__generic_unplug_device(1447) calling q->request_fn() @ c00f97e4
>>do_ide_request(1279) HWIF=c01dee8c (0), HWGROUP=c0fac2a0 (738987520), 
>>drive=c01def1c (0, 0), queue=c02d3040 (00000000)
> 
> 
> I don't understand what values you are dumping above, please explain. Is
> HWIF c01dee8c or 0?

printk("%s(%d) HWIF=%p (%d), HWGROUP=%p (%d), drive=%p (%d, %d), queue=%p 
(%p)\n", __FUNCTION__, __LINE__, hwif, hwif->present, hwgroup, hwgroup->busy, 
drive, drive->present, drive->dead, q, drive->queue);

So HWIF is a c01dee8c and hwif->present=0.

>>Assertion '(hwif->present)' failed in 
>>drivers/ide/ide-io.c:do_ide_request(1284)
>>Assertion '(drive->present)' failed in 
>>drivers/ide/ide-io.c:do_ide_request(1290)
>>ide_do_request(1133) hwgroup is busy!
>>ide_do_request(1135) hwif=01000406
>>
>>The "738987520" above is hwgroup->busy! Obviously completly wrong. This 
>>seems to be a hint that an invalid pointer is dereferenced! The pointer 
>>hwif=01000406 also does not look very healthy! drive=c01def1c is the result 
>>of
> 
> 
> Yeah it looks very bad. Same thing with the reference counting, ide
> should not be freeing various structures that the block layer still
> holds a reference to.

Well or better tell the block layer that the drive is gone and it makes no sense 
to make any requests ...

>>So how could you generate requests (and handle them sanely) for devices 
>>that where removed?
> 
> Generation is not a problem, that happens outside of your scope. The job
> of the driver is just to make sure that it plays by the rule and at
> least makes sure it doesn't crash on its own for an active queue.

do_ide_request() could check hwif->present and/or drive->present.
BUT: at this point the request is already made and the low level block layer is 
sleeping and waiting for it's completion.
I could not figure out how to kill a request in do_ide_request() and wake up the 
block layer (sleeping in __wait_on_buffer()).
That's why I thought preventing the generation of such reuqests would be the 
right way.

> I suggest you take it up with Bart how best to solve this. He might even
> already have patches.
Bart? Are you there?

--
Steven
