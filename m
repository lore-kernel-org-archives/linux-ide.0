From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/12] libata: add detailed AC_ERR_* flags
Date: Sun, 22 Jan 2006 16:58:30 +0900
Message-ID: <11379167101842-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.205]:27826 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751247AbWAVH6g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:36 -0500
Received: by xproxy.gmail.com with SMTP id s14so513090wxc
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:35 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Add detailed AC_ERR_* flags and use them.  Long-term goal is to
describe all errors with err_mask and tf combination (tf for failed
sector information, etc...).  After proper error diagnosis is
implemented, sense data should also be generated from err_mask instead
of directly from hardware tf registers as it is currently.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |    6 ++----
 drivers/scsi/libata-core.c |   12 ++++++------
 drivers/scsi/sata_mv.c     |    2 +-
 drivers/scsi/sata_sil24.c  |    2 +-
 include/linux/libata.h     |   15 ++++++++++-----
 5 files changed, 20 insertions(+), 17 deletions(-)

1939435a8f0e7b2b1578b84cedd49f8adcab1ea9
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 30676b0..e7b937b 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -680,7 +680,7 @@ static void ahci_eng_timeout(struct ata_
 	 	 * not being called from the SCSI EH.
 	 	 */
 		qc->scsidone = scsi_finish_command;
-		qc->err_mask |= AC_ERR_OTHER;
+		qc->err_mask |= AC_ERR_TIMEOUT;
 		ata_qc_complete(qc);
 	}
 
@@ -720,10 +720,8 @@ static inline int ahci_host_intr(struct 
 		/* command processing has stopped due to error; restart */
 		ahci_restart_port(ap, status);
 
-		if (qc) {
-			qc->err_mask |= AC_ERR_OTHER;
+		if (qc)
 			ata_qc_complete(qc);
-		}
 	}
 
 	return 1;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 43a2328..f5519f0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1142,7 +1142,7 @@ ata_exec_internal(struct ata_port *ap, s
 		 * spurious interrupt.  We can live with that.
 		 */
 		if (qc->flags & ATA_QCFLAG_ACTIVE) {
-			qc->err_mask = AC_ERR_OTHER;
+			qc->err_mask = AC_ERR_TIMEOUT;
 			ata_qc_complete(qc);
 			printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
 			       ap->id, command);
@@ -2917,7 +2917,7 @@ static unsigned long ata_pio_poll(struct
 	status = ata_chk_status(ap);
 	if (status & ATA_BUSY) {
 		if (time_after(jiffies, ap->pio_task_timeout)) {
-			qc->err_mask |= AC_ERR_ATA_BUS;
+			qc->err_mask |= AC_ERR_TIMEOUT;
 			ap->hsm_task_state = HSM_ST_TMOUT;
 			return 0;
 		}
@@ -3295,7 +3295,7 @@ static void atapi_pio_bytes(struct ata_q
 err_out:
 	printk(KERN_INFO "ata%u: dev %u: ATAPI check failed\n",
 	      ap->id, dev->devno);
-	qc->err_mask |= AC_ERR_ATA_BUS;
+	qc->err_mask |= AC_ERR_HSM;
 	ap->hsm_task_state = HSM_ST_ERR;
 }
 
@@ -3353,7 +3353,7 @@ static void ata_pio_block(struct ata_por
 	} else {
 		/* handle BSY=0, DRQ=0 as error */
 		if ((status & ATA_DRQ) == 0) {
-			qc->err_mask |= AC_ERR_ATA_BUS;
+			qc->err_mask |= AC_ERR_HSM;
 			ap->hsm_task_state = HSM_ST_ERR;
 			return;
 		}
@@ -4159,14 +4159,14 @@ static void atapi_packet_task(void *_dat
 	/* sleep-wait for BSY to clear */
 	DPRINTK("busy wait\n");
 	if (ata_busy_sleep(ap, ATA_TMOUT_CDB_QUICK, ATA_TMOUT_CDB)) {
-		qc->err_mask |= AC_ERR_ATA_BUS;
+		qc->err_mask |= AC_ERR_TIMEOUT;
 		goto err_out;
 	}
 
 	/* make sure DRQ is set */
 	status = ata_chk_status(ap);
 	if ((status & (ATA_BUSY | ATA_DRQ)) != ATA_DRQ) {
-		qc->err_mask |= AC_ERR_ATA_BUS;
+		qc->err_mask |= AC_ERR_HSM;
 		goto err_out;
 	}
 
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index cd54244..89bcd85 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1866,7 +1866,7 @@ static void mv_eng_timeout(struct ata_po
 	 	 */
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		qc->scsidone = scsi_finish_command;
-		qc->err_mask |= AC_ERR_OTHER;
+		qc->err_mask |= AC_ERR_TIMEOUT;
 		ata_qc_complete(qc);
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 9231301..fb59012 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -653,7 +653,7 @@ static void sil24_eng_timeout(struct ata
 	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 	qc->scsidone = scsi_finish_command;
-	qc->err_mask |= AC_ERR_OTHER;
+	qc->err_mask |= AC_ERR_TIMEOUT;
 	ata_qc_complete(qc);
 
 	sil24_reset_controller(ap);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d58b659..8ff3a7f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -222,10 +222,15 @@ enum hsm_task_states {
 };
 
 enum ata_completion_errors {
-	AC_ERR_OTHER		= (1 << 0),
-	AC_ERR_DEV		= (1 << 1),
-	AC_ERR_ATA_BUS		= (1 << 2),
-	AC_ERR_HOST_BUS		= (1 << 3),
+	AC_ERR_DEV		= (1 << 0), /* device reported error */
+	AC_ERR_HSM		= (1 << 1), /* host state machine violation */
+	AC_ERR_TIMEOUT		= (1 << 2), /* timeout */
+	AC_ERR_MEDIA		= (1 << 3), /* media error */
+	AC_ERR_ATA_BUS		= (1 << 4), /* ATA bus error */
+	AC_ERR_HOST_BUS		= (1 << 5), /* host bus error */
+	AC_ERR_SYSTEM		= (1 << 6), /* system error */
+	AC_ERR_INVALID		= (1 << 7), /* invalid argument */
+	AC_ERR_OTHER		= (1 << 8), /* unknown */
 };
 
 /* forward declarations */
@@ -833,7 +838,7 @@ static inline int ata_try_flush_cache(co
 static inline unsigned int ac_err_mask(u8 status)
 {
 	if (status & ATA_BUSY)
-		return AC_ERR_ATA_BUS;
+		return AC_ERR_HSM;
 	if (status & (ATA_ERR | ATA_DF))
 		return AC_ERR_DEV;
 	return 0;
-- 
1.0.8


