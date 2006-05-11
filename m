From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/13] libata-hp: implement hotplug
Date: Fri, 12 May 2006 00:32:07 +0900
Message-ID: <11473615271543-git-send-email-htejun@gmail.com>
References: <11473615261297-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:10565 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030266AbWEKPcP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:32:15 -0400
Received: by wr-out-0506.google.com with SMTP id i12so392288wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:32:14 -0700 (PDT)
In-Reply-To: <11473615261297-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ATA part of hotplug.  To avoid probing broken devices over
and over again, disabled devices are not automatically detached.  They
are detached only if probing is requested for the device or the
associated port is offline.  Also, to avoid infinite probing loop,
Each device is probed only once per EH run.

As SATA PHY status is fragile, devices are detached only after it has
used up its recovery chances unless explicitly requested by LLDD or
user (LLDD may request direct detach if, for example, it supports cold
presence detection).

---

 drivers/scsi/libata-eh.c |  118 +++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 101 insertions(+), 17 deletions(-)

d68c358b60321f81cbb29687668f9a0c43d43900
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index fcbc4a5..0481abc 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -903,6 +903,7 @@ static void ata_eh_analyze_serror(struct
 	if (serror & (SERR_PHYRDY_CHG | SERR_DEV_XCHG)) {
 		err_mask |= AC_ERR_ATA_BUS;
 		action |= ATA_EH_HARDRESET;
+		ehc->i.probe_mask |= 1;
 	}
 
 	ehc->i.err_mask |= err_mask;
@@ -1439,11 +1440,12 @@ static int ata_eh_reset(struct ata_port 
 	return rc;
 }
 
-static int ata_eh_revalidate(struct ata_port *ap,
-			     struct ata_device **r_failed_dev)
+static int ata_eh_revalidate_and_attach(struct ata_port *ap,
+					struct ata_device **r_failed_dev)
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	struct ata_device *dev;
+	unsigned long flags;
 	int i, rc = 0;
 
 	DPRINTK("ENTER\n");
@@ -1465,6 +1467,23 @@ static int ata_eh_revalidate(struct ata_
 				break;
 
 			ehc->i.action &= ~ATA_EH_REVALIDATE;
+		} else if (dev->class == ATA_DEV_UNKNOWN &&
+			   ehc->tries[dev->devno] &&
+			   ata_class_enabled(ehc->classes[dev->devno])) {
+			dev->class = ehc->classes[dev->devno];
+
+			rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
+			if (rc == 0)
+				rc = ata_dev_configure(dev, 1);
+
+			if (rc) {
+				dev->class = ATA_DEV_UNKNOWN;
+				break;
+			}
+
+			spin_lock_irqsave(&ap->host_set->lock, flags);
+			ap->flags |= ATA_FLAG_SCSI_HOTPLUG;
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
 		}
 	}
 
@@ -1485,6 +1504,36 @@ static int ata_port_nr_enabled(struct at
 	return cnt;
 }
 
+static int ata_port_nr_vacant(struct ata_port *ap)
+{
+	int i, cnt = 0;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (ap->device[i].class == ATA_DEV_UNKNOWN)
+			cnt++;
+	return cnt;
+}
+
+static int ata_eh_skip_recovery(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	int i;
+
+	if (ap->flags & ATA_FLAG_FROZEN || ata_port_nr_enabled(ap))
+		return 0;
+
+	/* skip if class codes for all vacant slots are ATA_DEV_NONE */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+
+		if (dev->class == ATA_DEV_UNKNOWN &&
+		    ehc->classes[dev->devno] != ATA_DEV_NONE)
+			return 0;
+	}
+
+	return 1;
+}
+
 /**
  *	ata_eh_recover - recover host port after error
  *	@ap: host port to recover
@@ -1495,9 +1544,10 @@ static int ata_port_nr_enabled(struct at
  *
  *	This is the alpha and omega, eum and yang, heart and soul of
  *	libata exception handling.  On entry, actions required to
- *	recover each devices are recorded in eh_context.  This
- *	function executes all the operations with appropriate retrials
- *	and fallbacks to resurrect failed devices.
+ *	recover the port and hotplug requests are recorded in
+ *	eh_context.  This function executes all the operations with
+ *	appropriate retrials and fallbacks to resurrect failed
+ *	devices, detach goners and greet newcomers.
  *
  *	LOCKING:
  *	Kernel thread context (may sleep).
@@ -1520,6 +1570,19 @@ static int ata_eh_recover(struct ata_por
 		dev = &ap->device[i];
 
 		ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
+
+		/* process hotplug request */
+		if (dev->flags & ATA_DFLAG_DETACH)
+			ata_eh_detach_dev(dev);
+
+		if (!ata_dev_enabled(dev) &&
+		    (ehc->i.probe_mask & (1 << dev->devno) &&
+		     !(ehc->did_probe_mask & (1 << dev->devno)))) {
+			ata_eh_detach_dev(dev);
+			ata_dev_init(dev);
+			ehc->did_probe_mask |= (1 << dev->devno);
+			ehc->i.action |= ATA_EH_SOFTRESET;
+		}
 	}
 
  retry:
