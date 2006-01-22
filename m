From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/12] libata: kill NULL qc handling from ->eng_timeout callbacks
Date: Sun, 22 Jan 2006 16:58:31 +0900
Message-ID: <11379167112100-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.198]:33198 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751247AbWAVH6j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:39 -0500
Received: by xproxy.gmail.com with SMTP id s14so513088wxc
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:39 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

->eng_timeout is not invoked with NULL qc anymore.  Kill NULL qc
handling from all ->eng_timeout callbacks.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |   12 +++---------
 drivers/scsi/libata-core.c  |   12 +-----------
 drivers/scsi/sata_mv.c      |    9 ++-------
 drivers/scsi/sata_promise.c |    9 +--------
 drivers/scsi/sata_sil24.c   |    5 -----
 drivers/scsi/sata_sx4.c     |    9 +--------
 6 files changed, 8 insertions(+), 48 deletions(-)

ceaea59820d442a5b57e1dd2bf185173dfd2c109
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 89ba2bd..fdd11ee 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -666,19 +666,13 @@ static void ahci_eng_timeout(struct ata_
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
+	ahci_restart_port(ap, readl(port_mmio + PORT_IRQ_STAT));
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-	} else {
-		ahci_restart_port(ap, readl(port_mmio + PORT_IRQ_STAT));
-		qc->err_mask |= AC_ERR_TIMEOUT;
-	}
+	qc->err_mask |= AC_ERR_TIMEOUT;
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
-	if (qc)
-		ata_eh_qc_complete(qc);
+	ata_eh_qc_complete(qc);
 }
 
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 93ae2dc..b2f51bb 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3503,20 +3503,10 @@ static void ata_qc_timeout(struct ata_qu
 
 void ata_eng_timeout(struct ata_port *ap)
 {
-	struct ata_queued_cmd *qc;
-
 	DPRINTK("ENTER\n");
 
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (qc)
-		ata_qc_timeout(qc);
-	else {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-		goto out;
-	}
+	ata_qc_timeout(ata_qc_from_tag(ap, ap->active_tag));
 
-out:
 	DPRINTK("EXIT\n");
 }
 
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index d9a554c..9b56f9b 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1853,13 +1853,8 @@ static void mv_eng_timeout(struct ata_po
 	mv_err_intr(ap);
 	mv_stop_and_reset(ap);
 
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-	} else {
-		qc->err_mask |= AC_ERR_TIMEOUT;
-		ata_eh_qc_complete(qc);
-	}
+	qc->err_mask |= AC_ERR_TIMEOUT;
+	ata_eh_qc_complete(qc);
 }
 
 /**
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index 77ef646..9fc9cbf 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -394,11 +394,6 @@ static void pdc_eng_timeout(struct ata_p
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-		goto out;
-	}
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -418,10 +413,8 @@ static void pdc_eng_timeout(struct ata_p
 		break;
 	}
 
-out:
 	spin_unlock_irqrestore(&host_set->lock, flags);
-	if (qc)
-		ata_eh_qc_complete(qc);
+	ata_eh_qc_complete(qc);
 	DPRINTK("EXIT\n");
 }
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 7222fc7..1160fda 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -638,11 +638,6 @@ static void sil24_eng_timeout(struct ata
 	struct ata_queued_cmd *qc;
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-		return;
-	}
 
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 	qc->err_mask |= AC_ERR_TIMEOUT;
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 9f992fb..b4ffa3f 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -866,11 +866,6 @@ static void pdc_eng_timeout(struct ata_p
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-		goto out;
-	}
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -889,10 +884,8 @@ static void pdc_eng_timeout(struct ata_p
 		break;
 	}
 
-out:
 	spin_unlock_irqrestore(&host_set->lock, flags);
-	if (qc)
-		ata_eh_qc_complete(qc);
+	ata_eh_qc_complete(qc);
 	DPRINTK("EXIT\n");
 }
 
-- 
1.0.8


