From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] ata_set_mode() to send SET FEATURES first
Date: Fri, 12 Nov 2004 21:27:37 +0800
Message-ID: <004701c4c8bb$640d2880$6801a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0044_01C4C8FE.6E8317F0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:47596 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262531AbUKLN14 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 Nov 2004 08:27:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0044_01C4C8FE.6E8317F0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Jeff:

  Changes to ata_set_mode() for your review/comment:
1. Re-order ata_set_mode() such that "SET FEATURES" is sent to the device before
   the driver set the timing registers.

   Promise HBA hardware will look at the SET FEATURES and set the timing registers
    automatically. Under 133MHz PLL, the values set by the hardware is incorrect.
   Because ata_set_mode() call low-level driver to set timing registers 
   before "SET FEATURES", the correct value set by the software driver is later overwritten
   by hardware when "SET FEATURES" seen by the hardware.

2. Remove the restriction that master/slave devices cannot be set to different mode
   as in ata_get_mode_mask().

 The patch is against the libata-dev-2.6 tree.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

*********************************************************************************
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c 2004-11-10 17:53:24.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata-core.c 2004-11-12 21:02:10.188293547 +0800
@@ -52,7 +52,7 @@
         unsigned long tmout_pat,
             unsigned long tmout);
 static void ata_set_mode(struct ata_port *ap);
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
+static int ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
 static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift);
 static int fgb(u32 bitmap);
 static int ata_choose_xfer_mode(struct ata_port *ap,
@@ -1344,32 +1344,41 @@
 
  return 0xff;
 }
-
-static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
+/**
+ * Map xfer_mask to xfer_mode and issue set features to the device
+ */
+static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev, unsigned int xfer_mask, int shift)
 {
  int ofs, idx;
  u8 base;
+ int rc;
 
- if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
-  return;
-
- if (dev->xfer_shift == ATA_SHIFT_PIO)
-  dev->flags |= ATA_DFLAG_PIO;
+ base = base_from_shift(shift);
 
- ata_dev_set_xfermode(ap, dev);
+ ofs = fgb(xfer_mask);
+ dev->xfer_mode = base + ofs;
 
- base = base_from_shift(dev->xfer_shift);
- ofs = dev->xfer_mode - base;
- idx = ofs + dev->xfer_shift;
+ dev->xfer_shift = shift;
+ idx = dev->xfer_shift + ofs;
  WARN_ON(idx >= ARRAY_SIZE(xfer_mode_str));
+  
+ if (shift == ATA_SHIFT_PIO) {
+  dev->pio_mode = dev->xfer_mode;
+ } else {
+  dev->dma_mode = dev->xfer_mode;
+ }
 
  DPRINTK("idx=%d xfer_shift=%u, xfer_mode=0x%x, base=0x%x, offset=%d\n",
   idx, dev->xfer_shift, (int)dev->xfer_mode, (int)base, ofs);
 
+ /* FIXME: return error if set feature fails */
+ rc = ata_dev_set_xfermode(ap, dev);
+
  printk(KERN_INFO "ata%u: dev %u configured for %s\n",
   ap->id, dev->devno, xfer_mode_str[idx]);
+ 
+ return rc;
 }
-
 static int ata_host_set_pio(struct ata_port *ap)
 {
  unsigned int mask;
@@ -1419,7 +1428,92 @@
   }
  }
 }
