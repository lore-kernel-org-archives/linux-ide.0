From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: [PATCH 1/1] [v3] Add support 2 SATA ports for Maui and change filename from sata_dwc_460ex.c to sata_dwc_4xx.c
Date: Fri,  6 Apr 2012 12:31:05 +0700
Message-ID: <1333690265-27857-1-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:33699 "HELO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752940Ab2DFFbU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Apr 2012 01:31:20 -0400
Received: by dake40 with SMTP id e40so2403817dak.11
        for <linux-ide@vger.kernel.org>; Thu, 05 Apr 2012 22:31:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: Phong Vo <pvo@apm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, "Thang Q. Nguyen" <tqnguyen@apm.com>


Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
---
Changes for v2:
       - Use git rename feature to change the driver to the newname and=
 for
         easier review.

Changes for v3:
	- Remove materials not related to 2 SATA ports support. They will
	 be added in another patches.

 drivers/ata/Makefile                             |    2 +-
 drivers/ata/{sata_dwc_460ex.c =3D> sata_dwc_4xx.c} |  820 +++++++++++-=
----------
 2 files changed, 430 insertions(+), 392 deletions(-)
 rename drivers/ata/{sata_dwc_460ex.c =3D> sata_dwc_4xx.c} (73%)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 6ece5b7..d225c0c 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_SATA_AHCI_PLATFORM) +=3D ahci_platform.o l=
ibahci.o
 obj-$(CONFIG_SATA_FSL)		+=3D sata_fsl.o
 obj-$(CONFIG_SATA_INIC162X)	+=3D sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+=3D sata_sil24.o
-obj-$(CONFIG_SATA_DWC)		+=3D sata_dwc_460ex.o
+obj-$(CONFIG_SATA_DWC)		+=3D sata_dwc_4xx.o
=20
 # SFF w/ custom DMA
 obj-$(CONFIG_PDC_ADMA)		+=3D pdc_adma.o
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_4xx.c
similarity index 73%
rename from drivers/ata/sata_dwc_460ex.c
rename to drivers/ata/sata_dwc_4xx.c
index 69f7cde..07e9b36 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_4xx.c
@@ -1,6 +1,4 @@
 /*
- * drivers/ata/sata_dwc_460ex.c
- *
  * Synopsys DesignWare Cores (DWC) SATA host driver
  *
  * Author: Mark Miesfeld <mmiesfeld@amcc.com>
@@ -16,6 +14,15 @@
  * under  the terms of  the GNU General  Public License as published b=
y the
  * Free Software Foundation;  either version 2 of the  License, or (at=
 your
  * option) any later version.
+ *
+ * CHANGES:
+ * - Version 1.4:
+ *   + Change filename from sata_dwc_460ex.c to sata_dwc_4xx.c
+ *   + This driver supports more than one SATA port. Each SATA port ha=
s its
+ *     own private attribute. Move sata_dwc_host_priv structure to
+ *     sata_dwc_device and sata_dwc_device_port structures.
+ *   + Change to use ata_bmdma_qc_issue and ata_bmdma_error_handler be=
cause
+ *     the ata_sff_qc_issue and ata_sff_error_handler no longer suppor=
t DMA.
  */
=20
 #ifdef CONFIG_SATA_DWC_DEBUG
@@ -44,10 +51,10 @@
 #undef	DRV_NAME
 #undef	DRV_VERSION
 #define DRV_NAME        "sata-dwc"
-#define DRV_VERSION     "1.3"
+#define DRV_VERSION     "1.4"
=20
 /* SATA DMA driver Globals */
-#define DMA_NUM_CHANS		1
+#define DMA_NUM_CHANS		2
 #define DMA_NUM_CHAN_REGS	8
=20
 /* SATA DMA Register definitions */
@@ -158,6 +165,7 @@ enum {
 /* Assign HW handshaking interface (x) to destination / source periphe=
ral */
 #define	DMA_CFG_HW_HS_DEST(int_num) (((int_num) & 0xF) << 11)
 #define	DMA_CFG_HW_HS_SRC(int_num) (((int_num) & 0xF) << 7)
+#define	DMA_CFG_HW_CH_PRIOR(int_num) (((int_num) & 0xF) << 5)
 #define	DMA_LLP_LMS(addr, master) (((addr) & 0xfffffffc) | (master))
=20
 /*
@@ -268,22 +276,25 @@ enum {
 						 << 16)
 struct sata_dwc_device {
 	struct device		*dev;		/* generic device struct */
-	struct ata_probe_ent	*pe;		/* ptr to probe-ent */
 	struct ata_host		*host;
 	u8			*reg_base;
 	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
 	int			irq_dma;
+	u8			*scr_base;
+	int			dma_channel;	/* DWC SATA DMA channel */
+	int			hostID;
 };
=20
 #define SATA_DWC_QCMD_MAX	32
=20
 struct sata_dwc_device_port {
 	struct sata_dwc_device	*hsdev;
-	int			cmd_issued[SATA_DWC_QCMD_MAX];
 	struct lli		*llit[SATA_DWC_QCMD_MAX];  /* DMA LLI table */
 	dma_addr_t		llit_dma[SATA_DWC_QCMD_MAX];
 	u32			dma_chan[SATA_DWC_QCMD_MAX];
 	int			dma_pending[SATA_DWC_QCMD_MAX];
+	u32			sactive_issued;
+	u32			sactive_queued;
 };
=20
 /*
@@ -300,41 +311,39 @@ struct sata_dwc_device_port {
 #define HSDEV_FROM_HSDEVP(p)	((struct sata_dwc_device *)\
 						(hsdevp)->hsdev)
=20
+/* Host Controller ID */
 enum {
-	SATA_DWC_CMD_ISSUED_NOT		=3D 0,
-	SATA_DWC_CMD_ISSUED_PEND	=3D 1,
-	SATA_DWC_CMD_ISSUED_EXEC	=3D 2,
-	SATA_DWC_CMD_ISSUED_NODATA	=3D 3,
+	APM_460EX_SATA =3D 0,
+	APM_821XX_SATA =3D 1,
+};
=20
+enum {
 	SATA_DWC_DMA_PENDING_NONE	=3D 0,
 	SATA_DWC_DMA_PENDING_TX		=3D 1,
 	SATA_DWC_DMA_PENDING_RX		=3D 2,
 };
=20
-struct sata_dwc_host_priv {
-	void	__iomem	 *scr_addr_sstatus;
-	u32	sata_dwc_sactive_issued ;
-	u32	sata_dwc_sactive_queued ;
-	u32	dma_interrupt_count;
-	struct	ahb_dma_regs	*sata_dma_regs;
-	struct	device	*dwc_dev;
-};
-struct sata_dwc_host_priv host_pvt;
+/* This is used for easier trace back when having DMA channel */
+static struct sata_dwc_device *dwc_dev_list[DMA_NUM_CHANS];
+
+/*
+ * As we have only one DMA controller, this will be set static and glo=
bal
+ * for easier to access
+ */
+static struct ahb_dma_regs *sata_dma_regs;
+
 /*
  * Prototypes
  */
 static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 =
tag);
 static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued=
_cmd *qc,
 				u32 check_status);
-static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_=
status);
 static void sata_dwc_port_stop(struct ata_port *ap);
 static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, =
u8 tag);
 static int dma_dwc_init(struct sata_dwc_device *hsdev, int irq);
-static void dma_dwc_exit(struct sata_dwc_device *hsdev);
-static int dma_dwc_xfer_setup(struct scatterlist *sg, int num_elems,
-			      struct lli *lli, dma_addr_t dma_lli,
-			      void __iomem *addr, int dir);
+static int dma_dwc_xfer_setup(struct ata_port *ap, dma_addr_t dma_lli)=
;
 static void dma_dwc_xfer_start(int dma_ch);
+static irqreturn_t dma_dwc_interrupt(int irq, struct sata_dwc_device *=
hsdev);
=20
 static const char *get_prot_descript(u8 protocol)
 {
@@ -372,15 +381,15 @@ static const char *get_dma_dir_descript(int dma_d=
ir)
 	}
 }
