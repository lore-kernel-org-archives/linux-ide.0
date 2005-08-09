From: Edward Falk <efalk@google.com>
Subject: [PATCH] Lay groundwork for ATA port multiplier support
Date: Mon, 08 Aug 2005 17:05:38 -0700
Message-ID: <42F7F352.2080307@google.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060506010801080807000505"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 216-239-45-4.google.com ([216.239.45.4]:21957 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S932378AbVHIAG0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Aug 2005 20:06:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel-daily-digest@lists.us.dell.com

This is a multi-part message in MIME format.
--------------060506010801080807000505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds a few constants related to port multipliers to libata.h, 
hdreg.h, and libata-core.c

	-ed falk

--------------060506010801080807000505
Content-Type: text/plain;
 name="patch-pm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-pm"

diff -urpN linux.git/drivers/scsi/libata-core.c linux.git.changed/drivers/scsi/libata-core.c
--- linux.git/drivers/scsi/libata-core.c	2005-08-08 16:52:03.000000000 -0700
+++ linux.git.changed/drivers/scsi/libata-core.c	2005-08-08 16:42:23.000000000 -0700
@@ -851,8 +851,8 @@ static unsigned int ata_devchk(struct at
  *	None.
  *
  *	RETURNS:
- *	Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, or %ATA_DEV_UNKNOWN
- *	the event of failure.
+ *	Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, %ATA_DEV_PM, or
+ *	%ATA_DEV_UNKNOWN in the event of failure.
  */
 
 unsigned int ata_dev_classify(struct ata_taskfile *tf)
@@ -868,12 +868,16 @@ unsigned int ata_dev_classify(struct ata
 		return ATA_DEV_ATA;
 	}
 
-	if (((tf->lbam == 0x14) && (tf->lbah == 0xeb)) ||
-	    ((tf->lbam == 0x69) && (tf->lbah == 0x96))) {
+	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb)) {
 		DPRINTK("found ATAPI device by sig\n");
 		return ATA_DEV_ATAPI;
 	}
 
+	if ((tf->lbam == 0x69) && (tf->lbah == 0x96)) {
+		DPRINTK("found port multiplier by sig\n");
+		return ATA_DEV_PM;
+	}
+
 	DPRINTK("unknown device\n");
 	return ATA_DEV_UNKNOWN;
 }
@@ -1141,7 +1145,7 @@ static void ata_dev_identify(struct ata_
 	DPRINTK("ENTER, host %u, dev %u\n", ap->id, device);
 
 	assert (dev->class == ATA_DEV_ATA || dev->class == ATA_DEV_ATAPI ||
-		dev->class == ATA_DEV_NONE);
+		dev->class == ATA_DEV_PM || dev->class == ATA_DEV_NONE);
 
 	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
 
@@ -1396,6 +1400,9 @@ void ata_port_probe(struct ata_port *ap)
  *	PHY registers, to wake up the phy (and device), and
  *	clear any reset condition.
  *
+ *	If the reset times out, the port will be disabled.  This
+ *	function probably should not be called on non-SATA interfaces.
+ *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
  *