+/**
+ * Find the transfer mode between the HBA and the device
+ */
+static int ata_set_xfermode(struct ata_port *ap, struct ata_device *dev)
+{
+ unsigned int dev_pio_mask   = 0x07; /* PIO mode 0-2 */
+ unsigned int dev_mwdma_mask = 0;
+ unsigned int dev_udma_mask  = 0;
+
+ unsigned int xfer_pio_mask;
+ unsigned int xfer_mwdma_mask;
+ unsigned int xfer_udma_mask;
+
+ int no_dma = 1;
+
+ /* step 1. Assemble the PIO, MWDMA and UDMA mask of the device */
+ if (dev->id[53] & 0x02) // Is word 64 valid?
+  /* spec doesn't return explicit support for
+   * PIO0-2, so we fake it
+   */
+  dev_pio_mask |= (dev->id[ATA_ID_PIO_MODES] & 0x03) << 3;
+ 
+ dev_mwdma_mask = dev->id[ATA_ID_MWDMA_MODES] & 0x07;
+ 
+ if (dev->id[53] & 0x04) /* Is word 88 valid */
+  dev_udma_mask = dev->id[ATA_ID_UDMA_MODES] & 0xff;
+
+ /* FIXME: Check device black list for workable mask */
+ 
+ /* step 2. Find mode that both HBA and device can support */
+ xfer_pio_mask   = ap->pio_mask   & dev_pio_mask;
+ xfer_mwdma_mask = ap->mwdma_mask & dev_mwdma_mask;
+ xfer_udma_mask  = ap->udma_mask  & dev_udma_mask;
+ 
+ /* step 3. Check whether 80-conductor wire/SATA is needed and present */
+ if (xfer_udma_mask & (~ATA_UDMA_MASK_40C)) {
+  /* UDMA 3 or above.
+   * 80-conductor wire/SATA cable is needed
+   */
+  if ((ap->cbl == ATA_CBL_PATA40) ||
+      (ap->cbl == ATA_CBL_PATA_UNK)) {
+   printk(KERN_WARNING "ata%u: 40-conductor cable detected on port %d, transfer speed reduced to UDMA-33\n", 
+          ap->id, ap->port_no);
+   xfer_udma_mask &= ATA_UDMA_MASK_40C;
+  }
+ }
+ 
+ /* step 4. Map xfer_mask to xfer_mode
+  * Issue set features to the device for PIO mode.
+  */
+
+ ata_dev_set_mode(ap, dev, xfer_pio_mask, ATA_SHIFT_PIO);
+
+ 
+ /* step 5. Map xfer_mask to xfer_mode
+  * Issue set features to the device for MWDMA/UDMA mode.
+  */
+ if (xfer_udma_mask) {
+  no_dma = ata_dev_set_mode(ap, dev, xfer_udma_mask, ATA_SHIFT_UDMA);
+ } 
+ 
+ if (no_dma && xfer_mwdma_mask) 
+  /* Try MWDMA */
+  no_dma = ata_dev_set_mode(ap, dev, xfer_mwdma_mask, ATA_SHIFT_MWDMA);
 
+ if (no_dma)
+  /* Forced to PIO only */
+  dev->flags |= ATA_DFLAG_PIO;
+ 
+ /* step 6. Here the lowlevel driver change the HBA timing registers.
+  * This has to be done after "set features" to device
+  * because some HBA hardware (ex. Promise) will look at SET FEATURES
+  * and change the timing registers.
+  */
+
+ if (ap->ops->set_piomode)
+  ap->ops->set_piomode(ap, dev);
+
+ if (ap->ops->set_dmamode)
+  ap->ops->set_dmamode(ap, dev);
+ 
+ if (ap->ops->post_set_mode)
+  ap->ops->post_set_mode(ap);
+
+ return 0;
+}
 /**
  * ata_set_mode - Program timings and issue SET FEATURES - XFER
  * @ap: port on which timings will be programmed
@@ -1429,38 +1523,25 @@
  */
 static void ata_set_mode(struct ata_port *ap)
 {
- unsigned int i, xfer_shift;
- u8 xfer_mode;
- int rc;
+ int i;
 
- /* step 1: always set host PIO timings */
- rc = ata_host_set_pio(ap);
- if (rc)
-  goto err_out;
+ if (ap->flags & ATA_FLAG_PORT_DISABLED) 
+  return;
 
- /* step 2: choose the best data xfer mode */
- xfer_mode = xfer_shift = 0;
- rc = ata_choose_xfer_mode(ap, &xfer_mode, &xfer_shift);
- if (rc)
-  goto err_out;
+ for (i=0; i < ATA_MAX_DEVICES; i++) {
 
- /* step 3: if that xfer mode isn't PIO, set host DMA timings */
- if (xfer_shift != ATA_SHIFT_PIO)
-  ata_host_set_dma(ap, xfer_mode, xfer_shift);
-
- /* step 4: update devices' xfer mode */
- ata_dev_set_mode(ap, &ap->device[0]);
- ata_dev_set_mode(ap, &ap->device[1]);
+  struct ata_device *dev = &ap->device[i];
 
- if (ap->flags & ATA_FLAG_PORT_DISABLED)
-  return;
+  if (ata_dev_present(dev)) {
+   
+   ata_set_xfermode(ap, dev);
 
- if (ap->ops->post_set_mode)
-  ap->ops->post_set_mode(ap);
+   /* Is this needed? */
+   if (ap->flags & ATA_FLAG_PORT_DISABLED)
+    return;
 
- for (i = 0; i < 2; i++) {
-  struct ata_device *dev = &ap->device[i];
-  ata_dev_set_protocol(dev);
+   ata_dev_set_protocol(dev);
+  }
  }
 
  return;
@@ -1834,7 +1915,7 @@
  * LOCKING:
  */
 
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
+static int ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev)
 {
  DECLARE_COMPLETION(wait);
  struct ata_queued_cmd *qc;
@@ -1866,6 +1947,9 @@
   wait_for_completion(&wait);
 
  DPRINTK("EXIT\n");
+
+ /* FIXME: Return the result of set features */
+ return 0;
 }
 
 /**

------=_NextPart_000_0044_01C4C8FE.6E8317F0
Content-Type: application/octet-stream;
	name="ata_set_mode.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ata_set_mode.patch"

--- libata-dev-2.6-ori/drivers/scsi/libata-core.c	2004-11-10 =
17:53:24.000000000 +0800=0A=
+++ libata-dev-2.6/drivers/scsi/libata-core.c	2004-11-12 =
21:02:10.188293547 +0800=0A=
@@ -52,7 +52,7 @@=0A=
 				    unsigned long tmout_pat,=0A=
 			    	    unsigned long tmout);=0A=
 static void ata_set_mode(struct ata_port *ap);=0A=
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device =
*dev);=0A=
+static int ata_dev_set_xfermode(struct ata_port *ap, struct ata_device =
*dev);=0A=
 static unsigned int ata_get_mode_mask(struct ata_port *ap, int shift);=0A=
 static int fgb(u32 bitmap);=0A=
 static int ata_choose_xfer_mode(struct ata_port *ap,=0A=
@@ -1344,32 +1344,41 @@=0A=
 =0A=
 	return 0xff;=0A=
 }=0A=
-=0A=
-static void ata_dev_set_mode(struct ata_port *ap, struct ata_device =
*dev)=0A=
+/**=0A=
+ * Map xfer_mask to xfer_mode and issue set features to the device=0A=
+ */=0A=
+static int ata_dev_set_mode(struct ata_port *ap, struct ata_device =
*dev, unsigned int xfer_mask, int shift)=0A=
 {=0A=
 	int ofs, idx;=0A=
 	u8 base;=0A=
+	int rc;=0A=
 =0A=
-	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))=0A=
-		return;=0A=
-=0A=
-	if (dev->xfer_shift =3D=3D ATA_SHIFT_PIO)=0A=
-		dev->flags |=3D ATA_DFLAG_PIO;=0A=
+	base =3D base_from_shift(shift);=0A=
 =0A=
