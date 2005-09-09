From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH RFC] libata: interrupt driven pio
Date: Fri, 09 Sep 2005 13:35:25 -0400
Message-ID: <4321C7DD.5050503@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:41102 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030284AbVIIRfa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2005 13:35:30 -0400
In-Reply-To: <4321B4E0.8020801@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Albert Lee wrote:
> Dear all,
> 
> The interrupt driven PIO draft patch is ready for your review.
> 
> Changes:
> - add PIO_ST_FIRST for the state before sending ATAPI CDB or sending 
> "ATA PIO data out" first data block.
> - remove the ATA_FLAG_NOINTR flag since the interrupt handler is now 
> aware of the states
> - modify ata_pio_sector() and atapi_pio_bytes() to work in the interrupt 
> context
> - modify the ata_host_intr() to handle PIO interrupts
> - modify ata_qc_issue_prot() to initialize states
> - atapi_packet_task() changed to handle "ATA PIO data out" first data block
> - support the pre-ATA4 ATAPI device which raise interrupt when ready to 
> receive CDB
> 
> Patch against 2.6.13 (80ac2912f846c01d702774bb6aa7100ec71e88b9).

Very nice, thanks for working on this.

Comments:

1) With this work, PIO_ST_xxx is no longer an appropriate name.  I 
suggest s/PIO_ST_/HSM_ST_/


2) ditto with s/pio_task_state/hsm_task_state/


3) Don't bother with in_atomic(), since we mix contexts in libata. 
Causes more trouble than its worth.  Just use *map_atomic()


4) prefer 'ata_id_cdb_intr' to 'atapi_...'


5) please don't put braces around single-line C statements:

+	if (status & ATA_BUSY) {
+		goto idle_irq;
+	}


6) the following locking is questionable.  AFAICS this should be 
resolved elsewhere, and if you have to take the lock here, you already 
have problems

+		/* PIO data out protocol.
+		 * send first data block.
+		 */
+		ata_pio_sector(qc);

-		/* PIO commands are handled by polling */
+		spin_lock_irqsave(&ap->host_set->lock, flags);
  		ap->pio_task_state = PIO_ST;
-		queue_work(ata_wq, &ap->pio_task);
+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+		/* interrupt handler takes over from here */

ie. why queue the task at all, if the intr handler takes over?


7) Overall, looks pretty good at first glance.  This patch will require 
much testing before global deployment.  Once you have a final patch, 
we'll let it simmer in libata-dev.git for a while, allowing -mm users 
plenty of time for testing.  Possibly a 2.6.16 version target.

