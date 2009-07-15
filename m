From: Robert Hancock <hancockrwd@gmail.com>
Subject: [PATCH #NEXT] libata: add command name parsing for error output
Date: Tue, 14 Jul 2009 20:43:39 -0600
Message-ID: <4A5D425B.4080300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f184.google.com ([209.85.210.184]:38244 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZGOCuf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2009 22:50:35 -0400
Received: by yxe14 with SMTP id 14so4955907yxe.33
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2009 19:50:35 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>

This patch improve libata's output for error/notification messages to allow easier
comprehension and debugging:

When ATAPI commands issued through the SCSI layer fail, use SCSI functions
to print the CDB in human-readable form instead of just dumping out the CDB
in hex.

Print out the name of the failed command (as defined by the ATA specification)
in error handling output along with the raw register contents.

When reporting status of ACPI taskfile commands executed on resume, also output
the names of the commands being executed (or not) in readable form.

Since the extra data for printing command names increases kernel size slightly,
a config option has been added to allow disabling command name output
(as well as some of the error register parsing) for those highly sensitive to
kernel text size.

Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index b17c57f..8e64d3c 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -26,6 +26,17 @@ config ATA_NONSTANDARD
        bool
        default n
 
+config ATA_VERBOSE_ERROR
+	bool "Verbose ATA error reporting"
+	default y
+	help
+	  This option adds parsing of ATA command descriptions and error bits
+	  in libata kernel output, making it easier to interpret.
+	  This option will enlarge the kernel by approx. 6KB. Disable it only
+	  if kernel size is more important than ease of debugging.
+
+	  If unsure, say Y.
+
 config ATA_ACPI
 	bool "ATA ACPI Support"
 	depends on ACPI && PCI
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index ac176da..01964b6 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -689,6 +689,7 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 	struct ata_taskfile tf, ptf, rtf;
 	unsigned int err_mask;
 	const char *level;
+	const char *descr;
 	char msg[60];
 	int rc;
 
@@ -736,11 +737,13 @@ static int ata_acpi_run_tf(struct ata_device *dev,
 		snprintf(msg, sizeof(msg), "filtered out");
 		rc = 0;
 	}
+	descr = ata_get_cmd_descript(tf.command);
 
 	ata_dev_printk(dev, level,
-		       "ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x %s\n",
+		       "ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x (%s) %s\n",
 		       tf.command, tf.feature, tf.nsect, tf.lbal,
-		       tf.lbam, tf.lbah, tf.device, msg);
+		       tf.lbam, tf.lbah, tf.device,
+		       (descr ? descr : "unknown"), msg);
 
 	return rc;
 }
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index fa22f94..826fe6f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -40,6 +40,7 @@
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_dbg.h>
 #include "../scsi/scsi_transport_api.h"
 
 #include <linux/libata.h>
