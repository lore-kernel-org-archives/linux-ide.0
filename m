From: Brett Russ <russb@emc.com>
Subject: [PATCH libata-2.6] AHCI: support for tf_read (RFC)
Date: Thu, 24 Feb 2005 18:24:13 -0500 (EST)
Message-ID: <20050224232413.4869514FC5@lns1032.lss.emc.com>
Received: from mailhub.lss.emc.com ([168.159.2.31]:31122 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S262535AbVBXXYR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 18:24:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: ric@emc.com

I coded this because ata_pass_thru_cc() (in the dev branch) and other
functions call tf_read() which is supported for most except ahci.
I've been unable to test because I'm leaving on vacation and am in a
last minute rush but wanted to get this out there for comments.

Signed-off-by: Brett Russ <russb@emc.com>

===== drivers/scsi/ahci.c 1.15 vs edited =====
--- 1.15/drivers/scsi/ahci.c	Wed Feb 23 14:47:04 2005
+++ edited/drivers/scsi/ahci.c	Thu Feb 24 18:18:59 2005
@@ -177,6 +177,7 @@
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_host_stop(struct ata_host_set *host_set);
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
@@ -222,6 +223,8 @@
 	.scr_read		= ahci_scr_read,
 	.scr_write		= ahci_scr_write,
 
+	.tf_read		= ahci_tf_read,
+
 	.port_start		= ahci_port_start,
 	.port_stop		= ahci_port_stop,
 	.host_stop		= ahci_host_stop,
@@ -483,6 +486,28 @@
 		pp->cmd_tbl_sg[i].addr_hi = cpu_to_le32((addr >> 16) >> 16);
 		pp->cmd_tbl_sg[i].flags_size = cpu_to_le32(sg_len - 1);
 	}
+}
+
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	u32 *rx_fis_reg = pp->rx_fis + RX_FIS_D2H_REG;
+
+	tf->lbal = rx_fis_reg[1] & 0xff;
+	tf->hob_lbal = rx_fis_reg[2] & 0xff;
+
+	tf->lbam = (rx_fis_reg[1] >> 8) & 0xff;
+	tf->hob_lbam = (rx_fis_reg[2] >> 8) & 0xff;
+
+	tf->lbah = (rx_fis_reg[1] >> 16) & 0xff;
+	tf->hob_lbah = (rx_fis_reg[2] >> 16) & 0xff;
+
+	tf->nsect = rx_fis_reg[3] & 0xff;
+	tf->hob_nsect = (rx_fis_reg[3] >> 8) & 0xff;
+
+	tf->device = (rx_fis_reg[1] >> 24) & 0xff;
+
+	/* feature not filled b/c doesn't exist in D2H reg FIS */
 }
 
 static void ahci_qc_prep(struct ata_queued_cmd *qc)
