From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH 3/3] libata - Query the driver for ATAPI DMA support
Date: Thu, 16 Dec 2004 13:28:28 +0800
Message-ID: <002201c4e330$562a61d0$e4574109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001F_01C4E373.209D4B20"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:65017 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261852AbULPFal (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Dec 2004 00:30:41 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.

------=_NextPart_000_001F_01C4E373.209D4B20
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi, Jeff:

> 
> > After some testing, it seems that some PATA host adapter (ex. pdc20275) cannot 
> > work reliably with specific request buffer sizes under ATAPI DMA mode.
> >
> > Detailed test result:
> > 4096, 2048, 1024, 512, 256: OK
> > 384, 257, 255, 128, 96, 64, 32:  failed (irq lost)
> > 
> >  It seems multiple of 256 bytes are the safe ATAPI DMA buffer sizes to use.
> >
> 
> Attached please find the patch to fix the pdc2027x ATAPI DMA problem.
> (The patch is against libata-dev-2.6 tree.)
> 
> Changes:
> 1. Add a callback function "check_atapi_dma()" to ata_port_operations such that libata core
> can ask the driver: "Can this command be processed in ATAPI DMA mode safely? " 
> when the the command is received.
> 2. ATAPI DMA is off by default if the callback function is not provided by the driver

    Sorry, there is a mistake in the previous patch. Revised the patch here:
If the callback function is not provided by the driver, the ATAPI DMA should be as is.
We should not turn off ATAPI DMA silently as in the previous patch. The ATAPI DMA is 
already controlled by dev->flags.

BTW, the patch isolates the ATAPI DMA workaround to the pdc20275 driver itself, not impacting libata core .
Attached please find the revised patch for your review.
 
Albert
 
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c libata-dev-2.6/drivers/scsi/libata-core.c
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c 2004-12-15 16:10:30.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata-core.c 2004-12-16 11:33:33.000000000 +0800
@@ -1947,7 +1947,24 @@
  if (idx)
   ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
+/**
+ * ata_check_atapi_dma - Check whether ATAPI DMA can be supported
+ * @qc: Metadata associated with taskfile to check
+ *
+ * LOCKING:
+ * RETURNS: 0 when ATAPI DMA can be used
+ *               nonzero otherwise
+ */
+int ata_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+ struct ata_port *ap = qc->ap;
+ int rc = 0; /* Assume ATAPI DMA is OK by default */
+
+ if (ap->ops->check_atapi_dma)
+  rc = ap->ops->check_atapi_dma(qc);
 
+ return rc;
+}
 /**
  * ata_qc_prep - Prepare taskfile for submission
  * @qc: Metadata associated with taskfile to be prepared
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata.h libata-dev-2.6/drivers/scsi/libata.h
--- libata-dev-2.6-ori/drivers/scsi/libata.h 2004-11-30 12:52:28.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata.h 2004-12-15 16:36:55.000000000 +0800
@@ -38,6 +38,7 @@
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
           struct ata_device *dev);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
+extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-scsi.c libata-dev-2.6/drivers/scsi/libata-scsi.c
--- libata-dev-2.6-ori/drivers/scsi/libata-scsi.c 2004-11-30 12:52:28.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c 2004-12-15 16:15:59.000000000 +0800
@@ -1558,6 +1558,11 @@
  int using_pio = (dev->flags & ATA_DFLAG_PIO);
  int nodata = (cmd->sc_data_direction == SCSI_DATA_NONE);
 
+ if (!using_pio)
+  /* Check whether ATAPI DMA is safe */
+  if (ata_check_atapi_dma(qc))
+   using_pio = 1;
+
  memcpy(&qc->cdb, scsicmd, qc->ap->cdb_len);
 
  qc->complete_fn = atapi_qc_complete;