@@ -2110,6 +2111,116 @@ void ata_eh_autopsy(struct ata_port *ap)
 }
 
 /**
+ *	ata_get_cmd_descript - get description for ATA command
+ *	@command: ATA command code to get description for
+ *
+ *	Return a textual description of the given command, or NULL if the
+ *	command is not known.
+ *
+ *	LOCKING:
+ *	None
+ */
+const char *ata_get_cmd_descript(u8 command)
+{
+#ifdef CONFIG_ATA_VERBOSE_ERROR
+	static const struct
+	{
+		u8 command;
+		const char *text;
+	} cmd_descr[] = {
+		{ ATA_CMD_DEV_RESET,		"DEVICE RESET" },
+		{ ATA_CMD_CHK_POWER, 		"CHECK POWER MODE" },
+		{ ATA_CMD_STANDBY, 		"STANDBY" },
+		{ ATA_CMD_IDLE, 		"IDLE" },
+		{ ATA_CMD_EDD, 			"EXECUTE DEVICE DIAGNOSTIC" },
+		{ ATA_CMD_DOWNLOAD_MICRO,   	"DOWNLOAD MICROCODE" },
+		{ ATA_CMD_NOP,			"NOP" },
+		{ ATA_CMD_FLUSH, 		"FLUSH CACHE" },
+		{ ATA_CMD_FLUSH_EXT, 		"FLUSH CACHE EXT" },
+		{ ATA_CMD_ID_ATA,  		"IDENTIFY DEVICE" },
+		{ ATA_CMD_ID_ATAPI, 		"IDENTIFY PACKET DEVICE" },
+		{ ATA_CMD_SERVICE, 		"SERVICE" },
+		{ ATA_CMD_READ, 		"READ DMA" },
+		{ ATA_CMD_READ_EXT, 		"READ DMA EXT" },
+		{ ATA_CMD_READ_QUEUED, 		"READ DMA QUEUED" },
+		{ ATA_CMD_READ_STREAM_EXT, 	"READ STREAM EXT" },
+		{ ATA_CMD_READ_STREAM_DMA_EXT,  "READ STREAM DMA EXT" },
+		{ ATA_CMD_WRITE, 		"WRITE DMA" },
+		{ ATA_CMD_WRITE_EXT, 		"WRITE DMA EXT" },
+		{ ATA_CMD_WRITE_QUEUED, 	"WRITE DMA QUEUED EXT" },
+		{ ATA_CMD_WRITE_STREAM_EXT, 	"WRITE STREAM EXT" },
+		{ ATA_CMD_WRITE_STREAM_DMA_EXT, "WRITE STREAM DMA EXT" },
+		{ ATA_CMD_WRITE_FUA_EXT,	"WRITE DMA FUA EXT" },
+		{ ATA_CMD_WRITE_QUEUED_FUA_EXT, "WRITE DMA QUEUED FUA EXT" },
+		{ ATA_CMD_FPDMA_READ,		"READ FPDMA QUEUED" },
+		{ ATA_CMD_FPDMA_WRITE,		"WRITE FPDMA QUEUED" },
+		{ ATA_CMD_PIO_READ,		"READ SECTOR(S)" },
+		{ ATA_CMD_PIO_READ_EXT,		"READ SECTOR(S) EXT" },
+		{ ATA_CMD_PIO_WRITE,		"WRITE SECTOR(S)" },
+		{ ATA_CMD_PIO_WRITE_EXT,	"WRITE SECTOR(S) EXT" },
+		{ ATA_CMD_READ_MULTI,		"READ MULTIPLE" },
+		{ ATA_CMD_READ_MULTI_EXT,	"READ MULTIPLE EXT" },
+		{ ATA_CMD_WRITE_MULTI,		"WRITE MULTIPLE" },
+		{ ATA_CMD_WRITE_MULTI_EXT,	"WRITE MULTIPLE EXT" },
+		{ ATA_CMD_WRITE_MULTI_FUA_EXT, 	"WRITE MULTIPLE FUA EXT" },
+		{ ATA_CMD_SET_FEATURES,		"SET FEATURES" },
+		{ ATA_CMD_SET_MULTI,		"SET MULTIPLE MODE" },
+		{ ATA_CMD_VERIFY,		"READ VERIFY SECTOR(S)" },
+		{ ATA_CMD_VERIFY_EXT,		"READ VERIFY SECTOR(S) EXT" },
+		{ ATA_CMD_WRITE_UNCORR_EXT,	"WRITE UNCORRECTABLE EXT" },
+		{ ATA_CMD_STANDBYNOW1,		"STANDBY IMMEDIATE" },
+		{ ATA_CMD_IDLEIMMEDIATE,	"IDLE IMMEDIATE" },
+		{ ATA_CMD_SLEEP,		"SLEEP" },
+		{ ATA_CMD_INIT_DEV_PARAMS,	"INITIALIZE DEVICE PARAMETERS" },
+		{ ATA_CMD_READ_NATIVE_MAX,	"READ NATIVE MAX ADDRESS" },
+		{ ATA_CMD_READ_NATIVE_MAX_EXT,	"READ NATIVE MAX ADDRESS EXT" },
+		{ ATA_CMD_SET_MAX,		"SET MAX ADDRESS" },
+		{ ATA_CMD_SET_MAX_EXT,		"SET MAX ADDRESS EXT" },
+		{ ATA_CMD_READ_LOG_EXT,		"READ LOG EXT" },
+		{ ATA_CMD_WRITE_LOG_EXT,	"WRITE LOG EXT" },
+		{ ATA_CMD_READ_LOG_DMA_EXT,	"READ LOG DMA EXT" },
+		{ ATA_CMD_WRITE_LOG_DMA_EXT, 	"WRITE LOG DMA EXT" },
+		{ ATA_CMD_TRUSTED_RCV,		"TRUSTED RECEIVE" },
+		{ ATA_CMD_TRUSTED_RCV_DMA, 	"TRUSTED RECEIVE DMA" },
+		{ ATA_CMD_TRUSTED_SND,		"TRUSTED SEND" },
+		{ ATA_CMD_TRUSTED_SND_DMA, 	"TRUSTED SEND DMA" },
+		{ ATA_CMD_PMP_READ,		"READ BUFFER" },
+		{ ATA_CMD_PMP_WRITE,		"WRITE BUFFER" },
+		{ ATA_CMD_CONF_OVERLAY,		"DEVICE CONFIGURATION OVERLAY" },
+		{ ATA_CMD_SEC_SET_PASS,		"SECURITY SET PASSWORD" },
+		{ ATA_CMD_SEC_UNLOCK,		"SECURITY UNLOCK" },
+		{ ATA_CMD_SEC_ERASE_PREP,	"SECURITY ERASE PREPARE" },
+		{ ATA_CMD_SEC_ERASE_UNIT,	"SECURITY ERASE UNIT" },
+		{ ATA_CMD_SEC_FREEZE_LOCK,	"SECURITY FREEZE LOCK" },
+		{ ATA_CMD_SEC_DISABLE_PASS,	"SECURITY DISABLE PASSWORD" },
+		{ ATA_CMD_CONFIG_STREAM,	"CONFIGURE STREAM" },
+		{ ATA_CMD_SMART,		"SMART" },
+		{ ATA_CMD_MEDIA_LOCK,		"DOOR LOCK" },
+		{ ATA_CMD_MEDIA_UNLOCK,		"DOOR UNLOCK" },
+		{ ATA_CMD_CHK_MED_CRD_TYP, 	"CHECK MEDIA CARD TYPE" },
+		{ ATA_CMD_CFA_REQ_EXT_ERR, 	"CFA REQUEST EXTENDED ERROR" },
+		{ ATA_CMD_CFA_WRITE_NE,		"CFA WRITE SECTORS WITHOUT ERASE" },
+		{ ATA_CMD_CFA_TRANS_SECT,	"CFA TRANSLATE SECTOR" },
+		{ ATA_CMD_CFA_ERASE,		"CFA ERASE SECTORS" },
+		{ ATA_CMD_CFA_WRITE_MULT_NE, 	"CFA WRITE MULTIPLE WITHOUT ERASE" },
+		{ ATA_CMD_READ_LONG,		"READ LONG (with retries)" },
+		{ ATA_CMD_READ_LONG_ONCE,	"READ LONG (without retries)" },
+		{ ATA_CMD_WRITE_LONG,		"WRITE LONG (with retries)" },
+		{ ATA_CMD_WRITE_LONG_ONCE,	"WRITE LONG (without retries)" },
+		{ ATA_CMD_RESTORE,		"RECALIBRATE" },
+		{ 0,				NULL } /* terminate list */
+	};
+
+	unsigned int i;
+	for (i = 0; cmd_descr[i].text; i++)
+		if (cmd_descr[i].command == command)
+			return cmd_descr[i].text;
+#endif
+
+	return NULL;
+}
+
+/**
  *	ata_eh_link_report - report error handling to user
  *	@link: ATA link EH is going on
  *
@@ -2175,6 +2286,7 @@ static void ata_eh_link_report(struct ata_link *link)
 			ata_link_printk(link, KERN_ERR, "%s\n", desc);
 	}
 
+#ifdef CONFIG_ATA_VERBOSE_ERROR
 	if (ehc->i.serror)
 		ata_link_printk(link, KERN_ERR,
 		  "SError: { %s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s}\n",
@@ -2195,6 +2307,7 @@ static void ata_eh_link_report(struct ata_link *link)
 		  ehc->i.serror & SERR_TRANS_ST_ERROR ? "TrStaTrns " : "",
 		  ehc->i.serror & SERR_UNRECOG_FIS ? "UnrecFIS " : "",
 		  ehc->i.serror & SERR_DEV_XCHG ? "DevExch " : "");
+#endif
 
 	for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
 		struct ata_queued_cmd *qc = __ata_qc_from_tag(ap, tag);
@@ -2226,14 +2339,23 @@ static void ata_eh_link_report(struct ata_link *link)
 				 dma_str[qc->dma_dir]);
 		}
 
-		if (ata_is_atapi(qc->tf.protocol))
-			snprintf(cdb_buf, sizeof(cdb_buf),
+		if (ata_is_atapi(qc->tf.protocol)) {
+			if (qc->scsicmd)
+				scsi_print_command(qc->scsicmd);
+			else
+				snprintf(cdb_buf, sizeof(cdb_buf),
 				 "cdb %02x %02x %02x %02x %02x %02x %02x %02x  "
 				 "%02x %02x %02x %02x %02x %02x %02x %02x\n         ",
 				 cdb[0], cdb[1], cdb[2], cdb[3],
 				 cdb[4], cdb[5], cdb[6], cdb[7],
 				 cdb[8], cdb[9], cdb[10], cdb[11],
 				 cdb[12], cdb[13], cdb[14], cdb[15]);
+		} else {
+			const char *descr = ata_get_cmd_descript(cmd->command);
+			if (descr)
+				ata_dev_printk(qc->dev, KERN_ERR,
+					"failed command: %s\n", descr);
+		}
 
 		ata_dev_printk(qc->dev, KERN_ERR,
 			"cmd %02x/%02x:%02x:%02x:%02x:%02x/%02x:%02x:%02x:%02x:%02x/%02x "
@@ -2252,6 +2374,7 @@ static void ata_eh_link_report(struct ata_link *link)
 			res->device, qc->err_mask, ata_err_string(qc->err_mask),
 			qc->err_mask & AC_ERR_NCQ ? " <F>" : "");
 
+#ifdef CONFIG_ATA_VERBOSE_ERROR
 		if (res->command & (ATA_BUSY | ATA_DRDY | ATA_DF | ATA_DRQ |
 				    ATA_ERR)) {
 			if (res->command & ATA_BUSY)
@@ -2275,6 +2398,7 @@ static void ata_eh_link_report(struct ata_link *link)
 			  res->feature & ATA_UNC ? "UNC " : "",
 			  res->feature & ATA_IDNF ? "IDNF " : "",
 			  res->feature & ATA_ABORTED ? "ABRT " : "");
+#endif
 	}
 }
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 89a1e00..be8e262 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -164,6 +164,7 @@ extern void ata_eh_about_to_do(struct ata_link *link, struct ata_device *dev,
 extern void ata_eh_done(struct ata_link *link, struct ata_device *dev,
 			unsigned int action);
 extern void ata_eh_autopsy(struct ata_port *ap);
+const char *ata_get_cmd_descript(u8 command);
 extern void ata_eh_report(struct ata_port *ap);
 extern int ata_eh_reset(struct ata_link *link, int classify,
 			ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 9c75921..5a5bab7 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -210,15 +210,25 @@ enum {
 	ATA_CMD_STANDBY		= 0xE2, /* place in standby power mode */
 	ATA_CMD_IDLE		= 0xE3, /* place in idle power mode */
 	ATA_CMD_EDD		= 0x90,	/* execute device diagnostic */
