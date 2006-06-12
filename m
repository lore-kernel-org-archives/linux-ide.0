From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/10] libata: update ata_do_simple_cmd()
Date: Tue, 13 Jun 2006 00:50:28 +0900
Message-ID: <11501274283498-git-send-email-htejun@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:36172 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752080AbWFLPuf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:35 -0400
Received: by py-out-1112.google.com with SMTP id x31so1732388pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:50:35 -0700 (PDT)
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* export ata_do_simple_cmd() in drivers/scsi/libata.h
* add proper leading comment
* fix return value
* don't print error message.  it's the caller's responsibility

This will be used by new PM.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   25 ++++++++++++++-----------
 drivers/scsi/libata.h      |    1 +
 2 files changed, 15 insertions(+), 11 deletions(-)

722e4a01585700ae416ae7c7a746fd6835ddae34
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4fc8759..ba9f346 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1123,14 +1123,22 @@ unsigned ata_exec_internal(struct ata_de
 	return err_mask;
 }
 
-/*
- * Execute a 'simple' command, that only consists of the opcode 'cmd' itself,
- * without filling any other registers
+/*	ata_do_simple_cmd - execute simple internal command
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
+unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
 {
 	struct ata_taskfile tf;
-	int err;
 
 	ata_tf_init(dev, &tf);
 
@@ -1138,12 +1146,7 @@ static int ata_do_simple_cmd(struct ata_
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
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index bdd4888..539b0b5 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -50,6 +50,7 @@ extern void ata_port_flush_task(struct a
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen);
+extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   int post_reset, u16 *id);
 extern int ata_dev_configure(struct ata_device *dev, int print_info);
-- 
1.3.2


