From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] libata: implement ata_tf_read_block()
Date: Tue, 14 Nov 2006 22:37:35 +0900
Message-ID: <11635114554175-git-send-email-htejun@gmail.com>
References: <11635114553453-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:1937 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965753AbWKNNhr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Nov 2006 08:37:47 -0500
Received: by nz-out-0102.google.com with SMTP id l1so971449nzf
        for <linux-ide@vger.kernel.org>; Tue, 14 Nov 2006 05:37:47 -0800 (PST)
In-Reply-To: <11635114553453-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_tf_read_block().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h      |    1 +
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 476df94..dab577c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -240,6 +240,49 @@ int ata_rwcmd_protocol(struct ata_queued
 }
 
 /**
+ *	ata_tf_read_block - Read block address from ATA taskfile
+ *	@tf: ATA taskfile of interest
+ *	@dev: ATA device @tf belongs to
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	Read block address from @tf.  This function can handle all
+ *	three address formats - LBA, LBA48 and CHS.  tf->protocol and
+ *	flags select the address format to use.
+ *
+ *	RETURNS:
+ *	Block address read from @tf.
+ */
+u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev)
+{
+	u64 block = 0;
+
+	if (tf->flags & ATA_TFLAG_LBA) {
+		if (tf->flags & ATA_TFLAG_LBA48) {
+			block |= (u64)tf->hob_lbah << 40;
+			block |= (u64)tf->hob_lbam << 32;
+			block |= tf->hob_lbal << 24;
+		} else
+			block |= (tf->device & 0xf) << 24;
+
+		block |= tf->lbah << 16;
+		block |= tf->lbam << 8;
+		block |= tf->lbal;
+	} else {
+		u32 cyl, head, sect;
+
+		cyl = tf->lbam | (tf->lbah << 8);
+		head = tf->device & 0xf;
+		sect = tf->lbal;
+
+		block = (cyl * dev->heads + head) * dev->sectors + sect;
+	}
+
+	return block;
+}
+
+/**
  *	ata_pack_xfermask - Pack pio, mwdma and udma masks into xfer_mask
  *	@pio_mask: pio_mask
  *	@mwdma_mask: mwdma_mask
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index e4ffb2e..0549b19 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -45,6 +45,7 @@ extern int atapi_dmadir;
 extern int libata_fua;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
+extern u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev);
 extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_port_flush_task(struct ata_port *ap);
 extern unsigned ata_exec_internal(struct ata_device *dev,
-- 
1.4.3.3


