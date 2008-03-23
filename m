From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: assume no device is attached if both
 IDENTIFYs are aborted
Date: Sun, 23 Mar 2008 15:16:53 +0900
Message-ID: <47E5F5D5.6050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:9171 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbYCWGRJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 02:17:09 -0400
Received: by wf-out-1314.google.com with SMTP id 28so2392357wff.4
        for <linux-ide@vger.kernel.org>; Sat, 22 Mar 2008 23:17:08 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, jb.faq@gmx.de, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

This is to fix bugzilla #10254.  QSI cdrom attached to pata_sis as
secondary master appears as phantom device for the slave.
Interestingly, instead of not setting DRQ after IDENTIFY which
triggers NODEV_HINT, it aborts both IDENTIFY and IDENTIFY PACKET which
makes EH retry.

Modify EH such that it assumes no device is attached if both flavors
of IDENTIFY are aborted by the device.  There really isn't much point
in retrying when the device actively aborts the commands.

While at it, convert NODEV detection message to ata_dev_printk() to
help debugging obscure detection problems.

This problem was reported by Jan B=FCcken.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Jan B=FCcken <jb.faq@gmx.de>
---
Alan, does this look okay?

Thanks.

 drivers/ata/libata-core.c |   38 ++++++++++++++++++++++++-------------=
-
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4bbe31f..c9c5280 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2092,24 +2092,34 @@ int ata_dev_read_id(struct ata_device *dev, uns=
igned int *p_class,
 				     id, sizeof(id[0]) * ATA_ID_WORDS, 0);
 	if (err_mask) {
 		if (err_mask & AC_ERR_NODEV_HINT) {
-			DPRINTK("ata%u.%d: NODEV after polling detection\n",
-				ap->print_id, dev->devno);
+			ata_dev_printk(dev, KERN_DEBUG,
+				       "NODEV after polling detection\n");
 			return -ENOENT;
 		}
=20
-		/* Device or controller might have reported the wrong
-		 * device class.  Give a shot at the other IDENTIFY if
-		 * the current one is aborted by the device.
-		 */
-		if (may_fallback &&
-		    (err_mask =3D=3D AC_ERR_DEV) && (tf.feature & ATA_ABORTED)) {
-			may_fallback =3D 0;
+		if ((err_mask =3D=3D AC_ERR_DEV) && (tf.feature & ATA_ABORTED)) {
+			/* Device or controller might have reported
+			 * the wrong device class.  Give a shot at the
+			 * other IDENTIFY if the current one is
+			 * aborted by the device.
+			 */
+			if (may_fallback) {
+				may_fallback =3D 0;
=20
-			if (class =3D=3D ATA_DEV_ATA)
-				class =3D ATA_DEV_ATAPI;
-			else
-				class =3D ATA_DEV_ATA;
-			goto retry;
+				if (class =3D=3D ATA_DEV_ATA)
+					class =3D ATA_DEV_ATAPI;
+				else
+					class =3D ATA_DEV_ATA;
+				goto retry;
+			}
+
+			/* Control reaches here iff the device aborted
+			 * both flavors of IDENTIFYs which happens
+			 * sometimes with phantom devices.
+			 */
+			ata_dev_printk(dev, KERN_DEBUG,
+				       "both IDENTIFYs aborted, assuming NODEV\n");
+			return -ENOENT;
 		}
=20
 		rc =3D -EIO;