diff -Nru libata-dev-2.6-ori/drivers/scsi/pata_pdc2027x.c libata-dev-2.6/drivers/scsi/pata_pdc2027x.c
--- libata-dev-2.6-ori/drivers/scsi/pata_pdc2027x.c 2004-11-30 12:52:28.000000000 +0800
+++ libata-dev-2.6/drivers/scsi/pata_pdc2027x.c 2004-12-15 16:21:00.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME "pata_pdc2027x"
-#define DRV_VERSION "0.53"
+#define DRV_VERSION "0.54"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -51,6 +51,7 @@
 static void pdc2027x_phy_reset(struct ata_port *ap);
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev);
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev);
+static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);
 
 /* 
  * ATA Timing Tables based on 133MHz controller clock.
@@ -141,6 +142,7 @@
 
  .phy_reset  = pdc2027x_phy_reset,   
 
+ .check_atapi_dma = pdc2027x_check_atapi_dma,
  .bmdma_setup            = ata_bmdma_setup,
  .bmdma_start            = ata_bmdma_start,
  .qc_prep  = ata_qc_prep,
@@ -377,6 +379,27 @@
  }
 }
 /**
+ * pdc2027x_check_atapi_dma - Check whether ATAPI DMA can be supported for this command
+ * @qc: Metadata associated with taskfile to check
+ *
+ * LOCKING:
+ * None (inherited from caller).
+ *
+ * RETURNS: 0 when ATAPI DMA can be used
+ *               1 otherwise
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
+/**
  * adjust_pll - Adjust the PLL input clock in Hz.
  *
  * @pdc_controller: controller specific information
diff -Nru libata-dev-2.6-ori/include/linux/libata.h libata-dev-2.6/include/linux/libata.h
--- libata-dev-2.6-ori/include/linux/libata.h 2004-11-30 12:52:42.000000000 +0800
+++ libata-dev-2.6/include/linux/libata.h 2004-12-15 16:17:41.000000000 +0800
@@ -339,6 +339,8 @@
  void (*phy_reset) (struct ata_port *ap);
  void (*post_set_mode) (struct ata_port *ap);
 
+ int (*check_atapi_dma) (struct ata_queued_cmd *qc);
+
  void (*bmdma_setup) (struct ata_queued_cmd *qc);
  void (*bmdma_start) (struct ata_queued_cmd *qc);
 

------=_NextPart_000_001F_01C4E373.209D4B20
Content-Type: application/octet-stream;
	name="atapi_dma_check.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="atapi_dma_check.patch"

diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-core.c =
libata-dev-2.6/drivers/scsi/libata-core.c=0A=
--- libata-dev-2.6-ori/drivers/scsi/libata-core.c	2004-12-15 =
16:10:30.000000000 +0800=0A=
+++ libata-dev-2.6/drivers/scsi/libata-core.c	2004-12-16 =
11:33:33.000000000 +0800=0A=
@@ -1947,7 +1947,24 @@=0A=
 	if (idx)=0A=
 		ap->prd[idx - 1].flags_len |=3D cpu_to_le32(ATA_PRD_EOT);=0A=
 }=0A=
+/**=0A=
+ *	ata_check_atapi_dma - Check whether ATAPI DMA can be supported=0A=
+ *	@qc: Metadata associated with taskfile to check=0A=
+ *=0A=
+ *	LOCKING:=0A=
+ *	RETURNS: 0 when ATAPI DMA can be used=0A=
+ *               nonzero otherwise=0A=
+ */=0A=
+int ata_check_atapi_dma(struct ata_queued_cmd *qc)=0A=
+{=0A=
+	struct ata_port *ap =3D qc->ap;=0A=
+	int rc =3D 0; /* Assume ATAPI DMA is OK by default */=0A=
+=0A=
+	if (ap->ops->check_atapi_dma)=0A=
+		rc =3D ap->ops->check_atapi_dma(qc);=0A=
 =0A=
+	return rc;=0A=
+}=0A=
 /**=0A=
  *	ata_qc_prep - Prepare taskfile for submission=0A=
  *	@qc: Metadata associated with taskfile to be prepared=0A=
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata.h =
libata-dev-2.6/drivers/scsi/libata.h=0A=
--- libata-dev-2.6-ori/drivers/scsi/libata.h	2004-11-30 =
12:52:28.000000000 +0800=0A=
+++ libata-dev-2.6/drivers/scsi/libata.h	2004-12-15 16:36:55.000000000 =
+0800=0A=
@@ -38,6 +38,7 @@=0A=
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,=0A=
 				      struct ata_device *dev);=0A=
 extern int ata_qc_issue(struct ata_queued_cmd *qc);=0A=
+extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);=0A=
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,=0A=
                            unsigned int wait, unsigned int can_sleep);=0A=
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct =
ata_taskfile *tf);=0A=
diff -Nru libata-dev-2.6-ori/drivers/scsi/libata-scsi.c =
libata-dev-2.6/drivers/scsi/libata-scsi.c=0A=
--- libata-dev-2.6-ori/drivers/scsi/libata-scsi.c	2004-11-30 =
12:52:28.000000000 +0800=0A=
+++ libata-dev-2.6/drivers/scsi/libata-scsi.c	2004-12-15 =
16:15:59.000000000 +0800=0A=
@@ -1558,6 +1558,11 @@=0A=
 	int using_pio =3D (dev->flags & ATA_DFLAG_PIO);=0A=
 	int nodata =3D (cmd->sc_data_direction =3D=3D SCSI_DATA_NONE);=0A=
 =0A=
+	if (!using_pio)=0A=
+		/* Check whether ATAPI DMA is safe */=0A=
+		if (ata_check_atapi_dma(qc))=0A=
+			using_pio =3D 1;=0A=
+=0A=
 	memcpy(&qc->cdb, scsicmd, qc->ap->cdb_len);=0A=
 =0A=
 	qc->complete_fn =3D atapi_qc_complete;=0A=
