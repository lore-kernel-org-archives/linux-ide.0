From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] 2.6.x libata update
Date: Fri, 22 Oct 2004 00:57:27 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041022045727.GA31230@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:3000 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266786AbUJVE6b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Oct 2004 00:58:31 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Today's libata update.

NOTE:  bkbits.net and openlogging.org seem to be down, so I list my
alternate location in the BK URL below.  If you tried to pull
net-drivers-2.6 and failed (submitted earlier today), you can pull that
with 'bk pull bk://kernel.bkbits.net/jgarzik/net-drivers-2.6'

Anyway, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-2.6

This will update the following files:

 drivers/scsi/libata-core.c |   19 ++++++------
 drivers/scsi/libata-scsi.c |   66 +++++++++++++++++++++------------------------
 drivers/scsi/libata.h      |    5 +--
 drivers/scsi/sata_sil.c    |    2 -
 include/linux/ata.h        |   36 ++++++++++++------------
 include/linux/libata.h     |   12 ++++----
 6 files changed, 69 insertions(+), 71 deletions(-)

through these ChangeSets:

<lsml@rtr.ca> (04/10/15 1.1988.89.2)
   [PATCH] Export ata_scsi_simulate() for use by non-libata drivers
   
   This patch modifies libata-scsi for easier sharing of
   the various ata_id_* functions and the ata_scsi_simulate()
   function with non-libata drivers.
   
   Signed-off-by: Mark Lord <mlord@pobox.com>

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-10-22 00:09:00 -04:00
+++ b/drivers/scsi/libata-core.c	2004-10-22 00:09:00 -04:00
@@ -831,17 +831,17 @@
  *	caller.
  */
 
