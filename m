From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH 7/9] libata: Implement support for sense data reporting
Date: Fri, 27 Mar 2015 16:46:36 +0100
Message-ID: <1427471198-62676-8-git-send-email-hare@suse.de>
References: <1427471198-62676-1-git-send-email-hare@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427471198-62676-1-git-send-email-hare@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
List-Id: linux-ide@vger.kernel.org

ACS-4 defines a sense data reporting feature set.
This patch implements support for it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/libata-core.c | 20 ++++++++++-
 drivers/ata/libata-eh.c   | 86 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/ata.h       | 18 ++++++++++
 3 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ef150eb..2ff3ab6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2144,6 +2144,24 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 	return 0;
 }
 
+static void ata_dev_config_sense_reporting(struct ata_device *dev)
+{
+	unsigned int err_mask;
+
+	if (!ata_id_has_sense_reporting(dev->id))
+		return;
+
+	if (ata_id_sense_reporting_enabled(dev->id))
+		return;
+
+	err_mask = ata_dev_set_feature(dev, SETFEATURE_SENSE_DATA, 0x1);
+	if (err_mask) {
+		ata_dev_dbg(dev,
+			    "failed to enable Sense Data Reporting, Emask 0x%x\n",
+			    err_mask);
+	}
+}
+
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
@@ -2366,7 +2384,7 @@ int ata_dev_configure(struct ata_device *dev)
 					dev->devslp_timing[i] = sata_setting[j];
 				}
 		}