=20
-static void sata_dwc_tf_dump(struct ata_taskfile *tf)
+static void sata_dwc_tf_dump(struct device *dwc_dev, struct ata_taskfi=
le *tf)
 {
-	dev_vdbg(host_pvt.dwc_dev, "taskfile cmd: 0x%02x protocol: %s flags:"
+	dev_vdbg(dwc_dev, "taskfile cmd: 0x%02x protocol: %s flags:"
 		"0x%lx device: %x\n", tf->command,
 		get_prot_descript(tf->protocol), tf->flags, tf->device);
-	dev_vdbg(host_pvt.dwc_dev, "feature: 0x%02x nsect: 0x%x lbal: 0x%x "
+	dev_vdbg(dwc_dev, "feature: 0x%02x nsect: 0x%x lbal: 0x%x "
 		"lbam: 0x%x lbah: 0x%x\n", tf->feature, tf->nsect, tf->lbal,
 		 tf->lbam, tf->lbah);
-	dev_vdbg(host_pvt.dwc_dev, "hob_feature: 0x%02x hob_nsect: 0x%x "
+	dev_vdbg(dwc_dev, "hob_feature: 0x%02x hob_nsect: 0x%x "
 		"hob_lbal: 0x%x hob_lbam: 0x%x hob_lbah: 0x%x\n",
 		tf->hob_feature, tf->hob_nsect, tf->hob_lbal, tf->hob_lbam,
 		tf->hob_lbah);
@@ -416,52 +425,89 @@ static  int get_burst_length_encode(int datalengt=
h)
=20
 static  void clear_chan_interrupts(int c)
 {
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.tfr.low),
+	out_le32(&sata_dma_regs->interrupt_clear.tfr.low,
 		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.block.low),
+	out_le32(&sata_dma_regs->interrupt_clear.block.low,
 		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.srctran.low),
+	out_le32(&sata_dma_regs->interrupt_clear.srctran.low,
 		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.dsttran.low),
+	out_le32(&sata_dma_regs->interrupt_clear.dsttran.low,
 		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.error.low),
+	out_le32(&sata_dma_regs->interrupt_clear.error.low,
 		 DMA_CHANNEL(c));
 }
=20
 /*
  * Function: dma_request_channel
- * arguments: None
+ * arguments: ap
  * returns channel number if available else -1
  * This function assigns the next available DMA channel from the list =
to the
  * requester
  */
-static int dma_request_channel(void)
+static int dma_request_channel(struct ata_port *ap)
 {
-	int i;
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
=20
-	for (i =3D 0; i < DMA_NUM_CHANS; i++) {
-		if (!(in_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low)) &\
-			DMA_CHANNEL(i)))
-			return i;
-	}
-	dev_err(host_pvt.dwc_dev, "%s NO channel chan_en: 0x%08x\n", __func__=
,
-		in_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low)));
+	/* Check if the channel is not currently in use */
+	if (!(in_le32(&(sata_dma_regs->dma_chan_en.low)) &\
+		DMA_CHANNEL(hsdev->dma_channel)))
+		return hsdev->dma_channel;
+
+	dev_err(ap->dev, "%s Channel %d is currently in use\n", __func__,
+		hsdev->dma_channel);
 	return -1;
 }
