From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH] libata-dev-2.6 -- pdc2027x timing register bug fix
Date: Fri, 21 Jan 2005 21:30:08 +0800
Message-ID: <005e01c4ffbd$55c9b200$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005B_01C50000.615BE6E0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:31712 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262361AbVAUNat (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 Jan 2005 08:30:49 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.

------=_NextPart_000_005B_01C50000.615BE6E0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi Jeff,

Attached please find the patch against libata-dev-2.6 for your review.

Changes:
1. Resubmit the pdc2027x ATAPI DMA bug fix.
2. Turn on prefetch only when the drive supports PIO mode only.
3. Minor debug message fix
4. Fix the incorrect timing register values automatically set by the hardware by
    setting timing registers again in ap->post_set_mode(). Problem detailed below:

   Promise pdc2027x hardware will look at the SET FEATURES and set the timing registers
   automatically. Under 133MHz PLL, the values set by the hardware is incorrect.
   Because ata_set_mode() set HBA timing registers before "SET FEATURES", 
   the correct value set by the software device driver is later overwritten
   by hardware when "SET FEATURES" seen by the hardware.
   So,  pdc2027x_post_set_mode() is added to set the correct timeing values back.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
----------------------------------------------------------------------------------------------
--- libata-2.6/drivers/scsi/pata_pdc2027x.c 2005-01-21 20:00:52.000000000 +0800
+++ libata-2.6-mod/drivers/scsi/pata_pdc2027x.c 2005-01-21 21:03:26.868787243 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME "pata_pdc2027x"
-#define DRV_VERSION "0.53"
+#define DRV_VERSION "0.55"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -51,6 +51,8 @@
 static void pdc2027x_phy_reset(struct ata_port *ap);
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
+static void pdc2027x_post_set_mode(struct ata_port *ap);
+static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);
 
 /* 
  * ATA Timing Tables based on 133MHz controller clock.
@@ -140,15 +142,17 @@
  .dev_select  = ata_std_dev_select,
 
  .phy_reset  = pdc2027x_phy_reset,   
+ .post_set_mode  = pdc2027x_post_set_mode,
 
- .bmdma_setup            = ata_bmdma_setup,
- .bmdma_start            = ata_bmdma_start,
+ .check_atapi_dma = pdc2027x_check_atapi_dma,
+ .bmdma_setup  = ata_bmdma_setup,
+ .bmdma_start  = ata_bmdma_start,
  .qc_prep  = ata_qc_prep,
  .qc_issue  = ata_qc_issue_prot,
  .eng_timeout  = ata_eng_timeout,
 
  .irq_handler  = ata_interrupt,
- .irq_clear              = ata_bmdma_irq_clear,
+ .irq_clear  = ata_bmdma_irq_clear,
 
  .port_start  = ata_port_start,
  .port_stop  = ata_port_stop,
@@ -284,8 +288,6 @@
  unsigned int pio      = adev->pio_mode - XFER_PIO_0;
  unsigned int drive_dn = (ap->port_no ? 2 : 0) + adev->devno;
  u8 adj        = (drive_dn%2) ? 0x08 : 0x00;
- u8 tmp8;
-
 
  PDPRINTK("adev->pio_mode[%X]\n", adev->pio_mode);
 
@@ -305,20 +307,7 @@
 
  PDPRINTK("Set pio regs done\n");
 
- /*
-  *  Check whether the device supports turning off IORDY.
-  * For PIO3 and above, the device must support IORDY and set bit 10 
-  */
- if (adev->id[49] & 0x400) { 
-  /* IORDY_EN & PREFETCH_EN */
-  /* Turn on Prefetch */
-  tmp8 = pdc_get_indexed_reg(ap, 0x13 + adj);
-  pdc_set_indexed_reg(ap, 0x13 + adj, tmp8 | 0x03);
-
-  PDPRINTK("Turn on prefetch\n");
- }
-
- printk(KERN_INFO DRV_NAME ": Set to pio mode[%u] \n", pio);
+ PDPRINTK("Set to pio mode[%u] \n", pio);
 }
 /**
  * pdc2027x_set_dmamode - Initialize host controller PATA UDMA timings
@@ -359,7 +348,7 @@
   pdc_set_indexed_reg(ap, 0x12 + adj, pdc2027x_udma_timing_tbl[udma_mode].value2);
   PDPRINTK("Set udma regs done\n");
   
-  printk(KERN_INFO DRV_NAME ": Set to udma mode[%u] \n", udma_mode);
+  PDPRINTK("Set to udma mode[%u] \n", udma_mode);
 
  } else  if((dma_mode >= XFER_MW_DMA_0) && 
      (dma_mode <= XFER_MW_DMA_2)) {
@@ -371,11 +360,70 @@
   pdc_set_indexed_reg(ap, 0x0f + adj, pdc2027x_mdma_timing_tbl[mdma_mode].value1);
   PDPRINTK("Set mdma regs done\n");
   
-  printk(KERN_INFO DRV_NAME ": Set to mdma mode[%u] \n", mdma_mode);
+  PDPRINTK("Set to mdma mode[%u] \n", mdma_mode);
  } else {
   printk(KERN_ERR DRV_NAME ": Unknown dma mode [%u] ignored\n", dma_mode);
  }
 }
+
+/**
+ * pdc2027x_post_set_mode - Set the timing registers back to correct values.
+ * @ap: Port to configure
+ * 
+ * The pdc2027x hardware will look at "SET FEATURES" and change the timing registers 
+ * automatically. The values set by the hardware might be incorrect, under 133Mhz PLL.
+ * This function overwrites the possibly incorrect values set by the hardware to be correct.
+ */
+static void pdc2027x_post_set_mode(struct ata_port *ap)
+{
+ int i;
+
+ for (i = 0; i < ATA_MAX_DEVICES; i++) {
+  struct ata_device *dev = &ap->device[i];
+
+  if (ata_dev_present(dev)) {
+   u8 adj = (i % 2) ? 0x08 : 0x00;
+   u8 tmp8;
+   
+   pdc2027x_set_piomode(ap, dev);
+
+   /*
+    * Enable prefetch if the device support PIO only.
+    */
+   if (dev->xfer_shift == ATA_SHIFT_PIO) { 
+    tmp8 = pdc_get_indexed_reg(ap, 0x13 + adj);
+    pdc_set_indexed_reg(ap, 0x13 + adj, tmp8 | 0x02);
+    
+    PDPRINTK("Turn on prefetch\n");
+   } else {
+    pdc2027x_set_dmamode(ap, dev);
+   }
+  }
+ }
+}
+
+/**
+ * pdc2027x_check_atapi_dma - Check whether ATAPI DMA can be supported for this command
+ * @qc: Metadata associated with taskfile to check
+ *
+ * LOCKING:
+ * None (inherited from caller).
+ *
+ * RETURNS: 0 when ATAPI DMA can be used
+ *   1 otherwise
+ */
+static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+ struct scsi_cmnd *cmd = qc->scsicmd;
+ int rc = 0;
+
+ /* pdc2027x can only do ATAPI DMA for specific buffer size */
+ if (cmd->request_bufflen % 256)
+  rc = 1;
+
+ return rc;
+}
+
 /**
  * adjust_pll - Adjust the PLL input clock in Hz.
  *

------=_NextPart_000_005B_01C50000.615BE6E0
Content-Type: application/octet-stream;
	name="pdc2027x_055.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pdc2027x_055.patch"

--- libata-2.6/drivers/scsi/pata_pdc2027x.c	2005-01-21 =
20:00:52.000000000 +0800=0A=
+++ libata-2.6-mod/drivers/scsi/pata_pdc2027x.c	2005-01-21 =
21:03:26.868787243 +0800=0A=
@@ -29,7 +29,7 @@=0A=
 #include <asm/io.h>=0A=
 =0A=
 #define DRV_NAME	"pata_pdc2027x"=0A=
-#define DRV_VERSION	"0.53"=0A=
+#define DRV_VERSION	"0.55"=0A=
 #undef PDC_DEBUG=0A=
 =0A=
 #ifdef PDC_DEBUG=0A=
@@ -51,6 +51,8 @@=0A=
 static void pdc2027x_phy_reset(struct ata_port *ap);=0A=
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device =
*adev);=0A=
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device =
*adev);=0A=
+static void pdc2027x_post_set_mode(struct ata_port *ap);=0A=
+static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);=0A=
 =0A=
 /* =0A=
  * ATA Timing Tables based on 133MHz controller clock.=0A=
@@ -140,15 +142,17 @@=0A=
 	.dev_select		=3D ata_std_dev_select,=0A=
 =0A=
 	.phy_reset		=3D pdc2027x_phy_reset,   =0A=
+	.post_set_mode		=3D pdc2027x_post_set_mode,=0A=
 =0A=
-	.bmdma_setup            =3D ata_bmdma_setup,=0A=
-	.bmdma_start            =3D ata_bmdma_start,=0A=
+	.check_atapi_dma	=3D pdc2027x_check_atapi_dma,=0A=
+	.bmdma_setup		=3D ata_bmdma_setup,=0A=
+	.bmdma_start		=3D ata_bmdma_start,=0A=
 	.qc_prep		=3D ata_qc_prep,=0A=
 	.qc_issue		=3D ata_qc_issue_prot,=0A=
 	.eng_timeout		=3D ata_eng_timeout,=0A=
 =0A=
 	.irq_handler		=3D ata_interrupt,=0A=
-	.irq_clear              =3D ata_bmdma_irq_clear,=0A=
+	.irq_clear		=3D ata_bmdma_irq_clear,=0A=
 =0A=
 	.port_start		=3D ata_port_start,=0A=
 	.port_stop		=3D ata_port_stop,=0A=
@@ -284,8 +288,6 @@=0A=
 	unsigned int pio      =3D adev->pio_mode - XFER_PIO_0;=0A=
 	unsigned int drive_dn =3D (ap->port_no ? 2 : 0) + adev->devno;=0A=
 	u8 adj		      =3D (drive_dn%2) ? 0x08 : 0x00;=0A=
-	u8 tmp8;=0A=
-=0A=
 =0A=
 	PDPRINTK("adev->pio_mode[%X]\n", adev->pio_mode);=0A=
 =0A=
@@ -305,20 +307,7 @@=0A=
 =0A=
 	PDPRINTK("Set pio regs done\n");=0A=
 =0A=
-	/*=0A=
-	 *  Check whether the device supports turning off IORDY.=0A=
-	 * For PIO3 and above, the device must support IORDY and set bit 10 =0A=
-	 */=0A=
-	if (adev->id[49] & 0x400) { =0A=
-		/* IORDY_EN & PREFETCH_EN */=0A=
-		/* Turn on Prefetch */=0A=
-		tmp8 =3D pdc_get_indexed_reg(ap, 0x13 + adj);=0A=
-		pdc_set_indexed_reg(ap, 0x13 + adj, tmp8 | 0x03);=0A=
-=0A=
-		PDPRINTK("Turn on prefetch\n");=0A=
-	}=0A=
-=0A=
-	printk(KERN_INFO DRV_NAME ": Set to pio mode[%u] \n", pio);=0A=
+	PDPRINTK("Set to pio mode[%u] \n", pio);=0A=
 }=0A=
 /**=0A=
  *	pdc2027x_set_dmamode - Initialize host controller PATA UDMA timings=0A=
@@ -359,7 +348,7 @@=0A=
 		pdc_set_indexed_reg(ap, 0x12 + adj, =
pdc2027x_udma_timing_tbl[udma_mode].value2);=0A=
 		PDPRINTK("Set udma regs done\n");=0A=
 		=0A=
-		printk(KERN_INFO DRV_NAME ": Set to udma mode[%u] \n", udma_mode);=0A=
+		PDPRINTK("Set to udma mode[%u] \n", udma_mode);=0A=
 =0A=
 	} else  if((dma_mode >=3D XFER_MW_DMA_0) && =0A=
 		   (dma_mode <=3D XFER_MW_DMA_2)) {=0A=
@@ -371,11 +360,70 @@=0A=
 		pdc_set_indexed_reg(ap, 0x0f + adj, =
pdc2027x_mdma_timing_tbl[mdma_mode].value1);=0A=
 		PDPRINTK("Set mdma regs done\n");=0A=
 		=0A=
-		printk(KERN_INFO DRV_NAME ": Set to mdma mode[%u] \n", mdma_mode);=0A=
+		PDPRINTK("Set to mdma mode[%u] \n", mdma_mode);=0A=
 	} else {=0A=
 		printk(KERN_ERR DRV_NAME ": Unknown dma mode [%u] ignored\n", =
dma_mode);=0A=
 	}=0A=
 }=0A=
+=0A=
+/**=0A=
+ *	pdc2027x_post_set_mode - Set the timing registers back to correct =
values.=0A=
+ *	@ap: Port to configure=0A=
+ *	=0A=
+ *	The pdc2027x hardware will look at "SET FEATURES" and change the =
timing registers =0A=
+ *	automatically. The values set by the hardware might be incorrect, =
under 133Mhz PLL.=0A=
+ *	This function overwrites the possibly incorrect values set by the =
hardware to be correct.=0A=
+ */=0A=
+static void pdc2027x_post_set_mode(struct ata_port *ap)=0A=
+{=0A=
+	int i;=0A=
+=0A=
+	for (i =3D 0; i < ATA_MAX_DEVICES; i++) {=0A=
+		struct ata_device *dev =3D &ap->device[i];=0A=
+=0A=
+		if (ata_dev_present(dev)) {=0A=
+			u8 adj =3D (i % 2) ? 0x08 : 0x00;=0A=
+			u8 tmp8;=0A=
+			=0A=
+			pdc2027x_set_piomode(ap, dev);=0A=
+=0A=
+			/*=0A=
+			 * Enable prefetch if the device support PIO only.=0A=
+			 */=0A=
+			if (dev->xfer_shift =3D=3D ATA_SHIFT_PIO) { =0A=
+				tmp8 =3D pdc_get_indexed_reg(ap, 0x13 + adj);=0A=
+				pdc_set_indexed_reg(ap, 0x13 + adj, tmp8 | 0x02);=0A=
+				=0A=
+				PDPRINTK("Turn on prefetch\n");=0A=
+			} else {=0A=
+				pdc2027x_set_dmamode(ap, dev);=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
+/**=0A=
+ *	pdc2027x_check_atapi_dma - Check whether ATAPI DMA can be supported =
for this command=0A=
+ *	@qc: Metadata associated with taskfile to check=0A=
+ *=0A=
+ *	LOCKING:=0A=
+ *	None (inherited from caller).=0A=
+ *=0A=
+ *	RETURNS: 0 when ATAPI DMA can be used=0A=
+ *		 1 otherwise=0A=
+ */=0A=
+static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc)=0A=
+{=0A=
+	struct scsi_cmnd *cmd =3D qc->scsicmd;=0A=
+	int rc =3D 0;=0A=
+=0A=
+	/* pdc2027x can only do ATAPI DMA for specific buffer size */=0A=
+	if (cmd->request_bufflen % 256)=0A=
+		rc =3D 1;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /**=0A=
  * adjust_pll - Adjust the PLL input clock in Hz.=0A=
  *=0A=

------=_NextPart_000_005B_01C50000.615BE6E0--


