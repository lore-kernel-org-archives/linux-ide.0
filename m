From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/15] libata-pmp: implement qc_defer for command switching PMP support
Date: Sun, 1 Jul 2007 19:54:16 +0900
Message-ID: <11832872562055-git-send-email-htejun@gmail.com>
References: <1183287253677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:12116 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756905AbXGAKyY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:54:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1891724wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:54:23 -0700 (PDT)
In-Reply-To: <1183287253677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Implement sata_pmp_qc_defer_cmd_switch() - standard qc_defer for
command switching PMP support.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 drivers/ata/libata-pmp.c  |   30 ++++++++++++++++++++++++++++++
 include/linux/libata.h    |    1 +
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 151b585..568e750 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7098,6 +7098,7 @@ EXPORT_SYMBOL_GPL(ata_pci_default_filter);
 EXPORT_SYMBOL_GPL(ata_pci_clear_simplex);
 #endif /* CONFIG_PCI */
 
+EXPORT_SYMBOL_GPL(sata_pmp_qc_defer_cmd_switch);
 EXPORT_SYMBOL_GPL(sata_pmp_read_init_tf);
 EXPORT_SYMBOL_GPL(sata_pmp_read_val);
 EXPORT_SYMBOL_GPL(sata_pmp_write_init_tf);
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index d6d05b2..7053abc 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -70,6 +70,36 @@ static int sata_pmp_write(struct ata_link *link, int reg, u32 val)
 }
 
 /**
+ *	sata_pmp_qc_defer_cmd_switch - qc_defer for command switching PMP
+ *	@qc: ATA command in question
+ *
+ *	A host which has command switching PMP support cannot issue
+ *	commands to multiple links simultaneously.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	ATA_DEFER_* if deferring is needed, 0 otherwise.
+ */
+int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc)
+{
+	struct ata_link *link = qc->dev->link;
+	struct ata_port *ap = link->ap;
+
+	if (ap->excl_link == NULL || ap->excl_link == link) {
+		if (ap->nr_active_links == 0 || ata_link_active(link)) {
+			qc->flags |= ATA_QCFLAG_CLEAR_EXCL;
+			return ata_std_qc_defer(qc);
+		}
+
+		ap->excl_link = link;
+	}
+
+	return ATA_DEFER_PORT;
+}
+
+/**
  *	sata_pmp_read_init_tf - initialize TF for PMP read
  *	@tf: taskfile to initialize
  *	@dev: PMP dev
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c12312f..6d9f17e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -941,6 +941,7 @@ extern unsigned long ata_pci_default_filter(struct ata_device *, unsigned long);
 /*
  * PMP
  */
+extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
 extern void sata_pmp_read_init_tf(struct ata_taskfile *tf,
 				  struct ata_device *dev, int pmp, int reg);
 extern u32 sata_pmp_read_val(const struct ata_taskfile *tf);
-- 
1.5.0.3


