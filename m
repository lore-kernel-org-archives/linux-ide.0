From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 8/9] libata-eh: Set 'information' field for autosense
Date: Fri, 27 Mar 2015 16:46:37 +0100
Message-ID: <1427471198-62676-9-git-send-email-hare@suse.de>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
List-Id: linux-ide@vger.kernel.org

If NCQ autosense or the sense data reporting feature is enabled
the LBA of the offending command should be stored in the sense
data 'information' field.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c |  4 ++--
 drivers/ata/libata-eh.c   |  3 +++
 drivers/ata/libata-scsi.c | 12 ++++++++++++
 drivers/ata/libata.h      |  5 ++++-
 drivers/scsi/scsi_error.c | 31 +++++++++++++++++++++++++++++++
 include/scsi/scsi_eh.h    |  1 +
 6 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2ff3ab6..51cba76 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -691,11 +691,11 @@ static int ata_rwcmd_protocol(struct ata_taskfile *tf, struct ata_device *dev)
  *	RETURNS:
  *	Block address read from @tf.
  */
-u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev)
+u64 ata_tf_read_block(const struct ata_taskfile *tf, struct ata_device *dev)
 {
 	u64 block = 0;
 
-	if (tf->flags & ATA_TFLAG_LBA) {
+	if (!dev || tf->flags & ATA_TFLAG_LBA) {
 		if (tf->flags & ATA_TFLAG_LBA48) {
 			block |= (u64)tf->hob_lbah << 40;
 			block |= (u64)tf->hob_lbam << 32;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9fa81d9..77ef43e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1852,6 +1852,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 		ata_dev_dbg(dev, "NCQ Autosense %02x/%02x/%02x\n",
 			    sense_key, asc, ascq);
 		ata_scsi_set_sense(qc->scsicmd, sense_key, asc, ascq);
+		ata_scsi_set_sense_information(qc->scsicmd, &qc->result_tf);
 		qc->flags |= ATA_QCFLAG_SENSE_VALID;
 	}
 
@@ -1894,6 +1895,8 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 			tmp = ata_eh_request_sense(qc, qc->scsicmd);
 			if (tmp)
 				qc->err_mask |= tmp;
+			else
+				ata_scsi_set_sense_information(qc->scsicmd, tf);
 		} else {
 			ata_dev_warn(qc->dev, "sense data available but port frozen\n");
 		}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 2e126c1..35fec70 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -280,6 +280,18 @@ void ata_scsi_set_sense(struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq)
 	scsi_build_sense_buffer(0, cmd->sense_buffer, sk, asc, ascq);
 }
 
+void ata_scsi_set_sense_information(struct scsi_cmnd *cmd,
+				    const struct ata_taskfile *tf)
+{
+	u64 information;
+
+	if (!cmd)
+		return;
+
+	information = ata_tf_read_block(tf, NULL);
+	scsi_set_sense_information(cmd->sense_buffer, information);
+}
+
 static ssize_t
 ata_scsi_em_message_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 8cfdd96..a998a17 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -67,7 +67,8 @@ extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
 			   unsigned int tag);
-extern u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev);
+extern u64 ata_tf_read_block(const struct ata_taskfile *tf,
+			     struct ata_device *dev);
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
 				  int dma_dir, void *buf, unsigned int buflen,
@@ -138,6 +139,8 @@ extern int ata_scsi_add_hosts(struct ata_host *host,
 extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
 extern void ata_scsi_set_sense(struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq);
+extern void ata_scsi_set_sense_information(struct scsi_cmnd *cmd,
+					   const struct ata_taskfile *tf);
 extern void ata_scsi_media_change_notify(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
 extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 4cdaffc..c95a4e9 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -26,6 +26,7 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
+#include <asm/unaligned.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -2586,3 +2587,33 @@ void scsi_build_sense_buffer(int desc, u8 *buf, u8 key, u8 asc, u8 ascq)
 	}
 }
 EXPORT_SYMBOL(scsi_build_sense_buffer);
+
+/**
+ * scsi_set_sense_information - set the information field in a
+ *		formatted sense data buffer
+ * @buf:	Where to build sense data
+ * @info:	64-bit information value to be set
+ *
+ **/
+void scsi_set_sense_information(u8 *buf, u64 info)
+{
+	if ((buf[0] & 0x7f) == 0x72) {
+		u8 *ucp, len;
+
+		len = buf[7];
+		ucp = (char *)scsi_sense_desc_find(buf, len + 8, 0);
+		if (!ucp) {
+			buf[7] = len + 0xa;
+			ucp = buf + 8 + len;
+		}
+		ucp[0] = 0;
+		ucp[1] = 0xa;
+		ucp[2] = 0x80; /* Valid bit */
+		ucp[3] = 0;
+		put_unaligned_be64(info, &ucp[4]);
+	} else if ((buf[0] & 0x7f) == 0x70) {
+		buf[0] |= 0x80;
+		put_unaligned_be64(info, &buf[3]);
+	}
+}
+EXPORT_SYMBOL(scsi_set_sense_information);
diff --git a/include/scsi/scsi_eh.h b/include/scsi/scsi_eh.h
index 1e1421b..5a4bb5b 100644
--- a/include/scsi/scsi_eh.h
+++ b/include/scsi/scsi_eh.h
@@ -59,6 +59,7 @@ extern int scsi_get_sense_info_fld(const u8 * sense_buffer, int sb_len,
 				   u64 * info_out);
 
 extern void scsi_build_sense_buffer(int desc, u8 *buf, u8 key, u8 asc, u8 ascq);
+extern void scsi_set_sense_information(u8 *buf, u64 info);
 
 extern int scsi_ioctl_reset(struct scsi_device *, int __user *);
 
-- 
1.8.5.2