+	ATA_CMD_DOWNLOAD_MICRO  = 0x92,
+	ATA_CMD_NOP		= 0x00,
 	ATA_CMD_FLUSH		= 0xE7,
 	ATA_CMD_FLUSH_EXT	= 0xEA,
 	ATA_CMD_ID_ATA		= 0xEC,
 	ATA_CMD_ID_ATAPI	= 0xA1,
+	ATA_CMD_SERVICE		= 0xA2,
 	ATA_CMD_READ		= 0xC8,
 	ATA_CMD_READ_EXT	= 0x25,
+	ATA_CMD_READ_QUEUED	= 0x26,
+	ATA_CMD_READ_STREAM_EXT	= 0x2B,
+	ATA_CMD_READ_STREAM_DMA_EXT = 0x2A,
 	ATA_CMD_WRITE		= 0xCA,
 	ATA_CMD_WRITE_EXT	= 0x35,
+	ATA_CMD_WRITE_QUEUED	= 0x36,
+	ATA_CMD_WRITE_STREAM_EXT = 0x3B,
+	ATA_CMD_WRITE_STREAM_DMA_EXT = 0x3A,
 	ATA_CMD_WRITE_FUA_EXT	= 0x3D,
+	ATA_CMD_WRITE_QUEUED_FUA_EXT = 0x3E,
 	ATA_CMD_FPDMA_READ	= 0x60,
 	ATA_CMD_FPDMA_WRITE	= 0x61,
 	ATA_CMD_PIO_READ	= 0x20,