=20
 /*
+ * Check if the selected DMA channel is currently enabled.
+ */
+static int sata_dwc_dma_chk_en(int ch)
+{
+	u32 dma_chan_reg;
+	/* Read the DMA channel register */
+	dma_chan_reg =3D in_le32(&(sata_dma_regs->dma_chan_en.low));
+	/* Check if it is currently enabled */
+	if (dma_chan_reg & DMA_CHANNEL(ch))
+		return 1;
+	return 0;
+}
+
+/*
+ * Handle DMA transfer complete interrupt. This checks and passes the
+ * processing to the appropriate ATA port.
+ */
+static irqreturn_t dma_dwc_handler(int irq, void *hsdev_instance)
+{
+	u32 tfr_reg, err_reg;
+	int chan;
+
+	tfr_reg =3D in_le32(&(sata_dma_regs->interrupt_status.tfr.low));
+	err_reg =3D in_le32(&(sata_dma_regs->interrupt_status.error.low));
+
+	for (chan =3D 0; chan < DMA_NUM_CHANS; chan++) {
+		/* Check for end-of-transfer interrupt. */
+		if (tfr_reg & DMA_CHANNEL(chan))
+			dma_dwc_interrupt(0, dwc_dev_list[chan]);
+
+		/* Check for error interrupt. */
+		if (err_reg & DMA_CHANNEL(chan))
+			dma_dwc_interrupt(0, dwc_dev_list[chan]);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
  * Function: dma_dwc_interrupt
  * arguments: irq, dev_id, pt_regs
  * returns channel number if available else -1
  * Interrupt Handler for DW AHB SATA DMA
  */
-static irqreturn_t dma_dwc_interrupt(int irq, void *hsdev_instance)
+static irqreturn_t dma_dwc_interrupt(int irq, struct sata_dwc_device *=
hsdev)
 {
 	int chan;
 	u32 tfr_reg, err_reg;
 	unsigned long flags;
-	struct sata_dwc_device *hsdev =3D
-		(struct sata_dwc_device *)hsdev_instance;
 	struct ata_host *host =3D (struct ata_host *)hsdev->host;
 	struct ata_port *ap;
 	struct sata_dwc_device_port *hsdevp;
@@ -471,41 +517,25 @@ static irqreturn_t dma_dwc_interrupt(int irq, voi=
d *hsdev_instance)
 	spin_lock_irqsave(&host->lock, flags);
 	ap =3D host->ports[port];
 	hsdevp =3D HSDEVP_FROM_AP(ap);
-	tag =3D ap->link.active_tag;
=20
-	tfr_reg =3D in_le32(&(host_pvt.sata_dma_regs->interrupt_status.tfr\
+	if (ap->link.active_tag !=3D ATA_TAG_POISON)
+		tag =3D ap->link.active_tag;
+
+	tfr_reg =3D in_le32(&(sata_dma_regs->interrupt_status.tfr\
 			.low));
-	err_reg =3D in_le32(&(host_pvt.sata_dma_regs->interrupt_status.error\
+	err_reg =3D in_le32(&(sata_dma_regs->interrupt_status.error\
 			.low));
-
 	dev_dbg(ap->dev, "eot=3D0x%08x err=3D0x%08x pending=3D%d active port=3D=
%d\n",
 		tfr_reg, err_reg, hsdevp->dma_pending[tag], port);
=20
-	for (chan =3D 0; chan < DMA_NUM_CHANS; chan++) {
-		/* Check for end-of-transfer interrupt. */
+	chan =3D hsdev->dma_channel;
+	if (chan >=3D 0) {
 		if (tfr_reg & DMA_CHANNEL(chan)) {
-			/*
-			 * Each DMA command produces 2 interrupts.  Only
-			 * complete the command after both interrupts have been
-			 * seen. (See sata_dwc_isr())
-			 */
-			host_pvt.dma_interrupt_count++;
+			/* Clear DMA config after transfer complete */
 			sata_dwc_clear_dmacr(hsdevp, tag);
=20
-			if (hsdevp->dma_pending[tag] =3D=3D
-			    SATA_DWC_DMA_PENDING_NONE) {
-				dev_err(ap->dev, "DMA not pending eot=3D0x%08x "
-					"err=3D0x%08x tag=3D0x%02x pending=3D%d\n",
-					tfr_reg, err_reg, tag,
-					hsdevp->dma_pending[tag]);
-			}
-
-			if ((host_pvt.dma_interrupt_count % 2) =3D=3D 0)
-				sata_dwc_dma_xfer_complete(ap, 1);
-
 			/* Clear the interrupt */
-			out_le32(&(host_pvt.sata_dma_regs->interrupt_clear\
-				.tfr.low),
+			out_le32(&(sata_dma_regs->interrupt_clear.tfr.low),
 				 DMA_CHANNEL(chan));
 		}
=20
@@ -516,11 +546,16 @@ static irqreturn_t dma_dwc_interrupt(int irq, voi=
d *hsdev_instance)
 				err_reg);
=20
 			/* Clear the interrupt. */
-			out_le32(&(host_pvt.sata_dma_regs->interrupt_clear\
+			out_le32(&(sata_dma_regs->interrupt_clear\
 				.error.low),
 				 DMA_CHANNEL(chan));
 		}
 	}
+	hsdevp->dma_pending[tag] =3D SATA_DWC_DMA_PENDING_NONE;
+
+	if (hsdevp->sactive_queued =3D=3D 0)
+		ap->link.active_tag =3D ATA_TAG_POISON;
+
 	spin_unlock_irqrestore(&host->lock, flags);
 	return IRQ_HANDLED;
 }
@@ -534,21 +569,21 @@ static irqreturn_t dma_dwc_interrupt(int irq, voi=
d *hsdev_instance)
 static int dma_request_interrupts(struct sata_dwc_device *hsdev, int i=
rq)
 {
 	int retval =3D 0;
-	int chan;
=20
-	for (chan =3D 0; chan < DMA_NUM_CHANS; chan++) {
-		/* Unmask error interrupt */
-		out_le32(&(host_pvt.sata_dma_regs)->interrupt_mask.error.low,
-			 DMA_ENABLE_CHAN(chan));
+	/* Unmask error interrupt */
+	out_le32(&sata_dma_regs->interrupt_mask.error.low,
+		in_le32(&sata_dma_regs->interrupt_mask.error.low) |
+			 DMA_ENABLE_CHAN(hsdev->dma_channel));
=20
-		/* Unmask end-of-transfer interrupt */
-		out_le32(&(host_pvt.sata_dma_regs)->interrupt_mask.tfr.low,
-			 DMA_ENABLE_CHAN(chan));
-	}
+	/* Unmask end-of-transfer interrupt */
+	out_le32(&sata_dma_regs->interrupt_mask.tfr.low,
+		in_le32(&sata_dma_regs->interrupt_mask.tfr.low) |
+			 DMA_ENABLE_CHAN(hsdev->dma_channel));
=20
-	retval =3D request_irq(irq, dma_dwc_interrupt, 0, "SATA DMA", hsdev);
+	retval =3D request_irq(irq, dma_dwc_handler, IRQF_SHARED, "SATA DMA",
+		hsdev);
 	if (retval) {
-		dev_err(host_pvt.dwc_dev, "%s: could not get IRQ %d\n",
+		dev_err(hsdev->dev, "%s: could not get IRQ %d\n",\
 		__func__, irq);
 		return -ENODEV;
 	}
@@ -567,16 +602,19 @@ static int dma_request_interrupts(struct sata_dwc=
_device *hsdev, int irq)
  * Currently this function sets interrupts enabled for each linked lis=
t item:
  * DMA_CTL_INT_EN.
  */
-static int map_sg_to_lli(struct scatterlist *sg, int num_elems,
-			struct lli *lli, dma_addr_t dma_lli,
+static int map_sg_to_lli(struct ata_port *ap, struct scatterlist *sg,
+			int num_elems, struct lli *lli, dma_addr_t dma_lli,
 			void __iomem *dmadr_addr, int dir)
 {
+	struct device *dwc_dev =3D ap->dev;
+	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
 	int i, idx =3D 0;
 	int fis_len =3D 0;
 	dma_addr_t next_llp;
 	int bl;
+	u32 sms_val, dms_val;
=20
-	dev_dbg(host_pvt.dwc_dev, "%s: sg=3D%p nelem=3D%d lli=3D%p dma_lli=3D=
0x%08x"
+	dev_dbg(dwc_dev, "%s: sg=3D%p nelem=3D%d lli=3D%p dma_lli=3D0x%08x"
 		" dmadr=3D0x%08x\n", __func__, sg, num_elems, lli, (u32)dma_lli,
 		(u32)dmadr_addr);
=20
@@ -589,13 +627,13 @@ static int map_sg_to_lli(struct scatterlist *sg, =
int num_elems,
 		addr =3D (u32) sg_dma_address(sg);
 		sg_len =3D sg_dma_len(sg);
=20
-		dev_dbg(host_pvt.dwc_dev, "%s: elem=3D%d sg_addr=3D0x%x sg_len"
+		dev_dbg(dwc_dev, "%s: elem=3D%d sg_addr=3D0x%x sg_len"
 			"=3D%d\n", __func__, i, addr, sg_len);
=20
 		while (sg_len) {
 			if (idx >=3D SATA_DWC_DMAC_LLI_NUM) {
 				/* The LLI table is not large enough. */
-				dev_err(host_pvt.dwc_dev, "LLI table overrun "
+				dev_err(dwc_dev, "LLI table overrun "
 				"(idx=3D%d)\n", idx);
 				break;
 			}
@@ -614,7 +652,7 @@ static int map_sg_to_lli(struct scatterlist *sg, in=
t num_elems,
 			 * the host controller.
 			 */
 			if (fis_len + len > 8192) {
-				dev_dbg(host_pvt.dwc_dev, "SPLITTING: fis_len=3D"
+				dev_dbg(dwc_dev, "SPLITTING: fis_len=3D"
 					"%d(0x%x) len=3D%d(0x%x)\n", fis_len,
 					 fis_len, len, len);
 				len =3D 8192 - fis_len;
@@ -629,14 +667,22 @@ static int map_sg_to_lli(struct scatterlist *sg, =
int num_elems,
 			 * Set DMA addresses and lower half of control register
 			 * based on direction.
 			 */
+			if (hsdevp->hsdev->hostID =3D=3D APM_821XX_SATA) {
+				sms_val =3D 1+hsdevp->hsdev->dma_channel;
+				dms_val =3D 0;
+			} else {
+				sms_val =3D 0;
+				dms_val =3D 1+hsdevp->hsdev->dma_channel;
+			}
+
 			if (dir =3D=3D DMA_FROM_DEVICE) {
 				lli[idx].dar =3D cpu_to_le32(addr);
 				lli[idx].sar =3D cpu_to_le32((u32)dmadr_addr);
=20
 				lli[idx].ctl.low =3D cpu_to_le32(
 					DMA_CTL_TTFC(DMA_CTL_TTFC_P2M_DMAC) |
-					DMA_CTL_SMS(0) |
-					DMA_CTL_DMS(1) |
+					DMA_CTL_SMS(sms_val) |
+					DMA_CTL_DMS(dms_val) |
 					DMA_CTL_SRC_MSIZE(bl) |
 					DMA_CTL_DST_MSIZE(bl) |
 					DMA_CTL_SINC_NOCHANGE |
@@ -651,8 +697,8 @@ static int map_sg_to_lli(struct scatterlist *sg, in=
t num_elems,
=20
 				lli[idx].ctl.low =3D cpu_to_le32(
 					DMA_CTL_TTFC(DMA_CTL_TTFC_M2P_PER) |
-					DMA_CTL_SMS(1) |
-					DMA_CTL_DMS(0) |
+					DMA_CTL_SMS(dms_val) |
+					DMA_CTL_DMS(sms_val) |
 					DMA_CTL_SRC_MSIZE(bl) |
 					DMA_CTL_DST_MSIZE(bl) |
 					DMA_CTL_DINC_NOCHANGE |
@@ -663,7 +709,7 @@ static int map_sg_to_lli(struct scatterlist *sg, in=
t num_elems,
 					DMA_CTL_LLP_DSTEN);
 			}
=20
-			dev_dbg(host_pvt.dwc_dev, "%s setting ctl.high len: "
+			dev_dbg(dwc_dev, "%s setting ctl.high len: "
 				"0x%08x val: 0x%08x\n", __func__,
 				len, DMA_CTL_BLK_TS(len / 4));
=20
@@ -678,7 +724,13 @@ static int map_sg_to_lli(struct scatterlist *sg, i=
nt num_elems,
 							lli)));
=20
 			/* The last 2 bits encode the list master select. */
-			next_llp =3D DMA_LLP_LMS(next_llp, DMA_LLP_AHBMASTER2);
+			if (hsdevp->hsdev->hostID =3D=3D APM_460EX_SATA) {
+				next_llp =3D DMA_LLP_LMS(next_llp,
+					DMA_LLP_AHBMASTER2);
+			} else {
+				next_llp =3D DMA_LLP_LMS(next_llp,
+					DMA_LLP_AHBMASTER1);
+			}
=20
 			lli[idx].llp =3D cpu_to_le32(next_llp);
 			idx++;
@@ -714,70 +766,49 @@ static int map_sg_to_lli(struct scatterlist *sg, =
int num_elems,
 static void dma_dwc_xfer_start(int dma_ch)
 {
 	/* Enable the DMA channel */
-	out_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low),
-		 in_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low)) |
+	out_le32(&(sata_dma_regs->dma_chan_en.low),
+		 in_le32(&(sata_dma_regs->dma_chan_en.low)) |
 		 DMA_ENABLE_CHAN(dma_ch));
 }
=20
-static int dma_dwc_xfer_setup(struct scatterlist *sg, int num_elems,
-			      struct lli *lli, dma_addr_t dma_lli,
-			      void __iomem *addr, int dir)
+
+static int dma_dwc_xfer_setup(struct ata_port *ap, dma_addr_t dma_lli)
 {
 	int dma_ch;
-	int num_lli;
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
 	/* Acquire DMA channel */
-	dma_ch =3D dma_request_channel();
+	dma_ch =3D dma_request_channel(ap);
 	if (dma_ch =3D=3D -1) {
-		dev_err(host_pvt.dwc_dev, "%s: dma channel unavailable\n",
-			 __func__);
+		dev_err(ap->dev, "%s: dma channel unavailable\n", __func__);
 		return -EAGAIN;
 	}
=20
-	/* Convert SG list to linked list of items (LLIs) for AHB DMA */
-	num_lli =3D map_sg_to_lli(sg, num_elems, lli, dma_lli, addr, dir);
-
-	dev_dbg(host_pvt.dwc_dev, "%s sg: 0x%p, count: %d lli: %p dma_lli:"
-		" 0x%0xlx addr: %p lli count: %d\n", __func__, sg, num_elems,
-		 lli, (u32)dma_lli, addr, num_lli);
-
 	clear_chan_interrupts(dma_ch);
=20
 	/* Program the CFG register. */
-	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].cfg.high),
+	out_le32(&(sata_dma_regs->chan_regs[dma_ch].cfg.high),
+		 DMA_CFG_HW_HS_SRC(dma_ch) | DMA_CFG_HW_HS_DEST(dma_ch) | \
 		 DMA_CFG_PROTCTL | DMA_CFG_FCMOD_REQ);
-	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].cfg.low), 0);
+
+	out_le32(&(sata_dma_regs->chan_regs[dma_ch].cfg.low),
+		DMA_CFG_HW_CH_PRIOR(dma_ch));
=20
 	/* Program the address of the linked list */
-	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].llp.low),
+	if (hsdev->hostID =3D=3D APM_460EX_SATA) {
+		out_le32(&(sata_dma_regs->chan_regs[dma_ch].llp.low),
 		 DMA_LLP_LMS(dma_lli, DMA_LLP_AHBMASTER2));
+	} else {
+		out_le32(&(sata_dma_regs->chan_regs[dma_ch].llp.low),
+			DMA_LLP_LMS(dma_lli, DMA_LLP_AHBMASTER1));
+	}
=20
 	/* Program the CTL register with src enable / dst enable */
-	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].ctl.low),
+	out_le32(&(sata_dma_regs->chan_regs[dma_ch].ctl.low),
 		 DMA_CTL_LLP_SRCEN | DMA_CTL_LLP_DSTEN);
 	return dma_ch;
 }
=20
 /*
- * Function: dma_dwc_exit
- * arguments: None
- * returns status
- * This function exits the SATA DMA driver
- */
-static void dma_dwc_exit(struct sata_dwc_device *hsdev)
-{
-	dev_dbg(host_pvt.dwc_dev, "%s:\n", __func__);
-	if (host_pvt.sata_dma_regs) {
-		iounmap(host_pvt.sata_dma_regs);
-		host_pvt.sata_dma_regs =3D NULL;
-	}
-
-	if (hsdev->irq_dma) {
-		free_irq(hsdev->irq_dma, hsdev);
-		hsdev->irq_dma =3D 0;
-	}
-}
-
-/*
  * Function: dma_dwc_init
  * arguments: hsdev
  * returns status
@@ -789,24 +820,18 @@ static int dma_dwc_init(struct sata_dwc_device *h=
sdev, int irq)
=20
 	err =3D dma_request_interrupts(hsdev, irq);
 	if (err) {
-		dev_err(host_pvt.dwc_dev, "%s: dma_request_interrupts returns"
-			" %d\n", __func__, err);
-		goto error_out;
+		dev_err(hsdev->dev, "%s: dma_request_interrupts returns %d\n",
+			__func__, err);
+		return err;
 	}
=20
 	/* Enabe DMA */
-	out_le32(&(host_pvt.sata_dma_regs->dma_cfg.low), DMA_EN);
+	out_le32(&(sata_dma_regs->dma_cfg.low), DMA_EN);
=20
-	dev_notice(host_pvt.dwc_dev, "DMA initialized\n");
-	dev_dbg(host_pvt.dwc_dev, "SATA DMA registers=3D0x%p\n", host_pvt.\
-		sata_dma_regs);
+	dev_notice(hsdev->dev, "DMA initialized\n");
+	dev_dbg(hsdev->dev, "SATA DMA registers=3D0x%p\n", sata_dma_regs);
=20
 	return 0;
-
-error_out:
-	dma_dwc_exit(hsdev);
-
-	return err;
 }
=20
 static int sata_dwc_scr_read(struct ata_link *link, unsigned int scr, =
u32 *val)
@@ -818,7 +843,7 @@ static int sata_dwc_scr_read(struct ata_link *link,=
 unsigned int scr, u32 *val)
 	}
=20
 	*val =3D in_le32((void *)link->ap->ioaddr.scr_addr + (scr * 4));
-	dev_dbg(link->ap->dev, "%s: id=3D%d reg=3D%d val=3Dval=3D0x%08x\n",
+	dev_dbg(link->ap->dev, "%s: id=3D%d reg=3D%d val=3D0x%08x\n",
 		__func__, link->ap->print_id, scr, *val);
=20
 	return 0;
@@ -838,23 +863,27 @@ static int sata_dwc_scr_write(struct ata_link *li=
nk, unsigned int scr, u32 val)
 	return 0;
 }
=20
-static u32 core_scr_read(unsigned int scr)
+static u32 core_scr_read(struct ata_port *ap, unsigned int scr)
 {
-	return in_le32((void __iomem *)(host_pvt.scr_addr_sstatus) +\
-			(scr * 4));
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
+
+	return in_le32((void __iomem *)hsdev->scr_base + (scr * 4));
 }
=20
-static void core_scr_write(unsigned int scr, u32 val)
+
+static void core_scr_write(struct ata_port *ap, unsigned int scr, u32 =
val)
 {
-	out_le32((void __iomem *)(host_pvt.scr_addr_sstatus) + (scr * 4),
-		val);
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
+
+	out_le32((void __iomem *)hsdev->scr_base + (scr * 4), val);
 }
=20
-static void clear_serror(void)
+static void clear_serror(struct ata_port *ap)
 {
-	u32 val;
-	val =3D core_scr_read(SCR_ERROR);
-	core_scr_write(SCR_ERROR, val);
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
+
+	out_le32((void __iomem *)hsdev->scr_base + 4,
+		in_le32((void __iomem *)hsdev->scr_base + 4));
=20
 }
=20
@@ -869,7 +898,6 @@ static u32 qcmd_tag_to_mask(u8 tag)
 	return 0x00000001 << (tag & 0x1f);
 }
=20
-/* See ahci.c */
 static void sata_dwc_error_intr(struct ata_port *ap,
 				struct sata_dwc_device *hsdev, uint intpr)
 {
@@ -883,24 +911,23 @@ static void sata_dwc_error_intr(struct ata_port *=
ap,
=20
 	ata_ehi_clear_desc(ehi);
=20
-	serror =3D core_scr_read(SCR_ERROR);
+	serror =3D core_scr_read(ap, SCR_ERROR);
 	status =3D ap->ops->sff_check_status(ap);
=20
-	err_reg =3D in_le32(&(host_pvt.sata_dma_regs->interrupt_status.error.=
\
+	err_reg =3D in_le32(&(sata_dma_regs->interrupt_status.error.\
 			low));
 	tag =3D ap->link.active_tag;
=20
 	dev_err(ap->dev, "%s SCR_ERROR=3D0x%08x intpr=3D0x%08x status=3D0x%08=
x "
-		"dma_intp=3D%d pending=3D%d issued=3D%d dma_err_status=3D0x%08x\n",
-		__func__, serror, intpr, status, host_pvt.dma_interrupt_count,
-		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag], err_reg);
+		" pending=3D%d dma_err_status=3D0x%08x\n",
+		__func__, serror, intpr, status, hsdevp->dma_pending[tag],
+		err_reg);
=20
 	/* Clear error register and interrupt bit */
-	clear_serror();
+	clear_serror(ap);
 	clear_interrupt_bit(hsdev, SATA_DWC_INTPR_ERR);
=20
 	/* This is the only error happening now.  TODO check for exact error =
*/
-
 	err_mask |=3D AC_ERR_HOST_BUS;
 	action |=3D ATA_EH_RESET;
=20
@@ -919,7 +946,7 @@ static void sata_dwc_error_intr(struct ata_port *ap=
,
=20
 /*
  * Function : sata_dwc_isr
- * arguments : irq, void *dev_instance, struct pt_regs *regs
+ * arguments : irq, void *dev_instance
  * Return value : irqreturn_t - status of IRQ
  * This Interrupt handler called via port ops registered function.
  * .irq_handler =3D sata_dwc_isr
@@ -930,14 +957,14 @@ static irqreturn_t sata_dwc_isr(int irq, void *de=
v_instance)
 	struct sata_dwc_device *hsdev =3D HSDEV_FROM_HOST(host);
 	struct ata_port *ap;
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
 	u8 status, tag;
-	int handled, num_processed, port =3D 0;
-	uint intpr, sactive, sactive2, tag_mask;
+	int handled, port =3D 0;
+	int num_lli;
+	uint intpr, sactive, tag_mask;
 	struct sata_dwc_device_port *hsdevp;
-	host_pvt.sata_dwc_sactive_issued =3D 0;
+	u32 mask;
=20
-	spin_lock_irqsave(&host->lock, flags);
+	spin_lock(&host->lock);
=20
 	/* Read the interrupt register */
 	intpr =3D in_le32(&hsdev->sata_dwc_regs->intpr);
@@ -960,29 +987,44 @@ static irqreturn_t sata_dwc_isr(int irq, void *de=
v_instance)
 		clear_interrupt_bit(hsdev, SATA_DWC_INTPR_NEWFP);
=20
 		tag =3D (u8)(in_le32(&hsdev->sata_dwc_regs->fptagr));
+		mask =3D qcmd_tag_to_mask(tag);
 		dev_dbg(ap->dev, "%s: NEWFP tag=3D%d\n", __func__, tag);
-		if (hsdevp->cmd_issued[tag] !=3D SATA_DWC_CMD_ISSUED_PEND)
+		if ((hsdevp->sactive_queued & mask) =3D=3D 0)
 			dev_warn(ap->dev, "CMD tag=3D%d not pending?\n", tag);
=20
-		host_pvt.sata_dwc_sactive_issued |=3D qcmd_tag_to_mask(tag);
-
 		qc =3D ata_qc_from_tag(ap, tag);
 		/*
 		 * Start FP DMA for NCQ command.  At this point the tag is the
 		 * active tag.  It is the tag that matches the command about to
 		 * be completed.
 		 */
-		qc->ap->link.active_tag =3D tag;
-		sata_dwc_bmdma_start_by_tag(qc, tag);
+		if (qc) {
+			hsdevp->sactive_issued |=3D mask;
+			/* Prevent to issue more commands */
+			qc->ap->link.active_tag =3D tag;
+			qc->dev->link->sactive |=3D (1 << qc->tag);
+			num_lli =3D map_sg_to_lli(ap, qc->sg, qc->n_elem, \
+				hsdevp->llit[tag], hsdevp->llit_dma[tag], \
+				(void *__iomem)(&hsdev->sata_dwc_regs->dmadr), \
+				qc->dma_dir);
+			sata_dwc_bmdma_start_by_tag(qc, tag);
+			wmb();
+			qc->ap->hsm_task_state =3D HSM_ST_LAST;
+		} else {
+			hsdevp->sactive_issued &=3D ~mask;
+			dev_warn(ap->dev, "No QC available for tag %d (intpr=3D"
+				"0x%08x, qc_allocated=3D0x%08x)\n", tag, intpr,
+				ap->qc_allocated);
+		}
=20
 		handled =3D 1;
 		goto DONE;
 	}
-	sactive =3D core_scr_read(SCR_ACTIVE);
-	tag_mask =3D (host_pvt.sata_dwc_sactive_issued | sactive) ^ sactive;
+	sactive =3D core_scr_read(ap, SCR_ACTIVE);
+	tag_mask =3D (hsdevp->sactive_issued | sactive) ^ sactive;
=20
 	/* If no sactive issued and tag_mask is zero then this is not NCQ */
-	if (host_pvt.sata_dwc_sactive_issued =3D=3D 0 && tag_mask =3D=3D 0) {
+	if (hsdevp->sactive_issued =3D=3D 0 && tag_mask =3D=3D 0) {
 		if (ap->link.active_tag =3D=3D ATA_TAG_POISON)
 			tag =3D 0;
 		else
@@ -999,9 +1041,6 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev=
_instance)
 		}
 		status =3D ap->ops->sff_check_status(ap);
=20
-		qc->ap->link.active_tag =3D tag;
-		hsdevp->cmd_issued[tag] =3D SATA_DWC_CMD_ISSUED_NOT;
-
 		if (status & ATA_ERR) {
 			dev_dbg(ap->dev, "interrupt ATA_ERR (0x%x)\n", status);
 			sata_dwc_qc_complete(ap, qc, 1);
@@ -1012,28 +1051,12 @@ static irqreturn_t sata_dwc_isr(int irq, void *=
dev_instance)
 		dev_dbg(ap->dev, "%s non-NCQ cmd interrupt, protocol: %s\n",
 			__func__, get_prot_descript(qc->tf.protocol));
 DRVSTILLBUSY:
+		/* Do complete action for the current QC */
 		if (ata_is_dma(qc->tf.protocol)) {
-			/*
-			 * Each DMA transaction produces 2 interrupts. The DMAC
-			 * transfer complete interrupt and the SATA controller
-			 * operation done interrupt. The command should be
-			 * completed only after both interrupts are seen.
-			 */
-			host_pvt.dma_interrupt_count++;
-			if (hsdevp->dma_pending[tag] =3D=3D \
-					SATA_DWC_DMA_PENDING_NONE) {
-				dev_err(ap->dev, "%s: DMA not pending "
-					"intpr=3D0x%08x status=3D0x%08x pending"
-					"=3D%d\n", __func__, intpr, status,
-					hsdevp->dma_pending[tag]);
-			}
-
-			if ((host_pvt.dma_interrupt_count % 2) =3D=3D 0)
-				sata_dwc_dma_xfer_complete(ap, 1);
-		} else if (ata_is_pio(qc->tf.protocol)) {
+			sata_dwc_qc_complete(ap, qc, 1);
+		} else if ((ata_is_pio(qc->tf.protocol)) ||
+			(ata_is_nodata(qc->tf.protocol))) {
 			ata_sff_hsm_move(ap, qc, status, 0);
-			handled =3D 1;
-			goto DONE;
 		} else {
 			if (unlikely(sata_dwc_qc_complete(ap, qc, 1)))
 				goto DRVSTILLBUSY;
@@ -1049,23 +1072,18 @@ DRVSTILLBUSY:
 	 * as completion for more than one operation when commands are queued
 	 * (NCQ).  We need to process each completed command.
 	 */
-
-	 /* process completed commands */
-	sactive =3D core_scr_read(SCR_ACTIVE);
-	tag_mask =3D (host_pvt.sata_dwc_sactive_issued | sactive) ^ sactive;
-
-	if (sactive !=3D 0 || (host_pvt.sata_dwc_sactive_issued) > 1 || \
+	if (sactive !=3D 0 || hsdevp->sactive_issued > 1 || \
 							tag_mask > 1) {
 		dev_dbg(ap->dev, "%s NCQ:sactive=3D0x%08x  sactive_issued=3D0x%08x"
 			"tag_mask=3D0x%08x\n", __func__, sactive,
-			host_pvt.sata_dwc_sactive_issued, tag_mask);
+			hsdevp->sactive_issued, tag_mask);
 	}
=20
-	if ((tag_mask | (host_pvt.sata_dwc_sactive_issued)) !=3D \
-					(host_pvt.sata_dwc_sactive_issued)) {
+	if ((tag_mask | hsdevp->sactive_issued) !=3D \
+					hsdevp->sactive_issued) {
 		dev_warn(ap->dev, "Bad tag mask?  sactive=3D0x%08x "
-			 "(host_pvt.sata_dwc_sactive_issued)=3D0x%08x  tag_mask"
-			 "=3D0x%08x\n", sactive, host_pvt.sata_dwc_sactive_issued,
+			 "sactive_issued=3D0x%08x  tag_mask"
+			 "=3D0x%08x\n", sactive, hsdevp->sactive_issued,
 			  tag_mask);
 	}
=20
@@ -1073,70 +1091,21 @@ DRVSTILLBUSY:
 	status =3D ap->ops->sff_check_status(ap);
 	dev_dbg(ap->dev, "%s ATA status register=3D0x%x\n", __func__, status)=
;
=20
-	tag =3D 0;
-	num_processed =3D 0;
-	while (tag_mask) {
-		num_processed++;
-		while (!(tag_mask & 0x00000001)) {
-			tag++;
-			tag_mask <<=3D 1;
-		}
-
-		tag_mask &=3D (~0x00000001);
-		qc =3D ata_qc_from_tag(ap, tag);
-
-		/* To be picked up by completion functions */
-		qc->ap->link.active_tag =3D tag;
-		hsdevp->cmd_issued[tag] =3D SATA_DWC_CMD_ISSUED_NOT;
-
-		/* Let libata/scsi layers handle error */
-		if (status & ATA_ERR) {
-			dev_dbg(ap->dev, "%s ATA_ERR (0x%x)\n", __func__,
-				status);
+	for (tag =3D 0; tag < 32; tag++) {
+		if (tag_mask & qcmd_tag_to_mask(tag)) {
+			qc =3D ata_qc_from_tag(ap, tag);
+			if (!qc) {
+				dev_info(ap->dev, "error: Tag %d is set but " \
+					"not available\n", tag);
+				continue;
+			}
 			sata_dwc_qc_complete(ap, qc, 1);
-			handled =3D 1;
-			goto DONE;
 		}
-
-		/* Process completed command */
-		dev_dbg(ap->dev, "%s NCQ command, protocol: %s\n", __func__,
-			get_prot_descript(qc->tf.protocol));
-		if (ata_is_dma(qc->tf.protocol)) {
-			host_pvt.dma_interrupt_count++;
-			if (hsdevp->dma_pending[tag] =3D=3D \
-					SATA_DWC_DMA_PENDING_NONE)
-				dev_warn(ap->dev, "%s: DMA not pending?\n",
-					__func__);
-			if ((host_pvt.dma_interrupt_count % 2) =3D=3D 0)
-				sata_dwc_dma_xfer_complete(ap, 1);
-		} else {
-			if (unlikely(sata_dwc_qc_complete(ap, qc, 1)))
-				goto STILLBUSY;
-		}
-		continue;
-
-STILLBUSY:
-		ap->stats.idle_irq++;
-		dev_warn(ap->dev, "STILL BUSY IRQ ata%d: irq trap\n",
-			ap->print_id);
-	} /* while tag_mask */
-
-	/*
-	 * Check to see if any commands completed while we were processing ou=
r
-	 * initial set of completed commands (read status clears interrupts,
-	 * so we might miss a completed command interrupt if one came in whil=
e
-	 * we were processing --we read status as part of processing a comple=
ted
-	 * command).
-	 */
-	sactive2 =3D core_scr_read(SCR_ACTIVE);
-	if (sactive2 !=3D sactive) {
-		dev_dbg(ap->dev, "More completed - sactive=3D0x%x sactive2"
-			"=3D0x%x\n", sactive, sactive2);
 	}
 	handled =3D 1;
=20
 DONE:
-	spin_unlock_irqrestore(&host->lock, flags);
+	spin_unlock(&host->lock);
 	return IRQ_RETVAL(handled);
 }
=20
@@ -1157,7 +1126,7 @@ static void sata_dwc_clear_dmacr(struct sata_dwc_=
device_port *hsdevp, u8 tag)
 		 * This should not happen, it indicates the driver is out of
 		 * sync.  If it does happen, clear dmacr anyway.
 		 */
-		dev_err(host_pvt.dwc_dev, "%s DMA protocol RX and"
+		dev_err(hsdev->dev, "%s DMA protocol RX and"
 			"TX DMA not pending tag=3D0x%02x pending=3D%d"
 			" dmacr: 0x%08x\n", __func__, tag,
 			hsdevp->dma_pending[tag],
@@ -1167,44 +1136,6 @@ static void sata_dwc_clear_dmacr(struct sata_dwc=
_device_port *hsdevp, u8 tag)
 	}
 }
=20
-static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_=
status)
-{
-	struct ata_queued_cmd *qc;
-	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
-	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
-	u8 tag =3D 0;
-
-	tag =3D ap->link.active_tag;
-	qc =3D ata_qc_from_tag(ap, tag);
-	if (!qc) {
-		dev_err(ap->dev, "failed to get qc");
-		return;
-	}
-
-#ifdef DEBUG_NCQ
-	if (tag > 0) {
-		dev_info(ap->dev, "%s tag=3D%u cmd=3D0x%02x dma dir=3D%s proto=3D%s =
"
-			 "dmacr=3D0x%08x\n", __func__, qc->tag, qc->tf.command,
-			 get_dma_dir_descript(qc->dma_dir),
-			 get_prot_descript(qc->tf.protocol),
-			 in_le32(&(hsdev->sata_dwc_regs->dmacr)));
-	}
-#endif
-
-	if (ata_is_dma(qc->tf.protocol)) {
-		if (hsdevp->dma_pending[tag] =3D=3D SATA_DWC_DMA_PENDING_NONE) {
-			dev_err(ap->dev, "%s DMA protocol RX and TX DMA not "
-				"pending dmacr: 0x%08x\n", __func__,
-				in_le32(&(hsdev->sata_dwc_regs->dmacr)));
-		}
-
-		hsdevp->dma_pending[tag] =3D SATA_DWC_DMA_PENDING_NONE;
-		sata_dwc_qc_complete(ap, qc, check_status);
-		ap->link.active_tag =3D ATA_TAG_POISON;
-	} else {
-		sata_dwc_qc_complete(ap, qc, check_status);
-	}
-}
=20
 static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued=
_cmd *qc,
 				u32 check_status)
@@ -1213,24 +1144,39 @@ static int sata_dwc_qc_complete(struct ata_port=
 *ap, struct ata_queued_cmd *qc,
 	u32 mask =3D 0x0;
 	u8 tag =3D qc->tag;
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
-	host_pvt.sata_dwc_sactive_queued =3D 0;
+	int i;
+
 	dev_dbg(ap->dev, "%s checkstatus? %x\n", __func__, check_status);
=20
-	if (hsdevp->dma_pending[tag] =3D=3D SATA_DWC_DMA_PENDING_TX)
-		dev_err(ap->dev, "TX DMA PENDING\n");
-	else if (hsdevp->dma_pending[tag] =3D=3D SATA_DWC_DMA_PENDING_RX)
-		dev_err(ap->dev, "RX DMA PENDING\n");
+	/* Check main status, clearing INTRQ */
+	status =3D ap->ops->sff_check_status(ap);
+
+	if (check_status) {
+		/* Make sure SATA port is not in BUSY state */
+		i =3D 0;
+		while (status & ATA_BUSY) {
+			if (++i > 10)
+				break;
+			status =3D ap->ops->sff_check_altstatus(ap);
+		};
+
+		if (unlikely(status & ATA_BUSY))
+			dev_err(ap->dev, "QC complete cmd=3D0x%02x STATUS BUSY "
+				"(0x%02x) [%d]\n", qc->tf.command, status, i);
+	}
 	dev_dbg(ap->dev, "QC complete cmd=3D0x%02x status=3D0x%02x ata%u:"
 		" protocol=3D%d\n", qc->tf.command, status, ap->print_id,
 		 qc->tf.protocol);
=20
 	/* clear active bit */
 	mask =3D (~(qcmd_tag_to_mask(tag)));
-	host_pvt.sata_dwc_sactive_queued =3D (host_pvt.sata_dwc_sactive_queue=
d) \
-						& mask;
-	host_pvt.sata_dwc_sactive_issued =3D (host_pvt.sata_dwc_sactive_issue=
d) \
-						& mask;
+	hsdevp->sactive_issued &=3D ~mask;
+
 	ata_qc_complete(qc);
+
+	if (hsdevp->sactive_queued =3D=3D 0)
+		ap->link.active_tag =3D ATA_TAG_POISON;
+
 	return 0;
 }
=20
@@ -1248,7 +1194,7 @@ static void sata_dwc_enable_interrupts(struct sat=
a_dwc_device *hsdev)
 	 */
 	out_le32(&hsdev->sata_dwc_regs->errmr, SATA_DWC_SERROR_ERR_BITS);
=20
-	dev_dbg(host_pvt.dwc_dev, "%s: INTMR =3D 0x%08x, ERRMR =3D 0x%08x\n",
+	dev_dbg(hsdev->dev, "%s: INTMR =3D 0x%08x, ERRMR =3D 0x%08x\n",
 		 __func__, in_le32(&hsdev->sata_dwc_regs->intmr),
 		in_le32(&hsdev->sata_dwc_regs->errmr));
 }
@@ -1310,9 +1256,6 @@ static int sata_dwc_port_start(struct ata_port *a=
p)
 	}
 	hsdevp->hsdev =3D hsdev;
=20
-	for (i =3D 0; i < SATA_DWC_QCMD_MAX; i++)
-		hsdevp->cmd_issued[i] =3D SATA_DWC_CMD_ISSUED_NOT;
-
 	ap->bmdma_prd =3D 0;	/* set these so libata doesn't use them */
 	ap->bmdma_prd_dma =3D 0;
=20
@@ -1329,7 +1272,7 @@ static int sata_dwc_port_start(struct ata_port *a=
p)
 			dev_err(ap->dev, "%s: dma_alloc_coherent failed\n",
 				 __func__);
 			err =3D -ENOMEM;
-			goto CLEANUP_ALLOC;
+			goto CLEANUP;
 		}
 	}
=20
@@ -1347,15 +1290,16 @@ static int sata_dwc_port_start(struct ata_port =
*ap)
 	}
=20
 	/* Clear any error bits before libata starts issuing commands */
-	clear_serror();
+	clear_serror(ap);
 	ap->private_data =3D hsdevp;
 	dev_dbg(ap->dev, "%s: done\n", __func__);
 	return 0;
=20
-CLEANUP_ALLOC:
-	kfree(hsdevp);
 CLEANUP:
-	dev_dbg(ap->dev, "%s: fail. ap->id =3D %d\n", __func__, ap->print_id)=
;
+	sata_dwc_port_stop(ap);
+	kfree(hsdevp);
+	dev_dbg(ap->dev, "%s: fail\n", __func__);
+
 	return err;
 }
=20
@@ -1382,14 +1326,14 @@ static void sata_dwc_port_stop(struct ata_port =
*ap)
=20
 /*
  * Function : sata_dwc_exec_command_by_tag
- * arguments : ata_port *ap, ata_taskfile *tf, u8 tag, u32 cmd_issued
+ * arguments : ata_port *ap, ata_taskfile *tf, u8 tag
  * Return value : None
  * This function keeps track of individual command tag ids and calls
  * ata_exec_command in libata
  */
 static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
 					 struct ata_taskfile *tf,
-					 u8 tag, u32 cmd_issued)
+					 u8 tag)
 {
 	unsigned long flags;
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
@@ -1398,7 +1342,7 @@ static void sata_dwc_exec_command_by_tag(struct a=
ta_port *ap,
 		ata_get_cmd_descript(tf->command), tag);
=20
 	spin_lock_irqsave(&ap->host->lock, flags);
-	hsdevp->cmd_issued[tag] =3D cmd_issued;
+	hsdevp->sactive_queued |=3D qcmd_tag_to_mask(tag);
 	spin_unlock_irqrestore(&ap->host->lock, flags);
 	/*
 	 * Clear SError before executing a new command.
@@ -1406,15 +1350,10 @@ static void sata_dwc_exec_command_by_tag(struct=
 ata_port *ap,
 	 * managed SError register for the disk needs to be done before the
 	 * task file is loaded.
 	 */
-	clear_serror();
+	clear_serror(ap);
 	ata_sff_exec_command(ap, tf);
 }
=20
-static void sata_dwc_bmdma_setup_by_tag(struct ata_queued_cmd *qc, u8 =
tag)
-{
-	sata_dwc_exec_command_by_tag(qc->ap, &qc->tf, tag,
-				     SATA_DWC_CMD_ISSUED_PEND);
-}
=20
 static void sata_dwc_bmdma_setup(struct ata_queued_cmd *qc)
 {
@@ -1426,7 +1365,8 @@ static void sata_dwc_bmdma_setup(struct ata_queue=
d_cmd *qc)
 	} else {
 		tag =3D 0;
 	}
-	sata_dwc_bmdma_setup_by_tag(qc, tag);
+
+	sata_dwc_exec_command_by_tag(qc->ap, &qc->tf, tag);
 }
=20
 static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 =
tag)
@@ -1437,28 +1377,37 @@ static void sata_dwc_bmdma_start_by_tag(struct =
ata_queued_cmd *qc, u8 tag)
 	struct ata_port *ap =3D qc->ap;
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
 	int dir =3D qc->dma_dir;
-	dma_chan =3D hsdevp->dma_chan[tag];
=20
-	if (hsdevp->cmd_issued[tag] !=3D SATA_DWC_CMD_ISSUED_NOT) {
+	/* Configure DMA before starting data transfer */
+	dma_chan =3D dma_dwc_xfer_setup(ap, hsdevp->llit_dma[tag]);
+	if (unlikely(dma_chan < 0)) {
+		dev_err(ap->dev, "%s: dma channel unavailable\n", __func__);
+		/* Offending this QC as no channel available for transfer */
+		qc->err_mask |=3D AC_ERR_TIMEOUT;
+		return;
+	}
+
+	/* Check if DMA should be started */
+	hsdevp->dma_chan[tag] =3D dma_chan;
+	if (hsdevp->sactive_queued & qcmd_tag_to_mask(tag)) {
 		start_dma =3D 1;
 		if (dir =3D=3D DMA_TO_DEVICE)
 			hsdevp->dma_pending[tag] =3D SATA_DWC_DMA_PENDING_TX;
 		else
 			hsdevp->dma_pending[tag] =3D SATA_DWC_DMA_PENDING_RX;
 	} else {
-		dev_err(ap->dev, "%s: Command not pending cmd_issued=3D%d "
-			"(tag=3D%d) DMA NOT started\n", __func__,
-			hsdevp->cmd_issued[tag], tag);
+		dev_err(ap->dev, "%s: No pending cmd at tag %d\n",
+			__func__, tag);
 		start_dma =3D 0;
 	}
=20
 	dev_dbg(ap->dev, "%s qc=3D%p tag: %x cmd: 0x%02x dma_dir: %s "
 		"start_dma? %x\n", __func__, qc, tag, qc->tf.command,
 		get_dma_dir_descript(qc->dma_dir), start_dma);
-	sata_dwc_tf_dump(&(qc->tf));
+	sata_dwc_tf_dump(hsdev->dev, &qc->tf);
=20
 	if (start_dma) {
-		reg =3D core_scr_read(SCR_ERROR);
+		reg =3D core_scr_read(qc->ap, SCR_ERROR);
 		if (reg & SATA_DWC_SERROR_ERR_BITS) {
 			dev_err(ap->dev, "%s: ****** SError=3D0x%08x ******\n",
 				__func__, reg);
@@ -1473,6 +1422,7 @@ static void sata_dwc_bmdma_start_by_tag(struct at=
a_queued_cmd *qc, u8 tag)
=20
 		/* Enable AHB DMA transfer on the specified channel */
 		dma_dwc_xfer_start(dma_chan);
+		hsdevp->sactive_queued &=3D ~qcmd_tag_to_mask(tag);
 	}
 }
=20
@@ -1490,6 +1440,49 @@ static void sata_dwc_bmdma_start(struct ata_queu=
ed_cmd *qc)
 	sata_dwc_bmdma_start_by_tag(qc, tag);
 }
=20
+static void sata_dwc_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap =3D qc->ap;
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
+	int dma_ch, enabled;
+
+	dma_ch =3D hsdev->dma_channel;
+	enabled =3D sata_dwc_dma_chk_en(dma_ch);
+
+	if (enabled) {
+		dev_dbg(ap->dev,
+			"%s terminate DMA on channel=3D%d (mask=3D0x%08x) ...",
+			__func__, dma_ch, DMA_DISABLE_CHAN(dma_ch));
+		/* Disable the selected channel */
+		out_le32(&(sata_dma_regs->dma_chan_en.low),
+			DMA_DISABLE_CHAN(dma_ch));
+
+		/* Wait for the channel is disabled */
+		do {
+			enabled =3D sata_dwc_dma_chk_en(dma_ch);
+			ndelay(1000);
+		} while (enabled);
+		dev_dbg(ap->dev, "done\n");
+	}
+}
+
+static u8 sata_dwc_bmdma_status(struct ata_port *ap)
+{
+	u32 status =3D 0;
+	u32 tfr_reg, err_reg;
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
+
+	/* Check DMA register for status */
+	tfr_reg =3D in_le32(&(sata_dma_regs->interrupt_status.tfr.low));
+	err_reg =3D in_le32(&(sata_dma_regs->interrupt_status.error.low));
+
+	if (unlikely(err_reg & DMA_CHANNEL(hsdev->dma_channel)))
+		status =3D ATA_DMA_ERR;
+	else if (tfr_reg & DMA_CHANNEL(hsdev->dma_channel))
+		status =3D ATA_DMA_INTR;
+	return status;
+}
+
 /*
  * Function : sata_dwc_qc_prep_by_tag
  * arguments : ata_queued_cmd *qc, u8 tag
@@ -1500,24 +1493,22 @@ static void sata_dwc_qc_prep_by_tag(struct ata_=
queued_cmd *qc, u8 tag)
 {
 	struct scatterlist *sg =3D qc->sg;
 	struct ata_port *ap =3D qc->ap;
-	int dma_chan;
+	int num_lli;
 	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
=20
+	if ((qc->dma_dir =3D=3D DMA_NONE) || (qc->tf.protocol =3D=3D ATA_PROT=
_PIO))
+		return;
 	dev_dbg(ap->dev, "%s: port=3D%d dma dir=3D%s n_elem=3D%d\n",
 		__func__, ap->port_no, get_dma_dir_descript(qc->dma_dir),
 		 qc->n_elem);
=20
-	dma_chan =3D dma_dwc_xfer_setup(sg, qc->n_elem, hsdevp->llit[tag],
-				      hsdevp->llit_dma[tag],
-				      (void *__iomem)(&hsdev->sata_dwc_regs->\
-				      dmadr), qc->dma_dir);
-	if (dma_chan < 0) {
-		dev_err(ap->dev, "%s: dma_dwc_xfer_setup returns err %d\n",
-			__func__, dma_chan);
-		return;
+	if (!ata_is_ncq(qc->tf.protocol)) {
+		num_lli =3D map_sg_to_lli(qc->ap, sg, qc->n_elem,
+			hsdevp->llit[tag], hsdevp->llit_dma[tag],
+			(void *__iomem)(&hsdev->sata_dwc_regs->dmadr),
+			qc->dma_dir);
 	}
-	hsdevp->dma_chan[tag] =3D dma_chan;
 }
=20
 static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
@@ -1541,19 +1532,18 @@ static unsigned int sata_dwc_qc_issue(struct at=
a_queued_cmd *qc)
 	sata_dwc_qc_prep_by_tag(qc, tag);
=20
 	if (ata_is_ncq(qc->tf.protocol)) {
-		sactive =3D core_scr_read(SCR_ACTIVE);
+		/* Update SActive register for new command */
+		sactive =3D core_scr_read(qc->ap, SCR_ACTIVE);
 		sactive |=3D (0x00000001 << tag);
-		core_scr_write(SCR_ACTIVE, sactive);
-
-		dev_dbg(qc->ap->dev, "%s: tag=3D%d ap->link.sactive =3D 0x%08x "
-			"sactive=3D0x%08x\n", __func__, tag, qc->ap->link.sactive,
-			sactive);
+		core_scr_write(qc->ap, SCR_ACTIVE, sactive);
+		qc->dev->link->sactive |=3D 0x00000001 << tag;
=20
 		ap->ops->sff_tf_load(ap, &qc->tf);
-		sata_dwc_exec_command_by_tag(ap, &qc->tf, qc->tag,
-					     SATA_DWC_CMD_ISSUED_PEND);
+		sata_dwc_exec_command_by_tag(ap, &qc->tf, qc->tag);
 	} else {
-		ata_sff_qc_issue(qc);
+		/* As ata_sff_qc_issue is no longer handle DMA transfer,
+		 * change to use ata_bmdma_qc_issue instead */
+		ata_bmdma_qc_issue(qc);
 	}
 	return 0;
 }
@@ -1582,7 +1572,12 @@ static void sata_dwc_qc_prep(struct ata_queued_c=
md *qc)
 static void sata_dwc_error_handler(struct ata_port *ap)
 {
 	ap->link.flags |=3D ATA_LFLAG_NO_HRST;
-	ata_sff_error_handler(ap);
+	ata_bmdma_error_handler(ap);
+}
+
+u8 sata_dwc_check_altstatus(struct ata_port *ap)
+{
+	return ioread8(ap->ioaddr.altstatus_addr);
 }
=20
 /*
@@ -1616,6 +1611,10 @@ static struct ata_port_operations sata_dwc_ops =3D=
 {
=20
 	.bmdma_setup		=3D sata_dwc_bmdma_setup,
 	.bmdma_start		=3D sata_dwc_bmdma_start,
+	.bmdma_stop		=3D sata_dwc_bmdma_stop,
+	.bmdma_status		=3D sata_dwc_bmdma_status,
+
+	.sff_check_altstatus	=3D sata_dwc_check_altstatus,
 };
=20
 static const struct ata_port_info sata_dwc_port_info[] =3D {
@@ -1638,13 +1637,38 @@ static int sata_dwc_probe(struct platform_devic=
e *ofdev)
 	struct ata_host *host;
 	struct ata_port_info pi =3D sata_dwc_port_info[0];
 	const struct ata_port_info *ppi[] =3D { &pi, NULL };
+	const unsigned int *dma_chan;
+
+	/* Check if device is declared in device tree */
+	if (!of_device_is_available(ofdev->dev.of_node)) {
+		printk(KERN_INFO "%s: Port disabled via device-tree\n",
+		ofdev->dev.of_node->full_name);
+		return 0;
+	}
=20
 	/* Allocate DWC SATA device */
 	hsdev =3D kzalloc(sizeof(*hsdev), GFP_KERNEL);
 	if (hsdev =3D=3D NULL) {
 		dev_err(&ofdev->dev, "kmalloc failed for hsdev\n");
 		err =3D -ENOMEM;
-		goto error;
+		goto error_out_5;
+	}
+
+	/* Identify host controller using compatible attribute */
+	if (of_device_is_compatible(ofdev->dev.of_node, "amcc,sata-apm821xx")=
) {
+		printk(KERN_INFO "SATA is compatible for sata-821xx\n");
+		hsdev->hostID =3D APM_821XX_SATA;
+	} else {
+		printk(KERN_INFO "SATA is compatible for sata-460ex\n");
+		hsdev->hostID =3D APM_460EX_SATA;
+	}
+
+	dma_chan =3D of_get_property(ofdev->dev.of_node, "dma-channel", NULL)=
;
+	if (dma_chan) {
+		dev_notice(&ofdev->dev, "Getting DMA channel %d\n", *dma_chan);
+		hsdev->dma_channel =3D *dma_chan;
+	} else {
+		hsdev->dma_channel =3D 0;
 	}
=20
 	/* Ioremap SATA registers */
@@ -1653,7 +1677,7 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
 		dev_err(&ofdev->dev, "ioremap failed for SATA register"
 			" address\n");
 		err =3D -ENODEV;
-		goto error_kmalloc;
+		goto error_out_4;
 	}
 	hsdev->reg_base =3D base;
 	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