-void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+void ata_dev_id_string(u16 *id, unsigned char *s,
 		       unsigned int ofs, unsigned int len)
 {
 	unsigned int c;
 
 	while (len > 0) {
-		c = dev->id[ofs] >> 8;
+		c = id[ofs] >> 8;
 		*s = c;
 		s++;
 
-		c = dev->id[ofs] & 0xff;
+		c = id[ofs] & 0xff;
 		*s = c;
 		s++;
 
@@ -1084,7 +1084,7 @@
 	 */
 
 	/* we require LBA and DMA support (bits 8 & 9 of word 49) */
-	if (!ata_id_has_dma(dev) || !ata_id_has_lba(dev)) {
+	if (!ata_id_has_dma(dev->id) || !ata_id_has_lba(dev->id)) {
 		printk(KERN_DEBUG "ata%u: no dma/lba\n", ap->id);
 		goto err_out_nosup;
 	}
@@ -1102,7 +1102,7 @@
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
-		if (!ata_id_is_ata(dev))	/* sanity check */
+		if (!ata_id_is_ata(dev->id))	/* sanity check */
 			goto err_out_nosup;
 
 		tmp = dev->id[ATA_ID_MAJOR_VER];
@@ -1116,11 +1116,11 @@
 			goto err_out_nosup;
 		}
 
-		if (ata_id_has_lba48(dev)) {
+		if (ata_id_has_lba48(dev->id)) {
 			dev->flags |= ATA_DFLAG_LBA48;
-			dev->n_sectors = ata_id_u64(dev, 100);
+			dev->n_sectors = ata_id_u64(dev->id, 100);
 		} else {
-			dev->n_sectors = ata_id_u32(dev, 60);
+			dev->n_sectors = ata_id_u32(dev->id, 60);
 		}
 
 		ap->host->max_cmd_len = 16;
@@ -1135,7 +1135,7 @@
 
 	/* ATAPI-specific feature tests */
 	else {
-		if (ata_id_is_ata(dev))		/* sanity check */
+		if (ata_id_is_ata(dev->id))		/* sanity check */
 			goto err_out_nosup;
 
 		rc = atapi_cdb_len(dev->id);
@@ -3785,3 +3785,4 @@
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
+EXPORT_SYMBOL_GPL(ata_scsi_simulate);
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-22 00:09:00 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-22 00:09:00 -04:00
@@ -34,9 +34,6 @@
 #include "libata.h"
 
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, u8 *scsicmd);
-static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
-			      struct scsi_cmnd *cmd,
-			      void (*done)(struct scsi_cmnd *));
 static struct ata_device *
 ata_scsi_find_dev(struct ata_port *ap, struct scsi_device *scsidev);
 
@@ -411,7 +408,7 @@
 	tf->protocol = ATA_PROT_NODATA;
 
 	if ((tf->flags & ATA_TFLAG_LBA48) &&
-	    (ata_id_has_flush_ext(qc->dev)))
+	    (ata_id_has_flush_ext(qc->dev->id)))
 		tf->command = ATA_CMD_FLUSH_EXT;
 	else
 		tf->command = ATA_CMD_FLUSH;
@@ -757,7 +754,7 @@
 
 /**
  *	ata_scsi_rbuf_fill - wrapper for SCSI command simulators
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@actor: Callback hook for desired SCSI command simulator
  *
  *	Takes care of the hard work of simulating a SCSI command...
@@ -793,7 +790,7 @@
 
 /**
  *	ata_scsiop_inq_std - Simulate INQUIRY command
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -807,8 +804,6 @@
 unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen)
 {
-	struct ata_device *dev = args->dev;
-
 	u8 hdr[] = {
 		TYPE_DISK,
 		0,
@@ -818,7 +813,7 @@
 	};
 
 	/* set scsi removeable (RMB) bit per ata bit */
-	if (ata_id_removeable(dev))
+	if (ata_id_removeable(args->id))
 		hdr[1] |= (1 << 7);
 
 	VPRINTK("ENTER\n");
@@ -827,8 +822,8 @@
 
 	if (buflen > 35) {
 		memcpy(&rbuf[8], "ATA     ", 8);
-		ata_dev_id_string(dev, &rbuf[16], ATA_ID_PROD_OFS, 16);
-		ata_dev_id_string(dev, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
+		ata_dev_id_string(args->id, &rbuf[16], ATA_ID_PROD_OFS, 16);
+		ata_dev_id_string(args->id, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
 		if (rbuf[32] == 0 || rbuf[32] == ' ')
 			memcpy(&rbuf[32], "n/a ", 4);
 	}
@@ -852,7 +847,7 @@
 
 /**
  *	ata_scsiop_inq_00 - Simulate INQUIRY EVPD page 0, list of pages
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -880,7 +875,7 @@
 
 /**
  *	ata_scsiop_inq_80 - Simulate INQUIRY EVPD page 80, device serial number
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -902,7 +897,7 @@
 	memcpy(rbuf, hdr, sizeof(hdr));
 
 	if (buflen > (ATA_SERNO_LEN + 4))
-		ata_dev_id_string(args->dev, (unsigned char *) &rbuf[4],
+		ata_dev_id_string(args->id, (unsigned char *) &rbuf[4],
 				  ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
 
 	return 0;
@@ -912,7 +907,7 @@
 
 /**
  *	ata_scsiop_inq_83 - Simulate INQUIRY EVPD page 83, device identity
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -941,7 +936,7 @@
 
 /**
  *	ata_scsiop_noop -
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -989,7 +984,7 @@
 
 /**
  *	ata_msense_caching - Simulate MODE SENSE caching info page
- *	@dev: Device associated with this MODE SENSE command
+ *	@id: device IDENTIFY data
  *	@ptr_io: (input/output) Location to store more output data
  *	@last: End of output data buffer
  *
@@ -1001,7 +996,7 @@
  *	None.
  */
 
-static unsigned int ata_msense_caching(struct ata_device *dev, u8 **ptr_io,
+static unsigned int ata_msense_caching(u16 *id, u8 **ptr_io,
 				       const u8 *last)
 {
 	u8 page[] = {
@@ -1011,9 +1006,9 @@
 		0, 0, 0, 0, 0, 0, 0, 0		/* 8 zeroes */
 	};
 
-	if (ata_id_wcache_enabled(dev))
+	if (ata_id_wcache_enabled(id))
 		page[2] |= (1 << 2);	/* write cache enable */
-	if (!ata_id_rahead_enabled(dev))
+	if (!ata_id_rahead_enabled(id))
 		page[12] |= (1 << 5);	/* disable read ahead */
 
 	ata_msense_push(ptr_io, last, page, sizeof(page));
@@ -1067,7 +1062,7 @@
 
 /**
  *	ata_scsiop_mode_sense - Simulate MODE SENSE 6, 10 commands
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1081,7 +1076,6 @@
 				  unsigned int buflen)
 {
 	u8 *scsicmd = args->cmd->cmnd, *p, *last;
-	struct ata_device *dev = args->dev;
 	unsigned int page_control, six_byte, output_len;
 
 	VPRINTK("ENTER\n");
@@ -1109,7 +1103,7 @@
 		break;
 
 	case 0x08:		/* caching */
-		output_len += ata_msense_caching(dev, &p, last);
+		output_len += ata_msense_caching(args->id, &p, last);
 		break;
 
 	case 0x0a: {		/* control mode */
@@ -1119,7 +1113,7 @@
 
 	case 0x3f:		/* all pages */
 		output_len += ata_msense_rw_recovery(&p, last);
-		output_len += ata_msense_caching(dev, &p, last);
+		output_len += ata_msense_caching(args->id, &p, last);
 		output_len += ata_msense_ctl_mode(&p, last);
 		break;
 
@@ -1141,7 +1135,7 @@
 
 /**
  *	ata_scsiop_read_cap - Simulate READ CAPACITY[ 16] commands
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1154,11 +1148,15 @@
 unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf,
 			        unsigned int buflen)
 {
-	u64 n_sectors = args->dev->n_sectors;
+	u64 n_sectors;
 	u32 tmp;
 
 	VPRINTK("ENTER\n");
 
+	if (ata_id_has_lba48(args->id))
+		n_sectors = ata_id_u64(args->id, 100);
+	else
+		n_sectors = ata_id_u32(args->id, 60);
 	n_sectors--;		/* ATA TotalUserSectors - 1 */
 
 	tmp = n_sectors;	/* note: truncates, if lba48 */
@@ -1196,7 +1194,7 @@
 
 /**
  *	ata_scsiop_report_luns - Simulate REPORT LUNS command
- *	@args: Port / device / SCSI command of interest.
+ *	@args: device IDENTIFY data / SCSI command of interest.
  *	@rbuf: Response buffer, to which simulated SCSI cmd output is sent.
  *	@buflen: Response buffer length.
  *
@@ -1480,7 +1478,7 @@
 		if (xlat_func)
 			ata_scsi_translate(ap, dev, cmd, done, xlat_func);
 		else
-			ata_scsi_simulate(ap, dev, cmd, done);
+			ata_scsi_simulate(dev->id, cmd, done);
 	} else
 		ata_scsi_translate(ap, dev, cmd, done, atapi_xlat);
 
@@ -1490,8 +1488,7 @@
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@ap: Port to which ATA device is attached.
- *	@dev: Target device for CDB.
+ *	@id: current IDENTIFY data for target device.
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
  *
@@ -1502,15 +1499,14 @@
  *	spin_lock_irqsave(host_set lock)
  */
 
-static void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
-			      struct scsi_cmnd *cmd,
-			      void (*done)(struct scsi_cmnd *))
+void ata_scsi_simulate(u16 *id,
+		      struct scsi_cmnd *cmd,
+		      void (*done)(struct scsi_cmnd *))
 {
 	struct ata_scsi_args args;
 	u8 *scsicmd = cmd->cmnd;
 
-	args.ap = ap;
-	args.dev = dev;
+	args.id = id;
 	args.cmd = cmd;
 	args.done = done;
 
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	2004-10-22 00:09:00 -04:00
+++ b/drivers/scsi/libata.h	2004-10-22 00:09:00 -04:00
@@ -29,9 +29,8 @@
 #define DRV_VERSION	"1.02"	/* must be exactly four chars */
 
 struct ata_scsi_args {
-	struct ata_port		*ap;
-	struct ata_device	*dev;
-	struct scsi_cmnd		*cmd;
+	u16			*id;
+	struct scsi_cmnd	*cmd;
 	void			(*done)(struct scsi_cmnd *);
 };
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-10-22 00:09:00 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-10-22 00:09:00 -04:00
@@ -288,7 +288,7 @@
 	const char *s;
 	unsigned int len;
 
-	ata_dev_id_string(dev, model_num, ATA_ID_PROD_OFS,
+	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
 			  sizeof(model_num));
 	s = &model_num[0];
 	len = strnlen(s, sizeof(model_num));
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-10-22 00:09:00 -04:00
+++ b/include/linux/ata.h	2004-10-22 00:09:00 -04:00
@@ -217,24 +217,24 @@
 	u8			command;	/* IO operation */
 };
 
-#define ata_id_is_ata(dev)	(((dev)->id[0] & (1 << 15)) == 0)
-#define ata_id_rahead_enabled(dev) ((dev)->id[85] & (1 << 6))
-#define ata_id_wcache_enabled(dev) ((dev)->id[85] & (1 << 5))
-#define ata_id_has_flush(dev) ((dev)->id[83] & (1 << 12))
-#define ata_id_has_flush_ext(dev) ((dev)->id[83] & (1 << 13))
-#define ata_id_has_lba48(dev)	((dev)->id[83] & (1 << 10))
-#define ata_id_has_wcache(dev)	((dev)->id[82] & (1 << 5))
-#define ata_id_has_pm(dev)	((dev)->id[82] & (1 << 3))
-#define ata_id_has_lba(dev)	((dev)->id[49] & (1 << 9))
-#define ata_id_has_dma(dev)	((dev)->id[49] & (1 << 8))
-#define ata_id_removeable(dev)	((dev)->id[0] & (1 << 7))
-#define ata_id_u32(dev,n)	\
-	(((u32) (dev)->id[(n) + 1] << 16) | ((u32) (dev)->id[(n)]))
-#define ata_id_u64(dev,n)	\
-	( ((u64) dev->id[(n) + 3] << 48) |	\
-	  ((u64) dev->id[(n) + 2] << 32) |	\
-	  ((u64) dev->id[(n) + 1] << 16) |	\
-	  ((u64) dev->id[(n) + 0]) )
+#define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
+#define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
+#define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
+#define ata_id_has_flush(id) ((id)[83] & (1 << 12))
+#define ata_id_has_flush_ext(id) ((id)[83] & (1 << 13))
+#define ata_id_has_lba48(id)	((id)[83] & (1 << 10))
+#define ata_id_has_wcache(id)	((id)[82] & (1 << 5))
+#define ata_id_has_pm(id)	((id)[82] & (1 << 3))
+#define ata_id_has_lba(id)	((id)[49] & (1 << 9))
+#define ata_id_has_dma(id)	((id)[49] & (1 << 8))
+#define ata_id_removeable(id)	((id)[0] & (1 << 7))
+#define ata_id_u32(id,n)	\
+	(((u32) (id)[(n) + 1] << 16) | ((u32) (id)[(n)]))
+#define ata_id_u64(id,n)	\
+	( ((u64) (id)[(n) + 3] << 48) |	\
+	  ((u64) (id)[(n) + 2] << 32) |	\
+	  ((u64) (id)[(n) + 1] << 16) |	\
+	  ((u64) (id)[(n) + 0]) )
 
 static inline int atapi_cdb_len(u16 *dev_id)
 {
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-10-22 00:09:00 -04:00
+++ b/include/linux/libata.h	2004-10-22 00:09:00 -04:00
@@ -409,7 +409,7 @@
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
 extern unsigned int ata_dev_classify(struct ata_taskfile *tf);
-extern void ata_dev_id_string(struct ata_device *dev, unsigned char *s,
+extern void ata_dev_id_string(u16 *id, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
@@ -421,7 +421,9 @@
 			      struct block_device *bdev,
 			      sector_t capacity, int geom[]);
 extern int ata_scsi_slave_config(struct scsi_device *sdev);
-
+extern void ata_scsi_simulate(u16 *id,
+			      struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *));
 
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
@@ -619,9 +621,9 @@
 
 static inline int ata_try_flush_cache(struct ata_device *dev)
 {
-	return ata_id_wcache_enabled(dev) ||
-	       ata_id_has_flush(dev) ||
-	       ata_id_has_flush_ext(dev);
+	return ata_id_wcache_enabled(dev->id) ||
+	       ata_id_has_flush(dev->id) ||
+	       ata_id_has_flush_ext(dev->id);
 }
 
 #endif /* __LINUX_LIBATA_H__ */
