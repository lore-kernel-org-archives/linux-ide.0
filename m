From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for CHS
 only devices
Date: Wed, 23 Feb 2005 19:25:52 +0800
Message-ID: <421C6840.7090903@tw.ibm.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:9724 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261460AbVBWL0l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 06:26:41 -0500
In-Reply-To: <42167CDD.50301@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>, Mark Lord <mlord@pobox.com>


> Applied patches 1 and 2 of the first CHS series,
> and patches 3-1 through 3-3 of the second CHS series, to libata-dev queue.
> 
> As a follow-up, I believe libata-core should be modified to issue the
> INITIALIZE DEVICE PARAMETERS command for all CHS devices.
> 

Jeff,

   This is the patch to issue INITIALIZE DEVICE PARAMETERS for CHS only devices.

Changes:
1. Add ATA_CMD_INIT_DEV_PARAMS to the <linux/ata.h>.

2. Add ata_dev_init_params() and call it for ATA0-ATA3 CHS-only devices.

3. Fix uninitialized tf->command in ata_scsi_verify_xlat() and comment.

   Attached please find the patch against the libata-dev-2.6 tree for your review.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
==============================================================================================
--- libata-dev-2.6/include/linux/ata.h	2005-02-21 17:23:19.000000000 +0800
+++ libata-dev-2.6-mod/include/linux/ata.h	2005-02-23 17:28:42.000000000 +0800
@@ -125,6 +125,7 @@
  	ATA_CMD_PACKET		= 0xA0,
  	ATA_CMD_VERIFY		= 0x40,
  	ATA_CMD_VERIFY_EXT	= 0x42,
+	ATA_CMD_INIT_DEV_PARAMS	= 0x91,

  	/* SETFEATURES stuff */
  	SETFEATURES_XFER	= 0x03,
--- libata-dev-2.6/drivers/scsi/libata-core.c	2005-02-21 17:23:03.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-core.c	2005-02-23 19:08:57.000000000 +0800
@@ -52,6 +52,7 @@
  static unsigned int ata_busy_sleep (struct ata_port *ap,
  				    unsigned long tmout_pat,
  			    	    unsigned long tmout);
+static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev);
  static void ata_set_mode(struct ata_port *ap);
  static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
  static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift);
@@ -1085,6 +1086,10 @@
  			dev->sectors	= dev->id[6];
  			dev->n_sectors	= dev->cylinders * dev->heads * dev->sectors;

+			if (major_version < 4)
+				/* For newer devices, INIT DEVICE PARAMS is obsolete */
+				ata_dev_init_params(ap, dev);
+
  			if (ata_id_current_chs_valid(dev->id)) {
  				/* Current CHS translation is valid. */
  				dev->cylinders = dev->id[54];
@@ -1893,6 +1898,48 @@
  }

  /**
+ *	ata_dev_init_params - Issue INIT DEV PARAMS command
+ *	@ap: Port associated with device @dev
+ *	@dev: Device to which command will be sent
+ *
+ *	LOCKING:
+ */
+
+static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev)
+{
+	DECLARE_COMPLETION(wait);
+	struct ata_queued_cmd *qc;
+	int rc;
+	unsigned long flags;
+
+	/* set up init dev params taskfile */
+	DPRINTK("init dev params \n");
+
+	qc = ata_qc_new_init(ap, dev);
+	BUG_ON(qc == NULL);
+
+	qc->tf.command = ATA_CMD_INIT_DEV_PARAMS;
+	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+	qc->tf.protocol = ATA_PROT_NODATA;
+	qc->tf.nsect = dev->sectors;
+	qc->tf.device |= (dev->heads - 1) & 0x0f;
+
+	qc->waiting = &wait;
+	qc->complete_fn = ata_qc_complete_noop;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	rc = ata_qc_issue(qc);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (rc)
+		ata_port_disable(ap);
+	else
+		wait_for_completion(&wait);
+
+	DPRINTK("EXIT\n");
+}
+
+/**
   *	ata_sg_clean -
   *	@qc:
   *
--- libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-02-21 17:23:03.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c	2005-02-22 18:32:19.000000000 +0800
@@ -785,6 +785,7 @@
  		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect))
  			return 1;
  		
+		tf->command = ATA_CMD_VERIFY;
  		tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
  		tf->lbal = sect;
  		tf->lbam = cyl;
@@ -875,7 +876,7 @@

  	/* Check and compose ATA command */
  	if (!n_block)
-		/* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */
+		/* In ATA, sector count 0 means 256 or 65536 sectors, not 0 sectors. */
  		return 1;

  	if (lba) {