@@ -235,6 +245,7 @@ enum {
 	ATA_CMD_PACKET		= 0xA0,
 	ATA_CMD_VERIFY		= 0x40,
 	ATA_CMD_VERIFY_EXT	= 0x42,
+	ATA_CMD_WRITE_UNCORR_EXT = 0x45,
 	ATA_CMD_STANDBYNOW1	= 0xE0,
 	ATA_CMD_IDLEIMMEDIATE	= 0xE1,
 	ATA_CMD_SLEEP		= 0xE6,
@@ -243,15 +254,34 @@ enum {
 	ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
 	ATA_CMD_SET_MAX		= 0xF9,
 	ATA_CMD_SET_MAX_EXT	= 0x37,
-	ATA_CMD_READ_LOG_EXT	= 0x2f,
+	ATA_CMD_READ_LOG_EXT	= 0x2F,
+	ATA_CMD_WRITE_LOG_EXT	= 0x3F,
+	ATA_CMD_READ_LOG_DMA_EXT = 0x47,
+	ATA_CMD_WRITE_LOG_DMA_EXT = 0x57,
+	ATA_CMD_TRUSTED_RCV	= 0x5C,
+	ATA_CMD_TRUSTED_RCV_DMA = 0x5D,
+	ATA_CMD_TRUSTED_SND	= 0x5E,
+	ATA_CMD_TRUSTED_SND_DMA = 0x5F,
 	ATA_CMD_PMP_READ	= 0xE4,
 	ATA_CMD_PMP_WRITE	= 0xE8,
 	ATA_CMD_CONF_OVERLAY	= 0xB1,
+	ATA_CMD_SEC_SET_PASS	= 0xF1,
+	ATA_CMD_SEC_UNLOCK	= 0xF2,
+	ATA_CMD_SEC_ERASE_PREP	= 0xF3,
+	ATA_CMD_SEC_ERASE_UNIT	= 0xF4,
 	ATA_CMD_SEC_FREEZE_LOCK	= 0xF5,
+	ATA_CMD_SEC_DISABLE_PASS = 0xF6,
+	ATA_CMD_CONFIG_STREAM	= 0x51,
 	ATA_CMD_SMART		= 0xB0,
 	ATA_CMD_MEDIA_LOCK	= 0xDE,
 	ATA_CMD_MEDIA_UNLOCK	= 0xDF,
 	ATA_CMD_DSM		= 0x06,
+	ATA_CMD_CHK_MED_CRD_TYP = 0xD1,
+	ATA_CMD_CFA_REQ_EXT_ERR = 0x03,
+	ATA_CMD_CFA_WRITE_NE	= 0x38,
+	ATA_CMD_CFA_TRANS_SECT	= 0x87,
+	ATA_CMD_CFA_ERASE	= 0xC0,
+	ATA_CMD_CFA_WRITE_MULT_NE = 0xCD,
 	/* marked obsolete in the ATA/ATAPI-7 spec */
 	ATA_CMD_RESTORE		= 0x10,
 
