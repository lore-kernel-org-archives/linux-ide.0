From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs.
 intr race fix
Date: Sun, 21 Aug 2005 15:47:35 -0400
Message-ID: <4308DA57.9000303@pobox.com>
References: <20050820091651.486821E0@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:60105 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751105AbVHUVM2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:12:28 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LJorvB032297
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 12:50:53 -0700
In-Reply-To: <20050820091651.486821E0@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff and Albert.
> 
>  This patchset fixes the following race.
> (port A has ATA device and B ATAPI).
> 
> port B	: ata_issue_prot() (ATAPI_NODATA)
> port B	: packet_task scheduled
> port A	: ata_issue_prot() (DMA)
> intr	: ata_interrupt()
> port A	: ata_host_intr -> this is all good & dandy
> port B	: ata_host_intr -> finishes ATAPI cmd w/ error (request sense)
> 
>  This is where the race is, we're polling for port B's qc, we must not
> mess with it from interrupt.  Now, port B has dangling packet_task
> which will race w/ whatever will run on port B.
> 
>  The problem is that we don't always protect polled ports from
> interrupts with ata_qc_set_polling() and for non-DMA ATA commands
> there's no way to discern if actually an IRQ has occurred (this
> sucks), so we end up finishing the other port's command.
> 
>  This condition occurs quite often if both port A and B are busy.  The
> most common result is assertion failure in atapi_packet_task
> (assert(qc->flags & ATA_QCFLAG_ACTIVE)), but depending on timing and
> on SMP, weirder things could happen, I think.
> 
>  Note that for ATAPI_DMA, interrupt from the other port won't mess
> with a polled command as we can tell that it's not ours with
> bmdma_status, but, if spurious interrupt occurs on the port, the
> packet_task will go dangling.  That's why ATAPI_DMA also needs
> protection.  The baseline is that all polled qc's need to be protected
> with ata_qc_set_polling() until polling task is done with the command.
> 
> 
> [ Start of patch descriptions ]

While this is something to look into, the supplied patches are 
definitely not the way we want to go.  We need to follow the state 
diagram for the PACKET command protocol.  ATA4 [1] diagrams are a good 
thing to read, since they include mention of the behavior of certain 
ATAPI devices that can send an interrupt between taskfile-out and 
write-cdb steps in the sequence.

In patch #2, you're making ata_irq_on() way too heavy.  In patch #1, 
calling ata_qc_set_polling() for non-polled commands is a hack.

The better solution is to track the PACKET command protocol state much 
more closely, so that the code _knows_ when it should and shouldn't be 
getting an interrupt.

This is required anyway because, as mentioned in another email, an ATA 
device might assert INTRQ for certain events, such as non-data commands, 
where the controller is not required to assert the BMDMA IRQ bit.

I _suspect_ that many host controllers cause the BMDMA IRQ bit to track 
the ATA INTRQ status precisely, but this theory has not been validated.

	Jeff


[1] http://www.t13.org/project/d1153r18-ATA-ATAPI-4.pdf

