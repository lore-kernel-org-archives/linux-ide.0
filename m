From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/10] libata: move ata_do_simple_cmd() right below ata_exec_internal()
Date: Tue, 13 Jun 2006 00:50:28 +0900
Message-ID: <11501274283201-git-send-email-htejun@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:56657 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752077AbWFLPuf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:35 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1663630nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:50:34 -0700 (PDT)
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move ata_do_simple_cmd() right below ata_exec_internal().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   46 ++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

0b531e7f20027038fe1fb44e301fe0e4e88abbb8
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d9fdbbd..4fc8759 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1123,6 +1123,29 @@ unsigned ata_exec_internal(struct ata_de
 	return err_mask;
 }
 
+/*
+ * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
+ * without filling any other registers
+ */
+static int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
+{
+	struct ata_taskfile tf;
+	int err;
+
+	ata_tf_init(dev, &tf);
+
+	tf.command = cmd;
+	tf.flags |= ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_NODATA;
+
+	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	if (err)
+		ata_dev_printk(dev, KERN_ERR, "%s: ata command failed: %d\n",
+			       __FUNCTION__, err);
+
+	return err;
+}
+
 /**
  *	ata_pio_need_iordy	-	check if iordy needed
  *	@adev: ATA device
@@ -4924,29 +4947,6 @@ int ata_port_offline(struct ata_port *ap
 	return 0;
 }
 
-/*
- * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
- * without filling any other registers
- */
-static int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
-{
-	struct ata_taskfile tf;
-	int err;
-
-	ata_tf_init(dev, &tf);
-
-	tf.command = cmd;
-	tf.flags |= ATA_TFLAG_DEVICE;
-	tf.protocol = ATA_PROT_NODATA;
-
-	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-	if (err)
-		ata_dev_printk(dev, KERN_ERR, "%s: ata command failed: %d\n",
-			       __FUNCTION__, err);
-
-	return err;
-}
-
 /**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
-- 
1.3.2


