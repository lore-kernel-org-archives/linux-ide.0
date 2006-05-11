From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/13] ahci: convert to new probing mechanism and add hotplug support
Date: Fri, 12 May 2006 00:32:08 +0900
Message-ID: <1147361528718-git-send-email-htejun@gmail.com>
References: <11473615261297-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:35893 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030275AbWEKPcW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:32:22 -0400
Received: by py-out-1112.google.com with SMTP id f28so286413pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:32:19 -0700 (PDT)
In-Reply-To: <11473615261297-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert to new probing mechanism and add hotplug support by enabling
PORT_IRQ_PHYRDY.  Standard EH will do the right thing and schedule
probe after analyzing SError.

---

 drivers/scsi/ahci.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

214b9d988fe2db84de1d825d5c57e11ae2ffa28a
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index d977055..ce8b00a 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -136,6 +136,7 @@ enum {
 	PORT_IRQ_FREEZE		= PORT_IRQ_HBUS_ERR |
 				  PORT_IRQ_IF_ERR |
 				  PORT_IRQ_CONNECT |
+				  PORT_IRQ_PHYRDY |
 				  PORT_IRQ_UNK_FIS,
 	PORT_IRQ_ERROR		= PORT_IRQ_FREEZE |
 				  PORT_IRQ_TF_ERR |
@@ -200,7 +201,6 @@ static void ahci_scr_write (struct ata_p
 static int ahci_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 static irqreturn_t ahci_interrupt (int irq, void *dev_instance, struct pt_regs *regs);
-static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void ahci_irq_clear(struct ata_port *ap);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
@@ -239,8 +239,6 @@ static const struct ata_port_operations 
 
 	.tf_read		= ahci_tf_read,
 
-	.probe_reset		= ahci_probe_reset,
-
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 
@@ -564,6 +562,17 @@ static int ahci_clo(struct ata_port *ap)
 	return 0;
 }
 
+static int ahci_prereset(struct ata_port *ap)
+{
+	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
+	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {
+		/* ATA_BUSY hasn't cleared, so send a CLO */
+		ahci_clo(ap);
+	}
+
+	return ata_std_prereset(ap);
+}
+
 static int ahci_softreset(struct ata_port *ap, unsigned int *class)
 {
 	struct ahci_port_priv *pp = ap->private_data;
@@ -715,19 +724,6 @@ static void ahci_postreset(struct ata_po
 	}
 }
 
-static int ahci_probe_reset(struct ata_port *ap, unsigned int *classes)
-{
-	if ((ap->flags & AHCI_FLAG_RESET_NEEDS_CLO) &&
-	    (ata_busy_wait(ap, ATA_BUSY, 1000) & ATA_BUSY)) {
-		/* ATA_BUSY hasn't cleared, so send a CLO */
-		ahci_clo(ap);
-	}
-
-	return ata_drive_probe_reset(ap, ata_std_probeinit,
-				     ahci_softreset, ahci_hardreset,
-				     ahci_postreset, classes);
-}
-
 static u8 ahci_check_status(struct ata_port *ap)
 {
 	void __iomem *mmio = (void __iomem *) ap->ioaddr.cmd_addr;
@@ -1018,7 +1014,7 @@ static void ahci_error_handler(struct at
 	}
 
 	/* perform recovery */
-	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_hardreset,
+	ata_do_eh(ap, ahci_prereset, ahci_softreset, ahci_hardreset,
 		  ahci_postreset);
 }
 
-- 
1.2.4


