From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] libata: IDENTIFY backwards for drive side cable detection
Date: Thu, 22 Mar 2007 22:24:19 +0900
Message-ID: <20070322132419.GK6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:26186 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbXCVNYY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Mar 2007 09:24:24 -0400
Received: by wx-out-0506.google.com with SMTP id h31so811549wxd
        for <linux-ide@vger.kernel.org>; Thu, 22 Mar 2007 06:24:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: xhejtman@mail.muni.cz

For drive side cable detection to work correctly, drives need to be
identified backwards such that the slave device releases PDIAG- before
the mater drive tries to detect cable type.  ata_bus_probe() was fixed
by commit f31f0cc2f0b7527072d94d02da332d9bb8d7d94c but the new EH path
wasn't fixed.  This patch makes new EH path do IDENTIFY backwards.

ata_dev_configure() for new devices are still performed master first.
This is to keep the detection messages in forward order.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this one should go into #upstream-fixes.  The following
regression is fixed by this.

  http://thread.gmane.org/gmane.linux.ide/17433

Thanks.

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 361953a..c89664a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1743,12 +1743,17 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 {
 	struct ata_eh_context *ehc = &ap->eh_context;
 	struct ata_device *dev;
+	unsigned int new_mask = 0;
 	unsigned long flags;
 	int i, rc = 0;
 
 	DPRINTK("ENTER\n");
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+	/* For PATA drive side cable detection to work, IDENTIFY must
+	 * be done backwards such that PDIAG- is released by the slave
+	 * device before the master device is identified.
+	 */
+	for (i = ATA_MAX_DEVICES - 1; i >= 0; i--) {
 		unsigned int action, readid_flags = 0;
 
 		dev = &ap->device[i];
@@ -1760,13 +1765,13 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
 			if (ata_port_offline(ap)) {
 				rc = -EIO;
-				break;
+				goto err;
 			}
 
 			ata_eh_about_to_do(ap, dev, ATA_EH_REVALIDATE);
 			rc = ata_dev_revalidate(dev, readid_flags);
 			if (rc)
-				break;
+				goto err;
 
 			ata_eh_done(ap, dev, ATA_EH_REVALIDATE);
 
@@ -1784,40 +1789,53 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 
 			rc = ata_dev_read_id(dev, &dev->class, readid_flags,
 					     dev->id);
-			if (rc == 0) {
-				ehc->i.flags |= ATA_EHI_PRINTINFO;
-				rc = ata_dev_configure(dev);
-				ehc->i.flags &= ~ATA_EHI_PRINTINFO;
-			} else if (rc == -ENOENT) {
+			switch (rc) {
+			case 0:
+				new_mask |= 1 << i;
+				break;
+			case -ENOENT:
 				/* IDENTIFY was issued to non-existent
 				 * device.  No need to reset.  Just
 				 * thaw and kill the device.
 				 */
 				ata_eh_thaw_port(ap);
 				dev->class = ATA_DEV_UNKNOWN;
-				rc = 0;
-			}
-
-			if (rc) {
-				dev->class = ATA_DEV_UNKNOWN;
 				break;
+			default:
+				dev->class = ATA_DEV_UNKNOWN;
+				goto err;
 			}
+		}
+	}
 
-			if (ata_dev_enabled(dev)) {
-				spin_lock_irqsave(ap->lock, flags);
-				ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
-				spin_unlock_irqrestore(ap->lock, flags);
+	/* Configure new devices forward such that user doesn't see
+	 * device detection messages backwards.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
 
-				/* new device discovered, configure xfermode */
-				ehc->i.flags |= ATA_EHI_SETMODE;
-			}
-		}
+		if (!(new_mask & (1 << i)))
+			continue;
+
+		ehc->i.flags |= ATA_EHI_PRINTINFO;
+		rc = ata_dev_configure(dev);
+		ehc->i.flags &= ~ATA_EHI_PRINTINFO;
+		if (rc)
+			goto err;
+
+		spin_lock_irqsave(ap->lock, flags);
+		ap->pflags |= ATA_PFLAG_SCSI_HOTPLUG;
+		spin_unlock_irqrestore(ap->lock, flags);
+
+		/* new device discovered, configure xfermode */
+		ehc->i.flags |= ATA_EHI_SETMODE;
 	}
 
-	if (rc)
-		*r_failed_dev = dev;
+	return 0;
 
-	DPRINTK("EXIT\n");
+ err:
+	*r_failed_dev = dev;
+	DPRINTK("EXIT rc=%d\n", rc);
 	return rc;
 }
 