-
+		ata_dev_config_sense_reporting(dev);
 		dev->cdb_len = 16;
 	}
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c9b1994..9fa81d9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1618,6 +1618,70 @@ unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
 }
 
 /**
+ *	ata_eh_request_sense - perform REQUEST_SENSE_DATA_EXT
+ *	@dev: device to perform REQUEST_SENSE_SENSE_DATA_EXT to
+ *	@sense_buf: result sense data buffer (SCSI_SENSE_BUFFERSIZE bytes long)
+ *	@dfl_sense_key: default sense key to use
+ *
+ *	Perform REQUEST_SENSE_DATA_EXT after the device reported CHECK
+ *	SENSE.  This function is EH helper.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	encoded sense data on success, 0 on failure or if sense data
+ *	is not available.
+ */
+static u32 ata_eh_request_sense(struct ata_queued_cmd *qc,
+				struct scsi_cmnd *cmd)
+{
+	struct ata_device *dev = qc->dev;
+	struct ata_taskfile tf;
+	unsigned int err_mask;
+
+	if (!cmd)
+		return 0;
+
+	DPRINTK("ATA request sense\n");
+	ata_dev_warn(dev, "request sense\n");
+	if (!ata_id_sense_reporting_enabled(dev->id)) {
+		ata_dev_warn(qc->dev, "sense data reporting disabled\n");
+		return 0;
+	}
+	ata_tf_init(dev, &tf);
+
+	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	tf.flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
+	tf.command = ATA_CMD_REQ_SENSE_DATA;
+	tf.protocol = ATA_PROT_NODATA;
+
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
+	/*
+	 * ACS-4 states:
+	 * The device may set the SENSE DATA AVAILABLE bit to one in the
+	 * STATUS field and clear the ERROR bit to zero in the STATUS field
+	 * to indicate that the command returned completion without an error
+	 * and the sense data described in table 306 is available.
+	 *
+	 * IOW the 'ATA_SENSE' bit might not be set even though valid
+	 * sense data is available.
+	 * So check for both.
+	 */
+	if ((tf.command & ATA_SENSE) ||
+		tf.lbah != 0 || tf.lbam != 0 || tf.lbal != 0) {
+		ata_scsi_set_sense(cmd, tf.lbah, tf.lbam, tf.lbal);
+		qc->flags |= ATA_QCFLAG_SENSE_VALID;
+		ata_dev_warn(dev, "sense data %02x/%02x/%02x\n",
+			     tf.lbah, tf.lbam, tf.lbal);
+	} else {
+		ata_dev_warn(dev, "request sense failed stat %02x emask %x\n",
+			     tf.command, err_mask);
+	}
+	return err_mask;
+}
+
+/**
  *	atapi_eh_request_sense - perform ATAPI REQUEST_SENSE
  *	@dev: device to perform REQUEST_SENSE to
  *	@sense_buf: result sense data buffer (SCSI_SENSE_BUFFERSIZE bytes long)
@@ -1820,7 +1884,22 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 		return ATA_EH_RESET;
 	}
 
-	/* Set by NCQ autosense */
+	/*
+	 * Sense data reporting does not work if the
+	 * device fault bit is set.
+	 */
+	if ((stat & ATA_SENSE) && !(stat & ATA_DF) &&
+	    !(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
+		if (!(qc->ap->pflags & ATA_PFLAG_FROZEN)) {
+			tmp = ata_eh_request_sense(qc, qc->scsicmd);
+			if (tmp)
+				qc->err_mask |= tmp;
+		} else {
+			ata_dev_warn(qc->dev, "sense data available but port frozen\n");
+		}
+	}
+
+	/* Set by NCQ autosense or request sense above */
 	if (qc->flags & ATA_QCFLAG_SENSE_VALID)
 		return 0;
 
@@ -2566,14 +2645,15 @@ static void ata_eh_link_report(struct ata_link *link)
 
 #ifdef CONFIG_ATA_VERBOSE_ERROR
 		if (res->command & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ |
-				    ATA_ERR)) {
+				    ATA_SENSE | ATA_ERR)) {
 			if (res->command & ATA_BUSY)
 				ata_dev_err(qc->dev, "status: { Busy }\n");
 			else
-				ata_dev_err(qc->dev, "status: { %s%s%s%s}\n",
+				ata_dev_err(qc->dev, "status: { %s%s%s%s%s}\n",
 				  res->command & ATA_DRDY ? "DRDY " : "",
 				  res->command & ATA_DF ? "DF " : "",
 				  res->command & ATA_DRQ ? "DRQ " : "",
+				  res->command & ATA_SENSE ? "SENSE " : "",
 				  res->command & ATA_ERR ? "ERR " : "");
 		}
 
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 0c65526..b666b77 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -94,6 +94,8 @@ enum {
 	ATA_ID_SECTOR_SIZE	= 106,
 	ATA_ID_WWN		= 108,
 	ATA_ID_LOGICAL_SECTOR_SIZE	= 117,	/* and 118 */
+	ATA_ID_COMMAND_SET_3	= 119,
+	ATA_ID_COMMAND_SET_4	= 120,
 	ATA_ID_LAST_LUN		= 126,
 	ATA_ID_DLF		= 128,
 	ATA_ID_CSFO		= 129,
@@ -382,6 +384,8 @@ enum {
 	SATA_SSP		= 0x06,	/* Software Settings Preservation */
 	SATA_DEVSLP		= 0x09,	/* Device Sleep */
 
+	SETFEATURE_SENSE_DATA = 0xC3, /* Sense Data Reporting feature */
+
 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
 	ATA_SET_MAX_PASSWD	= 0x01,
@@ -705,6 +709,20 @@ static inline bool ata_id_has_read_log_dma_ext(const u16 *id)
 	return id[ATA_ID_COMMAND_SET_3] & (1 << 3);
 }
 
+static inline bool ata_id_has_sense_reporting(const u16 *id)
+{
+	if (!(id[ATA_ID_CFS_ENABLE_2] & (1 << 15)))
+		return false;
+	return id[ATA_ID_COMMAND_SET_3] & (1 << 6);
+}
+
+static inline bool ata_id_sense_reporting_enabled(const u16 *id)
+{
+	if (!(id[ATA_ID_CFS_ENABLE_2] & (1 << 15)))
+		return false;
+	return id[ATA_ID_COMMAND_SET_4] & (1 << 6);
+}
+
 /**
  *	ata_id_major_version	-	get ATA level of drive
  *	@id: Identify data
-- 
1.8.5.2