@@ -1450,6 +1457,8 @@ void __sata_phy_reset(struct ata_port *a
  *	This function resets the SATA bus, and then probes
  *	the bus for devices.
  *
+ *	May be used as the phy_reset() entry in ata_port_operations.
+ *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
  *
@@ -2238,11 +2247,17 @@ int ata_check_atapi_dma(struct ata_queue
 
 	return rc;
 }
+
+
 /**
  *	ata_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
  *
- *	Prepare ATA taskfile for submission.
+ *	Prepare ATA taskfile for submission.  Builds an IDE
+ *	scatter-gather list in memory for devices which support
+ *	standard PRD tables.
+ *
+ *	May be used as the qc_prep() entry in ata_port_operations.
  *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
@@ -2255,6 +2270,7 @@ void ata_qc_prep(struct ata_queued_cmd *
 	ata_fill_sg(qc);
 }
 
+
 /**
  *	ata_sg_init_one - Associate command with memory buffer
  *	@qc: Command to be associated
@@ -3134,6 +3125,11 @@ static inline int ata_should_dma_map(str
  *	area, filling in the S/G table, and finally
  *	writing the taskfile to hardware, starting the command.
  *
+ *	Calls the driver's qc_prep() and qc_issue() entry points.
+ *
+ *	Note: may NOT be used as the qc_issue() entry in
+ *	ata_port_operations.
+ *
  *	LOCKING:
  *	spin_lock_irqsave(host_set lock)
  *
@@ -3840,6 +3836,12 @@ err_out:
  *	This function requests irqs, probes the ATA bus, and probes
  *	the SCSI bus.
  *
+ *	For each port, this function executes a COMRESET, and a soft reset.
+ *	For each device on each port, it attempts an IDENTIFY DEVICE.
+ *
+ *	ata_device_add() is typically called from within the driver's
+ *	xxx_init_one() probe function.
+ *
  *	LOCKING:
  *	PCI/etc. bus probe sem.
  *
diff -urpN linux.git/include/linux/hdreg.h linux.git.changed/include/linux/hdreg.h
--- linux.git/include/linux/hdreg.h	2005-08-08 16:52:10.000000000 -0700
+++ linux.git.changed/include/linux/hdreg.h	2005-08-08 15:49:40.000000000 -0700
@@ -286,10 +286,12 @@ typedef struct hd_drive_hob_hdr {
 #define WIN_STANDBY			0xE2 /* Set device in Standby Mode */
 #define WIN_SETIDLE1			0xE3
 #define WIN_READ_BUFFER			0xE4 /* force read only 1 sector */
+#define WIN_READ_PORT_MULTIPLIER	0xE4 /* read port multiplier register */
 #define WIN_CHECKPOWERMODE1		0xE5
 #define WIN_SLEEPNOW1			0xE6
 #define WIN_FLUSH_CACHE			0xE7
 #define WIN_WRITE_BUFFER		0xE8 /* force write only 1 sector */
+#define WIN_WRITE_PORT_MULTIPLIER	0xE8 /* write port multiplier register */
 #define WIN_WRITE_SAME			0xE9 /* read ata-2 to use */
 	/* SET_FEATURES 0x22 or 0xDD */
 #define WIN_FLUSH_CACHE_EXT		0xEA /* 48-Bit */
@@ -370,6 +372,22 @@ typedef struct hd_drive_hob_hdr {
 #define SECURITY_FREEZE_LOCK		0xBE
 #define SECURITY_DISABLE_PASSWORD	0xBF
 
+
+/* Port multiplier registers */
+/* General registers (port 15) */
+#define	PM_GSCR_ID			0	/* Product Identifier */
+#define	PM_GSCR_REV			1	/* Revision Information */
+#define	PM_GSCR_PORT_INFO		2	/* Port Information */
+#define	PM_GSCR_ERRORS			32	/* Error Information */
+#define	PM_GSCR_ERROR_EN		33	/* Error Information Enable */
+#define	PM_GSCR_FEATURES		64	/* Optional Features Support */
+#define	PM_GSCR_FEATURE_EN		96	/* Optional Features Enable */
+/* Port registers (ports 0-14) */
+#define	PM_PSCR_STATUS			0	/* SStatus register */
+#define	PM_PSCR_SERROR			1	/* SError register */
+#define	PM_PSCR_SCONTROL		2	/* SControl register */
+#define	PM_PSCR_SACTIVE			4	/* SActive register */
+
 struct hd_geometry {
       unsigned char heads;
       unsigned char sectors;
diff -urpN linux.git/include/linux/libata.h linux.git.changed/include/linux/libata.h
--- linux.git/include/linux/libata.h	2005-08-08 16:52:11.000000000 -0700
+++ linux.git.changed/include/linux/libata.h	2005-08-08 15:45:32.000000000 -0700
@@ -101,7 +101,9 @@ enum {
 	ATA_DEV_ATA_UNSUP	= 2,	/* ATA device (unsupported) */
 	ATA_DEV_ATAPI		= 3,	/* ATAPI device */
 	ATA_DEV_ATAPI_UNSUP	= 4,	/* ATAPI device (unsupported) */
-	ATA_DEV_NONE		= 5,	/* no device */
+	ATA_DEV_PM		= 5,	/* Port Multiplier */
+	ATA_DEV_PM_UNSUP	= 6,	/* Port Multiplier (unsupported) */
+	ATA_DEV_NONE		= 7,	/* no device */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 1), /* host supports slave dev */
@@ -113,6 +115,8 @@ enum {
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
 	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
+	ATA_FLAG_PM_POSS	= (1 << 9), /* host supports port multiplier */
+
 
 	ATA_QCFLAG_ACTIVE	= (1 << 1), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
@@ -460,7 +464,8 @@ static inline unsigned int ata_tag_valid
 static inline unsigned int ata_dev_present(struct ata_device *dev)
 {
 	return ((dev->class == ATA_DEV_ATA) ||
-		(dev->class == ATA_DEV_ATAPI));
+		(dev->class == ATA_DEV_ATAPI) ||
+		(dev->class == ATA_DEV_PM));
 }
 
 static inline u8 ata_chk_status(struct ata_port *ap)

--------------060506010801080807000505--
