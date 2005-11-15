From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: queued_cmd ownership
Date: Tue, 15 Nov 2005 16:10:45 +0800
Message-ID: <43799805.9020500@tw.ibm.com>
References: <4374794C.6010701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:39650 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751370AbVKOILA
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Nov 2005 03:11:00 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jAF8AxYc008732
	for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2005 03:10:59 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jAF8CF7W026728
	for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2005 01:12:15 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jAF8AxnY007173
	for <linux-ide@vger.kernel.org>; Tue, 15 Nov 2005 01:10:59 -0700
In-Reply-To: <4374794C.6010701@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> 
> I think we need to go to an alloc/free model for ata_queued_cmd, so that
> the creator can own the results after the queued_cmd is complete.
> 
 
I've no good idea for this issue; only the following quick fix.

Changes:
- Add "void *complete_data" to ata_queued_cmd as private parameter for the complete function.

- Let the internal complete function (ata_qc_complete_noop() and ata_identify_complete())
  copy out the err_mask from the HSM thread to the caller thread, via qc->complete_data,
  before the qc is completed.

- add check for the err_mask result in the functions using internal commands:
  ex. - ata_dev_identify()
      - ata_dev_set_xfermode()
      - ata_dev_init_params()
      - ata_dev_reread_id()

- Add a new "ata_identify_complete()" complete function for ata_dev_identify()
  such that if an error is found, the "ata_identify_complete()" returns non-zero
  and qc will not be fully completed. 
  The caller thread can reuse the qc and do additional processing on the qc.  
  (modeled after the qc reuse case as in the recent atapi error handling patch)
  The caller thread has to call __ata_qc_complete() explicitly for such not-fully-completed qc.

- In ata_qc_complete(): notify the thread waiting on the "qc->waiting" completion when the
  callback indicates not to fully complete the command (non-zero).
  This is to make the waiting works for ata_identify_complete() under the not-fully-completed qc case.

Patch against the libata-dev upstream-fixes branch
(c6e6e666cbfe40f0d7fb1a293ff6332973acac37).

For your review and comment, thanks.

Albert

===========

