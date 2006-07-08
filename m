From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/17] libata-link: separate out ata_eh_handle_dev_fail()
Date: Sat, 8 Jul 2006 14:45:35 +0900
Message-ID: <11523375351421-git-send-email-htejun@gmail.com>
References: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.195]:11714 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932517AbWGHFoo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:44 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1205846wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:43 -0700 (PDT)
In-Reply-To: <11523375353473-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out ata_eh_handle_dev_fail() from ata_eh_recover().  This is
in preparation of ata_link and PMP support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   91 +++++++++++++++++++++++++---------------------
 1 files changed, 50 insertions(+), 41 deletions(-)

9f7fbf1bc05472523f3fe382d96a1d0b4dfef2a5
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index bd89608..05f0506 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1892,6 +1892,55 @@ static int ata_eh_skip_recovery(struct a
 	return 1;
 }
 
+static void ata_eh_handle_dev_fail(struct ata_device *dev, int err,
+				   int down_xfermask)
+{
+	struct ata_port *ap = dev->ap;
+	struct ata_eh_context *ehc = &ap->eh_context;
+
+	switch (err) {
+	case -ENODEV:
+		/* device missing, schedule probing */
+		ehc->i.probe_mask |= (1 << dev->devno);
+	case -EINVAL:
+		ehc->tries[dev->devno] = 0;
+		break;
+	case -EIO:
+		sata_down_spd_limit(ap);
+	default:
+		ehc->tries[dev->devno]--;
+		if (down_xfermask &&
+		    ata_down_xfermask_limit(dev, ehc->tries[dev->devno] == 1))
+			ehc->tries[dev->devno] = 0;
+	}
+
+	if (ata_dev_enabled(dev) && !ehc->tries[dev->devno]) {
+		/* disable device if it has used up all its chances */
+		ata_dev_disable(dev);
+
+		/* detach if offline */
+		if (ata_port_offline(ap))
+			ata_eh_detach_dev(dev);
+
+		/* probe if requested */
+		if ((ehc->i.probe_mask & (1 << dev->devno)) &&
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
+		if (ehc->i.flags & ATA_EHI_DID_RESET)
+			ehc->i.action |= ATA_EH_HARDRESET;
+		else
+			ehc->i.action |= ATA_EH_SOFTRESET;
+	}
+}
+
 /**
  *	ata_eh_recover - recover host port after error
  *	@ap: host port to recover
@@ -2003,47 +2052,7 @@ static int ata_eh_recover(struct ata_por
 	goto out;
 
  dev_fail:
-	switch (rc) {
-	case -ENODEV:
-		/* device missing, schedule probing */
-		ehc->i.probe_mask |= (1 << dev->devno);
-	case -EINVAL:
-		ehc->tries[dev->devno] = 0;
-		break;
-	case -EIO:
-		sata_down_spd_limit(ap);
-	default:
-		ehc->tries[dev->devno]--;
-		if (down_xfermask &&
-		    ata_down_xfermask_limit(dev, ehc->tries[dev->devno] == 1))
-			ehc->tries[dev->devno] = 0;
-	}
-
-	if (ata_dev_enabled(dev) && !ehc->tries[dev->devno]) {
-		/* disable device if it has used up all its chances */
-		ata_dev_disable(dev);
-
-		/* detach if offline */
-		if (ata_port_offline(ap))
-			ata_eh_detach_dev(dev);
-
-		/* probe if requested */
-		if ((ehc->i.probe_mask & (1 << dev->devno)) &&
-		    !(ehc->did_probe_mask & (1 << dev->devno))) {
-			ata_eh_detach_dev(dev);
-			ata_dev_init(dev);
-
-			ehc->tries[dev->devno] = ATA_EH_DEV_TRIES;
-			ehc->did_probe_mask |= (1 << dev->devno);
-			ehc->i.action |= ATA_EH_SOFTRESET;
-		}
-	} else {
-		/* soft didn't work?  be haaaaard */
-		if (ehc->i.flags & ATA_EHI_DID_RESET)
-			ehc->i.action |= ATA_EH_HARDRESET;
-		else
-			ehc->i.action |= ATA_EH_SOFTRESET;
-	}
+	ata_eh_handle_dev_fail(dev, rc, down_xfermask);
 
 	if (ata_port_nr_enabled(ap)) {
 		ata_port_printk(ap, KERN_WARNING, "failed to recover some "
-- 
1.3.2