@@ -1666,7 +1690,7 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
 	if (!host) {
 		dev_err(&ofdev->dev, "ata_host_alloc_pinfo failed\n");
 		err =3D -ENOMEM;
-		goto error_iomap;
+		goto error_out_4;
 	}
=20
 	host->private_data =3D hsdev;
@@ -1674,7 +1698,7 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
 	/* Setup port */
 	host->ports[0]->ioaddr.cmd_addr =3D base;
 	host->ports[0]->ioaddr.scr_addr =3D base + SATA_DWC_SCR_OFFSET;
-	host_pvt.scr_addr_sstatus =3D base + SATA_DWC_SCR_OFFSET;
+	hsdev->scr_base =3D (u8 *)(base + SATA_DWC_SCR_OFFSET);
 	sata_dwc_setup_port(&host->ports[0]->ioaddr, (unsigned long)base);
=20
 	/* Read the ID and Version Registers */
@@ -1688,23 +1712,30 @@ static int sata_dwc_probe(struct platform_devic=
e *ofdev)
 	if (irq =3D=3D NO_IRQ) {
 		dev_err(&ofdev->dev, "no SATA DMA irq\n");
 		err =3D -ENODEV;
-		goto error_out;
-	}
-
-	/* Get physical SATA DMA register base address */
-	host_pvt.sata_dma_regs =3D of_iomap(ofdev->dev.of_node, 1);
-	if (!(host_pvt.sata_dma_regs)) {
-		dev_err(&ofdev->dev, "ioremap failed for AHBDMA register"
-			" address\n");
-		err =3D -ENODEV;
-		goto error_out;
+		goto error_out_3;
 	}
