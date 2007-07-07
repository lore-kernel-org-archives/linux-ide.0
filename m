From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/7] libata: use freeze/thaw for polling PIO
Date: Sat, 07 Jul 2007 15:09:32 +0800
Message-ID: <468F3C2C.4050609@tw.ibm.com>
References: <468F3949.5050800@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:51080 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbXGGHJm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 7 Jul 2007 03:09:42 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6779dHq009085
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 03:09:39 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l6779dFq219622
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:09:39 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6779cYC020590
	for <linux-ide@vger.kernel.org>; Sat, 7 Jul 2007 01:09:39 -0600
In-Reply-To: <468F3949.5050800@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>

This patch let polling pio codes to use freeze()/thaw() for irq off/on.
The reason is: some ATAPI devices raises INTRQ even of nIEN = 1.
Using the host adapter irq mask mechanism, if available, is more reliable than the device nIEN bit.

ata_qc_set_polling() is also removed since now unused.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Considerations:
Polling PIO, the new user of freeze()/thaw(), might have higher calling frequency to freeze()/thaw() than EH.
Can current implemention of freeze()/thaw() handle that?
We might need more testing on sata_nv, sata_promise, sata_sil, sata_sil24, sata_via and sata_vsc.


diff -Nrup 03_add_thaw_freeze/drivers/ata/libata-core.c 04_use_freeze_polling/drivers/ata/libata-core.c
--- 03_add_thaw_freeze/drivers/ata/libata-core.c	2007-07-07 10:38:55.000000000 +0800
+++ 04_use_freeze_polling/drivers/ata/libata-core.c	2007-07-07 10:40:10.000000000 +0800
@@ -4753,7 +4753,7 @@ static void ata_hsm_qc_complete(struct a
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ap->ops->irq_on(ap);
+					ap->ops->thaw(ap);
 					ata_qc_complete(qc);
 				} else
 					ata_port_freeze(ap);
@@ -4769,7 +4769,7 @@ static void ata_hsm_qc_complete(struct a
 	} else {
 		if (in_wq) {
 			spin_lock_irqsave(ap->lock, flags);
-			ap->ops->irq_on(ap);
+			ap->ops->thaw(ap);
 			ata_qc_complete(qc);
 			spin_unlock_irqrestore(ap->lock, flags);
 		} else
@@ -5411,7 +5411,7 @@ unsigned int ata_qc_issue_prot(struct at
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
+			ap->ops->freeze(ap);
 
 		ata_tf_to_host(ap, &qc->tf);
 		ap->hsm_task_state = HSM_ST_LAST;
@@ -5432,7 +5432,7 @@ unsigned int ata_qc_issue_prot(struct at
 
 	case ATA_PROT_PIO:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
+			ap->ops->freeze(ap);
 
 		ata_tf_to_host(ap, &qc->tf);
 
@@ -5461,7 +5461,7 @@ unsigned int ata_qc_issue_prot(struct at
 	case ATA_PROT_ATAPI:
 	case ATA_PROT_ATAPI_NODATA:
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_qc_set_polling(qc);
+			ap->ops->freeze(ap);
 
 		ata_tf_to_host(ap, &qc->tf);
 
diff -Nrup 03_add_thaw_freeze/include/linux/libata.h 04_use_freeze_polling/include/linux/libata.h
--- 03_add_thaw_freeze/include/linux/libata.h	2007-07-07 09:59:42.000000000 +0800
+++ 04_use_freeze_polling/include/linux/libata.h	2007-07-07 10:40:10.000000000 +0800
@@ -1094,11 +1094,6 @@ static inline u8 ata_wait_idle(struct at
 	return status;
 }
 
-static inline void ata_qc_set_polling(struct ata_queued_cmd *qc)
-{
-	qc->tf.ctl |= ATA_NIEN;
-}
-
 static inline struct ata_queued_cmd *__ata_qc_from_tag(struct ata_port *ap,
 						       unsigned int tag)
 {