@@ -1527,15 +1590,18 @@ static int ata_eh_recover(struct ata_por
 	rc = 0;
 
 	/* skip EH if possible. */
-	if (!ata_port_nr_enabled(ap) && !(ap->flags & ATA_FLAG_FROZEN))
+	if (ata_eh_skip_recovery(ap))
 		ehc->i.action = 0;
 
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ehc->classes[i] = ATA_DEV_UNKNOWN;
+
 	/* reset */
 	if (ehc->i.action & ATA_EH_RESET_MASK) {
 		ata_eh_freeze_port(ap);
 
-		rc = ata_eh_reset(ap, 0, prereset, softreset, hardreset,
-				  postreset);
+		rc = ata_eh_reset(ap, ata_port_nr_vacant(ap), prereset,
+				  softreset, hardreset, postreset);
 		if (rc) {
 			ata_port_printk(ap, KERN_ERR,
 					"reset failed, giving up\n");
@@ -1545,8 +1611,8 @@ static int ata_eh_recover(struct ata_por
 		ata_eh_thaw_port(ap);
 	}
 
-	/* revalidate existing devices */
-	rc = ata_eh_revalidate(ap, &dev);
+	/* revalidate existing devices and attach new ones */
+	rc = ata_eh_revalidate_and_attach(ap, &dev);
 	if (rc)
 		goto dev_fail;
 
@@ -1564,6 +1630,8 @@ static int ata_eh_recover(struct ata_por
  dev_fail:
 	switch (rc) {
 	case -ENODEV:
+		/* device missing, schedule probing */
+		ehc->i.probe_mask |= (1 << dev->devno);
 	case -EINVAL:
 		ehc->tries[dev->devno] = 0;
 		break;
@@ -1576,15 +1644,31 @@ static int ata_eh_recover(struct ata_por
 			ehc->tries[dev->devno] = 0;
 	}
 
-	/* disable device if it has used up all its chances */
-	if (ata_dev_enabled(dev) && !ehc->tries[dev->devno])
+	if (ata_dev_enabled(dev) && !ehc->tries[dev->devno]) {
+		/* disable device if it has used up all its chances */
 		ata_dev_disable(dev);
 
-	/* soft didn't work?  be haaaaard */
-	if (ehc->flags & ATA_EHC_DID_RESET)
-		ehc->i.action |= ATA_EH_HARDRESET;
-	else
-		ehc->i.action |= ATA_EH_SOFTRESET;
+		/* detach if offline */
+		if (ata_port_offline(ap))
+			ata_eh_detach_dev(dev);
+
+		/* probe if requested */
+		if (ehc->i.probe_mask & (1 << dev->devno) &&
+		    !(ehc->did_probe_mask & (1 << dev->devno))) {
+			ata_eh_detach_dev(dev);
+			ata_dev_init(dev);
+
+			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
+			ehc->did_probe_mask |= (1 << dev->devno);
+			ehc->i.action |= ATA_EH_SOFTRESET;
+		}
+	} else {
+		/* soft didn't work?  be haaaaard */
+		if (ehc->flags & ATA_EHC_DID_RESET)
+			ehc->i.action |= ATA_EH_HARDRESET;
+		else
+			ehc->i.action |= ATA_EH_SOFTRESET;
+	}
 
 	if (ata_port_nr_enabled(ap)) {
 		ata_port_printk(ap, KERN_WARNING, "failed to recover some "
-- 
1.2.4


