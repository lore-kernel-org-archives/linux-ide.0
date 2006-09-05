From: Ric Wheeler <ric@emc.com>
Subject: Re: faulty disk testing
Date: Tue, 05 Sep 2006 10:19:45 -0400
Message-ID: <44FD8781.9040905@emc.com>
References: <44FCD328.3020800@emc.com> <44FD662A.6060404@gmail.com> <44FD803B.3040000@pobox.com> <44FD84E8.8000705@gmail.com>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:9438 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S964794AbWIEOVh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Sep 2006 10:21:37 -0400
In-Reply-To: <44FD84E8.8000705@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo wrote:
> Hello, Mark.
> 
> Mark Lord wrote:
> 
>> Sure it does.  It can determine the number of consecutive failures on
>> the same drive/channel, and it can also count intervening successes, 
>> if any.
>>
>> From that, at a minimum, it could notice that the same drive has gone 
>> 'round
>> the error treadmill (say) 20 times in a row, with no other I/O 
>> possible on it
>> because it has yet to successfully complete the reset+reinit phase.
> 
> 
> If a device fails reset+reinit phase a few times, libata surely drops 
> the device, but I don't think the kernel can drop a device because it 
> failed, say, 20 consecutive IO commands when it can respond to reset and 
> reinit.  That's where policy needs to come in, IMHO.
> 
> For Ric's case, I'm waiting for more info.  If EH is looping forever 
> without reporting to upper layer, it definitely needs fixing, but I 
> don't think that's the case.

Let me know what is useful here - I am working on the quick run with 
your new-init git tree & will do a second run with ATA_DEBUG enabled.  I 
also want to validate the disk interaction on the analyzer this morning.

> 
>> Such a drive is a candidate for pushing the error upstairs,
>> and possibly for getting offlined.
>>
>> Fancier fault-handling is also possible, but the bare minimum is that we
>> must not get stuck forever looping in the EH code.  Eventually a 
>> failed status
>> has to be returned to the layers above, I think.
> 
> 
> Error is always pushed upstairs.  libata itself doesn't initiate any 
> kind of retrials.  That's upto high level driver - in this case, sd.

If the error does pop out from SD, MD should (and has in the past) drop 
the drive from the array.

This certainly could be either the SD layer or the MD layer on top of 
that - it seems that my hardware friend injected the faulty sector onto 
the MD super block, so it might be a special path through MD.


> 
> One of the problems is that currently libata EH can take some minutes 
> recovering from an error condition.  With partial request retry from sd, 
>  a batch of consecutive bad sectors can make recovery take a really long 
> time.  This needs fixing.

So far, the new-init build has been running the recovery in the lab for 
about 40 minutes ;-)

regards,

ric

