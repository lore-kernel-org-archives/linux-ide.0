From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.4.x libata updates
Date: Mon, 23 Aug 2004 23:42:35 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040824034235.GA9260@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([216.162.42.101]:33937 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S268852AbUHXDmi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2004 23:42:38 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org


Mostly minor fixes.

Please do a

	bk pull bk://kernel.bkbits.net/jgarzik/libata-upstream-2.4

This will update the following files:

 Documentation/Configure.help |   10 ++
 drivers/scsi/libata-scsi.c   |  158 ++++++++++++++++++++++++++++++++++++++-----
 drivers/scsi/libata.h        |    2 
 drivers/scsi/sata_nv.c       |    6 +
 include/linux/ata.h          |    2 
 5 files changed, 158 insertions(+), 20 deletions(-)

through these ChangeSets:

<achew@nvidia.com> (04/08/18 1.1472.1.13)
   [libata sata_nv] fix leak on error
   
   Spotted by Francois Romieu.

<alan@redhat.com> (04/08/18 1.1472.1.12)
   [libata] improve translation of ATA errors to SCSI sense codes

<jgarzik@pobox.com> (04/08/18 1.1472.1.11)
   [ata] remove 'packed' attributed from struct ata_prd
   
   It's not needed, and it generates very poor code on some platforms.
   
   Noticed by Bart and David Miller.

<bunk@fs.tum.de> (04/08/18 1.1472.1.10)
   [PATCH] 2.4.28-pre1: add two SATA Configure.help entries
   
   The trivial patch below adds the missing Configure.help entries for two
   new options.
   
   
   Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	2004-08-23 23:41:43 -04:00
+++ b/Documentation/Configure.help	2004-08-23 23:41:43 -04:00
@@ -9324,6 +9324,16 @@
 
   If unsure, say N.
 
+CONFIG_SCSI_ATA_PIIX
+  This option enables support for ICH5 Serial ATA.
+
+  If unsure, say N.
+
+CONFIG_SCSI_SATA_NV
+  This option enables support for NVIDIA Serial ATA.
+
+  If unsure, say N.
+
 CONFIG_SCSI_SATA_PROMISE
   This option enables support for Promise Serial ATA TX2/TX4.
 
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-08-23 23:41:43 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-08-23 23:41:43 -04:00
@@ -161,34 +161,158 @@
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@qc: Command that we are erroring out
  *
- *	Converts an ATA error into a SCSI error.
- *
- *	Right now, this routine is laughably primitive.  We
- *	don't even examine what ATA told us, we just look at
- *	the command data direction, and return a fatal SCSI
- *	sense error based on that.
+ *	Converts an ATA error into a SCSI error. While we are at it
+ *	we decode and dump the ATA error for the user so that they
+ *	have some idea what really happened at the non make-believe
+ *	layer.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  */
 
-void ata_to_sense_error(struct ata_queued_cmd *qc)
+void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
+	u8 err = 0;
+	unsigned char *sb = cmd->sense_buffer;
+	/* Based on the 3ware driver translation table */
+	static unsigned char sense_table[][4] = {
+		/* BBD|ECC|ID|MAR */
+		{0xd1, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Device busy                  Aborted command
+		/* BBD|ECC|ID */
+		{0xd0,  	ABORTED_COMMAND, 0x00, 0x00}, 	// Device busy                  Aborted command
+		/* ECC|MC|MARK */
+		{0x61, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Device fault                 Hardware error
+		/* ICRC|ABRT */		/* NB: ICRC & !ABRT is BBD */
+		{0x84, 		ABORTED_COMMAND, 0x47, 0x00}, 	// Data CRC error               SCSI parity error
+		/* MC|ID|ABRT|TRK0|MARK */
+		{0x37, 		NOT_READY, 0x04, 0x00}, 	// Unit offline                 Not ready
+		/* MCR|MARK */
+		{0x09, 		NOT_READY, 0x04, 0x00}, 	// Unrecovered disk error       Not ready
+		/*  Bad address mark */
+		{0x01, 		MEDIUM_ERROR, 0x13, 0x00}, 	// Address mark not found       Address mark not found for data field
+		/* TRK0 */
+		{0x02, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Track 0 not found		  Hardware error
+		/* Abort & !ICRC */
+		{0x04, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Aborted command              Aborted command
+		/* Media change request */
+		{0x08, 		NOT_READY, 0x04, 0x00}, 	// Media change request	  FIXME: faking offline
+		/* SRV */
+		{0x10, 		ABORTED_COMMAND, 0x14, 0x00}, 	// ID not found                 Recorded entity not found
+		/* Media change */
+		{0x08,  	NOT_READY, 0x04, 0x00}, 	// Media change		  FIXME: faking offline
+		/* ECC */
+		{0x40, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Uncorrectable ECC error      Unrecovered read error
+		/* BBD - block marked bad */
+		{0x80, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Block marked bad		  Medium error, unrecovered read error
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+	};
+	static unsigned char stat_table[][4] = {
+		/* Must be first because BUSY means no other bits valid */
+		{0x80, 		ABORTED_COMMAND, 0x47, 0x00},	// Busy, fake parity for now
+		{0x20, 		HARDWARE_ERROR,  0x00, 0x00}, 	// Device fault
+		{0x08, 		ABORTED_COMMAND, 0x47, 0x00},	// Timed out in xfer, fake parity for now
+		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	  Medium error, recovered
+		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark 
+	};
+	int i = 0;
 
 	cmd->result = SAM_STAT_CHECK_CONDITION;
-
-	cmd->sense_buffer[0] = 0x70;
-	cmd->sense_buffer[2] = MEDIUM_ERROR;
-	cmd->sense_buffer[7] = 14 - 8;	/* addnl. sense len. FIXME: correct? */
-
+	
+	/*
+	 *	Is this an error we can process/parse
+	 */
+	 
+	if(drv_stat & ATA_ERR)
+		/* Read the err bits */
+		err = ata_chk_err(qc->ap);
+
+	/* Display the ATA level error info */
+	
+	printk(KERN_WARNING "ata%u: status=0x%02x { ", qc->ap->id, drv_stat);
+	if(drv_stat & 0x80)
+	{
+		printk("Busy ");
+		err = 0;	/* Data is not valid in this case */
+	}
+	else {
+		if(drv_stat & 0x40)	printk("DriveReady ");
+		if(drv_stat & 0x20)	printk("DeviceFault ");
+		if(drv_stat & 0x10)	printk("SeekComplete ");
+		if(drv_stat & 0x08)	printk("DataRequest ");
+		if(drv_stat & 0x04)	printk("CorrectedError ");
+		if(drv_stat & 0x02)	printk("Index ");
+		if(drv_stat & 0x01)	printk("Error ");
+	}
+	printk("}\n");
+	
+	if(err)
+	{
+		printk(KERN_WARNING "ata%u: error=0x%02x { ", qc->ap->id, err);
+		if(err & 0x04)		printk("DriveStatusError ");
+		if(err & 0x80)
+		{
+			if(err & 0x04)
+				printk("BadCRC ");
+			else
+				printk("Sector ");
+		}
+		if(err & 0x40)		printk("UncorrectableError ");
+		if(err & 0x10)		printk("SectorIdNotFound ");
+		if(err & 0x02)		printk("TrackZeroNotFound ");
+		if(err & 0x01)		printk("AddrMarkNotFound ");
+		printk("}\n");
+		
+		/* Should we dump sector info here too ?? */
+	}
+		
+	
+	/* Look for err */
+	while(sense_table[i][0] != 0xFF)
+	{
+		/* Look for best matches first */
+		if((sense_table[i][0] & err) == sense_table[i][0])
+		{
+			sb[0] = 0x70;
+			sb[2] = sense_table[i][1];
+			sb[7] = 0x0a;
+			sb[12] = sense_table[i][2];
+			sb[13] = sense_table[i][3];
+			return;
+		}
+		i++;
+	}
+	/* No immediate match */
+	if(err)
+		printk(KERN_DEBUG "ata%u: no sense translation for 0x%02x\n", qc->ap->id, err);
+	
+	/* Fall back to interpreting status bits */
+	while(stat_table[i][0] != 0xFF)
+	{
+		if(stat_table[i][0] & drv_stat)
+		{
+			sb[0] = 0x70;
+			sb[2] = stat_table[i][1];
+			sb[7] = 0x0a;
+			sb[12] = stat_table[i][2];
+			sb[13] = stat_table[i][3];
+			return;
+		}
+		i++;
+	}
+	/* No error ?? */
+	printk(KERN_ERR "ata%u: called with no error (%02X)!\n", qc->ap->id, drv_stat);
 	/* additional-sense-code[-qualifier] */
+	
+	sb[0] = 0x70;
+	sb[2] = MEDIUM_ERROR;
+	sb[7] = 0x0A;
 	if (cmd->sc_data_direction == SCSI_DATA_READ) {
-		cmd->sense_buffer[12] = 0x11; /* "unrecovered read error" */
-		cmd->sense_buffer[13] = 0x04;
+		sb[12] = 0x11; /* "unrecovered read error" */
+		sb[13] = 0x04;
 	} else {
-		cmd->sense_buffer[12] = 0x0C; /* "write error -             */
-		cmd->sense_buffer[13] = 0x02; /*  auto-reallocation failed" */
+		sb[12] = 0x0C; /* "write error -             */
+		sb[13] = 0x02; /*  auto-reallocation failed" */
 	}
 }
 
@@ -462,7 +586,7 @@
 	struct scsi_cmnd *cmd = qc->scsicmd;
 
 	if (unlikely(drv_stat & (ATA_ERR | ATA_BUSY | ATA_DRQ)))
-		ata_to_sense_error(qc);
+		ata_to_sense_error(qc, drv_stat);
 	else
 		cmd->result = SAM_STAT_GOOD;
 
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	2004-08-23 23:41:43 -04:00
+++ b/drivers/scsi/libata.h	2004-08-23 23:41:43 -04:00
@@ -46,7 +46,7 @@
 
 
 /* libata-scsi.c */
-extern void ata_to_sense_error(struct ata_queued_cmd *qc);
+extern void ata_to_sense_error(struct ata_queued_cmd *qc, u8 drv_stat);
 extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-08-23 23:41:43 -04:00
+++ b/drivers/scsi/sata_nv.c	2004-08-23 23:41:43 -04:00
@@ -370,7 +370,7 @@
 		probe_ent->mmio_base = ioremap(pci_resource_start(pdev, 5),
 				pci_resource_len(pdev, 5));
 		if (probe_ent->mmio_base == NULL)
-			goto err_out_free_ent;
+			goto err_out_iounmap;
 
 		base = (unsigned long)probe_ent->mmio_base;
 
@@ -395,6 +395,10 @@
 	ata_add_to_probe_list(probe_ent);
 
 	return 0;
+
+err_out_iounmap:
+	if (host->host_desc->host_flags & NV_HOST_FLAGS_SCR_MMIO)
+		iounmap(probe_ent->mmio_base);
 
 err_out_free_ent:
 	kfree(probe_ent);
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2004-08-23 23:41:43 -04:00
+++ b/include/linux/ata.h	2004-08-23 23:41:43 -04:00
@@ -192,7 +192,7 @@
 struct ata_prd {
 	u32			addr;
 	u32			flags_len;
-} __attribute__((packed));
+};
 
 struct ata_taskfile {
 	unsigned long		flags;		/* ATA_TFLAG_xxx */