=20
 	/* Save dev for later use in dev_xxx() routines */
-	host_pvt.dwc_dev =3D &ofdev->dev;
+	hsdev->dev =3D &ofdev->dev;
=20
-	/* Initialize AHB DMAC */
-	dma_dwc_init(hsdev, irq);
+	/* Init glovbal dev list */
+	dwc_dev_list[hsdev->dma_channel] =3D hsdev;
+
+	/* Get physical SATA DMA register base address */
+	if (sata_dma_regs =3D=3D NULL) {
+		sata_dma_regs =3D of_iomap(ofdev->dev.of_node, 1);
+		if (sata_dma_regs =3D=3D NULL) {
+			dev_err(&ofdev->dev,
+				"ioremap failed for AHBDMA register address\n");
+			err =3D -ENODEV;
+			goto error_out_2;
+		}
+
+		/* Initialize AHB DMAC */
+		rc =3D dma_dwc_init(hsdev, irq);
+		if (rc !=3D 0)
+			goto error_out_1;
+	}
=20
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
@@ -1714,7 +1745,7 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
 	if (irq =3D=3D NO_IRQ) {
 		dev_err(&ofdev->dev, "no SATA DMA irq\n");
 		err =3D -ENODEV;
-		goto error_out;
+		goto error_out_1;
 	}
