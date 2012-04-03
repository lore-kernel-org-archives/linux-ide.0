From: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename from sata_dwc_460ex.c to sata_dwc_4xx.c
Date: Tue,  3 Apr 2012 17:12:18 +0700
Message-ID: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, "Thang Q. Nguyen" <tqnguyen@apm.com>
List-Id: linux-ide@vger.kernel.org


Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
---
Changes for v2:
	- Use git rename feature to change the driver to the newname and for
	  easier review.

 arch/powerpc/boot/dts/bluestone.dts              |   21 +
 drivers/ata/Makefile                             |    2 +-
 drivers/ata/{sata_dwc_460ex.c =3D> sata_dwc_4xx.c} | 1371 ++++++++++++=
++--------
 3 files changed, 904 insertions(+), 490 deletions(-)
 rename drivers/ata/{sata_dwc_460ex.c =3D> sata_dwc_4xx.c} (56%)

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dt=
s/bluestone.dts
index cfa23bf..803fda6 100644
--- a/arch/powerpc/boot/dts/bluestone.dts
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -155,6 +155,27 @@
 					/*RXDE*/  0x5 0x4>;
 		};
=20
+		/* SATA DWC devices */
+		SATA0: sata@bffd1000 {
+			compatible =3D "amcc,sata-apm821xx";
+			reg =3D <4 0xbffd1000 0x800   /* SATA0 */
+			       4 0xbffd0800 0x400>; /* AHBDMA */
+			dma-channel=3D<0>;
+			interrupt-parent =3D <&UIC0>;
+			interrupts =3D <26 4    /* SATA0 */
+			              25 4>;  /* AHBDMA */
+		};
+
+		SATA1: sata@bffd1800 {
+			compatible =3D "amcc,sata-apm821xx";
+			reg =3D <4 0xbffd1800 0x800   /* SATA1 */
+			       4 0xbffd0800 0x400>; /* AHBDMA */
+			dma-channel=3D<1>;
+			interrupt-parent =3D <&UIC0>;
+			interrupts =3D <27 4    /* SATA1 */
+			              25 4>;  /* AHBDMA */
+		};
+
 		POB0: opb {
 			compatible =3D "ibm,opb";
 			#address-cells =3D <1>;
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
similarity index 56%
rename from drivers/ata/sata_dwc_460ex.c
rename to drivers/ata/sata_dwc_4xx.c
index 69f7cde..bdbb35a 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_4xx.c
@@ -1,5 +1,5 @@
 /*
- * drivers/ata/sata_dwc_460ex.c
+ * drivers/ata/sata_dwc_4xx.c
  *
  * Synopsys DesignWare Cores (DWC) SATA host driver
  *
@@ -16,6 +16,13 @@
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
  */
=20
 #ifdef CONFIG_SATA_DWC_DEBUG
@@ -44,13 +51,11 @@
 #undef	DRV_NAME
 #undef	DRV_VERSION
 #define DRV_NAME        "sata-dwc"
-#define DRV_VERSION     "1.3"
+#define DRV_VERSION     "1.4"
=20
-/* SATA DMA driver Globals */
-#define DMA_NUM_CHANS		1
+#define DMA_NUM_CHANS		2
 #define DMA_NUM_CHAN_REGS	8
=20
-/* SATA DMA Register definitions */
 #define AHB_DMA_BRST_DFLT	64	/* 16 data items burst length*/
=20
 struct dmareg {
@@ -128,6 +133,12 @@ enum {
 						SATA_DWC_DMAC_TWIDTH_BYTES),
 };
=20
+/* Host Controller ID */
+enum {
+	APM_460EX_SATA =3D 0,
+	APM_821XX_SATA =3D 1,
+};
+
 /* DMA Register Operation Bits */
 enum {
 	DMA_EN	=3D		0x00000001, /* Enable AHB DMA */
@@ -135,13 +146,12 @@ enum {
 	DMA_CTL_LLP_DSTEN =3D	0x08000000, /* Blk chain enable Dst */
 };
=20
-#define	DMA_CTL_BLK_TS(size)	((size) & 0x000000FFF)	/* Blk Transfer si=
ze */
+#define DMA_CTL_BLK_TS(size)	((size) & 0x000000FFF)	/* Blk Transfer si=
ze */
 #define DMA_CHANNEL(ch)		(0x00000001 << (ch))	/* Select channel */
 	/* Enable channel */
-#define	DMA_ENABLE_CHAN(ch)	((0x00000001 << (ch)) |			\
-				 ((0x000000001 << (ch)) << 8))
+#define	DMA_ENABLE_CHAN(ch)	(0x00000101 << (ch))
 	/* Disable channel */
-#define	DMA_DISABLE_CHAN(ch)	(0x00000000 | ((0x000000001 << (ch)) << 8=
))
+#define	DMA_DISABLE_CHAN(ch)	(0x000000100 << (ch))
 	/* Transfer Type & Flow Controller */
 #define	DMA_CTL_TTFC(type)	(((type) & 0x7) << 20)
 #define	DMA_CTL_SMS(num)	(((num) & 0x3) << 25) /* Src Master Select */
@@ -158,6 +168,7 @@ enum {
 /* Assign HW handshaking interface (x) to destination / source periphe=
ral */
 #define	DMA_CFG_HW_HS_DEST(int_num) (((int_num) & 0xF) << 11)
 #define	DMA_CFG_HW_HS_SRC(int_num) (((int_num) & 0xF) << 7)
+#define	DMA_CFG_HW_CH_PRIOR(int_num) (((int_num) & 0xF) << 5)
 #define	DMA_LLP_LMS(addr, master) (((addr) & 0xfffffffc) | (master))
=20
 /*
@@ -268,22 +279,26 @@ enum {
 						 << 16)
 struct sata_dwc_device {
 	struct device		*dev;		/* generic device struct */
-	struct ata_probe_ent	*pe;		/* ptr to probe-ent */
 	struct ata_host		*host;
 	u8			*reg_base;
 	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
+	u8			*scr_base;
+	int			dma_channel;	/* DWC SATA DMA channel */
 	int			irq_dma;
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
+	u32			sata_dwc_sactive_issued;
+	u32			sata_dwc_sactive_queued;
+	u32			dma_interrupt_count;
 };
=20
 /*
@@ -298,43 +313,32 @@ struct sata_dwc_device_port {
 #define HSDEV_FROM_QC(qc)	((struct sata_dwc_device *)\
 					(qc)->ap->host->private_data)
 #define HSDEV_FROM_HSDEVP(p)	((struct sata_dwc_device *)\
-						(hsdevp)->hsdev)
+					(hsdevp)->hsdev)
=20
 enum {
-	SATA_DWC_CMD_ISSUED_NOT		=3D 0,
-	SATA_DWC_CMD_ISSUED_PEND	=3D 1,
-	SATA_DWC_CMD_ISSUED_EXEC	=3D 2,
-	SATA_DWC_CMD_ISSUED_NODATA	=3D 3,
-
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
+/*
+ * Globals
+ */
+static struct sata_dwc_device *dwc_dev_list[2];
+static struct ahb_dma_regs *sata_dma_regs;
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
-static int dma_dwc_init(struct sata_dwc_device *hsdev, int irq);
-static void dma_dwc_exit(struct sata_dwc_device *hsdev);
-static int dma_dwc_xfer_setup(struct scatterlist *sg, int num_elems,
-			      struct lli *lli, dma_addr_t dma_lli,
-			      void __iomem *addr, int dir);
-static void dma_dwc_xfer_start(int dma_ch);
+static int dwc_dma_init(struct sata_dwc_device *hsdev, int irq);
+static int dwc_dma_xfer_setup(struct ata_port *ap, dma_addr_t dma_lli)=
;
+static void dwc_dma_xfer_start(int dma_ch);
+static void sata_dwc_init_port(struct ata_port *ap);
+
=20
 static const char *get_prot_descript(u8 protocol)
 {
@@ -372,27 +376,25 @@ static const char *get_dma_dir_descript(int dma_d=
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
 }
=20
 /*
- * Function: get_burst_length_encode
- * arguments: datalength: length in bytes of data
- * returns value to be programmed in register corresponding to data le=
ngth
+ * Calculate value to be programmed in register corresponding to data =
length
  * This value is effectively the log(base 2) of the length
  */
-static  int get_burst_length_encode(int datalength)
+static int get_burst_length_encode(int datalength)
 {
 	int items =3D datalength >> 2;	/* div by 4 to get lword count */
=20
@@ -414,152 +416,205 @@ static  int get_burst_length_encode(int datalen=
gth)
 	return 0;
 }
=20
-static  void clear_chan_interrupts(int c)
+/*
+ * Clear channel interrupt. No interrupt for the specified channel
+ * generated until it is enabled again.
+ */
+static void clear_chan_interrupts(int c)
 {
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.tfr.low),
-		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.block.low),
+	out_le32(&(sata_dma_regs->interrupt_clear.tfr.low), DMA_CHANNEL(c));
+	out_le32(&(sata_dma_regs->interrupt_clear.block.low), DMA_CHANNEL(c))=
;
+	out_le32(&(sata_dma_regs->interrupt_clear.srctran.low),
 		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.srctran.low),
