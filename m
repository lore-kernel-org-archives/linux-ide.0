From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6 1/2] ata_dev_identify() check status fix
Date: Sat, 02 Apr 2005 23:55:38 +0800
Message-ID: <424EC07A.10505@tw.ibm.com>
References: <424CE03C.7020903@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070502040707040703000301"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:41960 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261613AbVDBP4O (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Apr 2005 10:56:14 -0500
In-Reply-To: <424CE03C.7020903@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>, bruss@alum.wpi.edu

This is a multi-part message in MIME format.
--------------070502040707040703000301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

    Revised since lowlevel driver might use qc->private_data. qc->upper_private_data added instead.

Desc:
    In the ata_dev_identify() function, ata_chk_status() is used to check whether an error has occurred.
However, in some error situation, the device's status register always reads 0x0.
(Please see previously attached dmesg for detail.)
And the error found by the state machine is not seen by ata_dev_identify().

Changes:
- upper_private_data added to ata_queued_cmd
- use qc->upper_private_data to carry the drv_stat returned from the state machine.
- ata_qc_complete_noop() saves the drv_stat to *(qc->upper_private_data).
- ata_dev_identify() use the status returned from ata_qc_complete_noop(), instead of ata_chk_status().
- noisy PIO error printk() changed to DPRINTK()

Attached please find the revised patch 1/2 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------070502040707040703000301
Content-Type: text/plain;
 name="id_fix2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="id_fix2.diff"

--- 1.74/include/linux/libata.h	2005-03-08 13:59:27 +08:00
+++ 1.75/include/linux/libata.h	2005-04-02 22:22:11 +08:00
@@ -256,6 +256,9 @@
 
 	struct completion	*waiting;
 
+	/* reserved for owner of this ata_queued_cmd */
+	void			*upper_private_data;
+
 	void			*private_data;
 };
 
--- 1.134/drivers/scsi/libata-core.c	2005-03-08 13:59:27 +08:00
+++ 1.135/drivers/scsi/libata-core.c	2005-04-02 22:30:53 +08:00
@@ -995,6 +995,7 @@
 	}
 
 	qc->waiting = &wait;
+	qc->upper_private_data = &status;
 	qc->complete_fn = ata_qc_complete_noop;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
@@ -1006,7 +1007,6 @@
 	else
 		wait_for_completion(&wait);
 
-	status = ata_chk_status(ap);
 	if (status & ATA_ERR) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
@@ -2496,8 +2496,7 @@
 	assert(qc != NULL);
 
 	drv_stat = ata_chk_status(ap);
-	printk(KERN_WARNING "ata%u: PIO error, drv_stat 0x%x\n",
-	       ap->id, drv_stat);
+	DPRINTK("ata%u: PIO error, drv_stat 0x%x\n", ap->id, drv_stat);
 
 	ap->pio_task_state = PIO_ST_IDLE;
 
@@ -2770,6 +2769,7 @@
 
 static int ata_qc_complete_noop(struct ata_queued_cmd *qc, u8 drv_stat)
 {
+	*((u8*)qc->upper_private_data) = drv_stat;
 	return 0;
 }
 

--------------070502040707040703000301--


