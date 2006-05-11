From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/13] libata-hp: killl ops->probe_reset
Date: Fri, 12 May 2006 00:32:08 +0900
Message-ID: <1147361528594-git-send-email-htejun@gmail.com>
References: <11473615261297-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.206]:56391 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030267AbWEKPcV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:32:21 -0400
Received: by wx-out-0102.google.com with SMTP id i29so19904wxd
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:32:21 -0700 (PDT)
In-Reply-To: <11473615261297-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now that all drivers implementing new EH are converted to new probing
mechanism, ops->probe_reset doesn't have any user.  Kill it.

---

 drivers/scsi/libata-core.c |  185 +++-----------------------------------------
 include/linux/libata.h     |    8 --
 2 files changed, 13 insertions(+), 180 deletions(-)

4ab4ceecd22b795a66133fe621bfa75ed80bad33
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 3bce69d..e1f17c3 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1489,31 +1489,21 @@ static int ata_bus_probe(struct ata_port
 	down_xfermask = 0;
 
 	/* reset and determine device classes */
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		classes[i] = ATA_DEV_UNKNOWN;
+	ap->ops->phy_reset(ap);
 
-	if (ap->ops->probe_reset) {
-		rc = ap->ops->probe_reset(ap, classes);
-		if (rc) {
-			ata_port_printk(ap, KERN_ERR,
-					"reset failed (errno=%d)\n", rc);
-			return rc;
-		}
-	} else {
-		ap->ops->phy_reset(ap);
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
 
-		for (i = 0; i < ATA_MAX_DEVICES; i++) {
-			if (!(ap->flags & ATA_FLAG_DISABLED))
-				classes[i] = ap->device[i].class;
-			ap->device[i].class = ATA_DEV_UNKNOWN;
-		}
+		if (!(ap->flags & ATA_FLAG_DISABLED) &&
+		    dev->class != ATA_DEV_UNKNOWN)
+			classes[dev->devno] = dev->class;
+		else
+			classes[dev->devno] = ATA_DEV_NONE;
 
-		ata_port_probe(ap);
+		dev->class = ATA_DEV_UNKNOWN;
 	}
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (classes[i] == ATA_DEV_UNKNOWN)
-			classes[i] = ATA_DEV_NONE;
+	ata_port_probe(ap);
 
 	/* read IDENTIFY page and configure devices */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
@@ -2574,35 +2564,11 @@ int ata_std_prereset(struct ata_port *ap
 }
 
 /**
- *	ata_std_probeinit - initialize probing
- *	@ap: port to be probed
- *
- *	@ap is about to be probed.  Initialize it.  This function is
- *	to be used as standard callback for ata_drive_probe_reset().
- *
- *	NOTE!!! Do not use this function as probeinit if a low level
- *	driver implements only hardreset.  Just pass NULL as probeinit
- *	in that case.  Using this function is probably okay but doing
- *	so makes reset sequence different from the original
- *	->phy_reset implementation and Jeff nervous.  :-P
- */
-void ata_std_probeinit(struct ata_port *ap)
-{
-	/* resume link */
-	sata_phy_resume(ap, 1);
-
-	/* wait for device */
-	if (ata_port_online(ap))
-		ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
-}
-
-/**
  *	ata_std_softreset - reset host port via ATA SRST
  *	@ap: port to reset
  *	@classes: resulting classes of attached devices
  *
- *	Reset host port using ATA SRST.  This function is to be used
- *	as standard callback for ata_drive_*_reset() functions.
+ *	Reset host port using ATA SRST.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2657,8 +2623,6 @@ int ata_std_softreset(struct ata_port *a
  *	@class: resulting class of attached device
  *
  *	SATA phy-reset host port using DET bits of SControl register.
- *	This function is to be used as standard callback for
- *	ata_drive_*_reset().
  *
  *	LOCKING:
  *	Kernel thread context (may sleep)
@@ -2737,9 +2701,6 @@ int sata_std_hardreset(struct ata_port *
  *	the device might have been reset more than once using
  *	different reset methods before postreset is invoked.
  *
- *	This function is to be used as standard callback for
- *	ata_drive_*_reset().
- *
  *	LOCKING:
  *	Kernel thread context (may sleep)
  */
@@ -2786,32 +2747,6 @@ void ata_std_postreset(struct ata_port *
 	DPRINTK("EXIT\n");
 }
 
-/**
- *	ata_std_probe_reset - standard probe reset method
- *	@ap: prot to perform probe-reset
- *	@classes: resulting classes of attached devices
- *
- *	The stock off-the-shelf ->probe_reset method.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int ata_std_probe_reset(struct ata_port *ap, unsigned int *classes)
-{
-	ata_reset_fn_t hardreset;
-
-	hardreset = NULL;
-	if (ata_scr_valid(ap))
-		hardreset = sata_std_hardreset;
-
-	return ata_drive_probe_reset(ap, ata_std_probeinit,
-				     ata_std_softreset, hardreset,
-				     ata_std_postreset, classes);
-}
-
 int ata_do_reset(struct ata_port *ap, ata_reset_fn_t reset,
 		 unsigned int *classes)
 {
@@ -2841,97 +2776,6 @@ int ata_do_reset(struct ata_port *ap, at
 }
 
 /**
- *	ata_drive_probe_reset - Perform probe reset with given methods
- *	@ap: port to reset
- *	@probeinit: probeinit method (can be NULL)
- *	@softreset: softreset method (can be NULL)
- *	@hardreset: hardreset method (can be NULL)
- *	@postreset: postreset method (can be NULL)
- *	@classes: resulting classes of attached devices
- *
- *	Reset the specified port and classify attached devices using
- *	given methods.  This function prefers softreset but tries all
- *	possible reset sequences to reset and classify devices.  This
- *	function is intended to be used for constructing ->probe_reset
- *	callback by low level drivers.
- *
- *	Reset methods should follow the following rules.
- *
- *	- Return 0 on sucess, -errno on failure.
- *	- If classification is supported, fill classes[] with
- *	  recognized class codes.
- *	- If classification is not supported, leave classes[] alone.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -EINVAL if no reset method is avaliable, -ENODEV
- *	if classification fails, and any error code from reset
- *	methods.
- */
-int ata_drive_probe_reset(struct ata_port *ap, ata_probeinit_fn_t probeinit,
-			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-			  ata_postreset_fn_t postreset, unsigned int *classes)
-{
-	int rc = -EINVAL;
-
-	ata_eh_freeze_port(ap);
-
-	if (probeinit)
-		probeinit(ap);
-
-	if (softreset && !ata_set_sata_spd_needed(ap)) {
-		rc = ata_do_reset(ap, softreset, classes);
-		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
-			goto done;
-		ata_port_printk(ap, KERN_INFO, "softreset failed, "
-				"will try hardreset in 5 secs\n");
-		ssleep(5);
-	}
-
-	if (!hardreset)
-		goto done;
-
-	while (1) {
-		rc = ata_do_reset(ap, hardreset, classes);
-		if (rc == 0) {
-			if (classes[0] != ATA_DEV_UNKNOWN)
-				goto done;
-			break;
-		}
-
-		if (ata_down_sata_spd_limit(ap))
-			goto done;
-
-		ata_port_printk(ap, KERN_INFO, "hardreset failed, "
-				"will retry in 5 secs\n");
-		ssleep(5);
-	}
-
-	if (softreset) {
-		ata_port_printk(ap, KERN_INFO,
-				"hardreset succeeded without classification, "
-				"will retry softreset in 5 secs\n");
-		ssleep(5);
-
-		rc = ata_do_reset(ap, softreset, classes);
-	}
-
- done:
-	if (rc == 0) {
-		if (postreset)
-			postreset(ap, classes);
-
-		ata_eh_thaw_port(ap);
-
-		if (classes[0] == ATA_DEV_UNKNOWN)
-			rc = -ENODEV;
-	}
-	return rc;
-}
-
-/**
  *	ata_dev_same_device - Determine whether new ID matches configured device
  *	@dev: device to compare against
  *	@new_class: class of the new device
@@ -5358,7 +5202,7 @@ static struct ata_port * ata_host_add(co
 
 	DPRINTK("ENTER\n");
 
-	if (!ent->port_ops->probe_reset && !ent->port_ops->error_handler &&
+	if (!ent->port_ops->error_handler &&
 	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
 		printk(KERN_ERR "ata%u: no reset mechanism available\n",
 		       port_no);
@@ -5496,7 +5340,7 @@ int ata_device_add(const struct ata_prob
 			 */
 		}
 
