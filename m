From: <Stuart_Hayes@Dell.com>
Subject: RE: ide-cd question
Date: Thu, 24 Mar 2005 17:01:15 -0600
Message-ID: <7A8F92187EF7A249BF847F1BF4903C040AFC98@ausx2kmpc103.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:61555 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261207AbVCXXBS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2005 18:01:18 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: stuarthayes@austin.rr.com, axboe@suse.de, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Thu, 17 Mar 2005 10:17:58 -0600, Stuart_Hayes@dell.com
> <Stuart_Hayes@dell.com> wrote: 
>> Jens Axboe wrote:
>>> On Fri, Mar 04 2005, Stuart_Hayes@Dell.com wrote:
>>>> 
>>>>> 
>>>>> There's still a problem here, you are not initializing nsectors
>>>>> for non-pc requests. And your comments wrap :)
>>>>> 
>>>>>         int nsectors = rq->hard_nr_sectors;
>>>>> 
>>>>>         if (blk_pc_request(rq))
>>>>>                 nsectors = (rq->data_len + 511) >> 9;         if
>>>>>                 (!nsectors) nsectors = 1;
>>>>> 
>>>>>         ...
>>>>> 
>>>>> Can you resend with that fixed up and with a Signed-off-by header?
>>>> 
>>>> Here it is.  Thanks for all the help.  I'm attaching as a file,
>>>> too, just in case it gets garbled again.
>>>> Stuart
>>>> 
>>>> 
>>>> Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>
>>>> 
>>>> --- linux-2.6.11/drivers/ide/ide-io.c.orig   2005-03-04
>>>> 16:11:14.000000000 -0500 +++ linux-2.6.11/drivers/ide/ide-io.c   
>>>>              2005-03-04 16:19:19.000000000 -0500 @@ -516,7 +516,19
>>>> @@ static ide_startstop_t ide_atapi_error(i
>>>> hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG); 
>>>> 
>>>>      if (rq->errors >= ERROR_MAX) {
>>>> -            drive->driver->end_request(drive, 0, 0); +           
>>>> /* +             * make sure request is fully ended--otherwise the
>>>> +             * command will be retried without rq->errors getting
>>>> +             * reset to zero, which could cause us to get stuck
>>>> +             * in a loop with infinite retries without any more +
>>>> * reset attempts +            */ +            int nsectors =
>>>> rq->hard_nr_sectors; +            if (blk_pc_request(rq))
>>>> +                    nsectors = (rq->data_len + 511) >> 9; +      
>>>> if (!nsectors) +                    nsectors = 1;
> 
> ide_end_request() handles this case differently and this code path is
> used not only by ide-cd. 
> 
> You've changed the current behavior here.

The idea is to make sure that ide_end_request() actually does end the
request.

I don't think I ever said, but the problem I'm seeing occurs when an
IDE CD stops responding at all--it is as if it was unplugged from 
the system.  In this case, the busy bit in the status register reads
as "1", so the command never gets past the ide_wait_stat() that's
done in start_request before do_request() is called.

ide_wait_stat() then calls ide_atapi_error(), which does its thing, 
and the command goes back to start_request... after a couple loops of 
this, ide_atapi_error() decides to give up and end the request... but
ide_end_request() *isn't* ending the request, and it is stuck in the
queue getting retried forever, which doesn't seem desirable.

The patch will make ide_end_request actually end the request, though
I admit it isn't a particularly elegant way of doing so.

Do you agree that this is worth fixing?  If so, do you have any
suggestion as to how else it might be fixed?  It seems to me that
this would be a good thing to do for any device, not just CD-ROMs.


> The question is - what are the consequences of that?
> 
>>>> +            drive->driver->end_request(drive, 0, nsectors);     
>>>>              } else { if ((rq->errors & ERROR_RESET) ==
>>>>                      ERROR_RESET) { ++rq->errors;
>>> 
>>> Looks good, Bart care to pick this up?
> 
> This is not so obvious for me...
> 
>>> Signed-off-by: Jens Axboe <axboe@suse.de>
>> 
>> Bart--
>> 
>> Is there a chance you might pick this up, or is there a problem with
>> it? 
>> 
>> Thanks
>> Stuart