=20
 	/*
@@ -1730,15 +1761,19 @@ static int sata_dwc_probe(struct platform_devic=
e *ofdev)
 	dev_set_drvdata(&ofdev->dev, host);
 	return 0;
=20
-error_out:
-	/* Free SATA DMA resources */
-	dma_dwc_exit(hsdev);
+error_out_1:
+	iounmap(sata_dma_regs);
=20
-error_iomap:
+error_out_2:
+	free_irq(hsdev->irq_dma, hsdev);
+
+error_out_3:
 	iounmap(base);
-error_kmalloc:
+
+error_out_4:
 	kfree(hsdev);
-error:
+
+error_out_5:
 	return err;
 }
=20
@@ -1752,8 +1787,10 @@ static int sata_dwc_remove(struct platform_devic=
e *ofdev)
 	dev_set_drvdata(dev, NULL);
=20
 	/* Free SATA DMA resources */
-	dma_dwc_exit(hsdev);
+	iounmap(sata_dma_regs);
+	free_irq(hsdev->irq_dma, hsdev);
=20
+	/* Free internal resources */
 	iounmap(hsdev->reg_base);
 	kfree(hsdev);
 	kfree(host);
@@ -1763,6 +1800,7 @@ static int sata_dwc_remove(struct platform_device=
 *ofdev)
=20
 static const struct of_device_id sata_dwc_match[] =3D {
 	{ .compatible =3D "amcc,sata-460ex", },
+	{ .compatible =3D "amcc,sata-apm821xx", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sata_dwc_match);
--=20
1.7.3.4

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments,=
=20
is for the sole use of the intended recipient(s) and contains informati=
on=A0
that is confidential and proprietary to AppliedMicro Corporation or its=
 subsidiaries.=20
It is to be used solely for the purpose of furthering the parties' busi=
ness relationship.=20
All unauthorized review, use, disclosure or distribution is prohibited.=
=20
If you are not the intended recipient, please contact the sender by rep=
ly e-mail=20
and destroy all copies of the original message.