diff -Nru libata-dev-2.6-ori/drivers/scsi/pata_pdc2027x.c =
libata-dev-2.6/drivers/scsi/pata_pdc2027x.c=0A=
--- libata-dev-2.6-ori/drivers/scsi/pata_pdc2027x.c	2004-11-30 =
12:52:28.000000000 +0800=0A=
+++ libata-dev-2.6/drivers/scsi/pata_pdc2027x.c	2004-12-15 =
16:21:00.000000000 +0800=0A=
@@ -29,7 +29,7 @@=0A=
 #include <asm/io.h>=0A=
 =0A=
 #define DRV_NAME	"pata_pdc2027x"=0A=
-#define DRV_VERSION	"0.53"=0A=
+#define DRV_VERSION	"0.54"=0A=
 #undef PDC_DEBUG=0A=
 =0A=
 #ifdef PDC_DEBUG=0A=
@@ -51,6 +51,7 @@=0A=
 static void pdc2027x_phy_reset(struct ata_port *ap);=0A=
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device =
*adev);=0A=
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device =
*adev);=0A=
+static int pdc2027x_check_atapi_dma(struct ata_queued_cmd *qc);=0A=
 =0A=
 /* =0A=
  * ATA Timing Tables based on 133MHz controller clock.=0A=
@@ -141,6 +142,7 @@=0A=
 =0A=
 	.phy_reset		=3D pdc2027x_phy_reset,   =0A=
 =0A=
+	.check_atapi_dma	=3D pdc2027x_check_atapi_dma,=0A=
 	.bmdma_setup            =3D ata_bmdma_setup,=0A=
 	.bmdma_start            =3D ata_bmdma_start,=0A=
 	.qc_prep		=3D ata_qc_prep,=0A=
@@ -377,6 +379,27 @@=0A=
 	}=0A=
 }=0A=
 /**=0A=
+ *	pdc2027x_check_atapi_dma - Check whether ATAPI DMA can be supported =
for this command=0A=
+ *	@qc: Metadata associated with taskfile to check=0A=
+ *=0A=
+ *	LOCKING:=0A=
+ *	None (inherited from caller).=0A=
+ *=0A=
+ *	RETURNS: 0 when ATAPI DMA can be used=0A=
+ *               1 otherwise=0A=
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
+/**=0A=
  * adjust_pll - Adjust the PLL input clock in Hz.=0A=
  *=0A=
  * @pdc_controller: controller specific information=0A=
diff -Nru libata-dev-2.6-ori/include/linux/libata.h =
libata-dev-2.6/include/linux/libata.h=0A=
--- libata-dev-2.6-ori/include/linux/libata.h	2004-11-30 =
12:52:42.000000000 +0800=0A=
+++ libata-dev-2.6/include/linux/libata.h	2004-12-15 16:17:41.000000000 =
+0800=0A=
@@ -339,6 +339,8 @@=0A=
 	void (*phy_reset) (struct ata_port *ap);=0A=
 	void (*post_set_mode) (struct ata_port *ap);=0A=
 =0A=
+	int (*check_atapi_dma) (struct ata_queued_cmd *qc);=0A=
+=0A=
 	void (*bmdma_setup) (struct ata_queued_cmd *qc);=0A=
 	void (*bmdma_start) (struct ata_queued_cmd *qc);=0A=
 =0A=

------=_NextPart_000_001F_01C4E373.209D4B20--

