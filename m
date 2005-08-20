From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev-2.6:upstream 00/02] atapi: packet task vs. intr race fix
Date: Sat, 20 Aug 2005 18:17:22 +0900 (KST)
Message-ID: <20050820091651.486821E0@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:52949 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751078AbVHTJRp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Aug 2005 05:17:45 -0400
Received: by wproxy.gmail.com with SMTP id i2so754752wra
        for <linux-ide@vger.kernel.org>; Sat, 20 Aug 2005 02:17:39 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com
Cc: linux-ide@vger.kernel.org

 Hello, Jeff and Albert.

 This patchset fixes the following race.
(port A has ATA device and B ATAPI).

port B	: ata_issue_prot() (ATAPI_NODATA)
port B	: packet_task scheduled
port A	: ata_issue_prot() (DMA)
intr	: ata_interrupt()
port A	: ata_host_intr -> this is all good & dandy
port B	: ata_host_intr -> finishes ATAPI cmd w/ error (request sense)

 This is where the race is, we're polling for port B's qc, we must not
mess with it from interrupt.  Now, port B has dangling packet_task
which will race w/ whatever will run on port B.

 The problem is that we don't always protect polled ports from
interrupts with ata_qc_set_polling() and for non-DMA ATA commands
there's no way to discern if actually an IRQ has occurred (this
sucks), so we end up finishing the other port's command.

 This condition occurs quite often if both port A and B are busy.  The
most common result is assertion failure in atapi_packet_task
(assert(qc->flags & ATA_QCFLAG_ACTIVE)), but depending on timing and
on SMP, weirder things could happen, I think.

 Note that for ATAPI_DMA, interrupt from the other port won't mess
with a polled command as we can tell that it's not ours with
bmdma_status, but, if spurious interrupt occurs on the port, the
packet_task will go dangling.  That's why ATAPI_DMA also needs
protection.  The baseline is that all polled qc's need to be protected
with ata_qc_set_polling() until polling task is done with the command.

 Albert, I think, part of your assertion failures are from this.  We
also have unprotected qc_complete/EH race which can also cause other
assertion failures.  I'll post a patch for that soon.

[ Start of patch descriptions ]

01_atapi_update-ata_irq_on.patch
	: update ata_irq_on

	Update ata_irq_on for atapi_packet_task fix.  Changes are

	* IRQ is cleared _before_ unmasking interrupt.  This is
	  necessary as unmasking could raise a pending interrupt
	  which should have been ignored.

	* IRQ is cleared using both ata_chk_status and
          ap->ops->irq_clear.

	* ap->ctl value represents default ctl value and never gets
	  modified.  ap->last_ctl is the currently loaded ctl value.
	  Don't turn off ATA_NIEN on ap->ctl as the bit never gets set
	  on it.  Directly modify ap->last_ctl.

	* Don't do ata_wait_idle.  All current callers don't need it.
	  And it will always time out when used in atapi_packet_task.

02_atapi_fix-atapi_packet_task-race.patch
	: fix atapi_packet_task vs. ata_host_intr race

	Protect ATAPI_NODATA and ATAPI_DMA commands from being
	finished by ata_host_intr before atapi_packet_task is done w/
	the commands.  Previously, such ATAPI commands could have been
	completed by interrupts from other ports in the same host_set
	or by spurious interrupt, making atapi_packet_task access
	already finished commands.

[ End of patch descriptions ]

Thanks.

--
tejun

