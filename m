From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 5/10] libata: use freeze/thaw for polling
Date: Wed, 04 Jul 2007 16:57:19 +0800
Message-ID: <468B60EF.8030009@tw.ibm.com>
References: <468B5C97.1000803@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:59073 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980AbXGDI5Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 04:57:24 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l648vOO1020416
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 04:57:24 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l648vO9X168234
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:57:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l648vN3a015213
	for <linux-ide@vger.kernel.org>; Wed, 4 Jul 2007 02:57:23 -0600
In-Reply-To: <468B5C97.1000803@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@enoyolf.org>

Patch 5/10:

  This patch changes polling codes to use freeze()/thaw() for irq off/on.
The reason is: some ATAPI devices raises INTRQ even of nIEN = 1.
Using the host adapter irq mask mechanism, if available, is more reliable than the device nIEN bit.

ata_qc_set_polling() is also removed since now unused.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---

Considerations:
   HSM, the new user of freeze()/thaw(), will call freeze()/thaw() in higher frequency than EH.
Can current implemention of freeze()/thaw() handle it?

diff -Nrup 04_convert_freeze/drivers/ata/libata-core.c 05_convert_hsm_to_freeze/drivers/ata/libata-core.c
--- 04_convert_freeze/drivers/ata/libata-core.c	2007-07-04 11:57:33.000000000 +0800
+++ 05_convert_hsm_to_freeze/drivers/ata/libata-core.c	2007-07-04 13:13:56.000000000 +0800
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
 
diff -Nrup 04_convert_freeze/include/linux/libata.h 05_convert_hsm_to_freeze/include/linux/libata.h
--- 04_convert_freeze/include/linux/libata.h	2007-07-04 11:57:33.000000000 +0800
+++ 05_convert_hsm_to_freeze/include/linux/libata.h	2007-07-04 13:13:56.000000000 +0800
@@ -1097,11 +1097,6 @@ static inline u8 ata_wait_idle(struct at
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


