From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/27] libata: restructure SFF post-reset readiness waits
Date: Tue, 25 Mar 2008 22:16:50 +0900
Message-ID: <1206451027353-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.232]:15483 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbYCYNRg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3539072wxd.4
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:36 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Previously, post-softreset readiness is waited as follows.

1. ata_sff_wait_after_reset() waits for 150ms and then for
   ATA_TMOUT_FF_WAIT if status is 0xff and other conditions meet.

2. ata_bus_softreset() finishes with -ENODEV if status is still 0xff.
   If not, continue to #3.

3. ata_bus_post_reset() waits readiness of dev0 and/or dev1 depending
   on devmask using ata_sff_wait_ready().

And for post-hardreset readiness,

1. ata_sff_wait_after_reset() waits for 150ms and then for
   ATA_TMOUT_FF_WAIT if status is 0xff and other conditions meet.

2. sata_sff_hardreset waits for device readiness using
   ata_sff_wait_ready().

This patch merges and unifies post-reset readiness waits into
ata_sff_wait_ready() and ata_sff_wait_after_reset().

ATA_TMOUT_FF_WAIT handling is merged into ata_sff_wait_ready().  If TF
status is 0xff, link status is unknown and the port is SATA, it will
continue polling till ATA_TMOUT_FF_WAIT.

ata_sff_wait_after_reset() is updated to perform the following steps.

1. waits for 150ms.

2. waits for dev0 readiness using ata_sff_wait_ready().  Note that
   this is done regardless of devmask, as ata_sff_wait_ready() handles
   0xff status correctly, this preserves the original behavior except
   that it may wait longer after softreset if link is online but
   status is 0xff.  This behavior change is very unlikely to cause any
   actual difference and is intended.  It brings softreset behavior to
   that of hardreset.

3. waits for dev1 readiness just the same way ata_bus_post_reset() did.

Now both soft and hard resets call ata_sff_wait_after_reset() after
reset to wait for readiness after resets.  As
ata_sff_wait_after_reset() contains calls to ->sff_dev_select(),
explicit call near the end of sata_sff_hardreset() is removed.

This change makes reset implementation simpler and more consistent.

While at it, make the magical 150ms wait post-reset wait duration a
constant and ata_sff_wait_ready() and ata_sff_wait_after_reset() take
@link instead of @ap.  This is to make them consistent with other
reset helpers and ease core changes.

pata_scc is updated accordingly.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c          |   11 +--
 drivers/ata/libata-sff.c    |  161 ++++++++++++++++++-------------------------
 drivers/ata/pata_scc.c      |   91 ++++++++++++++-----------
 drivers/ata/sata_inic162x.c |    6 +-
 drivers/ata/sata_via.c      |    2 +-
 include/linux/libata.h      |   18 ++++-
 6 files changed, 139 insertions(+), 150 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 939dc1d..45a67a9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1302,10 +1302,8 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	tf.ctl &= ~ATA_SRST;
 	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
 
