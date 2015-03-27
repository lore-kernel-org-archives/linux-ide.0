From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/9] libata: Implement NCQ autosense
Date: Fri, 27 Mar 2015 16:46:35 +0100
Message-ID: <1427471198-62676-7-git-send-email-hare@suse.de>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
List-Id: linux-ide@vger.kernel.org

Some newer devices support NCQ autosense (cf ACS-4), so we should
be using it to retrieve the sense code and speed up recovery.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-eh.c   | 18 ++++++++++++++++++
 drivers/ata/libata-scsi.c |  9 +++++++--
 drivers/ata/libata.h      |  1 +
 include/linux/ata.h       |  2 ++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 50ffd4e..c9b1994 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1580,6 +1580,8 @@ static int ata_eh_read_log_10h(struct ata_device *dev,
 	tf->hob_lbah = buf[10];
 	tf->nsect = buf[12];
 	tf->hob_nsect = buf[13];
+	if (ata_id_has_ncq_autosense(dev->id))
+		tf->auxiliary = buf[14] << 16 | buf[15] << 8 | buf[16];
 
 	return 0;
 }
@@ -1777,6 +1779,18 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	memcpy(&qc->result_tf, &tf, sizeof(tf));
 	qc->result_tf.flags = ATA_TFLAG_ISADDR | ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
 	qc->err_mask |= AC_ERR_DEV | AC_ERR_NCQ;
+	if (qc->result_tf.auxiliary) {
+		char sense_key, asc, ascq;
+
+		sense_key = (qc->result_tf.auxiliary >> 16) & 0xff;
+		asc = (qc->result_tf.auxiliary >> 8) & 0xff;
+		ascq = qc->result_tf.auxiliary & 0xff;
+		ata_dev_dbg(dev, "NCQ Autosense %02x/%02x/%02x\n",
+			    sense_key, asc, ascq);
+		ata_scsi_set_sense(qc->scsicmd, sense_key, asc, ascq);
+		qc->flags |= ATA_QCFLAG_SENSE_VALID;
+	}
+
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
 
@@ -1806,6 +1820,10 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 		return ATA_EH_RESET;
 	}
 
+	/* Set by NCQ autosense */
+	if (qc->flags & ATA_QCFLAG_SENSE_VALID)
+		return 0;
+
 	if (stat & (ATA_ERR | ATA_DF))
 		qc->err_mask |= AC_ERR_DEV;
 	else
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f065cb1..2e126c1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -270,8 +270,11 @@ DEVICE_ATTR(unload_heads, S_IRUGO | S_IWUSR,
 	    ata_scsi_park_show, ata_scsi_park_store);
 EXPORT_SYMBOL_GPL(dev_attr_unload_heads);
 
-static void ata_scsi_set_sense(struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq)
+void ata_scsi_set_sense(struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq)
 {
+	if (!cmd)
+		return;
+
 	cmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
 
 	scsi_build_sense_buffer(0, cmd->sense_buffer, sk, asc, ascq);
@@ -1777,7 +1780,9 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 	    ((cdb[2] & 0x20) || need_sense)) {
 		ata_gen_passthru_sense(qc);
 	} else {
-		if (!need_sense) {
+		if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
+			cmd->result = SAM_STAT_CHECK_CONDITION;
+		} else if (!need_sense) {
 			cmd->result = SAM_STAT_GOOD;
 		} else {
 			/* TODO: decide which descriptor format to use
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index f840ca1..8cfdd96 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -137,6 +137,7 @@ extern int ata_scsi_add_hosts(struct ata_host *host,
 			      struct scsi_host_template *sht);
 extern void ata_scsi_scan_host(struct ata_port *ap, int sync);
 extern int ata_scsi_offline_dev(struct ata_device *dev);
+extern void ata_scsi_set_sense(struct scsi_cmnd *cmd, u8 sk, u8 asc, u8 ascq);
 extern void ata_scsi_media_change_notify(struct ata_device *dev);
 extern void ata_scsi_hotplug(struct work_struct *work);
 extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
diff --git a/include/linux/ata.h b/include/linux/ata.h
index e3cb41c..0c65526 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -525,6 +525,8 @@ struct ata_bmdma_prd {
 #define ata_id_cdb_intr(id)	(((id)[ATA_ID_CONFIG] & 0x60) == 0x20)
 #define ata_id_has_da(id)	((id)[ATA_ID_SATA_CAPABILITY_2] & (1 << 4))
 #define ata_id_has_devslp(id)	((id)[ATA_ID_FEATURE_SUPP] & (1 << 8))
+#define ata_id_has_ncq_autosense(id) \
+				((id)[ATA_ID_FEATURE_SUPP] & (1 << 7))
 
 static inline bool ata_id_has_hipm(const u16 *id)
 {
-- 
1.8.5.2
