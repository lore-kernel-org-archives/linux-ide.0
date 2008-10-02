From: Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 1/2] sata_via: load DEVICE register when CTL changes
Date: Thu, 02 Oct 2008 10:54:02 +0900
Message-ID: <48E429BA.8070708@kernel.org>
References: <48E42985.60400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56319 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbYJBBzr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Oct 2008 21:55:47 -0400
In-Reply-To: <48E42985.60400@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joseph Chan <JosephChan@via.com.tw>, IDE/ATA development list <linux-ide@vger.kernel.org>, HaraldWelte@viatech.com

VIA controllers clear DEVICE register when IEN changes.  Make sure
DEVICE is updated along with CTL.

This change is separated from Joseph Chan's larger patch.

  http://thread.gmane.org/gmane.linux.kernel.commits.mm/40640

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/ata/sata_via.c |   35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

Index: work/drivers/ata/sata_via.c
===================================================================
--- work.orig/drivers/ata/sata_via.c
+++ work/drivers/ata/sata_via.c
@@ -70,6 +70,7 @@ enum {
 static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 static int svia_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int svia_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
+static void svia_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
 static void svia_noop_freeze(struct ata_port *ap);
 static int vt6420_prereset(struct ata_link *link, unsigned long deadline);
 static int vt6421_pata_cable_detect(struct ata_port *ap);
@@ -103,21 +104,26 @@ static struct scsi_host_template svia_sh
 	ATA_BMDMA_SHT(DRV_NAME),
 };
 
-static struct ata_port_operations vt6420_sata_ops = {
+static struct ata_port_operations svia_base_ops = {
 	.inherits		= &ata_bmdma_port_ops,
+	.sff_tf_load		= svia_tf_load,
+};
+
+static struct ata_port_operations vt6420_sata_ops = {
+	.inherits		= &svia_base_ops,
 	.freeze			= svia_noop_freeze,
 	.prereset		= vt6420_prereset,
 };
 
 static struct ata_port_operations vt6421_pata_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &svia_base_ops,
 	.cable_detect		= vt6421_pata_cable_detect,
 	.set_piomode		= vt6421_set_pio_mode,
 	.set_dmamode		= vt6421_set_dma_mode,
 };
 
 static struct ata_port_operations vt6421_sata_ops = {
-	.inherits		= &ata_bmdma_port_ops,
+	.inherits		= &svia_base_ops,
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
 };
@@ -168,6 +174,29 @@ static int svia_scr_write(struct ata_lin
 	return 0;
 }
 
+/**
+ *	svia_tf_load - send taskfile registers to host controller
+ *	@ap: Port to which output is sent
+ *	@tf: ATA taskfile register set
+ *
+ *	Outputs ATA taskfile to standard ATA host controller.
+ *
+ *	This is to fix the internal bug of via chipsets, which will
+ *	reset the device register after changing the IEN bit on ctl
+ *	register.
+ */
+static void svia_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
+{
+	struct ata_taskfile ttf;
+
+	if (tf->ctl != ap->last_ctl)  {
+		ttf = *tf;
+		ttf.flags |= ATA_TFLAG_DEVICE;
+		tf = &ttf;
+	}
+	ata_sff_tf_load(ap, tf);
+}
+
 static void svia_noop_freeze(struct ata_port *ap)
 {
 	/* Some VIA controllers choke if ATA_NIEN is manipulated in