-	ata_dev_set_xfermode(ap, dev);=0A=
+	ofs =3D fgb(xfer_mask);=0A=
+	dev->xfer_mode =3D base + ofs;=0A=
 =0A=
-	base =3D base_from_shift(dev->xfer_shift);=0A=
-	ofs =3D dev->xfer_mode - base;=0A=
-	idx =3D ofs + dev->xfer_shift;=0A=
+	dev->xfer_shift =3D shift;=0A=
+	idx =3D dev->xfer_shift + ofs;=0A=
 	WARN_ON(idx >=3D ARRAY_SIZE(xfer_mode_str));=0A=
+		=0A=
+	if (shift =3D=3D ATA_SHIFT_PIO) {=0A=
+		dev->pio_mode =3D dev->xfer_mode;=0A=
+	} else {=0A=
+		dev->dma_mode =3D dev->xfer_mode;=0A=
+	}=0A=
 =0A=
 	DPRINTK("idx=3D%d xfer_shift=3D%u, xfer_mode=3D0x%x, base=3D0x%x, =
offset=3D%d\n",=0A=
 		idx, dev->xfer_shift, (int)dev->xfer_mode, (int)base, ofs);=0A=
 =0A=
+	/* FIXME: return error if set feature fails */=0A=
+	rc =3D ata_dev_set_xfermode(ap, dev);=0A=
+=0A=
 	printk(KERN_INFO "ata%u: dev %u configured for %s\n",=0A=
 		ap->id, dev->devno, xfer_mode_str[idx]);=0A=
