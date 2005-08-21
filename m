From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [SUMMARY] libata EH
Date: Sun, 21 Aug 2005 00:09:58 -0400
Message-ID: <4307FE96.10405@pobox.com>
References: <20050820023351.GA690@htj.dyndns.org> <4306B62F.7090509@pobox.com> <430768E2.60808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:64484 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750769AbVHUEKT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 00:10:19 -0400
In-Reply-To: <430768E2.60808@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com, mlord@pobox.com, lkosewsk@gmail.com, luben_tuikov@adaptec.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jens Axboe <axboe@suse.de>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Simple stuff like "command aborted" (invalid command) can be handled 
>> immediately, no need to kick in the error handling.

>> But as long as the right hardware interrupts are acknowledged, I don't 
>> mind if all error handling is moved to the thread.

>  My preference is toward unifying into single path as long as 
> performance penalty is acceptable for the sake of simplicity.

The hot path is completing reads and writes successfully.
Secondary hot path is completing <other commands> successfully.

For everything else, clear, simple, maintainable code is preferred over 
fast code.


>>> 2. Synchronization
>>>
>>>     * SCSI EH entrance is not synchronized with normal processing.
>>>       ATAPI error handling/timeout handling can run concurrently
>>>       with normal command processing.  Albert, I think it's the
>>>       same problem you're trying to solve by moving ATA_QCFLAG_ACTIVE
>>>       clearing.
>>>
>>>       http://marc.theaimsgroup.com/?l=linux-ide&m=112417360223374&w=2
>>
>>
>>
>> The SCSI layer stops all command processing before calling 
>> ->eh_strategy_handler().  Where do you see that it runs concurrently 
>> with normal command processing?  That should definitely -not- be 
>> happening.
>>
> 
>  There are currently two problems.
> 
>  * As we don't grab host_set lock on entry to ata_scsi_error(), we can
>    run concurrently with latter part of ata_qc_complete().  This race is
>    addressed by the following patches I've just posted.
> 
>    http://marc.theaimsgroup.com/?l=linux-ide&m=112454734102242&w=2


hmmmmm.  I can see a bit of that:

When ->eh_strategy_handler() is called, the SCSI layer has stopped 
sending commands to all ports on the specified SCSI host.

However, it looks like we can race against
(a) interrupt handler completing a command on another port
(b) interrupt handler belatedly completing a command on our port
(c) if polling, another kernel thread

(a) shouldn't matter right now, but will in the future when we take a 
host-reset action that can 'blip' all ports.
(b) is a -very- rare worry in ATA, since commands that don't complete 
after 30 seconds probably will never complete.  But given how CHECK 
CONDITION is implemented in libata's ATAPI code, falling immediately 
over to the EH, this might be a real concern for ATAPI.
(c) was mentioned in previous emails.  A rare worry.

Did I miss anything?


>  * After entering EH, normal command completion or spurious interrupt
>    can occur.  We currently don't peg those interrupts, so interrupt
>    handling can interfere with EH.

As long as it is not the local port, it shouldn't interfere with EH 
(currently).


>  As there are concerns regarding semantics of ->eh_strategy_handler and 
> it's a less-used and less-charted territory, I'm gonna try to write a 
> document describing the following.
> 
>  * How SCSI EH works and commands flow through it with the default
>    fine-grained hooks.
>  * From above, extract what ->eh_strategy_handler() should do.
>  * What libata error conditions are there and how qc's should be
>    handle.
>  * How to integrate libata EH into SCSI EH without losing commands.
> 
>  I don't how good the doc will turn out (don't expect too much), but I 
> hope it could serve as a basis for discussion if nothing else.

It would certainly be nice to get all of this written down.


>  After writing above mentioned doc, I'll try to improve/revise and break 
> down my previously posted EH patchset and explain how they conform to 
> above yet-to-be-written document such that it can be better understood 
> and easier to review/debug.

Cool.  Thank you.

I'll get those patches reviewed sometime this weekend.

	Jeff


