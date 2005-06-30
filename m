From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: Organized summary of the pacthes
Date: Thu, 30 Jun 2005 16:43:29 +0800
Message-ID: <42C3B0B1.6090001@tw.ibm.com>
References: <42C12A10.8030308@tw.ibm.com> <42C16AFC.7010908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:62450 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262890AbVF3Ir5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jun 2005 04:47:57 -0400
In-Reply-To: <42C16AFC.7010908@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: doug_maxey@us.ibm.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


Jeff,

> Albert Lee wrote:
> 
>> Summary of the pacthes for your review (as of 6/28/2005):
>> 1. atapi_pio_bytes() fixes
>>   => Three patches pending:
>>      #1-2. __atapi_pio_bytes(): if condition fix
>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111838913812842&w=2
> 
> 
> I'll probably apply this
> 
> 
>>      #1-3. __atapi_pio_bytes(): trailing data handling fix
>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111838955410270&w=2
>>
>>      #1-4. __atapi_pio_bytes(): odd-length data handling fix
>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111838987630460&w=2
>>      Patch #1-4 will overrun the odd-length buffer by one byte. :(
>>      Maybe we can just ignore the last byte of odd-length buffer?
> 
> 
> These two patches make me REALLY nervous.  This overrun business needs 
> to be handled in a different way.
> 
> For DMA, we will want to copy 0-3 odd bytes into a 4-byte buffer, and 
> then make that 4-byte buffer than final DMA segment.
> 
> For PIO, we might as well use the same buffer, and copy the last 0-3 (or 
> 0-1?) odd bytes.
> 
> Never overrun.
> 

Thanks for the review and tolerance for the newbie blindness.
I'll revise/resubmit patch 1-3 and 1-4 per your advice.
I will also study the DMA padding/alignment advised by you and Alan.

> 
>> 2. atapi_packet_task() assertion failed fix
>>   => Revised patch submitted:
>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111830130223323&w=2
>>   => Need more revision to remove the 'case ATA_PROT_ATAPI' handling 
>> in it.
>>     (It conflicts with patch #3-2 below:
>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111951880730921&w=2)
>>
>>
>> 3. ata_pio_task() race condition fixes.
>>   => Two patches submitted. Waiting for review:
>>    #3-1  http://marc.theaimsgroup.com/?l=linux-ide&m=111958527005103&w=2
>>    #3-2  http://marc.theaimsgroup.com/?l=linux-ide&m=111951880730921&w=2
> 
> 
> These are probably OK.
> 
> However, I am pondering scrapping all the polling code, since on SATA, 
> interrupt-driven mode is much more desirable.

Is there any draft plan or design for the interrupt driven PIO code
available? Also as Alan said, PIO polling would be useful for some
situation. Any plan for libata to support both PIO polling mode and the
interrupt driven mode?

If permitted, I would like to take this opportunity to participate in
the interrupt driven PIO task, under your design guideline.

> 
> If I continue to use polling, I will (after further review) apply your 
> patches.
> 
> Luckily PIO data paths are not used by users yet (disabled by default), 
> so these problems are not urgent.
> 

The rare race conditions only occur under hours of heavy stress test.

Based on the testing result, the libata PIO polling code is quite robust.
It has been tested with harddisks, cd-rom drives and even an old
ATAPI Zip 100 floppy drive, which supports PIO only; and it works
fine. (Except high CPU usage due to the nature of polling.)

> 
>> =======
>> 4. ata_qc_complete() race condition fix.
>>   => In ata_qc_complete(),
>>      "qc->flags &= ~ATA_QCFLAG_ACTIVE;" should be _before_
>>      "rc = qc->complete_fn(qc, drv_stat);".
> 
> 
> I agree.

Thanks, will submit the patch.

> 
> 
>>   => Otherwise ata_qc_complete() might race with atapi_request_sense().
> 
> 
> If ata_qc_complete() is racing with atapi_request_sense(), more 
> synchronization is needed.  ATAPI is violating the host state machine, 
> that wants fixing.

It's false alarm.
After moving "qc->flags &= ~ATA_QCFLAG_ACTIVE" described above,
no race between ata_qc_complete() and atapi_request_sense()
is ever seen. Please ignore my false alarm.

> 
> 
>> 5. pata_pdc2027x 0.62 update
>>   => http://marc.theaimsgroup.com/?l=linux-ide&m=111474486330692&w=2
>>   => Need more revision according to libata-dev tree in git.
> 
> 
> I think this patch is not needed, once ATAPI DMA/PIO is fixed properly 
> as described above.

Mmm, quite possibly. Will defer this patch and re-test after
ATAPI DMA/PIO fixes are ready.

> 
> 
>> 6. IDENTIFY DEVICE detects phantom drive problem
>>    http://marc.theaimsgroup.com/?l=linux-ide&m=111622547309019&w=2
> 
> 
> To answer the question in your email here, we should separate hardware 
> Status register value from a new 'force_error' parameter.  This would 
> require a new test in the code
> 
>     int have_error = forced_error || (tf->status & ATA_ERR);
> 
> Eventually we need to separate out errors into separate classes (hi 
> Alan, hi Tejun), such as dma-error, bus-error, device-error, etc.  When 
> that is done, the code paths described in your email must change anyway.

Understood. Please discard this patch.

Albert





