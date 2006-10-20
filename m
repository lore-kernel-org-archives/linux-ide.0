From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix ATA passthrough handling for ATAPI devices
Date: Fri, 20 Oct 2006 14:09:48 +0900
Message-ID: <20061020050948.GF13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:56172 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161444AbWJTFJ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Oct 2006 01:09:58 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1293617nfe
        for <linux-ide@vger.kernel.org>; Thu, 19 Oct 2006 22:09:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: dougg@torque.net

libata used to pass all SCSI commands directly to ATAPI devices.
However, this is incorrect for ATA passthrough commands as they must
be handled by the SAT layer in libata.  Also, regardless of the
attached ATAPI device's supported packet length, SAT says that both
flavors of passthrough commands (ATA12 and ATA16) should work.

This patch makes the following changes to fix ATA passthrough handling
for ATAPI devices.

* implement atapi_get_xlat_func() and make libata handle ATA12 and
  ATA16 in SAT layer instead of passing it directly to the target
  device even if the device is ATAPI.

* Always allow 16byte CDBs for ATAPI devices.  This makes
  ata_set_port_max_cmd_len() unnecessary and dev->cdb_len meaningless
  for ATA devices.  Both are stripped away.  Note that this doesn't
  breach error checking in any substantial way.  shost->max_cmd_len
  has never beena ble to properly protect CDB length violation anyway.

This problem has been spotted by Doublas Gilbert <dougg@torque.net>.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Douglas Gilbert <dougg@torque.net>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c127d6f..5c80c73 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1357,20 +1357,6 @@ static void ata_dev_config_ncq(struct at
 		snprintf(desc, desc_sz, "NCQ (depth %d/%d)", hdepth, ddepth);
 }
 
-static void ata_set_port_max_cmd_len(struct ata_port *ap)
-{
-	int i;
-
-	if (ap->scsi_host) {
-		unsigned int len = 0;
-
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			len = max(len, ap->device[i].cdb_len);
-
-		ap->scsi_host->max_cmd_len = len;
-	}
-}
-
 /**
  *	ata_dev_configure - Configure the specified ATA/ATAPI device
  *	@dev: Target device to configure
@@ -1500,8 +1486,6 @@ int ata_dev_configure(struct ata_device 
 					"ata%u: dev %u multi count %u\n",
 					ap->id, dev->devno, dev->multi_count);
 		}
-
-		dev->cdb_len = 16;
 	}
 
 	/* ATAPI-specific feature tests */
@@ -1542,8 +1526,6 @@ int ata_dev_configure(struct ata_device 
 		}
 	}
 
-	ata_set_port_max_cmd_len(ap);
-
 	/* limit bridge transfers to udma5, 200 sectors */
 	if (ata_dev_knobble(dev)) {
 		if (ata_msg_drv(ap) && print_info)
@@ -5371,7 +5353,7 @@ static void ata_port_init_shost(struct a
 	shost->max_id = 16;
 	shost->max_lun = 1;
 	shost->max_channel = 1;
-	shost->max_cmd_len = 12;
+	shost->max_cmd_len = 16;
 }
 
 /**
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7af2a4b..9e27b7f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2794,6 +2794,23 @@ static inline ata_xlat_func_t ata_get_xl
 }
 
 /**
+ *	atapi_get_xlat_func - determine translation function for ATAPI
+ *	@cmd: SCSI command opcode to consider
+ *
+ *	Look up the SCSI command given, and determine how to translate
+ *	the command.
+ *
+ *	RETURNS:
+ *	Pointer to translation function.
+ */
+static ata_xlat_func_t atapi_get_xlat_func(u8 cmd)
+{
+	if (cmd == ATA_12 || cmd == ATA_16)
+		return ata_scsi_pass_thru;
+	return atapi_xlat;
+}
+
+/**
  *	ata_scsi_dump_cdb - dump SCSI command contents to dmesg
  *	@ap: ATA port to which the command was being sent
  *	@cmd: SCSI command to dump
@@ -2831,8 +2848,11 @@ static inline int __ata_scsi_queuecmd(st
 			rc = ata_scsi_translate(dev, cmd, done, xlat_func);
 		else
 			ata_scsi_simulate(dev, cmd, done);
-	} else
-		rc = ata_scsi_translate(dev, cmd, done, atapi_xlat);
+	} else {
+		ata_xlat_func_t xlat_func = atapi_get_xlat_func(cmd->cmnd[0]);
+
+		rc = ata_scsi_translate(dev, cmd, done, xlat_func);
+	}
 
 	return rc;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d0a7ad5..a0f95f4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -480,7 +480,7 @@ struct ata_device {
 	unsigned int		multi_count;	/* sectors count for
 						   READ/WRITE MULTIPLE */
 	unsigned int		max_sectors;	/* per-device max sectors */
-	unsigned int		cdb_len;
+	unsigned int		cdb_len;	/* ATAPI CDB length */
 
 	/* per-dev xfer mask */
 	unsigned int		pio_mask;

