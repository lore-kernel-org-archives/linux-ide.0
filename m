From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/4] libata: kill NULL qc handling from ->eng_timeout callbacks
Date: Fri, 10 Feb 2006 15:10:48 +0900
Message-ID: <11395518482651-git-send-email-htejun@gmail.com>
References: <11395518482722-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:51206 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751159AbWBJGKx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 01:10:53 -0500
Received: by zproxy.gmail.com with SMTP id 13so360260nzn
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2006 22:10:52 -0800 (PST)
In-Reply-To: <11395518482722-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

->eng_timeout cannot be invoked with NULL qc anymore.  Add an
assertion in ata_scsi_error() and kill NULL qc handling from all
->eng_timeout callbacks.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |   12 +++---------
 drivers/scsi/libata-core.c  |   12 +-----------
 drivers/scsi/libata-scsi.c  |    1 +
 drivers/scsi/sata_mv.c      |    9 ++-------
 drivers/scsi/sata_promise.c |    9 +--------
 drivers/scsi/sata_sil24.c   |    5 -----
 drivers/scsi/sata_sx4.c     |    9 +--------
 7 files changed, 9 insertions(+), 48 deletions(-)

51abbd79791f47e86ba59ab163498203f6eb0ca0
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index c67189a..fa01894 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -677,19 +677,13 @@ static void ahci_eng_timeout(struct ata_
 
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
index d53e0bc..b938c7a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3524,20 +3524,10 @@ static void ata_qc_timeout(struct ata_qu
 
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
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index d67cc2f..9d67c67 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -782,6 +782,7 @@ int ata_scsi_error(struct Scsi_Host *hos
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	assert(!(ap->flags & ATA_FLAG_IN_EH));
 	ap->flags |= ATA_FLAG_IN_EH;
+	assert(ata_qc_from_tag(ap, ap->active_tag) != NULL);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	ap->ops->eng_timeout(ap);
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 1db05f2..6c80527 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -2027,13 +2027,8 @@ static void mv_eng_timeout(struct ata_po
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
index 5d4ed54..c9dfd93 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -432,11 +432,6 @@ static void pdc_eng_timeout(struct ata_p
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-		goto out;
-	}
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -456,10 +451,8 @@ static void pdc_eng_timeout(struct ata_p
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
index f4742ad..962396b 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -639,11 +639,6 @@ static void sil24_eng_timeout(struct ata
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
index 3319f03..212cff4 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -867,11 +867,6 @@ static void pdc_eng_timeout(struct ata_p
 	spin_lock_irqsave(&host_set->lock, flags);
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (!qc) {
-		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
-		       ap->id);
-		goto out;
-	}
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
@@ -890,10 +885,8 @@ static void pdc_eng_timeout(struct ata_p
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
1.1.5


