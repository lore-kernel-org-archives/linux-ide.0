From: Doug Maxey <dwm@maxeymade.com>
Subject: Re: [PATCH RFC] libata: interrupt driven pio
Date: Fri, 09 Sep 2005 13:14:01 -0500
Message-ID: <200509091814.j89IE1ck020560@falcon30.maxeymade.com>
References: <4321C7DD.5050503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from falcon30.maxeymade.com ([24.173.215.190]:49357 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S1030297AbVIISOc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Sep 2005 14:14:32 -0400
In-reply-to: <4321C7DD.5050503@pobox.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Albert Lee <albertcc@tw.ibm.com>, Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>


On Fri, 09 Sep 2005 13:35:25 EDT, Jeff Garzik wrote:
>Albert Lee wrote:
>> Dear all,
>> 
>> The interrupt driven PIO draft patch is ready for your review.
>> 
>> Changes:
>> - add PIO_ST_FIRST for the state before sending ATAPI CDB or sending 
>> "ATA PIO data out" first data block.
>> - remove the ATA_FLAG_NOINTR flag since the interrupt handler is now 
>> aware of the states
>> - modify ata_pio_sector() and atapi_pio_bytes() to work in the interrupt 
>> context
>> - modify the ata_host_intr() to handle PIO interrupts
>> - modify ata_qc_issue_prot() to initialize states
>> - atapi_packet_task() changed to handle "ATA PIO data out" first data block
>> - support the pre-ATA4 ATAPI device which raise interrupt when ready to 
>> receive CDB
>> 
>> Patch against 2.6.13 (80ac2912f846c01d702774bb6aa7100ec71e88b9).
>
...
>
>6) the following locking is questionable.  AFAICS this should be 
>resolved elsewhere, and if you have to take the lock here, you already 
>have problems

To protect this instance against being preempted on MP?  Not that large 
of an issue at present, but suspect that Ingo's work may affect in the 
near future.  I agree that this may be wrong location.

What mechanism (elsewhere) currently protects on irq handler entry?
 
>
>+		/* PIO data out protocol.
>+		 * send first data block.
>+		 */
>+		ata_pio_sector(qc);
>
>-		/* PIO commands are handled by polling */
>+		spin_lock_irqsave(&ap->host_set->lock, flags);
>  		ap->pio_task_state = PIO_ST;
>-		queue_work(ata_wq, &ap->pio_task);
>+		spin_unlock_irqrestore(&ap->host_set->lock, flags);
>+
>+		/* interrupt handler takes over from here */
>
>ie. why queue the task at all, if the intr handler takes over?
>
>
>7) Overall, looks pretty good at first glance.  This patch will require 
>much testing before global deployment.  Once you have a final patch, 
>we'll let it simmer in libata-dev.git for a while, allowing -mm users 
>plenty of time for testing.  Possibly a 2.6.16 version target.
>

Way to go Albert!

++doug

