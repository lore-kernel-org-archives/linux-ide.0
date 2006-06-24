From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/15] libata: update ata_do_simple_cmd()
Date: Sat, 24 Jun 2006 20:30:19 +0900
Message-ID: <11511486193701-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:19846 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932580AbWFXLaN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:13 -0400
Received: by nz-out-0102.google.com with SMTP id o37so445543nzf
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:13 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* the function has always returned AC_ERR_* masks not -errno but its
  return type was int.  Make return type unsigned int.

* don't print error message automatically.  it's the caller's
  responsibility.

* add header comment

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   57 +++++++++++++++++++++++++++++++++-----------
 1 files changed, 43 insertions(+), 14 deletions(-)

f078c744c2e4ab68aaaaca2183cdfc6a17d91a44
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bbd6665..4a44e75 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1131,14 +1131,23 @@ unsigned ata_exec_internal(struct ata_de
 	return err_mask;
 }
 
-/*
- * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
- * without filling any other registers
+/**
+ *	ata_do_simple_cmd - execute simple internal command
+ *	@dev: Device to which the command is sent
+ *	@cmd: Opcode to execute
+ *
+ *	Execute a 'simple' command, that only consists of the opcode
+ *	'cmd' itself, without filling any other registers
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, AC_ERR_* mask on failure
  */
-static int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
+static unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
 {
 	struct ata_taskfile tf;
-	int err;
 
 	ata_tf_init(dev, &tf);
 
@@ -1146,12 +1155,7 @@ static int ata_do_simple_cmd(struct ata_
 	tf.flags |= ATA_TFLAG_DEVICE;
 	tf.protocol = ATA_PROT_NODATA;
 
-	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
-	if (err)
-		ata_dev_printk(dev, KERN_ERR, "%s: ata command failed: %d\n",
-			       __FUNCTION__, err);
-
-	return err;
+	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
 }
 
 /**
@@ -4971,6 +4975,7 @@ int ata_port_offline(struct ata_port *ap
 
 static int ata_flush_cache(struct ata_device *dev)
 {
+	unsigned int err_mask;
 	u8 cmd;
 
 	if (!ata_try_flush_cache(dev))
@@ -4981,17 +4986,41 @@ static int ata_flush_cache(struct ata_de
 	else
 		cmd = ATA_CMD_FLUSH;
 
-	return ata_do_simple_cmd(dev, cmd);
+	err_mask = ata_do_simple_cmd(dev, cmd);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR, "failed to flush cache\n");
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static int ata_standby_drive(struct ata_device *dev)
 {
-	return ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
+	unsigned int err_mask;
+
+	err_mask = ata_do_simple_cmd(dev, ATA_CMD_STANDBYNOW1);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR, "failed to standby drive "
+			       "(err_mask=0x%x)\n", err_mask);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static int ata_start_drive(struct ata_device *dev)
 {
-	return ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
+	unsigned int err_mask;
+
+	err_mask = ata_do_simple_cmd(dev, ATA_CMD_IDLEIMMEDIATE);
+	if (err_mask) {
+		ata_dev_printk(dev, KERN_ERR, "failed to start drive "
+			       "(err_mask=0x%x)\n", err_mask);
+		return -EIO;
+	}
+
+	return 0;
 }
 
 /**
-- 
1.3.2


