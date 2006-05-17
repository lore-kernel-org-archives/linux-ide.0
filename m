From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 10:27:18 +0900
Message-ID: <446A7BF6.3090103@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6E6F.8010201@gmail.com> <446A7794.80909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.236]:19412 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751068AbWEQB1Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 21:27:25 -0400
Received: by wr-out-0506.google.com with SMTP id i5so110470wra
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2006 18:27:24 -0700 (PDT)
In-Reply-To: <446A7794.80909@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: ric@emc.com, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Jeff Garzik wrote:
>>>> Tejun Heo wrote:
>>>>> Hmmm.. The drive is issuing SDB FIS which completes already 
>>>>> completed tags.  This could be dangerous.  Depending on timing, it 
>>>>> might end up finishing a command which occupied the slot which 
>>>>> hasn't been processed yet.  If a drive does this, NCQ shouldn't be 
>>>>> enabled for it.  Can you post full boot dmesg?
>>>>
>>>> I'm not sure the data supports that conclusion?  PORT_IRQ_SDB_FIS is 
>>>> quite normal and expected during NCQ operation, if that interrupt is 
>>>> enabled.  Just normal SDB:Entry and SDB:SetIntr states.
>>>
>>> Strike that last part:  PORT_IRQ_SDB_FIS will appear, as with other 
>>> status bits, even if the enable bit is not set.
>>>
>>> So, you'll see that whenever you get an SDB FIS during normal operation.
>>
>> The problem is with the second dword.  Here are some of spurious SDB 
>> FISes Ric's AHCI was receiving.
>>
>> 004040a1:10000000
>> 004040a1:00000020
>> 004040a1:00000080
>>
>> If the second dword were all zero, it's simply SDB FIS turning on IRQ 
>> (bit 14 of the first dword) and there's nothing to worry about. 
>> However, all those spurious SDBs have one bit set in the second dword 
>> - meaning the SDB completes the corresponding tag, but the tag isn't 
>> active when those SDBs are received.
>>
>> This is okay as long as the controller thinks the tags are unoccupied 
>> when those SDBs are received, but it's not something which can be 
>> guaranteed.  NCQ command synchronization depends on devices not 
>> completing the same commands more than once.
>>
>> The duplicate completions might be okay if the drive guarantees it 
>> doesn't send it if it loses to command issuance.  e.g.
>>
>> 1. drive sends completion for tag x
>> 2. drive shortly schedules another completion for tag x (spurious)
>> 3. ahci/driver complete tag x
>> 4. ahci/driver issues tag x
>> 5. drive receives command for tag x before sending the spurious 
>> completion and determines not to send the spurious completion. (not 
>> very likely)
>>
>> If above is true, the drive might be okay, but nobody can guarantee 
>> how  various controllers react.  It depends on how controllers manage 
>> SActive (when to turn bits on).  At any rate, it's dangerous IMHO.
> 
> If the silicon is screwing up SActive bits, then we have bigger problems 
> than spurious interrupts.
> 
> So, the typical policy of Internet servers applies here:  "be liberal in 
> what you accept."  For smart controllers like AHCI, we will simply set 
> the desired IRQ mask, then happily receive and ack events anytime the 
> controller decides to raise them.  If the controller decides to send us 
> a no-op, don't worry about it.  This is particularly true when we turn 
> on Command Coalescing, where we'll have a run of work initiated 
> [sometimes] by an internal timer, rather than an actual FIS reception.

I wish I could explain it better.  This is a clear protocol violation 
from the drive.  Depending on specific implementation of the drive and 
the controller, it can result in completion of command which is not 
processed yet (data corruption!).

If I'm misunderstanding something, please point out.

> Side note:  remember that !BSY denotes that the device may accept 
> another [NCQ] command (something AHCI doesn't appear to check...).  The 
> device is free within NCQ rules to give itself some breathing room, and 
> not indicate its ready for new commands immediately.
> 
> Currently it appears to be a bug in ahci that we do not check for !BSY, 
> but simply assume the device is ready if queue is not full.

AFAIK, unless we do CLO explicitly, AHCI takes care of BSY waiting, NCQ 
or not.

-- 
tejun