+	=0A=
+	return rc;=0A=
 }=0A=
-=0A=
 static int ata_host_set_pio(struct ata_port *ap)=0A=
 {=0A=
 	unsigned int mask;=0A=
@@ -1419,7 +1428,92 @@=0A=
 		}=0A=
 	}=0A=
 }=0A=
+/**=0A=
+ * Find the transfer mode between the HBA and the device=0A=
+ */=0A=
+static int ata_set_xfermode(struct ata_port *ap, struct ata_device *dev)=0A=
+{=0A=
+	unsigned int dev_pio_mask   =3D 0x07; /* PIO mode 0-2 */=0A=
+	unsigned int dev_mwdma_mask =3D 0;=0A=
+	unsigned int dev_udma_mask  =3D 0;=0A=
+=0A=
+	unsigned int xfer_pio_mask;=0A=
+	unsigned int xfer_mwdma_mask;=0A=
+	unsigned int xfer_udma_mask;=0A=
+=0A=
+	int no_dma =3D 1;=0A=
+=0A=
+	/* step 1. Assemble the PIO, MWDMA and UDMA mask of the device */=0A=
+	if (dev->id[53] & 0x02) // Is word 64 valid?=0A=
+		/* spec doesn't return explicit support for=0A=
+		 * PIO0-2, so we fake it=0A=
+		 */=0A=
+		dev_pio_mask |=3D (dev->id[ATA_ID_PIO_MODES] & 0x03) << 3;=0A=
+	=0A=
+	dev_mwdma_mask =3D dev->id[ATA_ID_MWDMA_MODES] & 0x07;=0A=
+	=0A=
+	if (dev->id[53] & 0x04) /* Is word 88 valid */=0A=
+		dev_udma_mask =3D dev->id[ATA_ID_UDMA_MODES] & 0xff;=0A=
+=0A=
+	/* FIXME: Check device black list for workable mask */=0A=
+	=0A=
+	/* step 2. Find mode that both HBA and device can support */=0A=
+	xfer_pio_mask   =3D ap->pio_mask   & dev_pio_mask;=0A=
+	xfer_mwdma_mask =3D ap->mwdma_mask & dev_mwdma_mask;=0A=
+	xfer_udma_mask  =3D ap->udma_mask  & dev_udma_mask;=0A=
+	=0A=
+	/* step 3. Check whether 80-conductor wire/SATA is needed and present =
*/=0A=
+	if (xfer_udma_mask & (~ATA_UDMA_MASK_40C)) {=0A=
+		/* UDMA 3 or above.=0A=
+		 * 80-conductor wire/SATA cable is needed=0A=
+		 */=0A=
+		if ((ap->cbl =3D=3D ATA_CBL_PATA40) ||=0A=
+		    (ap->cbl =3D=3D ATA_CBL_PATA_UNK)) {=0A=
+			printk(KERN_WARNING "ata%u: 40-conductor cable detected on port %d, =
transfer speed reduced to UDMA-33\n", =0A=
+			       ap->id, ap->port_no);=0A=
+			xfer_udma_mask &=3D ATA_UDMA_MASK_40C;=0A=
+		}=0A=
+	}=0A=
+	=0A=
+	/* step 4. Map xfer_mask to xfer_mode=0A=
+	 * Issue set features to the device for PIO mode.=0A=
+	 */=0A=
+=0A=
+	ata_dev_set_mode(ap, dev, xfer_pio_mask, ATA_SHIFT_PIO);=0A=
+=0A=
+	=0A=
+	/* step 5. Map xfer_mask to xfer_mode=0A=
+	 * Issue set features to the device for MWDMA/UDMA mode.=0A=
+	 */=0A=
+	if (xfer_udma_mask) {=0A=
+		no_dma =3D ata_dev_set_mode(ap, dev, xfer_udma_mask, ATA_SHIFT_UDMA);=0A=
+	} =0A=
+	=0A=
+	if (no_dma && xfer_mwdma_mask)	=0A=
+		/* Try MWDMA */=0A=
+		no_dma =3D ata_dev_set_mode(ap, dev, xfer_mwdma_mask, =
ATA_SHIFT_MWDMA);=0A=
 =0A=
+	if (no_dma)=0A=
+		/* Forced to PIO only */=0A=
+		dev->flags |=3D ATA_DFLAG_PIO;=0A=
+	=0A=
+	/* step 6. Here the lowlevel driver change the HBA timing registers.=0A=
+	 * This has to be done after "set features" to device=0A=
+	 * because some HBA hardware (ex. Promise) will look at SET FEATURES=0A=
+	 * and change the timing registers.=0A=
+	 */=0A=
+=0A=
+	if (ap->ops->set_piomode)=0A=
+		ap->ops->set_piomode(ap, dev);=0A=
+=0A=
+	if (ap->ops->set_dmamode)=0A=
+		ap->ops->set_dmamode(ap, dev);=0A=
+	=0A=
+	if (ap->ops->post_set_mode)=0A=
+		ap->ops->post_set_mode(ap);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
 /**=0A=
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER=0A=
  *	@ap: port on which timings will be programmed=0A=
@@ -1429,38 +1523,25 @@=0A=
  */=0A=
 static void ata_set_mode(struct ata_port *ap)=0A=
 {=0A=
-	unsigned int i, xfer_shift;=0A=
-	u8 xfer_mode;=0A=
-	int rc;=0A=
+	int i;=0A=
 =0A=
-	/* step 1: always set host PIO timings */=0A=
-	rc =3D ata_host_set_pio(ap);=0A=
-	if (rc)=0A=
-		goto err_out;=0A=
+	if (ap->flags & ATA_FLAG_PORT_DISABLED) =0A=
+		return;=0A=
 =0A=
-	/* step 2: choose the best data xfer mode */=0A=
-	xfer_mode =3D xfer_shift =3D 0;=0A=
-	rc =3D ata_choose_xfer_mode(ap, &xfer_mode, &xfer_shift);=0A=
-	if (rc)=0A=
-		goto err_out;=0A=
+	for (i=3D0; i < ATA_MAX_DEVICES; i++) {=0A=
 =0A=
-	/* step 3: if that xfer mode isn't PIO, set host DMA timings */=0A=
-	if (xfer_shift !=3D ATA_SHIFT_PIO)=0A=
-		ata_host_set_dma(ap, xfer_mode, xfer_shift);=0A=
-=0A=
-	/* step 4: update devices' xfer mode */=0A=
-	ata_dev_set_mode(ap, &ap->device[0]);=0A=
-	ata_dev_set_mode(ap, &ap->device[1]);=0A=
+		struct ata_device *dev =3D &ap->device[i];=0A=
 =0A=
-	if (ap->flags & ATA_FLAG_PORT_DISABLED)=0A=
-		return;=0A=
+		if (ata_dev_present(dev)) {=0A=
+			=0A=
+			ata_set_xfermode(ap, dev);=0A=
 =0A=
-	if (ap->ops->post_set_mode)=0A=
-		ap->ops->post_set_mode(ap);=0A=
+			/* Is this needed? */=0A=
+			if (ap->flags & ATA_FLAG_PORT_DISABLED)=0A=
+				return;=0A=
 =0A=
-	for (i =3D 0; i < 2; i++) {=0A=
-		struct ata_device *dev =3D &ap->device[i];=0A=
-		ata_dev_set_protocol(dev);=0A=
+			ata_dev_set_protocol(dev);=0A=
+		}=0A=
 	}=0A=
 =0A=
 	return;=0A=
@@ -1834,7 +1915,7 @@=0A=
  *	LOCKING:=0A=
  */=0A=
 =0A=
-static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device =
*dev)=0A=
+static int ata_dev_set_xfermode(struct ata_port *ap, struct ata_device =
*dev)=0A=
 {=0A=
 	DECLARE_COMPLETION(wait);=0A=
 	struct ata_queued_cmd *qc;=0A=
@@ -1866,6 +1947,9 @@=0A=
 		wait_for_completion(&wait);=0A=
 =0A=
 	DPRINTK("EXIT\n");=0A=
+=0A=
+	/* FIXME: Return the result of set features */=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 /**=0A=

------=_NextPart_000_0044_01C4C8FE.6E8317F0--

