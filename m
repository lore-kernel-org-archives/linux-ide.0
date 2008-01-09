From: "Anantha Subramanyam" <ananth@broadcom.com>
Subject: [PATCH 2.6.23.11]: [sata_svw]: Add ATAPI DMA support for HT1x00
 SATA controller
Date: Wed, 9 Jan 2008 11:13:48 -0800
Message-ID: <03235919BBDE634289BB6A0758A20B3602F39355@NT-SJCA-0751.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:1172 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbYAITOE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 14:14:04 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

This patch adds ATAPI DMA support for HT1000 (aka BCM5785) & HT1100 (aka
BCM11000) SATA Controller.

Signed-off-by: Anantha Subramanyam <ananth@broadcom.com>
---
--- linux-2.6.23.11/drivers/ata/sata_svw.c.orig	2008-01-07
05:22:29.000000000 -0800
+++ linux-2.6.23.11/drivers/ata/sata_svw.c	2008-01-08
03:23:31.000000000 -0800
@@ -45,6 +45,8 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi.h>
 #include <linux/libata.h>
 
 #ifdef CONFIG_PPC_OF
@@ -53,12 +55,13 @@
 #endif /* CONFIG_PPC_OF */
 
 #define DRV_NAME	"sata_svw"
-#define DRV_VERSION	"2.3"
+#define DRV_VERSION	"2.3.1"
 
 enum {
 	/* ap->flags bits */
 	K2_FLAG_SATA_8_PORTS		= (1 << 24),
 	K2_FLAG_NO_ATAPI_DMA		= (1 << 25),
+	K2_FLAG_BAR_POS_3			= (1 << 26),
 
 	/* Taskfile registers offsets */
 	K2_SATA_TF_CMD_OFFSET		= 0x00,
@@ -88,17 +91,216 @@ enum {
 	/* Port stride */
 	K2_SATA_PORT_OFFSET		= 0x100,
 
-	board_svw4			= 0,
-	board_svw8			= 1,
+// ATAPI QDMA start
+	K2_ATAPI_FEAT_DMA_BIT	= 0x01,
+
+	/* qdma reg offsets */
+	K2_SATA_QAL_OFFSET		= 0xA0,
+	K2_SATA_QAU_OFFSET		= 0xA4,
+	K2_SATA_QPI_OFFSET		= 0xA8,
+	K2_SATA_QCI_OFFSET		= 0xAC,
+	K2_SATA_QCR_OFFSET		= 0xB0,
+	K2_SATA_QDR_OFFSET		= 0xB4,
+	K2_SATA_QSR_OFFSET		= 0xB8,
+	K2_SATA_QMR_OFFSET		= 0xBC,
+
+	K2_SATA_GLB_CTL_OFFSET	= 0x1000,
+	K2_SATA_GLB_STS_OFFSET	= 0x1004,
+
+	K2_SATA_ENABLE_INTRS		= 0x21,		// 0x3F, want
only done & common error
+	K2_SATA_CLEAR_ALL_INTRS		= 0xFFFFFFFF,
+	
+	K2_SATA_NUM_DESCRIPTORS		= 4,		// min 2 for
ATAPI, but min 4 for our hw
+	K2_SATA_QDMA_MODE_ON		= 1,
+    K2_SATA_QDMA_ENABLE        = 0x01,
+
+    K2_SATA_QDMA_PORT_RESET        = 0x08,
+    K2_SATA_QDMA_PORT_ABORT        = 0x04,
+    K2_SATA_QDMA_PORT_PAUSE        = 0x02,
+    K2_SATA_CLEAR_QDMA_QPI_REG     = 0x00,
+
+    K2_SATA_INTR_CMD_ERROR         = 0x00000020,
+    K2_SATA_INTR_DEV_CHANGE        = 0x10,
+    K2_SATA_INTR_RESET_ACK         = 0x08,
+    K2_SATA_INTR_ABORT_ACK         = 0x04,
+    K2_SATA_INTR_PAUSE_ACK         = 0x02,
+    K2_SATA_INTR_CMD_DONE          = 0x00000001,
+
+    K2_SATA_DESC_TYPE				= 0x00,
+    K2_SATA_DESC_PIO_DATA      		= 0x00,
+    K2_SATA_DESC_PIO_NON_DATA  		= 0x02,
+
+    K2_SATA_CTRL_FLAG_PIO_BIT      	= 0x80,     // PIO bit
+	K2_SATA_CTRL_FLAG_ATAPI			= 0x40,		// ATAPI
bit
+	K2_SATA_CTRL_FLAG_SKIP			= 0x10,		// SKIP
bit
+	K2_SATA_CTRL_FLAG_IGNR			= 0x08,		// IGNR
bit
+	K2_SATA_CTRL_FLAG_RD_DIR_BIT   	= 0x02,     // READ Dir bit
+    K2_SATA_CTRL_FLAG_EIN_BIT      	= 0x01,     // Enable Interrupt
bit
+
+    K2_SATA_DESC_D_BIT             	= 0x01,
+    K2_CMD_ONLY_FRM					= 0x010,    /*
No data associated with command */
+
+	K2_ATAPI_CDB_BUFSZ				= ATAPI_CDB_LEN,
+
+	K2_SATA_SELECT_DEV0				= 0xA0,
+    K2_SATA_CMD_DEVICE_RESET       	= 0x08,
+    K2_SATA_STS_BSY                	= 0x80,     // busy
+
+    K2_SATA_SCR2_RESET_PHY         	= 0x00000001,
+    K2_SATA_SCR2_CLEAR_REG         	= 0x00000000,
+
+    K2_SATA_DET_MASK               	= 0x000F,
+    K2_SATA_INTF_MASK              	= 0x0F00,
+    K2_DEV_DET_PHY_RDY             	= 0x3,
+    K2_SATA_INFT_ACTIVE            	= 0x1,
+
+    K2_SATA_10MS_WAIT              	= 10000,
+    K2_SATA_100MS_WAIT             	= 100000,
+    K2_SATA_PAUSE_ACK_TIME         	= 100,
+    K2_SATA_CLEAR_ALL_ERRORS       	= 0xffffffff,
+    K2_SATA_COM_RESET_WAIT         	= 1500,     //1.5ms
+
+    K2_SATA_QSR_PCI_MASTER_ABORT   	= (1<<21),
+    K2_SATA_QSR_DATA_CRC_ERR       	= (1<<20),
+    K2_SATA_QSR_UNDER_FLOW         	= (1<<19),
+    K2_SATA_QSR_OVER_FLOW          	= (1<<18),
+    K2_SATA_QSR_ATA_CMD_ERR        	= (1<<17),
+    K2_SATA_QSR_PCI_BUS_MASTER_ERR 	= (1<<16),
+    K2_SATA_QSR_SATA_INTF_ERR      	= (1<<6),
+	K2_SATA_QSR_ATAPI_UNDERRUN		= (1<<22),
+
+	chip_svw4			= 0,
+	chip_svw8			= 1,
+	chip_svwx			= 2,
+	chip_svw41			= 3,
+// ATAPI QDMA end
+
+// HT1100 additions
+    K2_SATA_SATADBGREG               = 0xF0,
+    // K2_SATA_LEDENREG            	= 0x5000,
+    K2_SATA_TESTCTRLREG         	= 0x10f0,
+    K2_SATA_MDIOCTRLREG         	= 0x8c,
+    // K2_SATA_PLLCTRLREG          	= 0x84,
+
+    K2_SATA_PLL_WAIT               	= 990,//100000,//90000,
+    K2_SATA_LED_ENABLE_VALUE       	= 0x00000002,
+    K2_SATA_TEST_CTRL_VALUE        	= 0x40000001,
+    K2_SATA_PLL_CTRL_VALUE         	= 0x08000000,
+    K2_SATA_PLL_1P5_GIG				= 0,
+    K2_SATA_PLL_3P0_GIG				= 1,
+    K2_SATA_RESET_PHY_DELAY        	= 0x3000,
+
+	// phy vals
+    BCM_SATA_PHY_TXCNT_1G5  = 0x7830,
+    BCM_SATA_PHY_TXCNT_3G0  = 0xF620,
+    BCM_SATA_PHY_RXCNT_1G5  = 0x0180,
+    BCM_SATA_PHY_RXCNT_3G0  = 0x0190,
+
+	chip_svw42			= 4,	// HT1100 bar 3
+	chip_svw43			= 5,	// HT1100 bar 5
+	// HT1100 addns end
+
 };
 
+/* SATA Command Descriptor Structure */
+
+typedef struct _k2_sata_cmd_desc_s {
+#ifdef __BIG_ENDIAN
+    u8              ss_Rsvd3;
+    u8              ss_PortMul;
+    u8              ss_CtrlFlags;
+    u8              ss_DescType;
+    u16             sw_Tag;
+    u16             sw_HostMemDataBuffAddr;
+    u32             sl_PrdTblBaseLow;
+    u16             sw_PrdCount;
+    u16             sw_PrdTblBaseHigh;
+    u16             sw_Features;
+    u8              ss_DevHead;
+    u8              ss_SataCmd;
+    u32             sl_LbaLow;
+    u16             sw_SectorCount;
+    u16             sw_LbaHigh;
+    u32             sl_Rsvd1c;
+#else
+    u8              ss_DescType;
+    u8              ss_CtrlFlags;
+    u8              ss_PortMul;
+    u8              ss_Rsvd3;
+    u16             sw_HostMemDataBuffAddr;
+    u16             sw_Tag;
+    u32             sl_PrdTblBaseLow;
+    u16             sw_PrdTblBaseHigh;
+    u16             sw_PrdCount;
+    u8              ss_SataCmd;
+    u8              ss_DevHead;
+    u16             sw_Features;
+    u32             sl_LbaLow;
+    u16             sw_LbaHigh;
+    u16             sw_SectorCount;
+    u32             sl_Rsvd1c;
+#endif
+} k2_sata_cmd_desc_t;
+
+
+typedef struct _k2_sata_port_info_s {
+    u8      qpi;
+    u8      qci;
+    u8      qdma_mode;
+    u32     qcr_local;
+
+    // qdma related addrs
+    void __iomem    *qal_addr;
+    void __iomem    *qau_addr;
+    void __iomem    *qpi_addr;
+    void __iomem    *qci_addr;
+    void __iomem    *qcr_addr;
+    void __iomem    *qdr_addr;
+    void __iomem    *qsr_addr;
+    void __iomem    *qmr_addr;
+
+    // desc area and addresses
+    dma_addr_t      cmd_desc_addr;
+    k2_sata_cmd_desc_t* pcmd_desc;
+
+    dma_addr_t      cdb_phy_addr;
+    u8              *pcdb_cpybuf;
+
+    u8  needs_reset;
+
+    // atapi related
+    u8  is_atapi_device;
+    u32 qsr_saved;
+    u32 atapi_reset_cnt;
+    u32 atapi_capabilities;
+
+} k2_sata_port_info;
+
+
+int skip_init = 0;
+module_param(skip_init, int, 0444);
+MODULE_PARM_DESC( skip_init, "Initialization done by BIOS");
+
+
 static u8 k2_stat_check_status(struct ata_port *ap);
 
 
 static int k2_sata_check_atapi_dma(struct ata_queued_cmd *qc)
 {
+	u8 command = qc->scsicmd->cmnd[0];
+
 	if (qc->ap->flags & K2_FLAG_NO_ATAPI_DMA)
 		return -1;	/* ATAPI DMA not supported */
+	else
+	{
+		// DMA is for only read or write commands
+		if( (command == READ_10) || (command == READ_16) ||
(command == READ_12)
+			|| (command == WRITE_10) || (command ==
WRITE_16) || (command == WRITE_12))
+			// TODO may need to check the dynamic flag in
pspi rather than unconditional ok
+			return 0;
+		else
+			return -1;
+	}
 
 	return 0;
 }
@@ -305,6 +507,612 @@ static int k2_sata_proc_info(struct Scsi
 }
 #endif /* CONFIG_PPC_OF */
 
+// ATAPI QDMA start
+
+#define K2_IS_SATA_STS_GOOD(sata_sts)      \
+    (((sata_sts & K2_SATA_DET_MASK) == K2_DEV_DET_PHY_RDY) &&
(((sata_sts & K2_SATA_INTF_MASK)>>8) == K2_SATA_INFT_ACTIVE))
+
+
+void k2_ht1x_qdma_disable(struct ata_port *ap);
+
+
+int k2_ht1x_port_start (struct ata_port *ap)
+{
+	struct device *dev = ap->dev;
+	int rc;
+	k2_sata_port_info* pspi;
+	ap->private_data = NULL;
+
+	rc = ata_port_start( ap);
+	if( rc)
+		return rc;
+
+	// do our qdma descriptor space alloc, we use prd from ata port
itself
+	pspi = kmalloc(sizeof(k2_sata_port_info), GFP_KERNEL);
+	if (pspi == NULL) {
+		rc = -ENOMEM;
+		goto start_err_out;
+	}
+
+	ap->private_data = pspi;
+
+	pspi->pcmd_desc = dma_alloc_coherent(dev, sizeof(
k2_sata_cmd_desc_t) * K2_SATA_NUM_DESCRIPTORS, &pspi->cmd_desc_addr,
GFP_KERNEL);
+	if (pspi->pcmd_desc == NULL) {
+		kfree( pspi);
+		rc = -ENOMEM;
+		goto start_err_out;
+	}
+
+	pspi->pcdb_cpybuf = dma_alloc_coherent(dev, K2_ATAPI_CDB_BUFSZ,
&pspi->cdb_phy_addr, GFP_KERNEL);
+	if (pspi->pcdb_cpybuf == NULL) 
+	{
+		dma_free_coherent(dev, sizeof( k2_sata_cmd_desc_t) *
K2_SATA_NUM_DESCRIPTORS, pspi->pcmd_desc, pspi->cmd_desc_addr);
+		kfree( pspi);
+		rc = -ENOMEM;
+		goto start_err_out;
+	}
+
+	// data_addr is at 0 offset
+	pspi->qal_addr = ap->ioaddr.data_addr + K2_SATA_QAL_OFFSET;
+	pspi->qau_addr = ap->ioaddr.data_addr + K2_SATA_QAU_OFFSET;
+	pspi->qpi_addr = ap->ioaddr.data_addr + K2_SATA_QPI_OFFSET;
+	pspi->qci_addr = ap->ioaddr.data_addr + K2_SATA_QCI_OFFSET;
+	pspi->qcr_addr = ap->ioaddr.data_addr + K2_SATA_QCR_OFFSET;
+	pspi->qdr_addr = ap->ioaddr.data_addr + K2_SATA_QDR_OFFSET;
+	pspi->qsr_addr = ap->ioaddr.data_addr + K2_SATA_QSR_OFFSET;
+	pspi->qmr_addr = ap->ioaddr.data_addr + K2_SATA_QMR_OFFSET;
+
+	VPRINTK("svw qal 0x%x qsr addr 0x%x ioaddr 0x%x\n",
pspi->qal_addr, pspi->qsr_addr, ap->ioaddr.data_addr);
+
+	// init our stuff
+	pspi->qpi = 0;
+	pspi->qci = 0;
+	pspi->qdma_mode = 0;
+
+	writeb( 0, pspi->qci_addr);
+	writeb( 0, pspi->qpi_addr);
+	pspi->qcr_local = 0;
+	writel( pspi->qcr_local, pspi->qcr_addr);
+	writel( K2_SATA_CLEAR_ALL_INTRS, pspi->qsr_addr);
+
+	// writel( K2_SATA_ENABLE_INTRS, pspi->qmr_addr);
+	writel( K2_SATA_NUM_DESCRIPTORS - 1, pspi->qdr_addr);
+
+	pspi->needs_reset = 0;	
+	pspi->is_atapi_device = 0;	// will be set anytime we get a
atapi cmd on the port
+	pspi->atapi_reset_cnt = 0;
+	pspi->atapi_capabilities = 0;		// if v need to disable
dma on the fly becoz of too many errors etc
+
+	return 0;
+
+start_err_out:
+
+	return rc;
+}
+
+void k2_ht1x_port_stop (struct ata_port *ap)
+{
+	struct device *dev = ap->dev;
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+
+	if( pspi == NULL)
+		return;
+
+	k2_ht1x_qdma_disable( ap);
+
+	// free our private data first, then call generic
+	dma_free_coherent(dev, sizeof( k2_sata_cmd_desc_t) *
K2_SATA_NUM_DESCRIPTORS, pspi->pcmd_desc, pspi->cmd_desc_addr);
+	dma_free_coherent(dev, K2_ATAPI_CDB_BUFSZ, pspi->pcdb_cpybuf,
pspi->cdb_phy_addr);
+	kfree( pspi);
+
+}
+
+/*
+	Some helper functions
+*/
+
+void k2_ht1x_qdma_enable(struct ata_port *ap)
+{
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+
+	pspi->qpi = 0;
+	pspi->qci = 0;
+
+	pspi->qcr_local = K2_SATA_QDMA_ENABLE;
+
+	writel( cpu_to_le32(pspi->cmd_desc_addr & 0xffffffff),
pspi->qal_addr);
+	
+	// our dma mask is 32bit, so v assume 0 for upper bits
+	// similar to what libata does for prd addresses
+	// as below causes grief in 32bit single CPU flavour
+	// writel( cpu_to_le32( (pspi->cmd_desc_addr >> 32) & 0xffff),
pspi->qau_addr);
+	writel( 0, pspi->qau_addr);
+
+	writeb( 0, pspi->qci_addr);
+	writeb( 0, pspi->qpi_addr);
+	writel( K2_SATA_CLEAR_ALL_INTRS, pspi->qsr_addr);
+	writel( K2_SATA_NUM_DESCRIPTORS - 1, pspi->qdr_addr);
+
+	writel( K2_SATA_ENABLE_INTRS, pspi->qmr_addr);
+	writel( pspi->qcr_local, pspi->qcr_addr);
+
+
+}
+
+void k2_ht1x_qdma_disable(struct ata_port *ap)
+{
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+
+	// disable qdma first
+	pspi->qcr_local = 0;
+	writel( pspi->qcr_local, pspi->qcr_addr);
+
+	pspi->qpi = 0;
+	pspi->qci = 0;
+	pspi->qdma_mode = 0;
+
+	writeb( 0, pspi->qci_addr);
+	writeb( 0, pspi->qpi_addr);
+	writel( K2_SATA_CLEAR_ALL_INTRS, pspi->qsr_addr);
+	writel( 0, pspi->qmr_addr);
+	writel( 0, pspi->qdr_addr);
+
+}
+
+int k2_ht1x_qdma_pause(struct ata_port *ap, int pause)
+{
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+	u32 qsr;
+	volatile int i = 0;
+
+	// if qdma is not enabled nothing todo, pause or unpause
+	if( !(pspi->qcr_local & K2_SATA_QDMA_ENABLE) )
+		return 0;
+
+	// pause qdma first, 
+	// disable intr on pause ack, we will poll for it as we don't q
cmds
+	if( !(pspi->qcr_local & K2_SATA_QDMA_PORT_PAUSE) && pause)
+	{
+		pspi->qcr_local |= K2_SATA_QDMA_PORT_PAUSE;
+		writel( pspi->qcr_local, pspi->qcr_addr);
+
+		// wait for pause ack
+		while( i++ < 200)
+		{
+			udelay( 5);
+
+			if( (qsr = readl( pspi->qsr_addr)) &
K2_SATA_INTR_PAUSE_ACK)
+			{
+				writel( qsr, pspi->qsr_addr);
+				break;
+			}
+		}
+
+		if( i == 200)
+		{
+			pspi->qcr_local &= ~K2_SATA_QDMA_PORT_PAUSE;
+			return -1;	// we couldn't pause in 10
msecs, we have problems.....
+		}
+
+	}
+	else
+	//  we need to unpause
+	if( (pspi->qcr_local & K2_SATA_QDMA_PORT_PAUSE) && !pause)
+	{
+
+		pspi->qcr_local &= ~K2_SATA_QDMA_PORT_PAUSE;
+		writel( pspi->qcr_local, pspi->qcr_addr);
+	}
+
+	return 0;
+}
+
+
+int k2_build_atapi_cmd_desc(struct ata_queued_cmd *qc,
k2_sata_cmd_desc_t *desc, u8 flags)
+{
+	struct ata_port *ap = qc->ap;
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+
+	memset(desc, 0, sizeof(k2_sata_cmd_desc_t));
+
+	desc->ss_CtrlFlags = flags;
+	desc->ss_SataCmd = 0xA0;	// ATAPI Pkt Cmd
+	desc->ss_DevHead = 0xA0;
+
+	// as per libata atapi_xlat func, this is set for only pio
+	desc->sl_LbaLow = 0;
+	desc->sw_LbaHigh = 0;
+
+	if (flags & K2_SATA_CTRL_FLAG_ATAPI) 
+	{
+		// ATAPI CDB Packet Transfer
+		// Set the CDB pad to zero
+		memset(pspi->pcdb_cpybuf, 0, K2_ATAPI_CDB_BUFSZ);
+		memcpy(pspi->pcdb_cpybuf, qc->cdb, qc->dev->cdb_len);
+
+		desc->sl_PrdTblBaseLow = cpu_to_le32( pspi->cdb_phy_addr
| 0x01);
+		desc->sw_PrdTblBaseHigh = 0;
+		desc->sw_PrdCount = qc->dev->cdb_len;
+		desc->sw_Features = K2_ATAPI_FEAT_DMA_BIT;
+	} 
+	else	// it is the data desc
+	{
+		// libata does not update this field when splitting
prd's for 64kb crossover
+		// so examine eot bit in first prd element to confirm
+		// if(qc->n_elem == 1) {
+		if( (ap->prd[0].flags_len & cpu_to_le32(ATA_PRD_EOT) )
!= 0) {
+			desc->sl_PrdTblBaseLow    = ap->prd[0].addr |
0x01;	// already in le format
+			desc->sw_PrdTblBaseHigh   = 0;	// revisit to
add >4GB support, ata_fill_sg can't be used then
+			desc->sw_PrdCount         = ap->prd[0].flags_len
& 0xFFFF;
+
+		}
+		else
+		{
+			desc->sl_PrdTblBaseLow    =
cpu_to_le32(ap->prd_dma);
+			desc->sw_PrdTblBaseHigh   = 0;	// v reuse same
prd table everytime
+		}
+
+	}
+
+	return 0;
+}
+
+void k2_ht1x_qdma_post_atapi(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+
+	u8 flags = 0;
+
+	k2_sata_cmd_desc_t* pcdesc = pspi->pcmd_desc + pspi->qpi;
+
+	flags  = K2_SATA_CTRL_FLAG_ATAPI | K2_SATA_CTRL_FLAG_PIO_BIT;
//  | K2_SATA_CTRL_FLAG_EIN_BIT;
+	k2_build_atapi_cmd_desc( qc, pcdesc, flags);
+
+	flags = K2_SATA_CTRL_FLAG_EIN_BIT;
+
+	if( !(qc->tf.flags & ATA_TFLAG_WRITE) ) 
+		flags |= K2_SATA_CTRL_FLAG_RD_DIR_BIT;
+	pcdesc++;
+	k2_build_atapi_cmd_desc( qc, pcdesc, flags);
+
+	pspi->qpi = (pspi->qpi + 2) % K2_SATA_NUM_DESCRIPTORS;
+
+	writel( pspi->qpi, pspi->qpi_addr);
+
+
+}
+
+
+/*
+later version of libata (kernel 2.6.18 & later) have a elaborate
+error handling mech that includes multilevel of resets (soft, hard,
post...)  
+so we plug into that
+
+*/
+int k2_ht1x_atapi_soft_reset(struct ata_port *ap, unsigned int *class)
+{
+	u8	dev_sts;
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	int count = 5;
+
+	writel( K2_SATA_SELECT_DEV0, ioaddr->device_addr );
+	udelay( 500);
+	writel( K2_SATA_CMD_DEVICE_RESET, ioaddr->command_addr );
+
+	// this can take upto 5 secs
+	do
+	{
+		dev_sts = ata_busy_wait( ap, 100000, K2_SATA_STS_BSY);
+		count--;
+	} while( ( dev_sts & K2_SATA_STS_BSY) && (count > 0) );
+
+	if (dev_sts & K2_SATA_STS_BSY) {
+		printk("sata_svw : Busy still set after soft reset
dev_sts=%x\n", dev_sts);
+		return -EIO;
+	}
+
+	*class = ata_dev_try_classify(ap, 0, NULL);
+	return 0;
+}
+
+
+int k2_ht1x_atapi_reset(struct ata_port *ap, unsigned int *class)
+{
+	u32	dev_sts, sata_sts, qsr, i;
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+	int ret = 0;
+	
+
+	// if (port->atapi.capabilities & ELR_ATAPI_QDMA) 
+	{
+		k2_ht1x_qdma_disable( ap);
+
+		// Do a PHY reset 
+		// Power Down Phy
+		k2_sata_scr_write( ap, (K2_SATA_SCR_CONTROL_OFFSET -
K2_SATA_SCR_STATUS_OFFSET), K2_SATA_SCR2_RESET_PHY );
+		// Delay 1.5ms
+		udelay( K2_SATA_COM_RESET_WAIT);
+		// Power Up Phy
+		k2_sata_scr_write( ap, (K2_SATA_SCR_CONTROL_OFFSET -
K2_SATA_SCR_STATUS_OFFSET), K2_SATA_SCR2_CLEAR_REG );
+		// Delay 1ms : Most drives should be ready within 1ms
+		udelay( K2_SATA_COM_RESET_WAIT);
+		//  delay up to 2 seconds, this should be ok for SATA I
and SATA II drives
+		for (i = 0; i < 20; i++) {
+			//  check if drive exist again
+			k2_sata_scr_read( ap, 0, &sata_sts );
+			dev_sts = k2_stat_check_status( ap);
+			//  drive exist and ready
+			if (K2_IS_SATA_STS_GOOD(sata_sts) && (!(dev_sts
& K2_SATA_STS_BSY))) {
+				//  Initialize Registers
+				k2_sata_scr_write( ap,
(K2_SATA_SCR_ERROR_OFFSET - K2_SATA_SCR_STATUS_OFFSET),
K2_SATA_CLEAR_ALL_ERRORS );
+				qsr = readl( pspi->qsr_addr);
+				writel( qsr, pspi->qsr_addr);
+	
+				VPRINTK( "PHY Reset on Port[%x] i=%x
DrvSts=%x SataSts=%x SUCCESSFULLY Completed\n",
+					ap->port_no, i, dev_sts,
sata_sts);
+				break;
+			}
+			//  check every 1 milli second, most of the
drive will be ready in a milli second
+			msleep( K2_SATA_100MS_WAIT / 1000);
+		}
+		if (i == 20) {
+			DPRINTK("\n\nPHY Reset on Port[%x] DrvSts=%x
SataSts=%x FAILED\n\n",
+				ap->port_no, dev_sts, sata_sts);
+			ret = -EIO;
+		}
+
+		// QDMA Reset
+        writel( (K2_SATA_QDMA_PORT_RESET|K2_SATA_QDMA_ENABLE),
pspi->qcr_addr);
+        // Wait for the Reset ack
+   		for (i = 0; i < K2_SATA_PAUSE_ACK_TIME; i++) {
+			qsr = readl( pspi->qsr_addr);
+			if (qsr & K2_SATA_INTR_RESET_ACK) break;
+			udelay( K2_SATA_10MS_WAIT);
+		}
+        if (i == K2_SATA_PAUSE_ACK_TIME) {
+            printk("sata_svw : Port[%x] ATAPI Reset FAILED QSR=%x\n",
ap->port_no, qsr);
+			ret = -EIO;
+        }
+
+		qsr = readl( pspi->qsr_addr);
+		writel( qsr, pspi->qsr_addr);
+		// Clear bit 5 in QSR if set
+		if (qsr & K2_SATA_INTR_CMD_ERROR)
+			writel( qsr, pspi->qsr_addr);
+		k2_sata_scr_write( ap, (K2_SATA_SCR_ERROR_OFFSET -
K2_SATA_SCR_STATUS_OFFSET), K2_SATA_CLEAR_ALL_ERRORS );
+	}
+	
+	if( ret != 0)
+		return ret;
+
+
+	// Enable QDMA
+	k2_ht1x_qdma_enable( ap);
+
+	*class = ata_dev_try_classify(ap, 0, NULL);
+	return 0;
+}
+
+
+inline unsigned int k2_ht1x_handle_qdma_error (struct ata_port *ap,
+				   struct ata_queued_cmd *qc, u32 qsr)
+{
+	u8 status;
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+
+	k2_ht1x_qdma_pause( ap, 1);
+	DPRINTK("qdma atapi error 0x%x\n", qsr);
+
+	// all tf registers specifically sts maintain their contents, so
fall into libata's complete fn
+	if( qsr & K2_SATA_QSR_PCI_BUS_MASTER_ERR)
+	{
+		qc->err_mask |= AC_ERR_HOST_BUS;
+		ap->hsm_task_state = HSM_ST_ERR;
+	}
+
+	status = k2_stat_check_status( ap);
+
+	if( (qsr & K2_SATA_QSR_OVER_FLOW) || ( pspi->qci != pspi->qpi) )
+	{
+		printk( "sata_svw needs_reset=1 qsr 0x%x\n", qsr);
+		pspi->qsr_saved = qsr;
+		pspi->needs_reset = 1;
+		qc->err_mask |= AC_ERR_HSM;		
+		// this will freeze the port & ops->error_handler is
then invoked to thaw the port
+		// and do other bad things like reset (hard, soft) etc
+	}
+
+	ata_hsm_move( ap, qc, status, 0);
+	return 0;
+
+}
+
+inline unsigned int k2_ht1x_qdma_intr (struct ata_port *ap,
+				   struct ata_queued_cmd *qc)
+{
+	u32 qsr;
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+
+	VPRINTK("ata%u: protocol %d task_state %d\n",
+		ap->id, qc->tf.protocol, ap->hsm_task_state);
+
+	/* Check whether we are expecting interrupt in this state */
+	switch (ap->hsm_task_state) {
+	case HSM_ST_LAST:
+		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
+		{
+
+			// do some qdma qsr processing here
+			qsr = readl( pspi->qsr_addr);
+
+			// check if there is an error, if not make sure
it is the done for the 2nd cmd
+			writel( qsr, pspi->qsr_addr);
+			pspi->qci = readl( pspi->qci_addr);
+			if( qsr & K2_SATA_INTR_CMD_ERROR)
+			{
+				// clear qsr common error bit
+				writel( qsr, pspi->qsr_addr);
+
+				k2_ht1x_handle_qdma_error( ap, qc, qsr);
+				return 1;	/* irq handled */
+			}
+			else
+			{
+				if( pspi->qci != pspi->qpi)
+				{
+					printk("sata_svw STOP stuck
without error qsr 0x%x\n", qsr);
+					return 0;
+				}
+
+
+				// yay! v got a normal completion, let
us finish it
+				ap->hsm_task_state = HSM_ST_IDLE;
+
+				// for now just clear tf read flag,
hopefully it is used only in error path
+				qc->flags &= ~ATA_QCFLAG_RESULT_TF;
+				ata_qc_complete( qc);
+				return 1;	/* irq handled */
+			}
+		}
+		else
+			printk("wrong protocol, we shouldn't hv been
here %d \n", qc->tf.protocol);
+		break;
+
+
+	default:
+		break;	// goto idle_irq;
+	}
+
+	return 0;	/* irq not handled */
+}
+
+
+irqreturn_t k2_ht1x_interrupt (int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	unsigned int i;
+	unsigned int handled = 0;
+	unsigned long flags;
+	k2_sata_port_info* pspi;
+	u32 glbsts;
+	struct ata_port *ap;
+	struct ata_queued_cmd *qc;
+
+	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
+	spin_lock_irqsave(&host->lock, flags);
+
+	ap = host->ports[0];
+	glbsts = readl( ap->ioaddr.data_addr + K2_SATA_GLB_STS_OFFSET);
+	for (i = 0; i < host->n_ports; i++) 
+	{
+		if( glbsts & (1 << i) )
+			// '1' bit indicates no interrupt on this port,
keep moving
+			continue;
+
+		ap = host->ports[i];
+
+		if (ap &&
+		    !(ap->flags & ATA_FLAG_DISABLED)) {
+			pspi = (k2_sata_port_info*)ap->private_data;
+			if( !pspi)
+			{
+				VPRINTK("pspi not set port %d \n", i);
+				continue;
+			}
+
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (qc && 
+			    (qc->flags & ATA_QCFLAG_ACTIVE))
+			{
+				if( (pspi->qcr_local &
K2_SATA_QDMA_ENABLE) &&
+						!(pspi->qcr_local &
K2_SATA_QDMA_PORT_PAUSE) )
+					handled |= k2_ht1x_qdma_intr(
ap, qc);
+				else
+				if( !(qc->tf.flags & ATA_TFLAG_POLLING))
+					// let libata's nice handler
take care of it
+					handled |= ata_host_intr(ap,
qc);
+			}
+
+		}
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
+unsigned int k2_ht1x_qc_issue_prot(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+
+	/* start the command */
+	switch (qc->tf.protocol) {
+
+	// ATA stuff fall through to libata
+	case ATA_PROT_NODATA:
+	case ATA_PROT_PIO:
+	case ATA_PROT_DMA:
+		pspi->is_atapi_device = 0;
+		return ata_qc_issue_prot( qc);
+		break;
+
+	case ATA_PROT_ATAPI:
+	case ATA_PROT_ATAPI_NODATA:
+		pspi->is_atapi_device = 1;
+		if( (pspi->qcr_local & K2_SATA_QDMA_ENABLE) && 
+			!(pspi->qcr_local & K2_SATA_QDMA_PORT_PAUSE) )
+			k2_ht1x_qdma_pause( ap, 1);
+
+		return ata_qc_issue_prot( qc);
+		break;
+
+
+	case ATA_PROT_ATAPI_DMA:
+		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
+		pspi->is_atapi_device = 1;
+
+		if( !(pspi->qcr_local & K2_SATA_QDMA_ENABLE) )
+			k2_ht1x_qdma_enable( ap);
+		else
+		// unpause if needed
+		if( pspi->qcr_local & K2_SATA_QDMA_PORT_PAUSE)
+			k2_ht1x_qdma_pause( ap, 0);
+
+		k2_ht1x_qdma_post_atapi( qc);
+
+		ap->hsm_task_state = HSM_ST_LAST;
+		break;
+
+	default:
+		WARN_ON(1);
+		return AC_ERR_SYSTEM;
+	}
+
+	return 0;
+}
+
+void k2_sata_error_handler(struct ata_port *ap)
+{
+	k2_sata_port_info* pspi = (k2_sata_port_info*)ap->private_data;
+
+	if( !pspi->is_atapi_device)
+	{
+		// let libata do all the hard work
+		ata_bmdma_error_handler( ap);
+		return;
+	}
+
+	// if we have atapi then likely we used qdma and hung on that
+	// so we use our soft & hardresets
+	ata_bmdma_drive_eh(ap, ata_std_prereset,
k2_ht1x_atapi_soft_reset, k2_ht1x_atapi_reset,
+			   ata_std_postreset);
+
+}
+
+// ATAPI QDMA end
+
 
 static struct scsi_host_template k2_sata_sht = {
 	.module			= THIS_MODULE,
@@ -346,6 +1154,7 @@ static const struct ata_port_operations 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
 	.error_handler		= ata_bmdma_error_handler,
+	.irq_handler		= ata_interrupt,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.irq_on			= ata_irq_on,
@@ -355,8 +1164,42 @@ static const struct ata_port_operations 
 	.port_start		= ata_port_start,
 };
 
+// ATAPI QDMA start
+
+static const struct ata_port_operations k2_ht1x_ops = {
+	.port_disable		= ata_port_disable,
+	.tf_load		= k2_sata_tf_load,
+	.tf_read		= k2_sata_tf_read,
+	.check_status		= k2_stat_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+	.check_atapi_dma	= k2_sata_check_atapi_dma,
+	.bmdma_setup		= k2_bmdma_setup_mmio,
+	.bmdma_start		= k2_bmdma_start_mmio,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= k2_ht1x_qc_issue_prot,
+	.data_xfer		= ata_data_xfer,
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= k2_sata_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.irq_handler		= k2_ht1x_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
+	.scr_read		= k2_sata_scr_read,
+	.scr_write		= k2_sata_scr_write,
+	.port_start		= k2_ht1x_port_start,
+	.port_stop		= k2_ht1x_port_stop,
+};
+
+// ATAPI QDMA end
+
+
 static const struct ata_port_info k2_port_info[] = {
-	/* board_svw4 */
+	/* chip_svw4 */
 	{
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA,
@@ -365,7 +1208,7 @@ static const struct ata_port_info k2_por
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &k2_sata_ops,
 	},
-	/* board_svw8 */
+	/* chip_svw8 */
 	{
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | K2_FLAG_NO_ATAPI_DMA |
@@ -375,8 +1218,156 @@ static const struct ata_port_info k2_por
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &k2_sata_ops,
 	},
+	/* chip_svwx */
+	{
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | K2_FLAG_BAR_POS_3, 
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &k2_ht1x_ops,
+	},
+	/* chip_svw41 */
+	{
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO, 
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &k2_ht1x_ops,
+	},
+	/* chip_svw42 */
+	{
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO | K2_FLAG_BAR_POS_3,
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &k2_sata_ops,
+	},
+	/* chip_svw43 */
+	{
+		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO,
+		.pio_mask	= 0x1f,
+		.mwdma_mask	= 0x07,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &k2_sata_ops,
+	},
 };
 
+// HT1100 addns
+inline void k2_lnx_sleep( u32 usec_delay)
+{
+    (usec_delay > 1000) ? mdelay(usec_delay/1000 + 1):
udelay(usec_delay);
+}
+
+ 
+#define K2_SATA_WAIT_MDIO_DONE(reg)       \
+{   \
+    u32     tmp_reg, to = 1000; \
+    while (to) {    \
+        tmp_reg = cpu_to_le32( readl(reg) );   \
+        if (tmp_reg & (1 << 15)) {  \
+            break;  \
+        }   \
+        k2_lnx_sleep( 10);  \
+        to--;   \
+    }   \
+}
+ 
+#define K2_IS_SATA_STS_GOOD(sata_sts)      \
+    (((sata_sts & K2_SATA_DET_MASK) == K2_DEV_DET_PHY_RDY) &&
(((sata_sts & K2_SATA_INTF_MASK)>>8) == K2_SATA_INFT_ACTIVE))
+
+
+inline void k2_sata_port_reset_phy_start_oob( void __iomem
*mmio_port_base, u32 ul_satainitval)
+{
+    u32 oob_try = 0, sata_sts;
+
+    writel( ul_satainitval, (mmio_port_base + K2_SATA_SATADBGREG) );
+    k2_lnx_sleep( K2_SATA_RESET_PHY_DELAY);
+
+    // Retry oob up to 5 times
+    do {
+        writel( K2_SATA_SCR2_RESET_PHY, (mmio_port_base +
K2_SATA_SCR_CONTROL_OFFSET) );
+        k2_lnx_sleep( K2_SATA_RESET_PHY_DELAY);
+
+        writel( K2_SATA_SCR2_CLEAR_REG, (mmio_port_base +
K2_SATA_SCR_CONTROL_OFFSET) );
+        k2_lnx_sleep( K2_SATA_RESET_PHY_DELAY);
+
+        sata_sts = readl( mmio_port_base + K2_SATA_SCR_STATUS_OFFSET);
+    } while ((!K2_IS_SATA_STS_GOOD(sata_sts)) && (++oob_try < 5));
+
+}
+
+ 
+inline void k2_sata_pll_init(void __iomem *mmio_base, u32 link_rate,
u32 portnum)
+{
+    u32     ul_PortSelect=0;
+    u32     ul_initval, ul_voltval, mdioctrl;
+ 
+ 
+    /* MDIO access is accessible only through Port 0, so we take mmio
base as input */
+ 
+    // Enable MDIO Space
+    writel( K2_SATA_TEST_CTRL_VALUE, ( mmio_base + K2_SATA_TESTCTRLREG)
);
+    k2_lnx_sleep( K2_SATA_PLL_WAIT);
+ 
+    /* mdio reg: 31:16  - r/w data
+     *           15     - done
+     *           14:13  - r(10) w(01)
+     *           12:8   - device address
+     *           7:5    - res
+     *           4:0    - reg addr
+     */
+
+	// pll workaround
+    writel( 0x4002, (mmio_base + K2_SATA_MDIOCTRLREG));
+    K2_SATA_WAIT_MDIO_DONE(mmio_base + K2_SATA_MDIOCTRLREG);
+	mdioctrl = readl( mmio_base + K2_SATA_MDIOCTRLREG) >> 16;
+	// clear bit 2
+	mdioctrl &= ~0x04;
+	mdioctrl = mdioctrl << 16;
+    writel( mdioctrl | 0x2002, (mmio_base + K2_SATA_MDIOCTRLREG));
+    K2_SATA_WAIT_MDIO_DONE(mmio_base + K2_SATA_MDIOCTRLREG);
+
+
+    ul_PortSelect = (((1 << portnum) << 16) | (0x2007));
+ 
+    if (link_rate == K2_SATA_PLL_1P5_GIG) 
+	{
+        //550 mV (Main Driver), 0% pre-emphasis, 0% Bias for SATA 1.5G
: voltval=0x7830
+        ul_voltval = (BCM_SATA_PHY_TXCNT_1G5 << 16) | 0x200a;
+        ul_initval = (BCM_SATA_PHY_RXCNT_1G5 << 16) | 0x2008;
+    } 
+	else 
+	{
+        //750 mV (Main Driver), 20% pre-emphasis, 0% Bias for 3G :
voltval=0xF620
+        ul_voltval = (BCM_SATA_PHY_TXCNT_3G0 << 16) | 0x200a;
+        ul_initval = (BCM_SATA_PHY_RXCNT_3G0 << 16) | 0x2008;
+    }
+ 
+    writel( ul_PortSelect, (mmio_base + K2_SATA_MDIOCTRLREG));
+    K2_SATA_WAIT_MDIO_DONE(mmio_base + K2_SATA_MDIOCTRLREG);
+ 
+    writel( ul_initval, (mmio_base + K2_SATA_MDIOCTRLREG));
+    K2_SATA_WAIT_MDIO_DONE(mmio_base + K2_SATA_MDIOCTRLREG);
+ 
+    writel( ul_voltval, (mmio_base + K2_SATA_MDIOCTRLREG));
+    K2_SATA_WAIT_MDIO_DONE(mmio_base + K2_SATA_MDIOCTRLREG);
+ 
+    // Disable MDIO Access
+    mdioctrl = readl( mmio_base + K2_SATA_TESTCTRLREG);
+    mdioctrl &= (~K2_SATA_TEST_CTRL_VALUE);
+    writel( mdioctrl | 0x01, (mmio_base + K2_SATA_TESTCTRLREG) );
+    k2_lnx_sleep( K2_SATA_PLL_WAIT);
+ 
+}
+
+// HT1100 end
+
+
+
 static void k2_sata_setup_port(struct ata_ioports *port, void __iomem
*base)
 {
 	port->cmd_addr		= base + K2_SATA_TF_CMD_OFFSET;
@@ -399,12 +1390,12 @@ static void k2_sata_setup_port(struct at
 
 static int k2_sata_init_one (struct pci_dev *pdev, const struct
pci_device_id *ent)
 {
-	static int printed_version;
+	static int printed_version = 0;
 	const struct ata_port_info *ppi[] =
 		{ &k2_port_info[ent->driver_data], NULL };
 	struct ata_host *host;
 	void __iomem *mmio_base;
-	int n_ports, i, rc;
+	int n_ports, i, rc, bar_pos;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version "
DRV_VERSION "\n");
@@ -418,6 +1409,10 @@ static int k2_sata_init_one (struct pci_
 	if (!host)
 		return -ENOMEM;
 
+	bar_pos = 5;
+	if (ppi[0]->flags & K2_FLAG_BAR_POS_3)
+		bar_pos = 3;
+
 	/*
 	 * If this driver happens to only be useful on Apple's K2, then
 	 * we should check that here as it has a normal Serverworks ID
@@ -430,25 +1425,51 @@ static int k2_sata_init_one (struct pci_
 	 * Check if we have resources mapped at all (second function may
 	 * have been disabled by firmware)
 	 */
-	if (pci_resource_len(pdev, 5) == 0)
+	if (pci_resource_len(pdev, bar_pos) == 0)
 		return -ENODEV;
 
 	/* Request and iomap PCI regions */
-	rc = pcim_iomap_regions(pdev, 1 << 5, DRV_NAME);
+	// rc = pcim_iomap_regions(pdev, 1 << 5, DRV_NAME);
+	rc = pcim_iomap_regions(pdev, 1 << bar_pos, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
-	mmio_base = host->iomap[5];
+	mmio_base = host->iomap[bar_pos];
 
 	/* different controllers have different number of ports -
currently 4 or 8 */
 	/* All ports are on the same function. Multi-function device is
no
 	 * longer available. This should not be seen in any system. */
 	for (i = 0; i < host->n_ports; i++)
+	{
+// HT1100 addns start
+		if( ent->device == 0x0410)
+		{
+			if( !skip_init)
+			{
+				// set mode, phy vals etc
+				// ht1100 needs a global phy enable bit,
so we do that for port zero iteration
+				if( i == 0)
+			 		writel( readl( mmio_base +
0x10F0) | 0x01, (mmio_base + 0x10F0) );
+
+				k2_sata_pll_init( mmio_base,
K2_SATA_PLL_1P5_GIG, i);
+
+				k2_sata_port_reset_phy_start_oob(
mmio_base + (i * K2_SATA_PORT_OFFSET), 0x10100 );
+
+			}
+
+			writel( readl( mmio_base + (i *
K2_SATA_PORT_OFFSET) + 0x84) | 0x2000f800, (mmio_base + (i *
K2_SATA_PORT_OFFSET) + 0x84) );
+			writel( readl( mmio_base + (i *
K2_SATA_PORT_OFFSET) + 0xE0) | 0x2, (mmio_base + (i *
K2_SATA_PORT_OFFSET) + 0xE0) );
+		}
+// HT1100 addns end
+
 		k2_sata_setup_port(&host->ports[i]->ioaddr,
 				   mmio_base + i * K2_SATA_PORT_OFFSET);
 
+	}
+
+
 	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
@@ -468,7 +1489,7 @@ static int k2_sata_init_one (struct pci_
 	writel(0x0, mmio_base + K2_SATA_SIM_OFFSET);
 
 	pci_set_master(pdev);
-	return ata_host_activate(host, pdev->irq, ata_interrupt,
IRQF_SHARED,
+	return ata_host_activate(host, pdev->irq,
ppi[0]->port_ops->irq_handler, IRQF_SHARED,
 				 &k2_sata_sht);
 }
 
@@ -477,14 +1498,19 @@ static int k2_sata_init_one (struct pci_
  * 0x242 is device ID for Serverworks Frodo8
  * 0x24a is device ID for BCM5785 (aka HT1000) HT southbridge
integrated SATA
  * controller
+ * 0x41x is device ID for HT1100 southbridge integrated SATA storage
controller
  * */
 static const struct pci_device_id k2_sata_pci_tbl[] = {
-	{ PCI_VDEVICE(SERVERWORKS, 0x0240), board_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0241), board_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x0242), board_svw8 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024a), board_svw4 },
-	{ PCI_VDEVICE(SERVERWORKS, 0x024b), board_svw4 },
-
+	{ PCI_VDEVICE(SERVERWORKS, 0x0240), chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw4 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0242), chip_svw8 },
+// ATAPI QDMA start						
+	{ PCI_VDEVICE(SERVERWORKS, 0x024a), chip_svw41 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024b), chip_svw41 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x024c), chip_svw4 },
+// ATAPI QDMA end						
+	{ PCI_VDEVICE(SERVERWORKS, 0x0410), chip_svw42 },
+	{ PCI_VDEVICE(SERVERWORKS, 0x0411), chip_svw43 },
 	{ }
 };
 

