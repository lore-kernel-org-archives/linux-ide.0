From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Thu, 24 Feb 2005 15:01:38 +0800
Message-ID: <421D7BD2.7030309@tw.ibm.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <421C97C1.9090701@pobox.com> <421D3DB1.1090800@tw.ibm.com> <421D41C2.3030909@pobox.com> <421D663B.5050107@tw.ibm.com> <421D679B.7020508@pobox.com> <421D7727.4030408@tw.ibm.com> <421D78A2.8090103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:46573 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261830AbVBXHBz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 02:01:55 -0500
In-Reply-To: <421D78A2.8090103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>



Jeff Garzik wrote:

> 
> 
> Please submit these libata-scsi changes in a separate patch.
> 
> 

The IDP patch with split libata-scsi fix.
Attached please find the revised patch for your review.


Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
=============================================================================================
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
+++ libata-dev-2.6-mod/drivers/scsi/libata-core.c	2005-02-24 14:35:55.000000000 +0800
@@ -52,6 +52,7 @@
  static unsigned int ata_busy_sleep (struct ata_port *ap,
  				    unsigned long tmout_pat,
  			    	    unsigned long tmout);
+static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev);
  static void ata_set_mode(struct ata_port *ap);
  static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
  static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift);
@@ -1053,11 +1054,16 @@
  			if (tmp & (1 << major_version))
  				break;

-		/* we require at least ATA-3 */
-		if (major_version < 3) {
-			printk(KERN_DEBUG "ata%u: no ATA-3\n", ap->id);
-			goto err_out_nosup;
-		}
+		/*
+		 * The exact sequence expected by certain pre-ATA4 drives is:
+		 * SRST RESET
+		 * IDENTIFY
+		 * INITIALIZE DEVICE PARAMETERS
+		 * anything else..
+		 * Some drives were very specific about that exact sequence.
+		 */
+		if (major_version < 4 || (!ata_id_has_lba(dev->id)))
+			ata_dev_init_params(ap, dev);

  		if (ata_id_has_lba(dev->id)) {
  			dev->flags |= ATA_DFLAG_LBA;
@@ -1893,6 +1899,54 @@
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
+	u16 sectors = dev->id[6];
+	u16 heads   = dev->id[3];
+
+	/* Number of sectors per track 1-255. Number of heads 1-16 */
+	if (sectors < 1 || sectors > 255 || heads < 1 || heads > 16)
+		return;
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
+	qc->tf.nsect = sectors;
+	qc->tf.device |= (heads - 1) & 0x0f; /* max head = number of heads - 1 */
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



