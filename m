From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6 2/2] check status fix for ata_dev_set_xfermode,
 etc.
Date: Sat, 02 Apr 2005 23:59:54 +0800
Message-ID: <424EC17A.8090507@tw.ibm.com>
References: <424CE15F.70403@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090106090508080706010603"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:9704 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261638AbVDBQAJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Apr 2005 11:00:09 -0500
In-Reply-To: <424CE15F.70403@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090106090508080706010603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

    (Revised to use qc->upper_private_data.)
Desc:
    The same check status fix for the functions using ata_qc_complete_noop() :
i.e. ata_dev_set_xfermode(), ata_dev_init_params() and atapi_request_sense().

Changes:
- Get the status returned from ata_qc_complete_noop() and check it for possible error.

Attached please find the revised patch 2/2 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------090106090508080706010603
Content-Type: text/plain;
 name="rc_fix2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rc_fix2.diff"

--- 1.135/drivers/scsi/libata-core.c	2005-04-02 22:30:53 +08:00
+++ 1.137/drivers/scsi/libata-core.c	2005-04-02 23:17:14 +08:00
@@ -52,9 +52,9 @@
 static unsigned int ata_busy_sleep (struct ata_port *ap,
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
-static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev);
+static int ata_dev_init_params(struct ata_port *ap, struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
+static int ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
 static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift);
 static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(struct ata_port *ap,
@@ -1885,12 +1885,13 @@
  *	LOCKING:
  */
 
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
+static int ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
 {
 	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
 	int rc;
 	unsigned long flags;
+	u8 status;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
@@ -1905,6 +1906,7 @@
 	qc->tf.nsect = dev->xfer_mode;
 
 	qc->waiting = &wait;
+	qc->upper_private_data = &status;
 	qc->complete_fn = ata_qc_complete_noop;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
@@ -1912,11 +1914,19 @@
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (rc)
-		ata_port_disable(ap);
+		goto err_out;
 	else
 		wait_for_completion(&wait);
 
+	if (status & ATA_ERR)
+		goto err_out;
+
 	DPRINTK("EXIT\n");
+	return 0;
+err_out:
+	ata_port_disable(ap);
+	DPRINTK("EXIT, err\n");
+	return -1;
 }
 
 /**
@@ -1927,7 +1937,7 @@
  *	LOCKING:
  */
 
-static void ata_dev_init_params(struct ata_port *ap, struct ata_device *dev)
+static int ata_dev_init_params(struct ata_port *ap, struct ata_device *dev)
 {
 	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
@@ -1935,10 +1945,11 @@
 	unsigned long flags;
 	u16 sectors = dev->id[6];
 	u16 heads   = dev->id[3];
+	u8 status;
 
 	/* Number of sectors per track 1-255. Number of heads 1-16 */
 	if (sectors < 1 || sectors > 255 || heads < 1 || heads > 16)
-		return;
+		goto err_out;
 
 	/* set up init dev params taskfile */
 	DPRINTK("init dev params \n");
@@ -1953,6 +1964,7 @@
 	qc->tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
 	qc->waiting = &wait;
+	qc->upper_private_data = &status;
 	qc->complete_fn = ata_qc_complete_noop;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
@@ -1960,11 +1972,19 @@
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (rc)
-		ata_port_disable(ap);
+		goto err_out;
 	else
 		wait_for_completion(&wait);
 
+	if (status & ATA_ERR)
+		goto err_out;
+
 	DPRINTK("EXIT\n");
+	return 0;
+err_out:
+	ata_port_disable(ap);
+	DPRINTK("EXIT, err\n");
+	return -1;
 }
 
 /**
@@ -2540,13 +2560,14 @@
 		queue_work(ata_wq, &ap->pio_task);
 }
 
-static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
+static int atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
 				struct scsi_cmnd *cmd)
 {
 	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	int rc;
+	u8 status;
 
 	DPRINTK("ATAPI request sense\n");
 
@@ -2572,6 +2593,7 @@
 	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
 	qc->waiting = &wait;
+	qc->upper_private_data = &status;
 	qc->complete_fn = ata_qc_complete_noop;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
@@ -2579,11 +2601,19 @@
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (rc)
-		ata_port_disable(ap);
+		goto err_out;
 	else
 		wait_for_completion(&wait);
 
+	if (status & ATA_ERR)
+		goto err_out;
+
 	DPRINTK("EXIT\n");
+	return 0;
+err_out:
+	ata_port_disable(ap);
+	DPRINTK("EXIT, err\n");
+	return -1;
 }
 
 /**

--------------090106090508080706010603--


