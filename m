From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/9] libata: make new reset act identical to ->phy_reset register-wise
Date: Fri, 10 Feb 2006 23:58:48 +0900
Message-ID: <11395835281384-git-send-email-htejun@gmail.com>
References: <11395835282719-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.201]:17310 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751271AbWBJO6x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 09:58:53 -0500
Received: by xproxy.gmail.com with SMTP id s18so338574wxc
        for <linux-ide@vger.kernel.org>; Fri, 10 Feb 2006 06:58:52 -0800 (PST)
In-Reply-To: <11395835282719-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch makes std component operations act identical to ->phy_reset
register-wise except for SError clearing on sata_std_hardreset.

Note that if a driver only implements/uses hardreset, it should not
use ata_std_probeinit() to avoid extra sata_phy_resume() and
ata_busy_sleep() compared to ->phy_reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   51 +++++++++++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 17 deletions(-)

132ad18278df23894fe8b0768ef0be8087ce790d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b938c7a..8424bd9 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1924,11 +1924,20 @@ static int sata_phy_resume(struct ata_po
  *
  *	@ap is about to be probed.  Initialize it.  This function is
  *	to be used as standard callback for ata_drive_probe_reset().
+ *
+ *	NOTE!!! Do not use this function as probeinit if a low level
+ *	driver implements only hardreset.  Just pass NULL as probeinit
+ *	in that case.  Using this function is probably okay but doing
+ *	so makes reset sequence different from the original
+ *	->phy_reset implementation and Jeff nervous.  :-P
  */
 extern void ata_std_probeinit(struct ata_port *ap)
 {
-	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read)
+	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read) {
 		sata_phy_resume(ap);
+		if (sata_dev_present(ap))
+			ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+	}
 }
 
 /**
@@ -1954,20 +1963,17 @@ int ata_std_softreset(struct ata_port *a
 
 	DPRINTK("ENTER\n");
 
+	if (ap->ops->scr_read && !sata_dev_present(ap)) {
+		classes[0] = ATA_DEV_NONE;
+		goto out;
+	}
+
 	/* determine if device 0/1 are present */
 	if (ata_devchk(ap, 0))
 		devmask |= (1 << 0);
 	if (slave_possible && ata_devchk(ap, 1))
 		devmask |= (1 << 1);
 
-	/* devchk reports device presence without actual device on
-	 * most SATA controllers.  Check SStatus and turn devmask off
-	 * if link is offline.  Note that we should continue resetting
-	 * even when it seems like there's no device.
-	 */
-	if (ap->ops->scr_read && !sata_dev_present(ap))
-		devmask = 0;
-
 	/* select device 0 again */
 	ap->ops->dev_select(ap, 0);
 
@@ -1989,6 +1995,7 @@ int ata_std_softreset(struct ata_port *a
 	if (slave_possible && err != 0x81)
 		classes[1] = ata_dev_try_classify(ap, 1, &err);
 
+ out:
 	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
 	return 0;
 }
@@ -2047,6 +2054,8 @@ int sata_std_hardreset(struct ata_port *
 		return -EIO;
 	}
 
+	ap->ops->dev_select(ap, 0);	/* probably unnecessary */
+
 	*class = ata_dev_try_classify(ap, 0, NULL);
 
 	DPRINTK("EXIT, class=%u\n", *class);
@@ -2081,11 +2090,9 @@ void ata_std_postreset(struct ata_port *
 	if (ap->cbl == ATA_CBL_SATA)
 		sata_print_link_status(ap);
 
-	/* bail out if no device is present */
-	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
-		DPRINTK("EXIT, no device\n");
-		return;
-	}
+	/* re-enable interrupts */
+	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+		ata_irq_on(ap);
 
 	/* is double-select really necessary? */
 	if (classes[0] != ATA_DEV_NONE)
@@ -2093,9 +2100,19 @@ void ata_std_postreset(struct ata_port *
 	if (classes[1] != ATA_DEV_NONE)
 		ap->ops->dev_select(ap, 0);
 
-	/* re-enable interrupts & set up device control */
-	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
-		ata_irq_on(ap);
+	/* bail out if no device is present */
+	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
+		DPRINTK("EXIT, no device\n");
+		return;
+	}
+
+	/* set up device control */
+	if (ap->ioaddr.ctl_addr) {
+		if (ap->flags & ATA_FLAG_MMIO)
+			writeb(ap->ctl, (void __iomem *) ap->ioaddr.ctl_addr);
+		else
+			outb(ap->ctl, ap->ioaddr.ctl_addr);
+	}
 
 	DPRINTK("EXIT\n");
 }
-- 
1.1.5