-		if (!ap->ops->probe_reset) {
+		if (ap->ops->error_handler) {
 			int bit = fls(ATA_FLAG_LOADING) - 1;
 			unsigned long flags;
 
@@ -5933,13 +5777,10 @@ EXPORT_SYMBOL_GPL(__sata_phy_reset);
 EXPORT_SYMBOL_GPL(ata_bus_reset);
 EXPORT_SYMBOL_GPL(sata_phy_debounce);
 EXPORT_SYMBOL_GPL(sata_phy_resume);
-EXPORT_SYMBOL_GPL(ata_std_probeinit);
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 EXPORT_SYMBOL_GPL(ata_std_softreset);
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
 EXPORT_SYMBOL_GPL(ata_std_postreset);
-EXPORT_SYMBOL_GPL(ata_std_probe_reset);
-EXPORT_SYMBOL_GPL(ata_drive_probe_reset);
 EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_pair);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 85a634e..db9e84c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -296,7 +296,6 @@ struct ata_queued_cmd;
 
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
-typedef void (*ata_probeinit_fn_t)(struct ata_port *ap);
 typedef int (*ata_prereset_fn_t)(struct ata_port *ap);
 typedef int (*ata_reset_fn_t)(struct ata_port *ap, unsigned int *classes);
 typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *classes);
@@ -543,7 +542,6 @@ struct ata_port_operations {
 
 	void (*phy_reset) (struct ata_port *ap); /* obsolete */
 	void (*set_mode) (struct ata_port *ap);
-	int (*probe_reset) (struct ata_port *ap, unsigned int *classes);
 
 	void (*post_set_mode) (struct ata_port *ap);
 
@@ -614,11 +612,6 @@ extern int sata_phy_debounce(struct ata_
 			     unsigned long duration_msec,
 			     unsigned long timeout_msec);
 extern int sata_phy_resume(struct ata_port *ap, int quick);
-extern int ata_drive_probe_reset(struct ata_port *ap,
-			ata_probeinit_fn_t probeinit,
-			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
-			ata_postreset_fn_t postreset, unsigned int *classes);
-extern void ata_std_probeinit(struct ata_port *ap);
 extern int ata_std_prereset(struct ata_port *ap);
 extern int ata_std_softreset(struct ata_port *ap, unsigned int *classes);
 extern int sata_std_hardreset(struct ata_port *ap, unsigned int *class);
@@ -675,7 +668,6 @@ extern void ata_std_dev_select (struct a
 extern u8 ata_check_status(struct ata_port *ap);
 extern u8 ata_altstatus(struct ata_port *ap);
 extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf);
-extern int ata_std_probe_reset(struct ata_port *ap, unsigned int *classes);
 extern int ata_port_start (struct ata_port *ap);
 extern void ata_port_stop (struct ata_port *ap);
 extern void ata_host_stop (struct ata_host_set *host_set);
-- 
1.2.4


