From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata-sff: improve HSM violation reporting
Date: Sat, 28 Jun 2008 01:39:43 +0900
Message-ID: <486517CF.8080204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34619 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbYF0QkD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jun 2008 12:40:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Improve SFF HSM violation reporting such that each HSM violation can
be distinguished using ehi_desc.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
If it's too late in -rc cycle, feel free to push it to #upstream.
It's not critical.  Thanks.

 drivers/ata/libata-sff.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 215d186..c0908c2 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1094,6 +1094,7 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 		     u8 status, int in_wq)
 {
+	struct ata_eh_info *ehi = &ap->link.eh_info;
 	unsigned long flags = 0;
 	int poll_next;
 
@@ -1125,9 +1126,12 @@ fsm_start:
 			if (likely(status & (ATA_ERR | ATA_DF)))
 				/* device stops HSM for abort/error */
 				qc->err_mask |= AC_ERR_DEV;
-			else
+			else {
 				/* HSM violation. Let EH handle this */
+				ata_ehi_push_desc(ehi,
+					"ST_FIRST: !(DRQ|ERR|DF)");
 				qc->err_mask |= AC_ERR_HSM;
+			}
 
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
@@ -1146,9 +1150,9 @@ fsm_start:
 			 * the CDB.
 			 */
 			if (!(qc->dev->horkage & ATA_HORKAGE_STUCK_ERR)) {
-				ata_port_printk(ap, KERN_WARNING,
-						"DRQ=1 with device error, "
-						"dev_stat 0x%X\n", status);
+				ata_ehi_push_desc(ehi, "ST_FIRST: "
+					"DRQ=1 with device error, "
+					"dev_stat 0x%X", status);
 				qc->err_mask |= AC_ERR_HSM;
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
@@ -1205,9 +1209,9 @@ fsm_start:
 			 * let the EH abort the command or reset the device.
 			 */
 			if (unlikely(status & (ATA_ERR | ATA_DF))) {
-				ata_port_printk(ap, KERN_WARNING, "DRQ=1 with "
-						"device error, dev_stat 0x%X\n",
-						status);
+				ata_ehi_push_desc(ehi, "ST-ATAPI: "
+					"DRQ=1 with device error, "
+					"dev_stat 0x%X", status);
 				qc->err_mask |= AC_ERR_HSM;
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
@@ -1226,13 +1230,17 @@ fsm_start:
 				if (likely(status & (ATA_ERR | ATA_DF)))
 					/* device stops HSM for abort/error */
 					qc->err_mask |= AC_ERR_DEV;
-				else
+				else {
 					/* HSM violation. Let EH handle this.
 					 * Phantom devices also trigger this
 					 * condition.  Mark hint.
 					 */
+					ata_ehi_push_desc(ehi, "ST-ATA: "
+						"DRQ=1 with device error, "
+						"dev_stat 0x%X", status);
 					qc->err_mask |= AC_ERR_HSM |
 							AC_ERR_NODEV_HINT;
+				}
 
 				ap->hsm_task_state = HSM_ST_ERR;
 				goto fsm_start;
@@ -1257,8 +1265,12 @@ fsm_start:
 					status = ata_wait_idle(ap);
 				}
 
-				if (status & (ATA_BUSY | ATA_DRQ))
+				if (status & (ATA_BUSY | ATA_DRQ)) {
+					ata_ehi_push_desc(ehi, "ST-ATA: "
+						"BUSY|DRQ persists on ERR|DF, "
+						"dev_stat 0x%X", status);
 					qc->err_mask |= AC_ERR_HSM;
+				}
 
 				/* ata_pio_sectors() might change the
 				 * state to HSM_ST_LAST. so, the state
