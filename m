From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/14] libata: implement ata_eh_read_log_10h()
Date: Mon, 3 Apr 2006 17:32:39 +0900
Message-ID: <114405315998-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.195]:36988 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751628AbWDCIcu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:50 -0400
Received: by xproxy.gmail.com with SMTP id t10so764240wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:50 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_eh_read_log_10h().  This will be used by NCQ EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 107 insertions(+), 0 deletions(-)

c70528a1ce4ae9f5dffb41986e56f349f4a172ca
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 3dadff8..94ecb0c 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -528,6 +528,113 @@ static unsigned int atapi_eh_request_sen
 }
 
 /**
+ *	ata_read_log_page - read a specific log page
+ *	@ap: port on which device we wish to probe resides
+ *	@dev: target device
+ *	@page: page to read
+ *	@buf: buffer to store read page
+ *	@sectors: number of sectors to read
+ *
+ *	Read log page using READ_LOG_EXT command.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, AC_ERR_* mask otherwise.
+ */
+static unsigned int ata_read_log_page(struct ata_port *ap,
+				      struct ata_device *dev,
+				      u8 page, void *buf, unsigned int sectors)
+{
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	DPRINTK("read log page - page %d\n", page);
+
+	ata_tf_init(ap, &tf, dev->devno);
+	tf.command = ATA_CMD_READ_LOG_EXT;
+	tf.lbal = page;
+	tf.nsect = sectors;
+	tf.hob_nsect = sectors >> 8;
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_LBA48 | ATA_TFLAG_DEVICE;
+	tf.protocol = ATA_PROT_PIO;
+
+	err_mask = ata_exec_internal(ap, dev, &tf, NULL, DMA_FROM_DEVICE,
+				     buf, sectors * ATA_SECT_SIZE);
+
+	DPRINTK("EXIT, err_mask=%x\n", err_mask);
+	return err_mask;
+}
+
+/**
+ *	ata_eh_read_log_10h - Read log page 10h for NCQ error details
+ *	@ap: Port associated with device @dev
+ *	@dev: Device to read log page 10h from
+ *	@tag: Resulting tag of the failed command
+ *	@tf: Resulting taskfile registers of the failed command
+ *
+ *	Read log page 10h to obtain NCQ error details and clear error
+ *	condition.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int ata_eh_read_log_10h(struct ata_port *ap, struct ata_device *dev,
+			       unsigned int *tag, struct ata_taskfile *tf)
+{
+	u8 *buf, csum;
+	unsigned int err_mask;
+	int i, rc;
+
+	buf = kmalloc(ATA_SECT_SIZE, GFP_KERNEL);
+	if (buf == NULL) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	err_mask = ata_read_log_page(ap, dev, ATA_LOG_SATA_NCQ, buf, 1);
+	if (err_mask) {
+		rc = -EIO;
+		goto out;
+	}
+
+	csum = 0;
+	for (i = 0; i < ATA_SECT_SIZE; i++)
+		csum += buf[i];
+	if (csum)
+		printk(KERN_WARNING "ata%u: dev %u invalid checksum 0x%x on "
+		       "log page 10h\n", ap->id, dev->devno, csum);
+
+	if (buf[0] & 0x80) {
+		rc = -ENOENT;
+		goto out;
+	}
+
+	*tag = buf[0] & 0x1f;
+
+	tf->command = buf[2];
+	tf->feature = buf[3];
+	tf->lbal = buf[4];
+	tf->lbam = buf[5];
+	tf->lbah = buf[6];
+	tf->device = buf[7];
+	tf->hob_lbal = buf[8];
+	tf->hob_lbam = buf[9];
+	tf->hob_lbah = buf[10];
+	tf->nsect = buf[12];
+	tf->hob_nsect = buf[13];
+
+	rc = 0;
+ out:
+	kfree(buf);
+	return rc;
+}
+
+/**
  *	ata_eh_determine_qc - Determine which qc caused error
  *	@ap: port which failed
  *	@tf: resulting taskfile registers of the failed command
-- 
1.2.4


