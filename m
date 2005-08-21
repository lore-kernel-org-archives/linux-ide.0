From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs.
 intr race fix
Date: Mon, 22 Aug 2005 06:38:24 +0900
Message-ID: <4308F450.4050402@gmail.com>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com> <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:40320 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751149AbVHUVid (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:38:33 -0400
Received: by zproxy.gmail.com with SMTP id r28so632609nza
        for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 14:38:32 -0700 (PDT)
In-Reply-To: <4308F114.9020608@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org


  Howdy, Jeff.

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Jeff Garzik wrote:
>>
>>> Tejun Heo wrote:
>>>
>>>>
>>>>  Hello, Jeff.
>>>>
>>>> Jeff Garzik wrote:
>>>>
>>>>> Tejun Heo wrote:
>>>>>
>>>>>>  Hello, Jeff and Albert.
>>>>>>
>>>>>>  This patchset fixes the following race.
>>>>>> (port A has ATA device and B ATAPI).
>>>>>>
>>>>>> port B    : ata_issue_prot() (ATAPI_NODATA)
>>>>>> port B    : packet_task scheduled
>>>>>> port A    : ata_issue_prot() (DMA)
>>>>>> intr    : ata_interrupt()
>>>>>> port A    : ata_host_intr -> this is all good & dandy
>>>>>> port B    : ata_host_intr -> finishes ATAPI cmd w/ error (request 
>>>>>> sense)
>>>>>>
>>>>>>  This is where the race is, we're polling for port B's qc, we must 
>>>>>> not
>>>>>> mess with it from interrupt.  Now, port B has dangling packet_task
>>>>>> which will race w/ whatever will run on port B.
>>>>>>
>>>>>>  The problem is that we don't always protect polled ports from
>>>>>> interrupts with ata_qc_set_polling() and for non-DMA ATA commands
>>>>>> there's no way to discern if actually an IRQ has occurred (this
>>>>>> sucks), so we end up finishing the other port's command.
>>>>>>
>>>>>>  This condition occurs quite often if both port A and B are busy.  
>>>>>> The
>>>>>> most common result is assertion failure in atapi_packet_task
>>>>>> (assert(qc->flags & ATA_QCFLAG_ACTIVE)), but depending on timing and
>>>>>> on SMP, weirder things could happen, I think.
>>>>>>
>>>>>>  Note that for ATAPI_DMA, interrupt from the other port won't mess
>>>>>> with a polled command as we can tell that it's not ours with
>>>>>> bmdma_status, but, if spurious interrupt occurs on the port, the
>>>>>> packet_task will go dangling.  That's why ATAPI_DMA also needs
>>>>>> protection.  The baseline is that all polled qc's need to be 
>>>>>> protected
>>>>>> with ata_qc_set_polling() until polling task is done with the 
>>>>>> command.
>>>>>>
>>>>>>
>>>>>> [ Start of patch descriptions ]
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> While this is something to look into, the supplied patches are 
>>>>> definitely not the way we want to go.  We need to follow the state 
>>>>> diagram for the PACKET command protocol.  ATA4 [1] diagrams are a 
>>>>> good thing to read, since they include mention of the behavior of 
>>>>> certain ATAPI devices that can send an interrupt between 
>>>>> taskfile-out and write-cdb steps in the sequence.
>>>>>
>>>>> In patch #2, you're making ata_irq_on() way too heavy.  In patch 
>>>>> #1, calling ata_qc_set_polling() for non-polled commands is a hack.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>  Have you received patches in the reverse order?  #1 changes 
>>>> ata_irq_on() and #2 adds ata_qc_set_polling().
>>>>
>>>>  Hmmm, only a call to ata_chk_status() is added to ata_irq_on(), 
>>>> which I think is needed regardless of other changes, and 
>>>> ata_wait_idle() is removed.  Does that make the function heavy?
>>>>
>>>>>
>>>>> The better solution is to track the PACKET command protocol state 
>>>>> much more closely, so that the code _knows_ when it should and 
>>>>> shouldn't be getting an interrupt.
>>>>>
>>>>> This is required anyway because, as mentioned in another email, an 
>>>>> ATA device might assert INTRQ for certain events, such as non-data 
>>>>> commands, where the controller is not required to assert the BMDMA 
>>>>> IRQ bit.
>>>>>
>>>>> I _suspect_ that many host controllers cause the BMDMA IRQ bit to 
>>>>> track the ATA INTRQ status precisely, but this theory has not been 
>>>>> validated.
>>>>>
>>>>>     Jeff
>>>>>
>>>>>
>>>>> [1] http://www.t13.org/project/d1153r18-ATA-ATAPI-4.pdf
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>  Without interrupt pending information from BMDMA bit for non-DMA 
>>>> commands (which I don't think we can use for non-DMA cmds as we'll 
>>>> never be sure if all controllers behave that way), the problem is 
>>>> that for many SATA controllers, more than one ports share single 
>>>> interrupt line.   And without interrupt pending bit, shared 
>>>> interrupt means a lot of spurious interrupts making it impossible to 
>>>> know when to expect interrupts.
>>>
>>>
>>>
>>>
>>> Incorrect...  this is why I keep harping on the "ATA host state 
>>> machine."
>>>
>>> You rely on proper implementation to know when to expect interrupts. 
>>> Read the state diagrams, they tell you precisely when an interrupt 
>>> may be expected.  By definition, any other interrupt is probably a 
>>> PCI shared interrupt, or a hardware or software bug.
>>>
>>
>>  I think I'm familiar with ATA host state machine.  I don't think I'm 
>> currently saying things because I don't know about it.  Maybe I'm 
>> missing something here.  Please consider the following scenario.
>>
>> 1. non-DMA command issued.
>> 2. device does something
>> 3. another device sharing the IRQ line raises interrupt
>> 4. D2H FIS received (BSY off, DRDY on, INTR on)
>> 5. interrupt handler kicks in for #3
>> 6. SATA controller raises interrupt
>> 7. SATA handler invoked from #5 checks ATA_STATUS and determines that
>>    completes the command (we don't know if it's our interrupt or not)
>> 8. interrupt handler from #5 returns.
>> 9. interrupt handler for #6.
>> 10. nobody cared.
>>
>>  Did I miss something?
> 
> 
> This gets into interrupt controller hardware, how interrupts are 
> asserted and delivered, and similar not-IDE-specific things.
> 
> If you clear the condition (by checking ATA Status) that caused the 
> interrupt hardware to raise an interrupt, during #5 and #7, then the 
> interrupt condition is cleared in the interrupt controller hardware, and 
> the kernel should not invoke the interrupt handler again.
> 

  Ah... yes right.  Gotta be level interrupt to be shared.

> 
>>  I think the problem is whether or not we're expecting interrupts, 
>> we'll get interrupts that are't ours and we have no way to tell if 
>> they're ours or not.  No?
> 
> 
> You can tell just by following normal interrupt assertion rules, and by 
> the "if it's nor ours it's either somebody else's interrupt, or 
> out-of-spec hardware"
> 
> In addition, (slight tangent)
> * if DMA is active, you can check the DMA status bits to see if you have 
> an interrupt condition to handle
> * if DMA is not active, you can check the AltStatus register, to test 
> the state without actually clearing anything
> 
> Though beware, on rare PATA controllers (old Macs?) the AltStatus 
> register doesn't exist.
> 

  Now I see what you're saying.  We should be able to know/clear 
interrupt by reading ATA_STATUS.  So, not having explicit interrupt 
pending bit can be compensated by following changes in ATA_STATUS (so 
the state machine), right?  Thanks a lot for putting up with my ignorance.

  So, how about a port status bit to tell interrupt handler whether or 
not we are expecting an interrupt currently?  That would solve the race 
from I tried to fix in the first patchset.  If that's okay with you, 
I'll redo all four patches accordingly.

  Again, thanks a lot. :-)

-- 
tejun