-		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.dsttran.low),
-		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.error.low),
+	out_le32(&(sata_dma_regs->interrupt_clear.dsttran.low),
 		 DMA_CHANNEL(c));
+	out_le32(&(sata_dma_regs->interrupt_clear.error.low), DMA_CHANNEL(c))=
;
 }
=20
 /*
- * Function: dma_request_channel
- * arguments: None
- * returns channel number if available else -1
- * This function assigns the next available DMA channel from the list =
to the
- * requester
+ * Check if the selected DMA channel is currently enabled.
  */
-static int dma_request_channel(void)
+static int sata_dwc_dma_chk_en(int ch)
 {
-	int i;
+	u32 dma_chan_reg;
+	/* Read the DMA channel register */
+	dma_chan_reg =3D in_le32(&(sata_dma_regs->dma_chan_en.low));
+	/* Check if it is currently enabled */
+	if (dma_chan_reg & DMA_CHANNEL(ch))
+		return 1;
+	return 0;
+}
=20
-	for (i =3D 0; i < DMA_NUM_CHANS; i++) {
-		if (!(in_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low)) &\
-			DMA_CHANNEL(i)))
-			return i;
+/*
+ * Terminate the current DMA transfer
+ *
+ * Refer to the "Abnormal Transfer Termination" section
+ * Disable the corresponding bit in the ChEnReg register
+ * and poll that register to until the channel is terminated.
+ */
+static void sata_dwc_dma_terminate(struct ata_port *ap, int dma_ch)
+{
+	int enabled =3D sata_dwc_dma_chk_en(dma_ch);
+	/* If the channel is currenly in use, release it. */
+	if (enabled)  {
+		dev_dbg(ap->dev,
+			"%s terminate DMA on channel=3D%d (mask=3D0x%08x) ...",
+			__func__, dma_ch, DMA_DISABLE_CHAN(dma_ch));
+		dev_dbg(ap->dev, "ChEnReg=3D0x%08x\n",
+			in_le32(&(sata_dma_regs->dma_chan_en.low)));
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
 	}
-	dev_err(host_pvt.dwc_dev, "%s NO channel chan_en: 0x%08x\n", __func__=
,
-		in_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low)));
+}
+
+/*
+ * Check if the DMA channel is currently available for transferring da=
ta
+ * on the specified ata_port.
+ */
+static int dma_request_channel(struct ata_port *ap)
+{
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
+
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
- * Function: dma_dwc_interrupt
- * arguments: irq, dev_id, pt_regs
- * returns channel number if available else -1
- * Interrupt Handler for DW AHB SATA DMA
+ * Processing DMA transfer complete interrupt
  */
-static irqreturn_t dma_dwc_interrupt(int irq, void *hsdev_instance)
+static irqreturn_t dwc_dma_interrupt(int irq, struct sata_dwc_device *=
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
-	u8 tag =3D 0;
+	u8 tag;
 	unsigned int port =3D 0;
=20
 	spin_lock_irqsave(&host->lock, flags);
 	ap =3D host->ports[port];
 	hsdevp =3D HSDEVP_FROM_AP(ap);
-	tag =3D ap->link.active_tag;
=20
-	tfr_reg =3D in_le32(&(host_pvt.sata_dma_regs->interrupt_status.tfr\
-			.low));
-	err_reg =3D in_le32(&(host_pvt.sata_dma_regs->interrupt_status.error\
-			.low));
+	/*
+	 * Find the right tag value for the current DMA transfer.
+	 * In case of NCQ transfer, tag for the current transfer is set to
+	 * active_tag.
+	 * For DMA transfer, tag is 0 (active_tag=3DATA_TAG_POISION).
+	 */
+	if (ap->link.active_tag !=3D ATA_TAG_POISON)
+		tag =3D ap->link.active_tag;
+	else
+		tag =3D 0;
=20
+	tfr_reg =3D in_le32(&(sata_dma_regs->interrupt_status.tfr.low));
+	err_reg =3D in_le32(&(sata_dma_regs->interrupt_status.error.low));
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
-		/* Check for error interrupt. */
-		if (err_reg & DMA_CHANNEL(chan)) {
-			/* TODO Need error handler ! */
+		/* Check for error interrupt, not expect error happens */
+		if (unlikely(err_reg & DMA_CHANNEL(chan))) {
 			dev_err(ap->dev, "error interrupt err_reg=3D0x%08x\n",
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
+	if (hsdevp->sata_dwc_sactive_queued =3D=3D 0)
+		ap->link.active_tag =3D ATA_TAG_POISON;
+
 	spin_unlock_irqrestore(&host->lock, flags);
 	return IRQ_HANDLED;
 }
=20
 /*
- * Function: dma_request_interrupts
- * arguments: hsdev
- * returns status
- * This function registers ISR for a particular DMA channel interrupt
+ * Handle DMA transfer complete interrupt. This checks and passes the
+ * processing to the appropriate ATA port.
  */
-static int dma_request_interrupts(struct sata_dwc_device *hsdev, int i=
rq)
+static irqreturn_t dma_dwc_handler(int irq, void *hsdev_instance)
 {
-	int retval =3D 0;
+	u32 tfr_reg, err_reg;
 	int chan;
=20
+	tfr_reg =3D in_le32(&(sata_dma_regs->interrupt_status.tfr.low));
+	err_reg =3D in_le32(&(sata_dma_regs->interrupt_status.error.low));
+
 	for (chan =3D 0; chan < DMA_NUM_CHANS; chan++) {
-		/* Unmask error interrupt */
-		out_le32(&(host_pvt.sata_dma_regs)->interrupt_mask.error.low,
-			 DMA_ENABLE_CHAN(chan));
+		/* Check for end-of-transfer interrupt. */
+		if (tfr_reg & DMA_CHANNEL(chan))
+			dwc_dma_interrupt(0, dwc_dev_list[chan]);
=20
-		/* Unmask end-of-transfer interrupt */
-		out_le32(&(host_pvt.sata_dma_regs)->interrupt_mask.tfr.low,
-			 DMA_ENABLE_CHAN(chan));
+		/* Check for error interrupt. */
+		if (err_reg & DMA_CHANNEL(chan))
+			dwc_dma_interrupt(0, dwc_dev_list[chan]);
 	}
=20
-	retval =3D request_irq(irq, dma_dwc_interrupt, 0, "SATA DMA", hsdev);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Registers ISR for a particular DMA channel interrupt
+ */
+static int dma_request_interrupts(struct sata_dwc_device *hsdev, int i=
rq)
+{
+	int retval;
+
+	/* Unmask error interrupt */
+	out_le32(&sata_dma_regs->interrupt_mask.error.low,
+		in_le32(&sata_dma_regs->interrupt_mask.error.low) |
+		 DMA_ENABLE_CHAN(hsdev->dma_channel));
+
+	/* Unmask end-of-transfer interrupt */
+	out_le32(&sata_dma_regs->interrupt_mask.tfr.low,
+		in_le32(&sata_dma_regs->interrupt_mask.tfr.low) |
+		 DMA_ENABLE_CHAN(hsdev->dma_channel));
+
+	retval =3D request_irq(irq, dma_dwc_handler, IRQF_SHARED, "SATA DMA",
+		hsdev);
 	if (retval) {
-		dev_err(host_pvt.dwc_dev, "%s: could not get IRQ %d\n",
+		dev_err(hsdev->dev, "%s: could not get IRQ %d\n",\
 		__func__, irq);
 		return -ENODEV;
 	}
=20
 	/* Mark this interrupt as requested */
 	hsdev->irq_dma =3D irq;
+
 	return 0;
 }
=20
 /*
- * Function: map_sg_to_lli
  * The Synopsis driver has a comment proposing that better performance
  * is possible by only enabling interrupts on the last item in the lin=
ked list.
  * However, it seems that could be a problem if an error happened on o=
ne of the
@@ -567,16 +622,19 @@ static int dma_request_interrupts(struct sata_dwc=
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
@@ -589,13 +647,13 @@ static int map_sg_to_lli(struct scatterlist *sg, =
int num_elems,
 		addr =3D (u32) sg_dma_address(sg);
 		sg_len =3D sg_dma_len(sg);
=20
-		dev_dbg(host_pvt.dwc_dev, "%s: elem=3D%d sg_addr=3D0x%x sg_len"
+		dev_dbg(dwc_dev, "%s: elem=3D%d sg_addr=3D0x%x sg_len"
 			"=3D%d\n", __func__, i, addr, sg_len);
=20
 		while (sg_len) {
-			if (idx >=3D SATA_DWC_DMAC_LLI_NUM) {
+			if (unlikely(idx >=3D SATA_DWC_DMAC_LLI_NUM)) {
 				/* The LLI table is not large enough. */
-				dev_err(host_pvt.dwc_dev, "LLI table overrun "
+				dev_err(dwc_dev, "LLI table overrun "
 				"(idx=3D%d)\n", idx);
 				break;
 			}
@@ -613,8 +671,8 @@ static int map_sg_to_lli(struct scatterlist *sg, in=
t num_elems,
 			 * cross that boundary -- this results in an error in
 			 * the host controller.
 			 */
-			if (fis_len + len > 8192) {
-				dev_dbg(host_pvt.dwc_dev, "SPLITTING: fis_len=3D"
+			if (unlikely(fis_len + len > 8192)) {
+				dev_dbg(dwc_dev, "SPLITTING: fis_len=3D"
 					"%d(0x%x) len=3D%d(0x%x)\n", fis_len,
 					 fis_len, len, len);
 				len =3D 8192 - fis_len;
@@ -629,14 +687,22 @@ static int map_sg_to_lli(struct scatterlist *sg, =
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
@@ -645,14 +711,14 @@ static int map_sg_to_lli(struct scatterlist *sg, =
int num_elems,
 					DMA_CTL_INT_EN |
 					DMA_CTL_LLP_SRCEN |
 					DMA_CTL_LLP_DSTEN);
-			} else {	/* DMA_TO_DEVICE */
+			} else { /* DMA_TO_DEVICE */
 				lli[idx].sar =3D cpu_to_le32(addr);
 				lli[idx].dar =3D cpu_to_le32((u32)dmadr_addr);
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
@@ -663,7 +729,7 @@ static int map_sg_to_lli(struct scatterlist *sg, in=
t num_elems,
 					DMA_CTL_LLP_DSTEN);
 			}
=20
-			dev_dbg(host_pvt.dwc_dev, "%s setting ctl.high len: "
+			dev_dbg(dwc_dev, "%s setting ctl.high len: "
 				"0x%08x val: 0x%08x\n", __func__,
 				len, DMA_CTL_BLK_TS(len / 4));
=20
@@ -678,7 +744,13 @@ static int map_sg_to_lli(struct scatterlist *sg, i=
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
@@ -693,7 +765,7 @@ static int map_sg_to_lli(struct scatterlist *sg, in=
t num_elems,
 	 * and destination enable) set back to 0 (disabled.) This is what tel=
ls
 	 * the core that this is the last item in the linked list.
 	 */
-	if (idx) {
+	if (likely(idx)) {
 		lli[idx-1].llp =3D 0x00000000;
 		lli[idx-1].ctl.low &=3D DMA_CTL_LLP_DISABLE_LE32;
=20
@@ -706,119 +778,86 @@ static int map_sg_to_lli(struct scatterlist *sg,=
 int num_elems,
 }
=20
 /*
- * Function: dma_dwc_xfer_start
- * arguments: Channel number
- * Return : None
- * Enables the DMA channel
+ * Enables the DMA channel to start transferring data
  */
-static void dma_dwc_xfer_start(int dma_ch)
+static void dwc_dma_xfer_start(int dma_ch)
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
+static int dwc_dma_xfer_setup(struct ata_port *ap, dma_addr_t dma_lli)
 {
 	int dma_ch;
-	int num_lli;
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
 	/* Acquire DMA channel */
-	dma_ch =3D dma_request_channel();
-	if (dma_ch =3D=3D -1) {
-		dev_err(host_pvt.dwc_dev, "%s: dma channel unavailable\n",
-			 __func__);
+	dma_ch =3D dma_request_channel(ap);
+	if (unlikely(dma_ch =3D=3D -1)) {
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
-		 DMA_LLP_LMS(dma_lli, DMA_LLP_AHBMASTER2));
+	if (hsdev->hostID =3D=3D APM_460EX_SATA) {
+		out_le32(&(sata_dma_regs->chan_regs[dma_ch].llp.low),
+			DMA_LLP_LMS(dma_lli, DMA_LLP_AHBMASTER2));
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
- * Function: dma_dwc_init
- * arguments: hsdev
- * returns status
- * This function initializes the SATA DMA driver
+ * Initializes the SATA DMA driver
  */
-static int dma_dwc_init(struct sata_dwc_device *hsdev, int irq)
+static int dwc_dma_init(struct sata_dwc_device *hsdev, int irq)
 {
 	int err;
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
-	/* Enabe DMA */
-	out_le32(&(host_pvt.sata_dma_regs->dma_cfg.low), DMA_EN);
+	/* Enabe DMA support */
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
 {
-	if (scr > SCR_NOTIFICATION) {
+	if (unlikely(scr > SCR_NOTIFICATION)) {
 		dev_err(link->ap->dev, "%s: Incorrect SCR offset 0x%02x\n",
 			__func__, scr);
 		return -EINVAL;
 	}
=20
 	*val =3D in_le32((void *)link->ap->ioaddr.scr_addr + (scr * 4));
-	dev_dbg(link->ap->dev, "%s: id=3D%d reg=3D%d val=3Dval=3D0x%08x\n",
+	dev_dbg(link->ap->dev, "%s: id=3D%d reg=3D%d val=3D0x%08x\n",
 		__func__, link->ap->print_id, scr, *val);
=20
 	return 0;
@@ -828,7 +867,7 @@ static int sata_dwc_scr_write(struct ata_link *link=
, unsigned int scr, u32 val)
 {
 	dev_dbg(link->ap->dev, "%s: id=3D%d reg=3D%d val=3Dval=3D0x%08x\n",
 		__func__, link->ap->print_id, scr, val);
-	if (scr > SCR_NOTIFICATION) {
+	if (unlikely(scr > SCR_NOTIFICATION)) {
 		dev_err(link->ap->dev, "%s: Incorrect SCR offset 0x%02x\n",
 			 __func__, scr);
 		return -EINVAL;
@@ -838,23 +877,24 @@ static int sata_dwc_scr_write(struct ata_link *li=
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
+	out_le32((void __iomem *)hsdev->scr_base + 4,
+		in_le32((void __iomem *)hsdev->scr_base + 4));
=20
 }
=20
@@ -864,12 +904,105 @@ static void clear_interrupt_bit(struct sata_dwc_=
device *hsdev, u32 bit)
 		 in_le32(&hsdev->sata_dwc_regs->intpr));
 }
=20
+/*
+ * Porting the ata_bus_softreset function from the libata-sff.c librar=
y.
+ */
+static int sata_dwc_bus_softreset(struct ata_port *ap, unsigned int de=
vmask,
+		unsigned long deadline)
+{
+	struct ata_ioports *ioaddr =3D &ap->ioaddr;
+
+	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
+
+	/* Software reset.  causes dev0 to be selected */
+	iowrite8(ap->ctl, ioaddr->ctl_addr);
+	udelay(20);	/* FIXME: flush */
+	iowrite8(ap->ctl | ATA_SRST, ioaddr->ctl_addr);
+	udelay(20);	/* FIXME: flush */
+	iowrite8(ap->ctl, ioaddr->ctl_addr);
+	ap->last_ctl =3D ap->ctl;
+
+	/* Wait the port to become ready */
+	return ata_sff_wait_after_reset(&ap->link, devmask, deadline);
+}
+
+/*
+ * Do soft reset on the current SATA link.
+ */
+static int sata_dwc_softreset(struct ata_link *link, unsigned int *cla=
sses,
+				unsigned long deadline)
+{
+	int rc;
+	u8 err;
+	struct ata_port *ap =3D link->ap;
+	unsigned int devmask =3D 0;
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
+
+	/* Select device 0 again */
+	ap->ops->sff_dev_select(ap, 0);
+
+	DPRINTK("about to softreset, devmask=3D%x\n", devmask);
+	rc =3D sata_dwc_bus_softreset(ap, devmask, deadline);
+
+	/* If link is occupied, -ENODEV too is an error */
+	if (rc && (rc !=3D -ENODEV || sata_scr_valid(link))) {
+		ata_link_printk(link, KERN_ERR, "SRST failed(errno=3D%d)\n", rc);
+		return rc;
+	}
+
+	/* Determine by signature whether we have ATA or ATAPI devices */
+	classes[0] =3D ata_sff_dev_classify(&link->device[0],
+				devmask & (1 << 0), &err);
+
+	DPRINTK("EXIT, classes[0]=3D%u [1]=3D%u\n", classes[0], classes[1]);
+	clear_serror(link->ap);
+
+	/* Terminate DMA if it is currently in use */
+	sata_dwc_dma_terminate(link->ap, hsdev->dma_channel);
+
+	return rc;
+}
+
+/*
+ * Reset all internal parameters to default value.
+ * This function should be called in hardreset
+ */
+static void dwc_reset_internal_params(struct ata_port *ap)
+{
+	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
+	int tag;
+	for (tag =3D 0; tag < SATA_DWC_QCMD_MAX; tag++)
+		hsdevp->dma_pending[tag] =3D SATA_DWC_DMA_PENDING_NONE;
+
+	hsdevp->sata_dwc_sactive_issued =3D 0;
+	hsdevp->sata_dwc_sactive_queued =3D 0;
+}
+
+static int sata_dwc_hardreset(struct ata_link *link, unsigned int *cla=
sses,
+			unsigned long deadline)
+{
+	int rc;
+	const unsigned long *timing =3D sata_ehc_deb_timing(&link->eh_context=
);
+	bool online;
+
+	/* Reset internal parameters to default values */
+	dwc_reset_internal_params(link->ap);
+
+	/* Call standard hard reset */
+	rc =3D sata_link_hardreset(link, timing, deadline, &online, NULL);
+
+	/* Reconfigure the port after hard reset */
+	if (ata_link_online(link))
+		sata_dwc_init_port(link->ap);
+
+	return online ? -EAGAIN : rc;
+}
+
 static u32 qcmd_tag_to_mask(u8 tag)
 {
 	return 0x00000001 << (tag & 0x1f);
 }
=20
-/* See ahci.c */
 static void sata_dwc_error_intr(struct ata_port *ap,
 				struct sata_dwc_device *hsdev, uint intpr)
 {
@@ -883,24 +1016,22 @@ static void sata_dwc_error_intr(struct ata_port =
*ap,
=20
 	ata_ehi_clear_desc(ehi);
=20
-	serror =3D core_scr_read(SCR_ERROR);
+	serror =3D core_scr_read(ap, SCR_ERROR);
 	status =3D ap->ops->sff_check_status(ap);
=20
-	err_reg =3D in_le32(&(host_pvt.sata_dma_regs->interrupt_status.error.=
\
-			low));
+	err_reg =3D in_le32(&(sata_dma_regs->interrupt_status.error.low));
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
@@ -918,11 +1049,7 @@ static void sata_dwc_error_intr(struct ata_port *=
ap,
 }
=20
 /*
- * Function : sata_dwc_isr
- * arguments : irq, void *dev_instance, struct pt_regs *regs
- * Return value : irqreturn_t - status of IRQ
  * This Interrupt handler called via port ops registered function.
- * .irq_handler =3D sata_dwc_isr
  */
 static irqreturn_t sata_dwc_isr(int irq, void *dev_instance)
 {
@@ -930,14 +1057,14 @@ static irqreturn_t sata_dwc_isr(int irq, void *d=
ev_instance)
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
@@ -958,38 +1085,61 @@ static irqreturn_t sata_dwc_isr(int irq, void *d=
ev_instance)
 	/* Check for DMA SETUP FIS (FP DMA) interrupt */
 	if (intpr & SATA_DWC_INTPR_NEWFP) {
 		clear_interrupt_bit(hsdev, SATA_DWC_INTPR_NEWFP);
+		if (ap->qc_allocated =3D=3D 0x0) {
+			handled =3D 1;
+			goto DONE;
+		}
=20
 		tag =3D (u8)(in_le32(&hsdev->sata_dwc_regs->fptagr));
+		mask =3D qcmd_tag_to_mask(tag);
 		dev_dbg(ap->dev, "%s: NEWFP tag=3D%d\n", __func__, tag);
-		if (hsdevp->cmd_issued[tag] !=3D SATA_DWC_CMD_ISSUED_PEND)
+		if ((hsdevp->sata_dwc_sactive_queued & mask) =3D=3D 0)
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
+			hsdevp->sata_dwc_sactive_issued |=3D mask;
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
+		    hsdevp->sata_dwc_sactive_issued &=3D ~mask;
+		    dev_warn(ap->dev, "No QC available for tag %d (intpr=3D"
+		    "0x%08x, qc_allocated=3D0x%08x, qc_active=3D0x%08x)\n", tag,\
+			intpr, ap->qc_allocated, ap->qc_active);
+		}
=20
 		handled =3D 1;
 		goto DONE;
 	}
-	sactive =3D core_scr_read(SCR_ACTIVE);
-	tag_mask =3D (host_pvt.sata_dwc_sactive_issued | sactive) ^ sactive;
=20
-	/* If no sactive issued and tag_mask is zero then this is not NCQ */
-	if (host_pvt.sata_dwc_sactive_issued =3D=3D 0 && tag_mask =3D=3D 0) {
+	sactive =3D core_scr_read(ap, SCR_ACTIVE);
+	tag_mask =3D (hsdevp->sata_dwc_sactive_issued | sactive) ^ sactive;
+
+	/*
+	 * If no sactive issued and tag_mask is zero then this is not NCQ.
+	 * Do actions for transfer completion interrupt.
+	 */
+	if (hsdevp->sata_dwc_sactive_issued =3D=3D 0 && tag_mask =3D=3D 0) {
 		if (ap->link.active_tag =3D=3D ATA_TAG_POISON)
 			tag =3D 0;
 		else
 			tag =3D ap->link.active_tag;
 		qc =3D ata_qc_from_tag(ap, tag);
=20
-		/* DEV interrupt w/ no active qc? */
+		/* Device interrupt without active qc? */
 		if (unlikely(!qc || (qc->tf.flags & ATA_TFLAG_POLLING))) {
 			dev_err(ap->dev, "%s interrupt with no active qc "
 				"qc=3D%p\n", __func__, qc);
@@ -997,11 +1147,9 @@ static irqreturn_t sata_dwc_isr(int irq, void *de=
v_instance)
 			handled =3D 1;
 			goto DONE;
 		}
+		/* Get current status and clear interrupt */
 		status =3D ap->ops->sff_check_status(ap);
=20
-		qc->ap->link.active_tag =3D tag;
-		hsdevp->cmd_issued[tag] =3D SATA_DWC_CMD_ISSUED_NOT;
-
 		if (status & ATA_ERR) {
 			dev_dbg(ap->dev, "interrupt ATA_ERR (0x%x)\n", status);
 			sata_dwc_qc_complete(ap, qc, 1);
@@ -1012,28 +1160,12 @@ static irqreturn_t sata_dwc_isr(int irq, void *=
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
@@ -1049,94 +1181,40 @@ DRVSTILLBUSY:
 	 * as completion for more than one operation when commands are queued
 	 * (NCQ).  We need to process each completed command.
 	 */
-
-	 /* process completed commands */
-	sactive =3D core_scr_read(SCR_ACTIVE);
-	tag_mask =3D (host_pvt.sata_dwc_sactive_issued | sactive) ^ sactive;
-
-	if (sactive !=3D 0 || (host_pvt.sata_dwc_sactive_issued) > 1 || \
+	if (sactive !=3D 0 || hsdevp->sata_dwc_sactive_issued > 1 || \
 							tag_mask > 1) {
 		dev_dbg(ap->dev, "%s NCQ:sactive=3D0x%08x  sactive_issued=3D0x%08x"
 			"tag_mask=3D0x%08x\n", __func__, sactive,
-			host_pvt.sata_dwc_sactive_issued, tag_mask);
+			hsdevp->sata_dwc_sactive_issued, tag_mask);
 	}
=20
-	if ((tag_mask | (host_pvt.sata_dwc_sactive_issued)) !=3D \
-					(host_pvt.sata_dwc_sactive_issued)) {
+	if (unlikely((tag_mask | hsdevp->sata_dwc_sactive_issued) !=3D \
+					hsdevp->sata_dwc_sactive_issued)) {
 		dev_warn(ap->dev, "Bad tag mask?  sactive=3D0x%08x "
-			 "(host_pvt.sata_dwc_sactive_issued)=3D0x%08x  tag_mask"
-			 "=3D0x%08x\n", sactive, host_pvt.sata_dwc_sactive_issued,
+			 "sata_dwc_sactive_issued=3D0x%08x  tag_mask"
+			 "=3D0x%08x\n", sactive, hsdevp->sata_dwc_sactive_issued,
 			  tag_mask);
 	}
=20
-	/* read just to clear ... not bad if currently still busy */
+	/* Read just to clear ... not bad if currently still busy */
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
@@ -1157,8 +1235,8 @@ static void sata_dwc_clear_dmacr(struct sata_dwc_=
device_port *hsdevp, u8 tag)
 		 * This should not happen, it indicates the driver is out of
 		 * sync.  If it does happen, clear dmacr anyway.
 		 */
-		dev_err(host_pvt.dwc_dev, "%s DMA protocol RX and"
-			"TX DMA not pending tag=3D0x%02x pending=3D%d"
+		dev_err(hsdev->dev, "%s DMA protocol RX and"
+			" TX DMA not pending tag=3D0x%02x pending=3D%d"
 			" dmacr: 0x%08x\n", __func__, tag,
 			hsdevp->dma_pending[tag],
 			in_le32(&(hsdev->sata_dwc_regs->dmacr)));
@@ -1167,70 +1245,51 @@ static void sata_dwc_clear_dmacr(struct sata_dw=
c_device_port *hsdevp, u8 tag)
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
 {
-	u8 status =3D 0;
-	u32 mask =3D 0x0;
+	u8 status;
+	int i;
 	u8 tag =3D qc->tag;
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
-	host_pvt.sata_dwc_sactive_queued =3D 0;
+	u32 serror;
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
+		serror =3D core_scr_read(ap, SCR_ERROR);
+		if (unlikely(serror & SATA_DWC_SERROR_ERR_BITS))
+			dev_err(ap->dev, "****** SERROR=3D0x%08x ******\n",
+				serror);
+	}
 	dev_dbg(ap->dev, "QC complete cmd=3D0x%02x status=3D0x%02x ata%u:"
 		" protocol=3D%d\n", qc->tf.command, status, ap->print_id,
 		 qc->tf.protocol);
=20
-	/* clear active bit */
-	mask =3D (~(qcmd_tag_to_mask(tag)));
-	host_pvt.sata_dwc_sactive_queued =3D (host_pvt.sata_dwc_sactive_queue=
d) \
-						& mask;
-	host_pvt.sata_dwc_sactive_issued =3D (host_pvt.sata_dwc_sactive_issue=
d) \
-						& mask;
-	ata_qc_complete(qc);
+	hsdevp->sata_dwc_sactive_issued &=3D ~qcmd_tag_to_mask(tag);
+
+	/* Complete taskfile transaction (does not read SCR registers) */
+	if (ata_is_atapi(qc->tf.protocol))
+		ata_sff_hsm_move(ap, qc, status, 0);
+	else
+		ata_qc_complete(qc);
+
+	if (hsdevp->sata_dwc_sactive_queued =3D=3D 0)
+		ap->link.active_tag =3D ATA_TAG_POISON;
+
 	return 0;
 }
=20
@@ -1241,18 +1300,42 @@ static void sata_dwc_enable_interrupts(struct s=
ata_dwc_device *hsdev)
 		 SATA_DWC_INTMR_ERRM |
 		 SATA_DWC_INTMR_NEWFPM |
 		 SATA_DWC_INTMR_PMABRTM |
-		 SATA_DWC_INTMR_DMATM);
+		 SATA_DWC_INTMR_DMATM |
+		 SATA_DWC_INTPR_IPF);
 	/*
 	 * Unmask the error bits that should trigger an error interrupt by
 	 * setting the error mask register.
 	 */
 	out_le32(&hsdev->sata_dwc_regs->errmr, SATA_DWC_SERROR_ERR_BITS);
=20
-	dev_dbg(host_pvt.dwc_dev, "%s: INTMR =3D 0x%08x, ERRMR =3D 0x%08x\n",
+	dev_dbg(hsdev->dev, "%s: INTMR =3D 0x%08x, ERRMR =3D 0x%08x\n",
 		 __func__, in_le32(&hsdev->sata_dwc_regs->intmr),
 		in_le32(&hsdev->sata_dwc_regs->errmr));
 }
=20
+static void sata_dwc_init_port(struct ata_port *ap)
+{
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
+
+	/* Configure DMA */
+	if (ap->port_no =3D=3D 0)  {
+		dev_dbg(ap->dev, "%s: clearing TXCHEN, RXCHEN in DMAC\n",
+				__func__);
+
+		/* Clear all transmit/receive bits */
+		out_le32(&hsdev->sata_dwc_regs->dmacr,
+			 SATA_DWC_DMACR_TXRXCH_CLEAR);
+
+		dev_dbg(ap->dev, "%s: setting burst size DBTSR\n", __func__);
+		out_le32(&hsdev->sata_dwc_regs->dbtsr,
+			 (SATA_DWC_DBTSR_MWR(AHB_DMA_BRST_DFLT) |
+			  SATA_DWC_DBTSR_MRD(AHB_DMA_BRST_DFLT)));
+	}
+
+	/* Enable interrupts */
+	sata_dwc_enable_interrupts(hsdev);
+}
+
 static void sata_dwc_setup_port(struct ata_ioports *port, unsigned lon=
g base)
 {
 	port->cmd_addr =3D (void *)base + 0x00;
@@ -1276,10 +1359,7 @@ static void sata_dwc_setup_port(struct ata_iopor=
ts *port, unsigned long base)
 }
=20
 /*
- * Function : sata_dwc_port_start
- * arguments : struct ata_ioports *port
- * Return value : returns 0 if success, error code otherwise
- * This function allocates the scatter gather LLI table for AHB DMA
+ * Allocates the scatter gather LLI table for AHB DMA
  */
 static int sata_dwc_port_start(struct ata_port *ap)
 {
@@ -1287,6 +1367,7 @@ static int sata_dwc_port_start(struct ata_port *a=
p)
 	struct sata_dwc_device *hsdev;
 	struct sata_dwc_device_port *hsdevp =3D NULL;
 	struct device *pdev;
+	u32 sstatus;
 	int i;
=20
 	hsdev =3D HSDEV_FROM_AP(ap);
@@ -1308,12 +1389,10 @@ static int sata_dwc_port_start(struct ata_port =
*ap)
 		err =3D -ENOMEM;
 		goto CLEANUP;
 	}
+	memset(hsdevp, 0, sizeof(*hsdevp));
 	hsdevp->hsdev =3D hsdev;
=20
-	for (i =3D 0; i < SATA_DWC_QCMD_MAX; i++)
-		hsdevp->cmd_issued[i] =3D SATA_DWC_CMD_ISSUED_NOT;
-
-	ap->bmdma_prd =3D 0;	/* set these so libata doesn't use them */
+	ap->bmdma_prd =3D 0;  /* set these so libata doesn't use them */
 	ap->bmdma_prd_dma =3D 0;
=20
 	/*
@@ -1329,7 +1408,7 @@ static int sata_dwc_port_start(struct ata_port *a=
p)
 			dev_err(ap->dev, "%s: dma_alloc_coherent failed\n",
 				 __func__);
 			err =3D -ENOMEM;
-			goto CLEANUP_ALLOC;
+			goto CLEANUP;
 		}
 	}
=20
@@ -1347,32 +1426,47 @@ static int sata_dwc_port_start(struct ata_port =
*ap)
 	}
=20
 	/* Clear any error bits before libata starts issuing commands */
-	clear_serror();
+	clear_serror(ap);
 	ap->private_data =3D hsdevp;
+
+	/* Are we in Gen I or II */
+	sstatus =3D core_scr_read(ap, SCR_STATUS);
+	switch (SATA_DWC_SCR0_SPD_GET(sstatus)) {
+	case 0x0:
+		dev_info(ap->dev, "**** No neg speed (nothing attached?)\n");
+		break;
+	case 0x1:
+		dev_info(ap->dev, "**** GEN I speed rate negotiated\n");
+		break;
+	case 0x2:
+		dev_info(ap->dev, "**** GEN II speed rate negotiated\n");
+		break;
+	}
+
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
 static void sata_dwc_port_stop(struct ata_port *ap)
 {
 	int i;
-	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
=20
 	dev_dbg(ap->dev, "%s: ap->id =3D %d\n", __func__, ap->print_id);
=20
-	if (hsdevp && hsdev) {
-		/* deallocate LLI table */
+	if (hsdevp) {
+		/* De-allocate LLI table */
 		for (i =3D 0; i < SATA_DWC_QCMD_MAX; i++) {
 			dma_free_coherent(ap->host->dev,
-					  SATA_DWC_DMAC_LLI_TBL_SZ,
-					 hsdevp->llit[i], hsdevp->llit_dma[i]);
+				SATA_DWC_DMAC_LLI_TBL_SZ,
+				hsdevp->llit[i], hsdevp->llit_dma[i]);
 		}
=20
 		kfree(hsdevp);
@@ -1381,15 +1475,76 @@ static void sata_dwc_port_stop(struct ata_port =
*ap)
 }
=20
 /*
- * Function : sata_dwc_exec_command_by_tag
- * arguments : ata_port *ap, ata_taskfile *tf, u8 tag, u32 cmd_issued
- * Return value : None
- * This function keeps track of individual command tag ids and calls
- * ata_exec_command in libata
+ * As our SATA is master only, no dev_select function needed.
+ * This just overwrite the ata_sff_dev_select() function in
+ * libata-sff
+ */
+void sata_dwc_dev_select(struct ata_port *ap, unsigned int device)
+{
+	ndelay(100);
+}
+
+/**
+ * Filter ATAPI cmds which are unsuitable for DMA.
+ *
+ * The bmdma engines cannot handle speculative data sizes
+ * (bytecount under/over flow). So only allow DMA for
+ * data transfer commands with known data sizes.
+ */
+static int sata_dwc_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *scmd =3D qc->scsicmd;
+	int pio =3D 1; /* ATAPI DMA disabled by default */
+	unsigned int lba;
+
+	if (scmd) {
+		switch (scmd->cmnd[0]) {
+		case WRITE_6:
+		case WRITE_10:
+		case WRITE_12:
+		case READ_6:
+		case READ_10:
+		case READ_12:
+			pio =3D 0; /* DMA is safe */
+			break;
+		}
+
+		/* Command WRITE_10 with LBA between -45150 (FFFF4FA2)
+		 * and -1 (FFFFFFFF) shall use PIO mode */
+		if (scmd->cmnd[0] =3D=3D WRITE_10) {
+			lba =3D (scmd->cmnd[2] << 24) |
+				(scmd->cmnd[3] << 16) |
+				(scmd->cmnd[4] << 8) |
+				 scmd->cmnd[5];
+			if (lba >=3D 0xFFFF4FA2)
+				pio =3D 1;
+		}
+		/*
+		* WORK AROUND: Fix DMA issue when blank CD/DVD disc
+		* in the drive and user use the 'fdisk -l' command.
+		* No DMA data returned so we can not complete the QC.
+		*/
+		if (scmd->cmnd[0] =3D=3D READ_10) {
+			lba =3D (scmd->cmnd[2] << 24) |
+				  (scmd->cmnd[3] << 16) |
+				  (scmd->cmnd[4] << 8) |
+				   scmd->cmnd[5];
+			if (lba < 0x20)
+				pio =3D 1;
+		}
+	}
+	dev_dbg(qc->ap->dev, "%s - using %s mode for command cmd=3D0x%02x\n",=
 \
+		__func__, (pio ? "PIO" : "DMA"), scmd->cmnd[0]);
+	return pio;
+}
+
+/*
+ * Keeps track of individual command tag ids and calls ata_exec_comman=
d
+ * in libata
  */
 static void sata_dwc_exec_command_by_tag(struct ata_port *ap,
 					 struct ata_taskfile *tf,
-					 u8 tag, u32 cmd_issued)
+					 u8 tag)
 {
 	unsigned long flags;
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
@@ -1398,7 +1553,7 @@ static void sata_dwc_exec_command_by_tag(struct a=
ta_port *ap,
 		ata_get_cmd_descript(tf->command), tag);
=20
 	spin_lock_irqsave(&ap->host->lock, flags);
-	hsdevp->cmd_issued[tag] =3D cmd_issued;
+	hsdevp->sata_dwc_sactive_queued |=3D qcmd_tag_to_mask(tag);
 	spin_unlock_irqrestore(&ap->host->lock, flags);
 	/*
 	 * Clear SError before executing a new command.
@@ -1406,15 +1561,10 @@ static void sata_dwc_exec_command_by_tag(struct=
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
@@ -1426,7 +1576,8 @@ static void sata_dwc_bmdma_setup(struct ata_queue=
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
@@ -1437,42 +1588,54 @@ static void sata_dwc_bmdma_start_by_tag(struct =
ata_queued_cmd *qc, u8 tag)
 	struct ata_port *ap =3D qc->ap;
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
 	int dir =3D qc->dma_dir;
-	dma_chan =3D hsdevp->dma_chan[tag];
=20
-	if (hsdevp->cmd_issued[tag] !=3D SATA_DWC_CMD_ISSUED_NOT) {
+	/* Configure DMA before starting data transfer */
+	dma_chan =3D dwc_dma_xfer_setup(ap, hsdevp->llit_dma[tag]);
+	if (unlikely(dma_chan < 0)) {
+		dev_err(ap->dev, "%s: dma channel unavailable\n", __func__);
+		/* Offending this QC as no channel available for transfer */
+		qc->err_mask |=3D AC_ERR_TIMEOUT;
+		return;
+	}
+
+	/* Check if DMA should be started */
+	hsdevp->dma_chan[tag] =3D dma_chan;
+	if (hsdevp->sata_dwc_sactive_queued & qcmd_tag_to_mask(tag)) {
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
+	sata_dwc_tf_dump(hsdev->dev, &(qc->tf));
=20
+	/* Enable to start DMA transfer */
 	if (start_dma) {
-		reg =3D core_scr_read(SCR_ERROR);
-		if (reg & SATA_DWC_SERROR_ERR_BITS) {
+		reg =3D core_scr_read(ap, SCR_ERROR);
+		if (unlikely(reg & SATA_DWC_SERROR_ERR_BITS)) {
 			dev_err(ap->dev, "%s: ****** SError=3D0x%08x ******\n",
 				__func__, reg);
 		}
=20
-		if (dir =3D=3D DMA_TO_DEVICE)
+		if (dir =3D=3D DMA_TO_DEVICE) {
 			out_le32(&hsdev->sata_dwc_regs->dmacr,
 				SATA_DWC_DMACR_TXCHEN);
-		else
+		} else {
 			out_le32(&hsdev->sata_dwc_regs->dmacr,
 				SATA_DWC_DMACR_RXCHEN);
+		}
=20
 		/* Enable AHB DMA transfer on the specified channel */
-		dma_dwc_xfer_start(dma_chan);
+		dwc_dma_xfer_start(dma_chan);
+		hsdevp->sata_dwc_sactive_queued &=3D ~qcmd_tag_to_mask(tag);
 	}
 }
=20
@@ -1490,34 +1653,98 @@ static void sata_dwc_bmdma_start(struct ata_que=
ued_cmd *qc)
 	sata_dwc_bmdma_start_by_tag(qc, tag);
 }
=20
+static u8 sata_dwc_dma_status(struct ata_port *ap)
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
+		status =3D ATA_DMA_ERR | ATA_DMA_INTR;
+	else if (tfr_reg & DMA_CHANNEL(hsdev->dma_channel))
+		status =3D ATA_DMA_INTR;
+	return status;
+}
+
 /*
- * Function : sata_dwc_qc_prep_by_tag
- * arguments : ata_queued_cmd *qc, u8 tag
- * Return value : None
- * qc_prep for a particular queued command based on tag
+ * Prepare for a particular queued command based on tag
  */
 static void sata_dwc_qc_prep_by_tag(struct ata_queued_cmd *qc, u8 tag)
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
+}
+
+int sata_dwc_qc_defer(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap =3D qc->ap;
+	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
+	u8 status;
+	int ret;
+
+	dev_dbg(qc->ap->dev, "%s -\n", __func__);
+	ret =3D ata_std_qc_defer(qc);
+	if (ret) {
+		printk(KERN_DEBUG "STD Defer %s cmd %s tag=3D%d\n",
+			(ret =3D=3D ATA_DEFER_LINK) ? "LINK" : "PORT",
+			ata_get_cmd_descript(qc->tf.command), qc->tag);
+		return ret;
+	}
+
+	/* Check the SATA host for busy status */
+	if (ata_is_ncq(qc->tf.protocol)) {
+		status =3D ap->ops->sff_check_altstatus(ap);
+		if (status & ATA_BUSY) {
+			dev_dbg(ap->dev,
+				"Defer PORT cmd %s tag=3D%d as host is busy\n",
+				ata_get_cmd_descript(qc->tf.command), qc->tag);
+			return ATA_DEFER_PORT;/*HOST BUSY*/
+		}
+
+		/* This will prevent collision error */
+		if (hsdevp->sata_dwc_sactive_issued) {
+			dev_dbg(ap->dev, "Defer PORT cmd %s with tag %d " \
+				"because another dma xfer is outstanding\n",
+				ata_get_cmd_descript(qc->tf.command), qc->tag);
+
+			return ATA_DEFER_PORT;/*DEVICE&HOST BUSY*/
+		}
+
+	}
+
+	return 0;
+}
+
+void sata_dwc_exec_command(struct ata_port *ap, const struct ata_taskf=
ile *tf)
+{
+	iowrite8(tf->command, ap->ioaddr.command_addr);
+	/* If we have an mmio device with no ctl and no altstatus
+	 * method, this will fail. No such devices are known to exist.
+	 */
+	if (ap->ioaddr.altstatus_addr)
+		ioread8(ap->ioaddr.altstatus_addr);
+
+	ndelay(400);
 }
=20
 static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
@@ -1525,6 +1752,8 @@ static unsigned int sata_dwc_qc_issue(struct ata_=
queued_cmd *qc)
 	u32 sactive;
 	u8 tag =3D qc->tag;
 	struct ata_port *ap =3D qc->ap;
+	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(qc->ap);
+	u8 status;
=20
 #ifdef DEBUG_NCQ
 	if (qc->tag > 0 || ap->link.sactive > 1)
@@ -1541,50 +1770,148 @@ static unsigned int sata_dwc_qc_issue(struct a=
ta_queued_cmd *qc)
 	sata_dwc_qc_prep_by_tag(qc, tag);
=20
 	if (ata_is_ncq(qc->tf.protocol)) {
-		sactive =3D core_scr_read(SCR_ACTIVE);
+		status =3D ap->ops->sff_check_altstatus(ap);
+		if (status & ATA_BUSY) {
+			/* Ignore the QC when device is BUSY */
+			sactive =3D core_scr_read(qc->ap, SCR_ACTIVE);
+			dev_info(ap->dev, "Ignore current QC as device BUSY"
+				"tag=3D%d, sactive=3D0x%08x)\n", qc->tag, sactive);
+			return AC_ERR_SYSTEM;
+		}
+
+		if (hsdevp->sata_dwc_sactive_issued)
+			return AC_ERR_SYSTEM;
+
+		sactive =3D core_scr_read(qc->ap, SCR_ACTIVE);
 		sactive |=3D (0x00000001 << tag);
-		core_scr_write(SCR_ACTIVE, sactive);
+		qc->dev->link->sactive |=3D (0x00000001 << tag);
+		core_scr_write(qc->ap, SCR_ACTIVE, sactive);
=20
 		dev_dbg(qc->ap->dev, "%s: tag=3D%d ap->link.sactive =3D 0x%08x "
-			"sactive=3D0x%08x\n", __func__, tag, qc->ap->link.sactive,
+			"sactive=3D0x%x\n", __func__, tag, qc->ap->link.sactive,
 			sactive);
=20
 		ap->ops->sff_tf_load(ap, &qc->tf);
-		sata_dwc_exec_command_by_tag(ap, &qc->tf, qc->tag,
-					     SATA_DWC_CMD_ISSUED_PEND);
+		sata_dwc_exec_command_by_tag(ap, &qc->tf, qc->tag);
 	} else {
-		ata_sff_qc_issue(qc);
+		ap->link.active_tag =3D qc->tag;
+		/* Pass QC to libata-sff to process */
+		ata_bmdma_qc_issue(qc);
 	}
 	return 0;
 }
=20
 /*
- * Function : sata_dwc_qc_prep
- * arguments : ata_queued_cmd *qc
- * Return value : None
- * qc_prep for a particular queued command
+ * Prepare for a particular queued command
  */
=20
 static void sata_dwc_qc_prep(struct ata_queued_cmd *qc)
 {
-	if ((qc->dma_dir =3D=3D DMA_NONE) || (qc->tf.protocol =3D=3D ATA_PROT=
_PIO))
+	if ((qc->dma_dir =3D=3D DMA_NONE) || (qc->tf.protocol =3D=3D ATA_PROT=
_PIO)
+		|| (qc->tf.protocol =3D=3D ATAPI_PROT_PIO))
 		return;
=20
 #ifdef DEBUG_NCQ
 	if (qc->tag > 0)
 		dev_info(qc->ap->dev, "%s: qc->tag=3D%d ap->active_tag=3D0x%08x\n",
 			 __func__, qc->tag, qc->ap->link.active_tag);
-
-	return ;
 #endif
 }
=20
+/*
+ * Get the QC currently used for transferring data
+ */
+static struct ata_queued_cmd *sata_dwc_get_active_qc(struct ata_port *=
ap)
+{
+	struct ata_queued_cmd *qc;
+
+	qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
+	if (qc && !(qc->tf.flags & ATA_TFLAG_POLLING))
+		return qc;
+	return NULL;
+}
+
+/*
+ * dwc_lost_interrupt -  check and process if interrupt is lost.
+ * @ap: ATA port
+ *
+ * Process the command when it is timeout.
+ * Check to see if interrupt is lost. If yes, complete the qc.
+ */
+static void sata_dwc_lost_interrupt(struct ata_port *ap)
+{
+	u8 status;
+	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
+	struct ata_queued_cmd *qc;
+
+	dev_dbg(ap->dev, "%s -\n", __func__);
+	/* Only one outstanding command per SFF channel */
+	qc =3D sata_dwc_get_active_qc(ap);
+	/* We cannot lose an interrupt on a non-existent or polled command */
+	if (!qc)
+		return;
+
+	/* See if the controller thinks it is still busy - if so the command
+	 isn't a lost IRQ but is still in progress */
+	status =3D ap->ops->sff_check_altstatus(ap);
+	if (status & ATA_BUSY) {
+		ata_port_printk(ap, KERN_INFO, "%s - ATA_BUSY\n", __func__);
+		return;
+	}
+
+	/* There was a command running, we are no longer busy and we have
+	   no interrupt. */
+	ata_link_printk(qc->dev->link, KERN_WARNING,
+		"lost interrupt (Status 0x%x)\n", status);
+
+	if (sata_dwc_dma_chk_en(hsdev->dma_channel)) {
+		/* When DMA does transfer does not complete,
+		 see if DMA fails */
+		qc->err_mask |=3D AC_ERR_DEV;
+		ap->hsm_task_state =3D HSM_ST_ERR;
+		sata_dwc_dma_terminate(ap, hsdev->dma_channel);
+	}
+	sata_dwc_qc_complete(ap, qc, 1);
+}
+
+
 static void sata_dwc_error_handler(struct ata_port *ap)
 {
-	ap->link.flags |=3D ATA_LFLAG_NO_HRST;
+	bool thaw =3D false;
+	struct ata_queued_cmd *qc;
+	u8 status =3D ap->ops->bmdma_status(ap);
+
+	qc =3D sata_dwc_get_active_qc(ap);
+	/* In case of DMA timeout, process it. */
+	if (qc && ata_is_dma(qc->tf.protocol)) {
+		if ((qc->err_mask =3D=3D AC_ERR_TIMEOUT)
+			&& (status & ATA_DMA_ERR)) {
+			qc->err_mask =3D AC_ERR_HOST_BUS;
+			thaw =3D true;
+		}
+
+		if (thaw) {
+			ap->ops->sff_check_status(ap);
+			if (ap->ops->sff_irq_clear)
+				ap->ops->sff_irq_clear(ap);
+		}
+	}
+	if (thaw)
+		ata_eh_thaw_port(ap);
+
 	ata_sff_error_handler(ap);
 }
=20
+u8 sata_dwc_check_status(struct ata_port *ap)
+{
+	return ioread8(ap->ioaddr.status_addr);
+}
+
+u8 sata_dwc_check_altstatus(struct ata_port *ap)
+{
+	return ioread8(ap->ioaddr.altstatus_addr);
+}
+
 /*
  * scsi mid-layer and libata interface structures
  */
@@ -1604,7 +1931,10 @@ static struct ata_port_operations sata_dwc_ops =3D=
 {
 	.inherits		=3D &ata_sff_port_ops,
=20
 	.error_handler		=3D sata_dwc_error_handler,
+	.softreset		=3D sata_dwc_softreset,
+	.hardreset		=3D sata_dwc_hardreset,
=20
+	.qc_defer		=3D sata_dwc_qc_defer,
 	.qc_prep		=3D sata_dwc_qc_prep,
 	.qc_issue		=3D sata_dwc_qc_issue,
=20
@@ -1614,8 +1944,17 @@ static struct ata_port_operations sata_dwc_ops =3D=
 {
 	.port_start		=3D sata_dwc_port_start,
 	.port_stop		=3D sata_dwc_port_stop,
=20
+	.check_atapi_dma	=3D sata_dwc_check_atapi_dma,
 	.bmdma_setup		=3D sata_dwc_bmdma_setup,
 	.bmdma_start		=3D sata_dwc_bmdma_start,
+	.bmdma_status		=3D sata_dwc_dma_status,
+
+	.sff_dev_select		=3D sata_dwc_dev_select,
+	.sff_check_status	=3D sata_dwc_check_status,
+	.sff_check_altstatus	=3D sata_dwc_check_altstatus,
+	.sff_exec_command	=3D sata_dwc_exec_command,
+
+	.lost_interrupt		=3D sata_dwc_lost_interrupt,
 };
=20
 static const struct ata_port_info sata_dwc_port_info[] =3D {
@@ -1639,21 +1978,49 @@ static int sata_dwc_probe(struct platform_devic=
e *ofdev)
 	struct ata_port_info pi =3D sata_dwc_port_info[0];
 	const struct ata_port_info *ppi[] =3D { &pi, NULL };
=20
+	const unsigned int *dma_chan;
+
+	/* Check if device is declared in device tree */
+	if (!of_device_is_available(ofdev->dev.of_node)) {
+		printk(KERN_INFO "%s: Port disabled via device-tree\n",
+		ofdev->dev.of_node->full_name);
+		return 0;
+	}
+
 	/* Allocate DWC SATA device */
-	hsdev =3D kzalloc(sizeof(*hsdev), GFP_KERNEL);
+	hsdev =3D kmalloc(sizeof(*hsdev), GFP_KERNEL);
 	if (hsdev =3D=3D NULL) {
 		dev_err(&ofdev->dev, "kmalloc failed for hsdev\n");
 		err =3D -ENOMEM;
-		goto error;
+		goto error_out_5;
 	}
+	memset(hsdev, 0, sizeof(*hsdev));
=20
-	/* Ioremap SATA registers */
+	/* Identify host controller using compatible attribute */
+	if (of_device_is_compatible(ofdev->dev.of_node, "amcc,sata-460ex")) {
+		printk(KERN_INFO "\n\nSATA is compatible for sata-460ex\n\n");
+		hsdev->hostID =3D APM_460EX_SATA;
+	} else {
+		printk(KERN_INFO "\n\nSATA is compatible for sata-821xx\n\n");
+		hsdev->hostID =3D APM_821XX_SATA;
+	}
+
+	/* Identify SATA controller index from the cell-index property */
+	dma_chan =3D of_get_property(ofdev->dev.of_node, "dma-channel", NULL)=
;
+	if (dma_chan) {
+		dev_notice(&ofdev->dev, "Getting DMA channel %d\n", *dma_chan);
+		hsdev->dma_channel =3D *dma_chan;
+	} else {
+		hsdev->dma_channel =3D 0;
+	}
+
+	/* Get base address from device tree */
 	base =3D of_iomap(ofdev->dev.of_node, 0);
 	if (!base) {
-		dev_err(&ofdev->dev, "ioremap failed for SATA register"
-			" address\n");
+		dev_err(&ofdev->dev,
+			"ioremap failed for SATA register address\n");
 		err =3D -ENODEV;
-		goto error_kmalloc;
+		goto error_out_4;
 	}
 	hsdev->reg_base =3D base;
 	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
@@ -1666,7 +2033,7 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
 	if (!host) {
 		dev_err(&ofdev->dev, "ata_host_alloc_pinfo failed\n");
 		err =3D -ENOMEM;
-		goto error_iomap;
+		goto error_out_4;
 	}
=20
 	host->private_data =3D hsdev;
@@ -1674,7 +2041,7 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
 	/* Setup port */
 	host->ports[0]->ioaddr.cmd_addr =3D base;
 	host->ports[0]->ioaddr.scr_addr =3D base + SATA_DWC_SCR_OFFSET;
-	host_pvt.scr_addr_sstatus =3D base + SATA_DWC_SCR_OFFSET;
+	hsdev->scr_base =3D (u8 *)(base + SATA_DWC_SCR_OFFSET);
 	sata_dwc_setup_port(&host->ports[0]->ioaddr, (unsigned long)base);
=20
 	/* Read the ID and Version Registers */
@@ -1688,23 +2055,30 @@ static int sata_dwc_probe(struct platform_devic=
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
+		rc =3D dwc_dma_init(hsdev, irq);
+		if (rc !=3D 0)
+			goto error_out_1;
+	}
=20
 	/* Enable SATA Interrupts */
 	sata_dwc_enable_interrupts(hsdev);
@@ -1712,9 +2086,9 @@ static int sata_dwc_probe(struct platform_device =
*ofdev)
 	/* Get SATA interrupt number */
 	irq =3D irq_of_parse_and_map(ofdev->dev.of_node, 0);
 	if (irq =3D=3D NO_IRQ) {
-		dev_err(&ofdev->dev, "no SATA DMA irq\n");
+		dev_err(&ofdev->dev, "no SATA irq\n");
 		err =3D -ENODEV;
-		goto error_out;
+		goto error_out_1;
 	}
=20
 	/*
@@ -1728,17 +2102,22 @@ static int sata_dwc_probe(struct platform_devic=
e *ofdev)
 		dev_err(&ofdev->dev, "failed to activate host");
=20
 	dev_set_drvdata(&ofdev->dev, host);
+
 	return 0;
=20
-error_out:
-	/* Free SATA DMA resources */
-	dma_dwc_exit(hsdev);
+error_out_1:
+	iounmap(sata_dma_regs);
+
+error_out_2:
+	free_irq(hsdev->irq_dma, hsdev);
=20
-error_iomap:
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
@@ -1752,8 +2131,10 @@ static int sata_dwc_remove(struct platform_devic=
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
@@ -1763,6 +2144,7 @@ static int sata_dwc_remove(struct platform_device=
 *ofdev)
=20
 static const struct of_device_id sata_dwc_match[] =3D {
 	{ .compatible =3D "amcc,sata-460ex", },
+	{ .compatible =3D "amcc,sata-apm821xx", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sata_dwc_match);
@@ -1777,7 +2159,18 @@ static struct platform_driver sata_dwc_driver =3D=
 {
 	.remove =3D sata_dwc_remove,
 };
=20
-module_platform_driver(sata_dwc_driver);
+static int __init sata_dwc_init(void)
+{
+	return platform_driver_register(&sata_dwc_driver);
+}
+
+static void __exit sata_dwc_exit(void)
+{
+	platform_driver_unregister(&sata_dwc_driver);
+}
+
+module_init(sata_dwc_init);
+module_exit(sata_dwc_exit);
=20
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mark Miesfeld <mmiesfeld@amcc.com>");
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