--- upstream-fixes/include/linux/libata.h	2005-11-15 11:28:10.000000000 +0800
+++ check_result/include/linux/libata.h	2005-11-15 15:12:57.000000000 +0800
@@ -280,6 +280,7 @@ struct ata_queued_cmd {
 	struct scatterlist	*__sg;
 
 	ata_qc_cb_t		complete_fn;
+	void			*complete_data;
 
 	struct completion	*waiting;
 
--- upstream-fixes/drivers/scsi/libata-core.c	2005-11-15 11:27:59.000000000 +0800
+++ check_result/drivers/scsi/libata-core.c	2005-11-15 14:51:26.000000000 +0800
@@ -1046,6 +1046,19 @@ static unsigned int ata_pio_modes(const 
 	return modes;
 }
 
+static int ata_identify_complete(struct ata_queued_cmd *qc, unsigned int err_mask)
+{
+	*((unsigned int *)qc->complete_data) = err_mask;
+
+	if (err_mask)
+		/* half complete the command since
+		 * we might retry atapi identify.
+		 */
+		return 1;
+
+	return 0;
+}
+
 /**
  *	ata_dev_identify - obtain IDENTIFY x DEVICE page
  *	@ap: port on which device we wish to probe resides
@@ -1079,6 +1092,7 @@ static void ata_dev_identify(struct ata_
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	int rc;
+	unsigned int err_mask;
 
 	if (!ata_dev_present(dev)) {
 		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
@@ -1116,7 +1130,8 @@ retry:
 	}
 
 	qc->waiting = &wait;
-	qc->complete_fn = ata_qc_complete_noop;
+	qc->complete_fn = ata_identify_complete;
+	qc->complete_data = &err_mask;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	rc = ata_qc_issue(qc);
@@ -1124,14 +1139,13 @@ retry:
 
 	if (rc)
 		goto err_out;
-	else
-		wait_for_completion(&wait);
 
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->ops->tf_read(ap, &qc->tf);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+	/* Wait until the qc is completed in HSM and
+	 * the err_mask is copied by the complete function.
+	 */
+	wait_for_completion(&wait);
 
-	if (qc->tf.command & ATA_ERR) {
+	if (err_mask) {
 		/*
 		 * arg!  EDD works for all test cases, but seems to return
 		 * the ATA signature for some ATAPI devices.  Until the
@@ -1144,8 +1158,12 @@ retry:
 		 * to have this problem.
 		 */
 		if ((using_edd) && (dev->class == ATA_DEV_ATA)) {
-			u8 err = qc->tf.feature;
-			if (err & ATA_ABORTED) {
+			spin_lock_irqsave(&ap->host_set->lock, flags);
+			ap->ops->tf_read(ap, &qc->tf);
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+			if((qc->tf.command & ATA_ERR) &&
+			   (qc->tf.feature & ATA_ABORTED)) {
 				dev->class = ATA_DEV_ATAPI;
 				qc->cursg = 0;
 				qc->cursg_ofs = 0;
@@ -1154,6 +1172,8 @@ retry:
 				goto retry;
 			}
 		}
+
+		__ata_qc_complete(qc);
 		goto err_out;
 	}
 
@@ -2244,6 +2264,7 @@ static void ata_dev_set_xfermode(struct 
 	struct ata_queued_cmd *qc;
 	int rc;
 	unsigned long flags;
+	unsigned int err_mask;
 
 	/* set up set-features taskfile */
 	DPRINTK("set features - xfer mode\n");
@@ -2259,17 +2280,28 @@ static void ata_dev_set_xfermode(struct 
 
 	qc->waiting = &wait;
 	qc->complete_fn = ata_qc_complete_noop;
+	qc->complete_data = &err_mask;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	rc = ata_qc_issue(qc);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (rc)
-		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+		goto err_out;
+
+	/* Wait until the qc is completed in HSM and
+	 * the err_mask is copied by the complete function.
+	 */
+	wait_for_completion(&wait);
+
+	if (err_mask)
+		goto err_out;
 
 	DPRINTK("EXIT\n");
+	return;
+err_out:
+	printk(KERN_ERR "ata%u: set XFER MODE failed\n", ap->id);
+	ata_port_disable(ap);
 }
 
 /**
@@ -2286,6 +2318,7 @@ static void ata_dev_reread_id(struct ata
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	int rc;
+	unsigned int err_mask;
 
 	qc = ata_qc_new_init(ap, dev);
 	BUG_ON(qc == NULL);
@@ -2307,6 +2340,7 @@ static void ata_dev_reread_id(struct ata
 
 	qc->waiting = &wait;
 	qc->complete_fn = ata_qc_complete_noop;
+	qc->complete_data = &err_mask;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	rc = ata_qc_issue(qc);
@@ -2315,8 +2349,14 @@ static void ata_dev_reread_id(struct ata
 	if (rc)
 		goto err_out;
 
+	/* Wait until the qc is completed in HSM and
+	 * the err_mask is copied by the complete function.
+	 */
 	wait_for_completion(&wait);
 
+	if (err_mask)
+		goto err_out;
+
 	swap_buf_le16(dev->id, ATA_ID_WORDS);
 
 	ata_dump_id(dev);
@@ -2325,6 +2365,7 @@ static void ata_dev_reread_id(struct ata
 
 	return;
 err_out:
+	printk(KERN_ERR "ata%u: reread IDENTIFY device data failed\n", ap->id);
 	ata_port_disable(ap);
 }
 
@@ -2344,6 +2385,7 @@ static void ata_dev_init_params(struct a
 	unsigned long flags;
 	u16 sectors = dev->id[6];
 	u16 heads   = dev->id[3];
+	unsigned int err_mask;
 
 	/* Number of sectors per track 1-255. Number of heads 1-16 */
 	if (sectors < 1 || sectors > 255 || heads < 1 || heads > 16)
@@ -2363,17 +2405,28 @@ static void ata_dev_init_params(struct a
 
 	qc->waiting = &wait;
 	qc->complete_fn = ata_qc_complete_noop;
+	qc->complete_data = &err_mask;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	rc = ata_qc_issue(qc);
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	if (rc)
-		ata_port_disable(ap);
-	else
-		wait_for_completion(&wait);
+		goto err_out;
+
+	/* Wait until the qc is completed in HSM and
+	 * the err_mask is copied by the complete function.
+	 */
+	wait_for_completion(&wait);
+
+	if (err_mask)
+		goto err_out;
 
 	DPRINTK("EXIT\n");
+	return;
+err_out:
+	printk(KERN_ERR "ata%u: init CHS dev params failed\n", ap->id);
+	ata_port_disable(ap);
 }
 
 /**
@@ -3422,6 +3475,7 @@ struct ata_queued_cmd *ata_qc_new_init(s
 
 int ata_qc_complete_noop(struct ata_queued_cmd *qc, unsigned int err_mask)
 {
+	*((unsigned int *)qc->complete_data) = err_mask;
 	return 0;
 }
 
@@ -3501,8 +3555,14 @@ void ata_qc_complete(struct ata_queued_c
 	/* if callback indicates not to complete command (non-zero),
 	 * return immediately
 	 */
-	if (rc != 0)
+	if (rc != 0) {
+		if (qc->waiting) {
+			struct completion *waiting = qc->waiting;
+			qc->waiting = NULL;
+			complete(waiting);
+		}
 		return;
+	}
 
 	__ata_qc_complete(qc);
 


