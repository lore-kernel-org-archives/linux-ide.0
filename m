From: Tejun Heo <htejun@gmail.com>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Thu, 15 Mar 2007 15:22:32 +0900
Message-ID: <45F8E628.2010004@gmail.com>
References: <45F631F7.6020106@mail.utexas.edu> <45F7760B.10102@gmail.com> <45F81177.9070106@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090006090001080103020601"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.177]:21685 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965425AbXCOGWj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 02:22:39 -0400
Received: by ik-out-1112.google.com with SMTP id c21so43243ika
        for <linux-ide@vger.kernel.org>; Wed, 14 Mar 2007 23:22:38 -0700 (PDT)
In-Reply-To: <45F81177.9070106@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <VladCodrea@mail.utexas.edu>
Cc: linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

This is a multi-part message in MIME format.
--------------090006090001080103020601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

[cc'ing Albert Lee.  Hi!]

Vlad Codrea wrote:
>> Okay, now that you're on libata driver, it's easier for me to debug.
>> Can you apply the attached patch over 2.6.20 and report what the kernel
>> says? (the patch will apply with some noise, it's okay)
> 
> I've applied your patch and recompiled the kernel, but the new dmesg
> (attached as dmesg_2.txt) doesn't seem to have changed much.

Hmmm.. that's weird, can you please try the attached patch?

Albert, can you take a look at this one?  I'm pretty sure you know much
better about this than me.  The whole thread can be read at...

  http://thread.gmane.org/gmane.linux.ide/17052

Thanks.

-- 
tejun

--------------090006090001080103020601
Content-Type: text/x-patch;
 name="hsm-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hsm-debug.patch"

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14629a3..855d33a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4382,6 +4382,12 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 			 */
 			qc = ata_qc_from_tag(ap, qc->tag);
 			if (qc) {
+				if ((qc->flags & ATA_QCFLAG_FAILED) ||
+				    qc->err_mask)
+					ata_port_printk(ap, KERN_WARNING,
+						"hsm_qc_complete: "
+						"flags=0x%lx err_mask=0x%x\n",
+						qc->flags, qc->err_mask);
 				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
 					ap->ops->irq_on(ap);
 					ata_qc_complete(qc);
@@ -4453,9 +4459,13 @@ fsm_start:
 			if (likely(status & (ATA_ERR | ATA_DF)))
 				/* device stops HSM for abort/error */
 				qc->err_mask |= AC_ERR_DEV;
-			else
+			else {
 				/* HSM violation. Let EH handle this */
+				ata_port_printk(ap, KERN_WARNING,
+						"!DRQ on HSM_ST_FIRST (0x%x)\n",
+						status);
 				qc->err_mask |= AC_ERR_HSM;
+			}
 
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
@@ -4547,13 +4557,17 @@ fsm_start:
 				if (likely(status & (ATA_ERR | ATA_DF)))
 					/* device stops HSM for abort/error */
 					qc->err_mask |= AC_ERR_DEV;
-				else
+				else {
+					ata_port_printk(ap, KERN_WARNING,
+						"!DRQ on HSM_ST (0x%x)\n",
+						status);
 					/* HSM violation. Let EH handle this.
 					 * Phantom devices also trigger this
 					 * condition.  Mark hint.
 					 */
 					qc->err_mask |= AC_ERR_HSM |
 							AC_ERR_NODEV_HINT;
+				}
 
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
@@ -4579,8 +4593,12 @@ fsm_start:
 					status = ata_wait_idle(ap);
 				}
 
-				if (status & (ATA_BUSY | ATA_DRQ))
+				if (status & (ATA_BUSY | ATA_DRQ)) {
+					ata_port_printk(ap, KERN_WARNING,
+						"BUSY|DRQ on ERR|DF (0x%x)\n",
+						status);
 					qc->err_mask |= AC_ERR_HSM;
+				}
 
 				/* ata_pio_sectors() might change the
 				 * state to HSM_ST_LAST. so, the state
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7349c3d..a956aaa 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1146,6 +1146,8 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	u8 stat = tf->command, err = tf->feature;
 
 	if ((stat & (ATA_BUSY | ATA_DRQ | ATA_DRDY)) != ATA_DRDY) {
+		ata_dev_printk(qc->dev, KERN_WARNING,
+			       "ata_eh_analyze_tf, AC_ERR_HSM, 0x%x\n", stat);
 		qc->err_mask |= AC_ERR_HSM;
 		return ATA_EH_SOFTRESET;
 	}

--------------090006090001080103020601--
