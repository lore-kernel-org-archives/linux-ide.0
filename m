From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: improve 0xff status handling
Date: Fri, 2 Feb 2007 16:50:52 +0900
Message-ID: <11704026522109-git-send-email-htejun@gmail.com>
References: <11704026511717-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:64800 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423206AbXBBHvT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:51:19 -0500
Received: by wx-out-0506.google.com with SMTP id h31so819854wxd
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:51:18 -0800 (PST)
In-Reply-To: <11704026511717-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

For PATA, 0xff status indicates empty port.  For SATA, it depends on
how the controller emulates status register.  On some controllers,
0xff is used to represent broken link or certain stage during reset.

libata currently deals SATA the same.  This hasn't caused any problem
because problematic situations usually only occur after hotplug or
other link disruption events and libata blindly waited for the device
to spin up and settle after hotplug giving the link and device
whatever time to go through those stages.

libata is going to replace unconditional spinup wait with generic
timed sequence of resets, so not only getting 0xff handling right for
SATA is, well, the right thing to do, it's much more important now.

This patch makes the following changes.

* Make ata_bus_softreset() return -ENODEV if any of its wait fails
  due to 0xff status.

* Fail soft/hardreset if status wait returns -ENODEV indicating 0xff
  status while SStatus says the link is online.  e.g. Reset fails if
  status is 0xff after reset when SStatus reports the linke is online.
  If SCR registers are not available, everything is the same as
  before.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c          |   14 ++++++--------
 drivers/ata/libata-core.c   |   33 ++++++++++++++++++++++-----------
 drivers/ata/sata_inic162x.c |    3 ++-
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8ae554c..fd4df56 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -858,15 +858,13 @@ static int ahci_softreset(struct ata_port *ap, unsigned int *class,
 	 */
 	msleep(150);
 
-	*class = ATA_DEV_NONE;
-	if (ata_port_online(ap)) {
-		rc = ata_wait_ready(ap, deadline);
-		if (rc && rc != -ENODEV) {
-			reason = "device not ready";
-			goto fail;
-		}
-		*class = ahci_dev_classify(ap);
+	rc = ata_wait_ready(ap, deadline);
+	/* link occupied, -ENODEV too is an error */
+	if (rc) {
+		reason = "device not ready";
+		goto fail;
 	}
+	*class = ahci_dev_classify(ap);
 
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 540698c..ef52beb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2616,15 +2616,18 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int dev0 = devmask & (1 << 0);
 	unsigned int dev1 = devmask & (1 << 1);
-	int rc;
+	int rc, ret = 0;
 
 	/* if device 0 was found in ata_devchk, wait for its
 	 * BSY bit to clear
 	 */
 	if (dev0) {
 		rc = ata_wait_ready(ap, deadline);
-		if (rc && rc != -ENODEV)
-			return rc;
+		if (rc) {
+			if (rc != -ENODEV)
+				return rc;
+			ret = rc;
+		}
 	}
 
 	/* if device 1 was found in ata_devchk, wait for
@@ -2644,8 +2647,11 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	}
 	if (dev1) {
 		rc = ata_wait_ready(ap, deadline);
-		if (rc && rc != -ENODEV)
-			return rc;
+		if (rc) {
+			if (rc != -ENODEV)
+				return rc;
+			ret = rc;
+		}
 	}
 
 	/* is all this really necessary? */
@@ -2655,7 +2661,7 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	if (dev0)
 		ap->ops->dev_select(ap, 0);
 
-	return 0;
+	return ret;
 }
 
 static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
@@ -2689,7 +2695,7 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	 * pulldown resistor.
 	 */
 	if (ata_check_status(ap) == 0xFF)
-		return 0;
+		return -ENODEV;
 
 	return ata_bus_post_reset(ap, devmask, deadline);
 }
@@ -2720,6 +2726,7 @@ void ata_bus_reset(struct ata_port *ap)
 	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
 	u8 err;
 	unsigned int dev0, dev1 = 0, devmask = 0;
+	int rc;
 
 	DPRINTK("ENTER, host %u, port %u\n", ap->id, ap->port_no);
 
@@ -2741,9 +2748,11 @@ void ata_bus_reset(struct ata_port *ap)
 	ap->ops->dev_select(ap, 0);
 
 	/* issue bus reset */
-	if (ap->flags & ATA_FLAG_SRST)
-		if (ata_bus_softreset(ap, devmask, jiffies + 40 * HZ))
+	if (ap->flags & ATA_FLAG_SRST) {
+		rc = ata_bus_softreset(ap, devmask, jiffies + 40 * HZ);
+		if (rc && rc != -ENODEV)
 			goto err_out;
+	}
 
 	/*
 	 * determine by signature whether we have ATA or ATAPI devices
@@ -3007,7 +3016,8 @@ int ata_std_softreset(struct ata_port *ap, unsigned int *classes,
 	/* issue bus reset */
 	DPRINTK("about to softreset, devmask=%x\n", devmask);
 	rc = ata_bus_softreset(ap, devmask, deadline);
-	if (rc) {
+	/* if link is occupied, -ENODEV too is an error */
+	if (rc && (rc != -ENODEV || sata_scr_valid(ap))) {
 		ata_port_printk(ap, KERN_ERR, "SRST failed (errno=%d)\n", rc);
 		return rc;
 	}
@@ -3124,7 +3134,8 @@ int sata_std_hardreset(struct ata_port *ap, unsigned int *class,
 	msleep(150);
 
 	rc = ata_wait_ready(ap, deadline);
-	if (rc && rc != -ENODEV) {
+	/* link occupied, -ENODEV too is an error */
+	if (rc) {
 		ata_port_printk(ap, KERN_ERR,
 				"COMRESET failed (errno=%d)\n", rc);
 		return rc;
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index dde369f..c5e9be2 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -451,7 +451,8 @@ static int inic_hardreset(struct ata_port *ap, unsigned int *class,
 		msleep(150);
 
 		rc = ata_wait_ready(ap, deadline);
-		if (rc && rc != -ENODEV) {
+		/* link occupied, -ENODEV too is an error */
+		if (rc) {
 			ata_port_printk(ap, KERN_WARNING, "device not ready "
 					"after hardreset (errno=%d)\n", rc);
 			return rc;
-- 
1.4.4.4


