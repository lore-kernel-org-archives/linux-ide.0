From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/18] [PATCH] libata-link: separate out ata_eh_handle_dev_fail()
Date: Mon, 16 Oct 2006 07:54:40 +0900
Message-ID: <11609528802346-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:23669 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422923AbWJOWyr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:47 -0400
Received: by py-out-1112.google.com with SMTP id t32so2080267pyc
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:46 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate out ata_eh_handle_dev_fail() from ata_eh_recover().  This is
in preparation of ata_link and PMP support.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   91 ++++++++++++++++++++++++++---------------------
 1 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2067db0..2cbd19d 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1911,6 +1911,55 @@ static int ata_eh_skip_recovery(struct a
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
@@ -2022,47 +2071,7 @@ static int ata_eh_recover(struct ata_por
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
1.4.2.3


