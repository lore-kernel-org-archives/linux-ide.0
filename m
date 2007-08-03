From: Jeff Garzik <jeff@garzik.org>
Subject: libata git tree, mbox queue status and contents
Date: Fri, 03 Aug 2007 12:09:40 -0400
Message-ID: <46B35344.3090208@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46201 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762819AbXHCQJm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Aug 2007 12:09:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alan <alan@lxorguk.ukuu.org.uk>

This is a quick guide to current libata work that is queued or in 
progress in some way, shape or form.

First, a guide to the branches currently in use in 
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

   ALL

Everything that is exported for testing (and akpm's -mm tree). 
Currently consists of upstream-fixes + upstream + sil680-mmio branches.


   master

Vanilla upstream linux-2.6.git tree.


   mv-ahci-pata

Marvell 6121/6141 PATA support.  Needs fixing in the 'PATA controller 
command' area before it is usable, and can go upstream.


   mv-ncq

sata_mv NCQ support.  Code is complete and /should/ be working, but it 
does nothing but timeout and fallback to non-NCQ here.  Needs debugging 
before can go upstream.


   new-eh

Convert sata_qstor and sata_sx4 to new EH.  Each needs 
testing/verification before it can go upstream.


   pmask

Add proto_mask to LLDDs, alongside pio_mask, udma_mask, etc.


   sii-lbt

Enable Large Block Transfer mode on sata_sil.  Verified to work locally, 
but some bug reports on the 'net need to be tracked down before this can 
go upstream.


   sil680-mmio

BenH's MMIO patch for pata_sil680.  Some MMIO/flushing type issues were 
raised on the list, a solution was reached.  That solution must be coded 
before this can go upstream.


   upstream

Everything queued for 2.6.24.  Includes everything in upstream-fixes.


   upstream-fixes

Everything queued for 2.6.23-rc.  This tends to go upstream rapidly.




mbox queue, prefixed by author:

* Kristen: ALPM patches.  We definitely want them, as they save a ton of 
power.

* Tony Vroon: LED trigger....  hmmm

* Alan: IORDY handling -- upstream whenever Alan is happy

* Tejun: improved probe info printout.  Want to test and review in 
depth, but probably OK

* Alan: ACPI checks for 80wire cable -- upstream whenever Alan is happy

* Tejun:  Port Multiplier Support -- I still need to review in depth, 
but would like go ahead and push ata_link in

* NVIDIA: sata_nv SW NCQ: need to review WRT FIS state machine, though I 
saw some flaws in there.  OK if that is OK.

* Albert: irq_on/off.  Really need to give this some thought.  Not sure 
I like where this model is going.  Polling and twiddling irq on/off 
should be kept to a minimum, because it's sorta an admission that the 
host state machine has broken down, and we need to bandaid.  Its a 
bandaid not a root-cause solution.

* Albert: minor PIO fixes.  Need to review in depth.

* Kristen: AN: it seems that things got stuck once Al Viro voiced an 
objection?

* Ben Collins: cleanup HPA support.  Need to review and see what's 
needed today, from this patch.

