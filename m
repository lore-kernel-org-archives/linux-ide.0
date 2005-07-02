From: Tejun Heo <htejun@gmail.com>
Subject: Re: Organized summary of the pacthes
Date: Sat, 02 Jul 2005 14:24:00 +0900
Message-ID: <42C624F0.8060406@gmail.com>
References: <42C12A10.8030308@tw.ibm.com> <42C16AFC.7010908@pobox.com> <42C3B0B1.6090001@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:5362 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261477AbVGBFYJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jul 2005 01:24:09 -0400
Received: by wproxy.gmail.com with SMTP id i2so489767wra
        for <linux-ide@vger.kernel.org>; Fri, 01 Jul 2005 22:24:07 -0700 (PDT)
In-Reply-To: <42C3B0B1.6090001@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, doug_maxey@us.ibm.com, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Albert Lee wrote:
> 
> Jeff,
> 
>> Albert Lee wrote:
>>
>>> Summary of the pacthes for your review (as of 6/28/2005):
>>> 1. atapi_pio_bytes() fixes
>>>   => Three patches pending:
>>>      #1-2. __atapi_pio_bytes(): if condition fix
>>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111838913812842&w=2
>>
>>
>>
>> I'll probably apply this
>>
>>
>>>      #1-3. __atapi_pio_bytes(): trailing data handling fix
>>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111838955410270&w=2
>>>
>>>      #1-4. __atapi_pio_bytes(): odd-length data handling fix
>>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111838987630460&w=2
>>>      Patch #1-4 will overrun the odd-length buffer by one byte. :(
>>>      Maybe we can just ignore the last byte of odd-length buffer?
>>
>>
>>
>> These two patches make me REALLY nervous.  This overrun business needs 
>> to be handled in a different way.
>>
>> For DMA, we will want to copy 0-3 odd bytes into a 4-byte buffer, and 
>> then make that 4-byte buffer than final DMA segment.
>>
>> For PIO, we might as well use the same buffer, and copy the last 0-3 
>> (or 0-1?) odd bytes.
>>
>> Never overrun.
>>
> 
> Thanks for the review and tolerance for the newbie blindness.
> I'll revise/resubmit patch 1-3 and 1-4 per your advice.
> I will also study the DMA padding/alignment advised by you and Alan.
> 
>>
>>> 2. atapi_packet_task() assertion failed fix
>>>   => Revised patch submitted:
>>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111830130223323&w=2
>>>   => Need more revision to remove the 'case ATA_PROT_ATAPI' handling 
>>> in it.
>>>     (It conflicts with patch #3-2 below:
>>>      http://marc.theaimsgroup.com/?l=linux-ide&m=111951880730921&w=2)
>>>
>>>
>>> 3. ata_pio_task() race condition fixes.
>>>   => Two patches submitted. Waiting for review:
>>>    #3-1  http://marc.theaimsgroup.com/?l=linux-ide&m=111958527005103&w=2
>>>    #3-2  http://marc.theaimsgroup.com/?l=linux-ide&m=111951880730921&w=2
>>
>>
>>
>> These are probably OK.
>>
>> However, I am pondering scrapping all the polling code, since on SATA, 
>> interrupt-driven mode is much more desirable.
> 
> 
> Is there any draft plan or design for the interrupt driven PIO code
> available? Also as Alan said, PIO polling would be useful for some
> situation. Any plan for libata to support both PIO polling mode and the
> interrupt driven mode?
> 
> If permitted, I would like to take this opportunity to participate in
> the interrupt driven PIO task, under your design guideline.
> 

  Hi, Albert.

  For interrupt-driven PIO, IDE driver should be an example albeit quite 
complex.  Once interrupt-driven PIO is implemented, IMHO, generic 
polling IO can easily be added by calling interrupt handler periodically 
while the driver is expecting notification (any command is in-flight). 
Most low-level SATA driver interrupt handlers are already ready to 
handle spurious interrupts, and maybe we can add a flag to disable 
polling for those unable to swallow spurious interrupts if any such 
device/driver exsits.

-- 
tejun
