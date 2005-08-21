From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs.
 intr race fix
Date: Mon, 22 Aug 2005 05:17:02 +0900
Message-ID: <4308E13E.6070104@gmail.com>
References: <20050820091651.486821E0@htj.dyndns.org> <4308DA57.9000303@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:60105 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751125AbVHUVMd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:12:33 -0400
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.207])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LKI9wQ009015
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 13:18:10 -0700
Received: by rproxy.gmail.com with SMTP id r35so852679rna
        for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 13:17:07 -0700 (PDT)
In-Reply-To: <4308DA57.9000303@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org


  Hello, Jeff.

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>>  Hello, Jeff and Albert.
>>
>>  This patchset fixes the following race.
>> (port A has ATA device and B ATAPI).
>>
>> port B    : ata_issue_prot() (ATAPI_NODATA)
>> port B    : packet_task scheduled
>> port A    : ata_issue_prot() (DMA)
>> intr    : ata_interrupt()
>> port A    : ata_host_intr -> this is all good & dandy
>> port B    : ata_host_intr -> finishes ATAPI cmd w/ error (request sense)
>>
>>  This is where the race is, we're polling for port B's qc, we must not
>> mess with it from interrupt.  Now, port B has dangling packet_task
>> which will race w/ whatever will run on port B.
>>
>>  The problem is that we don't always protect polled ports from
>> interrupts with ata_qc_set_polling() and for non-DMA ATA commands
>> there's no way to discern if actually an IRQ has occurred (this
>> sucks), so we end up finishing the other port's command.
>>
>>  This condition occurs quite often if both port A and B are busy.  The
>> most common result is assertion failure in atapi_packet_task
>> (assert(qc->flags & ATA_QCFLAG_ACTIVE)), but depending on timing and
>> on SMP, weirder things could happen, I think.
>>
>>  Note that for ATAPI_DMA, interrupt from the other port won't mess
>> with a polled command as we can tell that it's not ours with
>> bmdma_status, but, if spurious interrupt occurs on the port, the
>> packet_task will go dangling.  That's why ATAPI_DMA also needs
>> protection.  The baseline is that all polled qc's need to be protected
>> with ata_qc_set_polling() until polling task is done with the command.
>>
>>
>> [ Start of patch descriptions ]
> 
> 
> While this is something to look into, the supplied patches are 
> definitely not the way we want to go.  We need to follow the state 
> diagram for the PACKET command protocol.  ATA4 [1] diagrams are a good 
> thing to read, since they include mention of the behavior of certain 
> ATAPI devices that can send an interrupt between taskfile-out and 
> write-cdb steps in the sequence.
> 
> In patch #2, you're making ata_irq_on() way too heavy.  In patch #1, 
> calling ata_qc_set_polling() for non-polled commands is a hack.

  Have you received patches in the reverse order?  #1 changes 
ata_irq_on() and #2 adds ata_qc_set_polling().

  Hmmm, only a call to ata_chk_status() is added to ata_irq_on(), which 
I think is needed regardless of other changes, and ata_wait_idle() is 
removed.  Does that make the function heavy?

> 
> The better solution is to track the PACKET command protocol state much 
> more closely, so that the code _knows_ when it should and shouldn't be 
> getting an interrupt.
> 
> This is required anyway because, as mentioned in another email, an ATA 
> device might assert INTRQ for certain events, such as non-data commands, 
> where the controller is not required to assert the BMDMA IRQ bit.
> 
> I _suspect_ that many host controllers cause the BMDMA IRQ bit to track 
> the ATA INTRQ status precisely, but this theory has not been validated.
> 
>     Jeff
> 
> 
> [1] http://www.t13.org/project/d1153r18-ATA-ATAPI-4.pdf

  Without interrupt pending information from BMDMA bit for non-DMA 
commands (which I don't think we can use for non-DMA cmds as we'll never 
be sure if all controllers behave that way), the problem is that for 
many SATA controllers, more than one ports share single interrupt line. 
   And without interrupt pending bit, shared interrupt means a lot of 
spurious interrupts making it impossible to know when to expect interrupts.

  IDE driver deals with this by having only one command active per 
interrupt, but SATA doesn't have such scheme yet.  And I don't know if 
such a scheme is desirable at all.  Maybe just continuing to poll 
non-DMA commands (which isn't much a burden anyway) and keeping DMA 
commands fast is a better approach.

  So, the thing is that if we run non-DMA commands and other commands at 
the same time on ports which share interrupts, we'll get spurious 
interrupts very often regardless of ATA/ATAPI state machine.  Remember 
many spurious interrupts reports/fixes regarding ATAPI devices?  I 
suspect many of them are not actual spurious interrupts but interrupts 
from the other device sharing the host_set.

  So, how should we do here?  To follow ATA/ATAPI state machine, we need 
to implement exclusion among ports sharing an interrupt.  Is this the 
way to go?  Arggggggg...  Lack of interrupt pending bit is such a pain 
in the ass.  :-(

-- 
tejun