-	/* wait a while before checking status */
-	ata_sff_wait_after_reset(ap, deadline);
-
-	rc = ata_sff_wait_ready(ap, deadline);
+	/* wait for link to become ready */
+	rc = ata_sff_wait_after_reset(link, 1, deadline);
 	/* link occupied, -ENODEV too is an error */
 	if (rc) {
 		reason = "device not ready";
@@ -1415,9 +1413,6 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	if (rc || ata_link_offline(link))
 		return rc;
 
-	/* spec mandates ">= 2ms" before checking status */
-	msleep(150);
-
 	/* The pseudo configuration device on SIMG4726 attached to
 	 * ASUS P5W-DH Deluxe doesn't send signature FIS after
 	 * hardreset if no device is attached to the first downstream
@@ -1431,7 +1426,7 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 	 * have to be reset again.  For most cases, this should
 	 * suffice while making probing snappish enough.
 	 */
-	rc = ata_sff_wait_ready(ap, jiffies + 2 * HZ);
+	rc = ata_sff_wait_after_reset(link, 1, jiffies + 2 * HZ);
 	if (rc)
 		ahci_kick_engine(ap, 0);
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index e530bac..6e8de3c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -310,7 +310,7 @@ int ata_sff_busy_sleep(struct ata_port *ap,
 
 /**
  *	ata_sff_wait_ready - sleep until BSY clears, or timeout
- *	@ap: port containing status register to be polled
+ *	@link: SFF link to wait ready status for
  *	@deadline: deadline jiffies for the operation
  *
  *	Sleep until ATA Status register bit BSY clears, or timeout
@@ -322,26 +322,52 @@ int ata_sff_busy_sleep(struct ata_port *ap,
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int ata_sff_wait_ready(struct ata_port *ap, unsigned long deadline)
+int ata_sff_wait_ready(struct ata_link *link, unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	unsigned long start = jiffies;
+	unsigned long nodev_deadline = start + ATA_TMOUT_FF_WAIT;
 	int warned = 0;
 
+	if (time_after(nodev_deadline, deadline))
+		nodev_deadline = deadline;
+
 	while (1) {
 		u8 status = ap->ops->sff_check_status(ap);
 		unsigned long now = jiffies;
 
 		if (!(status & ATA_BUSY))
 			return 0;
-		if (!ata_link_online(&ap->link) && status == 0xff)
-			return -ENODEV;
+
+		/* No device status could be transient.  Ignore it if
+		 * link is online.  Also, some SATA devices take a
+		 * long time to clear 0xff after reset.  For example,
+		 * HHD424020F7SV00 iVDR needs >= 800ms while Quantum
+		 * GoVault needs even more than that.  Wait for
+		 * ATA_TMOUT_FF_WAIT on -ENODEV if link isn't offline.
+		 *
+		 * Note that some PATA controllers (pata_ali) explode
+		 * if status register is read more than once when
+		 * there's no device attached.
+		 */
+		if (status == 0xff) {
+			if (ata_link_online(link))
+				status = ATA_BUSY;
+			else if ((link->ap->flags & ATA_FLAG_SATA) &&
+				 !ata_link_offline(link) &&
+				 time_before(now, nodev_deadline))
+				status = ATA_BUSY;
+			if (status == 0xff)
+				return -ENODEV;
+		}
+
 		if (time_after(now, deadline))
 			return -EBUSY;
 
 		if (!warned && time_after(now, start + 5 * HZ) &&
 		    (deadline - now > 3 * HZ)) {
-			ata_port_printk(ap, KERN_WARNING,
-				"port is slow to respond, please be patient "
+			ata_link_printk(link, KERN_WARNING,
+				"link is slow to respond, please be patient "
 				"(Status 0x%x)\n", status);
 			warned = 1;
 		}
@@ -1625,7 +1651,6 @@ void ata_sff_thaw(struct ata_port *ap)
  */
 int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
 {
-	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	int rc;
 
@@ -1639,7 +1664,7 @@ int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
 
 	/* wait for !BSY if we don't know that no device is attached */
 	if (!ata_link_offline(link)) {
-		rc = ata_sff_wait_ready(ap, deadline);
+		rc = ata_sff_wait_ready(link, deadline);
 		if (rc && rc != -ENODEV) {
 			ata_link_printk(link, KERN_WARNING, "device not ready "
 					"(errno=%d), forcing hardreset\n", rc);
@@ -1762,25 +1787,41 @@ unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 	return class;
 }
 
-static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
-			      unsigned long deadline)
+/**
+ *	ata_sff_wait_after_reset - wait for devices to become ready after reset
+ *	@link: SFF link which is just reset
+ *	@devmask: mask of present devices
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Wait devices attached to SFF @link to become ready after
+ *	reset.  It contains preceding 150ms wait to avoid accessing TF
+ *	status register too early.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep).
+ *
+ *	RETURNS:
+ *	0 on success, -ENODEV if some or all of devices in @devmask
+ *	don't seem to exist.  -errno on other errors.
+ */
+int ata_sff_wait_after_reset(struct ata_link *link, unsigned int devmask,
+			     unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int dev0 = devmask & (1 << 0);
 	unsigned int dev1 = devmask & (1 << 1);
 	int rc, ret = 0;
 
-	/* if device 0 was found in ata_devchk, wait for its
-	 * BSY bit to clear
+	msleep(ATA_WAIT_AFTER_RESET_MSECS);
+
+	/* always check readiness of the master device */
+	rc = ata_sff_wait_ready(link, deadline);
+	/* -ENODEV means the odd clown forgot the D7 pulldown resistor
+	 * and TF status is 0xff, bail out on it too.
 	 */
-	if (dev0) {
-		rc = ata_sff_wait_ready(ap, deadline);
-		if (rc) {
-			if (rc != -ENODEV)
-				return rc;
-			ret = rc;
-		}
-	}
+	if (rc)
+		return rc;
 
 	/* if device 1 was found in ata_devchk, wait for register
 	 * access briefly, then wait for BSY to clear.
@@ -1804,7 +1845,7 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 			msleep(50);	/* give drive a breather */
 		}
 
-		rc = ata_sff_wait_ready(ap, deadline);
+		rc = ata_sff_wait_ready(link, deadline);
 		if (rc) {
 			if (rc != -ENODEV)
 				return rc;
@@ -1822,61 +1863,6 @@ static int ata_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	return ret;
 }
 
-/**
- *	ata_sff_wait_after_reset - wait before checking status after reset
- *	@ap: port containing status register to be polled
- *	@deadline: deadline jiffies for the operation
- *
- *	After reset, we need to pause a while before reading status.
- *	Also, certain combination of controller and device report 0xff
- *	for some duration (e.g. until SATA PHY is up and running)
- *	which is interpreted as empty port in ATA world.  This
- *	function also waits for such devices to get out of 0xff
- *	status.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep).
- */
-void ata_sff_wait_after_reset(struct ata_port *ap, unsigned long deadline)
-{
-	unsigned long until = jiffies + ATA_TMOUT_FF_WAIT;
-
-	if (time_before(until, deadline))
-		deadline = until;
-
-	/* Spec mandates ">= 2ms" before checking status.  We wait
-	 * 150ms, because that was the magic delay used for ATAPI
-	 * devices in Hale Landis's ATADRVR, for the period of time
-	 * between when the ATA command register is written, and then
-	 * status is checked.  Because waiting for "a while" before
-	 * checking status is fine, post SRST, we perform this magic
-	 * delay here as well.
-	 *
-	 * Old drivers/ide uses the 2mS rule and then waits for ready.
-	 */
-	msleep(150);
-
-	/* Wait for 0xff to clear.  Some SATA devices take a long time
-	 * to clear 0xff after reset.  For example, HHD424020F7SV00
-	 * iVDR needs >= 800ms while.  Quantum GoVault needs even more
-	 * than that.
-	 *
-	 * Note that some PATA controllers (pata_ali) explode if
-	 * status register is read more than once when there's no
-	 * device attached.
-	 */
-	if (ap->flags & ATA_FLAG_SATA) {
-		while (1) {
-			u8 status = ap->ops->sff_check_status(ap);
-
-			if (status != 0xff || time_after(jiffies, deadline))
-				return;
-
-			msleep(50);
-		}
-	}
-}
-
 static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 			     unsigned long deadline)
 {
@@ -1891,17 +1877,8 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	udelay(20);	/* FIXME: flush */
 	iowrite8(ap->ctl, ioaddr->ctl_addr);
 
-	/* wait a while before checking status */
-	ata_sff_wait_after_reset(ap, deadline);
-
-	/* Before we perform post reset processing we want to see if
-	 * the bus shows 0xFF because the odd clown forgets the D7
-	 * pulldown resistor.
-	 */
-	if (ap->ops->sff_check_status(ap) == 0xFF)
-		return -ENODEV;
-
-	return ata_bus_post_reset(ap, devmask, deadline);
+	/* wait the port to become ready */
+	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
 }
 
 /**
@@ -2003,20 +1980,18 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 		return 0;
 	}
 
-	/* wait a while before checking status */
-	ata_sff_wait_after_reset(ap, deadline);
-
 	/* If PMP is supported, we have to do follow-up SRST.  Note
 	 * that some PMPs don't send D2H Reg FIS after hardreset at
 	 * all if the first port is empty.  Wait for it just for a
 	 * second and request follow-up SRST.
 	 */
 	if (ap->flags & ATA_FLAG_PMP) {
-		ata_sff_wait_ready(ap, jiffies + HZ);
+		ata_sff_wait_after_reset(link, 1, jiffies + HZ);
 		return -EAGAIN;
 	}
 
-	rc = ata_sff_wait_ready(ap, deadline);
+	/* wait for the link to become online */
+	rc = ata_sff_wait_after_reset(link, 1, deadline);
 	/* link occupied, -ENODEV too is an error */
 	if (rc) {
 		ata_link_printk(link, KERN_ERR,
@@ -2024,8 +1999,6 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 		return rc;
 	}
 
-	ap->ops->sff_dev_select(ap, 0);	/* probably unnecessary */
-
 	*class = ata_sff_dev_classify(link->device, 1, NULL);
 
 	DPRINTK("EXIT, class=%u\n", *class);
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 97c9ae6..771f669 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -497,47 +497,68 @@ static unsigned int scc_devchk (struct ata_port *ap,
 }
 
 /**
- *	scc_bus_post_reset - PATA device post reset
+ *	scc_wait_after_reset - wait for devices to become ready after reset
  *
- *	Note: Original code is ata_bus_post_reset().
+ *	Note: Original code is ata_sff_wait_after_reset
  */
 
-static int scc_bus_post_reset(struct ata_port *ap, unsigned int devmask,
-                              unsigned long deadline)
+int scc_wait_after_reset(struct ata_link *link, unsigned int devmask,
+			 unsigned long deadline)
 {
+	struct ata_port *ap = link->ap;
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	unsigned int dev0 = devmask & (1 << 0);
 	unsigned int dev1 = devmask & (1 << 1);
-	int rc;
+	int rc, ret = 0;
+
+	/* Spec mandates ">= 2ms" before checking status.  We wait
+	 * 150ms, because that was the magic delay used for ATAPI
+	 * devices in Hale Landis's ATADRVR, for the period of time
+	 * between when the ATA command register is written, and then
+	 * status is checked.  Because waiting for "a while" before
+	 * checking status is fine, post SRST, we perform this magic
+	 * delay here as well.
+	 *
+	 * Old drivers/ide uses the 2mS rule and then waits for ready.
+	 */
+	msleep(150);
 
-	/* if device 0 was found in ata_devchk, wait for its
-	 * BSY bit to clear
+	/* always check readiness of the master device */
+	rc = ata_sff_wait_ready(link, deadline);
+	/* -ENODEV means the odd clown forgot the D7 pulldown resistor
+	 * and TF status is 0xff, bail out on it too.
 	 */
-	if (dev0) {
-		rc = ata_sff_wait_ready(ap, deadline);
-		if (rc && rc != -ENODEV)
-			return rc;
-	}
+	if (rc)
+		return rc;
 
-	/* if device 1 was found in ata_devchk, wait for
-	 * register access, then wait for BSY to clear
+	/* if device 1 was found in ata_devchk, wait for register
+	 * access briefly, then wait for BSY to clear.
 	 */
-	while (dev1) {
-		u8 nsect, lbal;
+	if (dev1) {
+		int i;
 
 		ap->ops->sff_dev_select(ap, 1);
-		nsect = in_be32(ioaddr->nsect_addr);
-		lbal = in_be32(ioaddr->lbal_addr);
-		if ((nsect == 1) && (lbal == 1))
-			break;
-		if (time_after(jiffies, deadline))
-			return -EBUSY;
-		msleep(50);	/* give drive a breather */
-	}
-	if (dev1) {
-		rc = ata_sff_wait_ready(ap, deadline);
-		if (rc && rc != -ENODEV)
-			return rc;
+
+		/* Wait for register access.  Some ATAPI devices fail
+		 * to set nsect/lbal after reset, so don't waste too
+		 * much time on it.  We're gonna wait for !BSY anyway.
+		 */
+		for (i = 0; i < 2; i++) {
+			u8 nsect, lbal;
+
+			nsect = in_be32(ioaddr->nsect_addr);
+			lbal = in_be32(ioaddr->lbal_addr);
+			if ((nsect == 1) && (lbal == 1))
+				break;
+			msleep(50);	/* give drive a breather */
+		}
+
+		rc = ata_sff_wait_ready(link, deadline);
+		if (rc) {
+			if (rc != -ENODEV)
+				return rc;
+			ret = rc;
+		}
 	}
 
 	/* is all this really necessary? */
@@ -547,7 +568,7 @@ static int scc_bus_post_reset(struct ata_port *ap, unsigned int devmask,
 	if (dev0)
 		ap->ops->sff_dev_select(ap, 0);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -570,17 +591,7 @@ static unsigned int scc_bus_softreset(struct ata_port *ap, unsigned int devmask,
 	udelay(20);
 	out_be32(ioaddr->ctl_addr, ap->ctl);
 
-	/* wait a while before checking status */
-	ata_sff_wait_after_reset(ap, deadline);
-
-	/* Before we perform post reset processing we want to see if
-	 * the bus shows 0xFF because the odd clown forgets the D7
-	 * pulldown resistor.
-	 */
-	if (scc_check_status(ap) == 0xFF)
-		return 0;
-
-	scc_bus_post_reset(ap, devmask, deadline);
+	scc_wait_after_reset(&ap->link, devmask, deadlien);
 
 	return 0;
 }
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 0b5a736..9f47d00 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -417,10 +417,8 @@ static int inic_hardreset(struct ata_link *link, unsigned int *class,
 	if (ata_link_online(link)) {
 		struct ata_taskfile tf;
 
-		/* wait a while before checking status */
-		ata_sff_wait_after_reset(ap, deadline);
-
-		rc = ata_sff_wait_ready(ap, deadline);
+		/* wait for link to become ready */
+		rc = ata_sff_wait_after_reset(link, 1, deadline);
 		/* link occupied, -ENODEV too is an error */
 		if (rc) {
 			ata_link_printk(link, KERN_WARNING, "device not ready "
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index e5df376..96deeb3 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -242,7 +242,7 @@ static int vt6420_prereset(struct ata_link *link, unsigned long deadline)
 
  skip_scr:
 	/* wait for !BSY */
-	ata_sff_wait_ready(ap, deadline);
+	ata_sff_wait_ready(link, deadline);
 
 	return 0;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 49b6888..b6e1968 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -248,6 +248,18 @@ enum {
 	 */
 	ATA_TMOUT_FF_WAIT	= 4 * HZ / 5,
 
+	/* Spec mandates to wait for ">= 2ms" before checking status
+	 * after reset.  We wait 150ms, because that was the magic
+	 * delay used for ATAPI devices in Hale Landis's ATADRVR, for
+	 * the period of time between when the ATA command register is
+	 * written, and then status is checked.  Because waiting for
+	 * "a while" before checking status is fine, post SRST, we
+	 * perform this magic delay here as well.
+	 *
+	 * Old drivers/ide uses the 2mS rule and then waits for ready.
+	 */
+	ATA_WAIT_AFTER_RESET_MSECS = 150,
+
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
 	BUS_DMA			= 1,
@@ -1369,7 +1381,7 @@ extern u8 ata_sff_check_status(struct ata_port *ap);
 extern u8 ata_sff_altstatus(struct ata_port *ap);
 extern int ata_sff_busy_sleep(struct ata_port *ap,
 			      unsigned long timeout_pat, unsigned long timeout);
-extern int ata_sff_wait_ready(struct ata_port *ap, unsigned long deadline);
+extern int ata_sff_wait_ready(struct ata_link *link, unsigned long deadline);
 extern void ata_sff_tf_load(struct ata_port *ap, const struct ata_taskfile *tf);
 extern void ata_sff_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 extern void ata_sff_exec_command(struct ata_port *ap,
@@ -1391,8 +1403,8 @@ extern void ata_sff_thaw(struct ata_port *ap);
 extern int ata_sff_prereset(struct ata_link *link, unsigned long deadline);
 extern unsigned int ata_sff_dev_classify(struct ata_device *dev, int present,
 					  u8 *r_err);
-extern void ata_sff_wait_after_reset(struct ata_port *ap,
-				     unsigned long deadline);
+extern int ata_sff_wait_after_reset(struct ata_link *link, unsigned int devmask,
+				    unsigned long deadline);
 extern int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 			     unsigned long deadline);
 extern int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
-- 
1.5.2.4

