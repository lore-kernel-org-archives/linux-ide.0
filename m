From: Mark Lord <liml@rtr.ca>
Subject: Re: libata EH appears to be NFG up to 2.6.17 (at least).
Date: Fri, 07 Jul 2006 09:03:29 -0400
Message-ID: <44AE5BA1.6000409@rtr.ca>
References: <44AD749C.1070208@rtr.ca> <44AD76CA.40100@pobox.com> <44AD77D5.90905@rtr.ca> <200607061724.13448.liml@rtr.ca> <44AD8A25.7020006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3482 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751186AbWGGNDb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jul 2006 09:03:31 -0400
In-Reply-To: <44AD8A25.7020006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Ric Wheeler <ric@emc.com>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Enable libata-scsi to report correct sense data on errors.
>>
>> Signed-off-by:  Mark Lord <mlord@pobox.com>
>> ---
>> --- linux/drivers/scsi/libata-scsi.c.orig    2006-07-06 
>> 17:09:54.000000000 -0400
>> +++ linux/drivers/scsi/libata-scsi.c    2006-07-06 17:17:43.000000000 
>> -0400
>> @@ -667,6 +667,13 @@
>>      qc->ap->ops->tf_read(qc->ap, tf);
>>  
>>      /*
>> +     * Restore the error bit, which got cleared when the
>> +     * interrupt handler first read the ata_status.
>> +     */
>> +    if (qc->err_mask & AC_ERR_DEV)
>> +        tf->command |= ATA_ERR;
>> +
>> +    /*
>>       * Use ata_to_sense_error() to map status register bits
> 
> 
> Again it's an LLDD issue.  Your answer of "all LLDDs" sounds a bit 
> suspicious.
> 
> AC_ERR_DEV should not be set unless (a) some code noticed that ATA_ERR 
> was already present in the Status register, or (b) some code set 
> AC_ERR_DEV for some reason other than ATA_ERR presence.  Both of those 
> factors depend heavily on LLDD behavior.

So that *is* the meaning of AC_ERR_DEV --> "LLDD saw ATA_ERR" ?
I'm just not sure whether to check for that one bit,
or for any bit set in qc->err_mask.

Of course even doing this is not at all foolproof -- the code in libata-scsi
will then go and read the ATA status again (along with all of the others),
and the drive/software may well have cleared/changed bits by then.

In fact, you've even had isolated bug reports from the past month with
exactly this happening -- where the reported error status was 0x50
by the time libata-scsi got hold of it.

I dunno what the new EH does (yet), but the only good way to deal with this
is for the ATA status & error values to be read *and* saved on command completion,
and then reused by any later code that needs to do detailed sense reporting
or other diagnostics.

With NCQ/TCQ, this can be tough to achieve, possibly requiring the LLDD to 
drop to legacy mode on error, and capture the values there.  Of course, by then
it's too late to be perfect, as the host controller has probably already read
and discarded the drive status at least once.  (the PDC sata_qstor device
is an exception there -- they save/return failed status during queuing).

In summary, when a command fails, we need to save the failed status and
error values that we saw when we decided it fails.  Reading them again later
is not optimal, because they can change in the interim (asynchronous notifications,
or just drives that like to clear ERR after status is read).

I'm out today, but I'll try and fiddle with this some more on the weekend.
I have several host controllers here to try this with.

Cheers
