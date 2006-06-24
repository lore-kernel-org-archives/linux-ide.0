From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/15] libata: move ata_do_simple_cmd() below ata_exec_internal()
Date: Sat, 24 Jun 2006 20:30:19 +0900
Message-ID: <11511486193205-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:55427 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752219AbWFXLaI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:08 -0400
Received: by nz-out-0102.google.com with SMTP id z31so964567nzd
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:08 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move ata_do_simple_cmd() below ata_exec_internal() for consistency.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   46 ++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

6797d58704ea97b5c90e3e222a7c052dd65ccf8d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6c66877..bbd6665 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1131,6 +1131,29 @@ unsigned ata_exec_internal(struct ata_de
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
@@ -4946,29 +4969,6 @@ int ata_port_offline(struct ata_port *ap
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
 static int ata_flush_cache(struct ata_device *dev)
 {
 	u8 cmd;
-- 
1.3.2


