From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.4.x libata fixes, and new ULi ctlr support
Date: Mon, 27 Dec 2004 16:00:41 -0500
Message-ID: <41D077F9.6020501@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040708070007020509090508"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59864 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261984AbUL0VAu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Dec 2004 16:00:50 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040708070007020509090508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

patch and changelog attached.

--------------040708070007020509090508
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/libata-upstream-2.4

This will update the following files:

 drivers/scsi/libata-core.c |   46 ++++++++++++++++++++++++----------------
 drivers/scsi/libata-scsi.c |    5 ++++
 drivers/scsi/libata.h      |    1 
 drivers/scsi/sata_nv.c     |   10 +++++++-
 drivers/scsi/sata_uli.c    |   51 ++++++++++++++++++++-------------------------
 include/linux/libata.h     |    2 +
 6 files changed, 68 insertions(+), 47 deletions(-)

through these ChangeSets:

<stkn@gentoo.org> (04/12/27 1.1559)
   [libata] add #include (fixes 2.4 alpha build)

<albertcc@tw.ibm.com> (04/12/27 1.1558)
   [libata] verify ATAPI DMA for a given request is OK
   
   After some testing, it seems that some PATA host adapter (ex. pdc20275) cannot 
   work reliably with specific request buffer sizes under ATAPI DMA mode.
   
   Detailed test result:
   4096, 2048, 1024, 512, 256: OK
   384, 257, 255, 128, 96, 64, 32:  failed (irq lost)
    
   It seems multiple of 256 bytes are the safe ATAPI DMA buffer sizes to use.
   
   Attached please find the patch to fix the pdc2027x ATAPI DMA problem.
   
   Changes:
   1. Add a callback function "check_atapi_dma()" to ata_port_operations such that libata core
   can ask the driver: "Can this command be processed in ATAPI DMA mode safely? " 
   when the the command is received.
   2. ATAPI DMA is off by default if the callback function is not provided by the driver
   
   If the callback function is not provided by the driver, the ATAPI DMA should be as is.
   The ATAPI DMA is already controlled by dev->flags.
   
   BTW, the patch isolates the ATAPI DMA workaround to the pdc20275 driver itself,
   not impacting libata core .
    
   Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

<albertcc@tw.ibm.com> (04/12/27 1.1557)
   [libata] PIO error handling improvement
   
   Tested burning CD-RW with libata-dev-2.6 and cdrecord:
   1. ATAPI DMA mode - tested OK
   2. ATAPI PIO mode - test failed when cdrecord finishes burning and issues MODE_SELECT to the device.
   
    After checking the log, it showed that MODE_SELECT caused ata_pio_complete() 
   to return error.
   However, the error is not handled by ata_pio_task().
   
   Attached please find the patch for ata_pio_task() error handling for your review.
     
   Changes in the patch:
   1. End the PIO task when PIO_ST_IDLE state is entered
   2. End the PIO task after PIO_ST_TMOUT and PIO_ST_ERR state handled by ata_pio_error()
   3. Remove the first "if" statement to handle the error condition returned from
      ata_pio_block(), ata_pio_complete() and ata_pio_poll().
   
   Change #2 is not so necessary since ata_pio_error() will put the cmd to  PIO_ST_IDLE state
   after the error condition is handled. The change just saves a function call to queue_work().
   
   Tested OK on on my machine with pdc20275 and ASUS CD-RW drive.
   
   Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

<albertcc@tw.ibm.com> (04/12/27 1.1556)
   [libata] use PIO mode for request sense
   
   Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

<jgarzik@pobox.com> (04/12/27 1.1555)
   [libata sata_uli] add 5281 support, fix SATA phy setup for others
   
   Contributed by Peer Chen @ ULi and tested by a user.

<jgarzik@pobox.com> (04/12/27 1.1554)
   [libata sata_nv] fix dev detect by removing sata-reset flag
   
   Remove ATA_FLAG_SATA_RESET.  See comment in code and
   http://bugme.osdl.org/show_bug.cgi?id=3352 for more details.
   
   This problem needs more investigation.  Removing the flag
   appears to fix the problems in the field, so it's the best
   temporary solution.


--------------040708070007020509090508
Content-Type: text/plain;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.txt"

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2004-12-27 15:58:11 -05:00
+++ b/drivers/scsi/libata-core.c	2004-12-27 15:58:11 -05:00
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/mm.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 #include <linux/blkdev.h>
@@ -1918,7 +1919,24 @@
 	if (idx)
 		ap->prd[idx - 1].flags_len |= cpu_to_le32(ATA_PRD_EOT);
 }
+/**
+ *	ata_check_atapi_dma - Check whether ATAPI DMA can be supported
+ *	@qc: Metadata associated with taskfile to check
+ *
+ *	LOCKING:
+ *	RETURNS: 0 when ATAPI DMA can be used
+ *               nonzero otherwise
+ */
+int ata_check_atapi_dma(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	int rc = 0; /* Assume ATAPI DMA is OK by default */
+
+	if (ap->ops->check_atapi_dma)
+		rc = ap->ops->check_atapi_dma(qc);
 
+	return rc;
+}
 /**
  *	ata_qc_prep - Prepare taskfile for submission
  *	@qc: Metadata associated with taskfile to be prepared
@@ -2368,6 +2386,9 @@
 	unsigned long timeout = 0;
 
 	switch (ap->pio_task_state) {
+	case PIO_ST_IDLE:
+		return;
+
 	case PIO_ST:
 		ata_pio_block(ap);
 		break;
@@ -2384,7 +2405,7 @@
 	case PIO_ST_TMOUT:
 	case PIO_ST_ERR:
 		ata_pio_error(ap);
-		break;
+		return;
 	}
 
 	if (timeout) {
@@ -2392,11 +2413,7 @@
 		schedule_timeout(timeout);
 	}
 
-	if ((ap->pio_task_state != PIO_ST_IDLE) &&
-	    (ap->pio_task_state != PIO_ST_TMOUT) &&
-	    (ap->pio_task_state != PIO_ST_ERR)) {
-		schedule_task(&ap->pio_task);
-	}
+	schedule_task(&ap->pio_task);
 }
 
 static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
@@ -2405,7 +2422,6 @@
 	DECLARE_COMPLETION(wait);
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
-	int using_pio = dev->flags & ATA_DFLAG_PIO;
 	int rc;
 
 	DPRINTK("ATAPI request sense\n");
@@ -2426,16 +2442,10 @@
 	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	qc->tf.command = ATA_CMD_PACKET;
 
-	if (using_pio) {
-		qc->tf.protocol = ATA_PROT_ATAPI;
-		qc->tf.lbam = (8 * 1024) & 0xff;
-		qc->tf.lbah = (8 * 1024) >> 8;
-
-		qc->nbytes = SCSI_SENSE_BUFFERSIZE;
-	} else {
-		qc->tf.protocol = ATA_PROT_ATAPI_DMA;
-		qc->tf.feature |= ATAPI_PKT_DMA;
-	}
+	qc->tf.protocol = ATA_PROT_ATAPI;
+	qc->tf.lbam = (8 * 1024) & 0xff;
+	qc->tf.lbah = (8 * 1024) >> 8;
+	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
 
 	qc->waiting = &wait;
 	qc->complete_fn = ata_qc_complete_noop;
@@ -2707,7 +2717,7 @@
 			return 1;
 
 		/* fall through */
-	
+
 	default:
 		return 0;
 	}
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-12-27 15:58:11 -05:00
+++ b/drivers/scsi/libata-scsi.c	2004-12-27 15:58:11 -05:00
@@ -1256,6 +1256,11 @@
 	int using_pio = (dev->flags & ATA_DFLAG_PIO);
 	int nodata = (cmd->sc_data_direction == SCSI_DATA_NONE);
 
+	if (!using_pio)
+		/* Check whether ATAPI DMA is safe */
+		if (ata_check_atapi_dma(qc))
+			using_pio = 1;
+
 	memcpy(&qc->cdb, scsicmd, qc->ap->cdb_len);
 
 	qc->complete_fn = atapi_qc_complete;
diff -Nru a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h	2004-12-27 15:58:11 -05:00
+++ b/drivers/scsi/libata.h	2004-12-27 15:58:11 -05:00
@@ -38,6 +38,7 @@
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern int ata_qc_issue(struct ata_queued_cmd *qc);
+extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void ata_tf_to_host_nolock(struct ata_port *ap, struct ata_taskfile *tf);
diff -Nru a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c	2004-12-27 15:58:11 -05:00
+++ b/drivers/scsi/sata_nv.c	2004-12-27 15:58:11 -05:00
@@ -219,10 +219,18 @@
 	.host_stop		= nv_host_stop,
 };
 
+/* FIXME: The hardware provides the necessary SATA PHY controls
+ * to support ATA_FLAG_SATA_RESET.  However, it is currently
+ * necessary to disable that flag, to solve misdetection problems.
+ * See http://bugme.osdl.org/show_bug.cgi?id=3352 for more info.
+ *
+ * This problem really needs to be investigated further.  But in the
+ * meantime, we avoid ATA_FLAG_SATA_RESET to get people working.
+ */
 static struct ata_port_info nv_port_info = {
 	.sht		= &nv_sht,
 	.host_flags	= ATA_FLAG_SATA |
-			  ATA_FLAG_SATA_RESET |
+			  /* ATA_FLAG_SATA_RESET | */
 			  ATA_FLAG_SRST |
 			  ATA_FLAG_NO_LEGACY,
 	.pio_mask	= NV_PIO_MASK,
diff -Nru a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c	2004-12-27 15:58:11 -05:00
+++ b/drivers/scsi/sata_uli.c	2004-12-27 15:58:11 -05:00
@@ -32,16 +32,18 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_uli"
-#define DRV_VERSION	"0.2"
+#define DRV_VERSION	"0.5"
 
 enum {
 	uli_5289		= 0,
 	uli_5287		= 1,
+	uli_5281		= 2,
 
 	/* PCI configuration registers */
-	ULI_SCR_BASE		= 0x90, /* sata0 phy SCR registers */
-	ULI_SATA1_OFS		= 0x10, /* offset from sata0->sata1 phy regs */
-
+	ULI5287_BASE		= 0x90, /* sata0 phy SCR registers */
+	ULI5287_OFFS		= 0x10, /* offset from sata0->sata1 phy regs */
+	ULI5281_BASE		= 0x60, /* sata0 phy SCR  registers */
+	ULI5281_OFFS		= 0x60, /* offset from sata0->sata1 phy regs */
 };
 
 static int uli_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -51,6 +53,7 @@
 static struct pci_device_id uli_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AL, 0x5289, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5289 },
 	{ PCI_VENDOR_ID_AL, 0x5287, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5287 },
+	{ PCI_VENDOR_ID_AL, 0x5281, PCI_ANY_ID, PCI_ANY_ID, 0, 0, uli_5281 },
 	{ }	/* terminate list */
 };
 
@@ -126,33 +129,15 @@
 MODULE_DEVICE_TABLE(pci, uli_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static unsigned int get_scr_cfg_addr(unsigned int port_no, unsigned int sc_reg)
+static unsigned int get_scr_cfg_addr(struct ata_port *ap, unsigned int sc_reg)
 {
-	unsigned int addr = ULI_SCR_BASE + (4 * sc_reg);
-
-	switch (port_no) {
-	case 0:
-		break;
-	case 1:
-		addr += ULI_SATA1_OFS;
-		break;
-	case 2:
-		addr += ULI_SATA1_OFS*4;
-		break;
-	case 3:
-		addr += ULI_SATA1_OFS*5;
-		break;
-	default:
-		BUG();
-		break;
-	}
-	return addr;
+	return ap->ioaddr.scr_addr + (4 * sc_reg);
 }
 
 static u32 uli_scr_cfg_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap, sc_reg);
 	u32 val;
 
 	pci_read_config_dword(pdev, cfg_addr, &val);
@@ -162,7 +147,7 @@
 static void uli_scr_cfg_write (struct ata_port *ap, unsigned int scr, u32 val)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
-	unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, scr);
+	unsigned int cfg_addr = get_scr_cfg_addr(ap, scr);
 
 	pci_write_config_dword(pdev, cfg_addr, val);
 }
@@ -220,9 +205,11 @@
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
-
+	
 	switch (board_idx) {
 	case uli_5287:
+		probe_ent->port[0].scr_addr = ULI5287_BASE;
+		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
        		probe_ent->n_ports = 4;
 
        		probe_ent->port[2].cmd_addr = pci_resource_start(pdev, 0) + 8;
@@ -230,19 +217,27 @@
 		probe_ent->port[2].ctl_addr =
 			(pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[2].bmdma_addr = pci_resource_start(pdev, 4) + 16;
+		probe_ent->port[2].scr_addr = ULI5287_BASE + ULI5287_OFFS*4;
 
 		probe_ent->port[3].cmd_addr = pci_resource_start(pdev, 2) + 8;
 		probe_ent->port[3].altstatus_addr =
 		probe_ent->port[3].ctl_addr =
 			(pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS) + 4;
 		probe_ent->port[3].bmdma_addr = pci_resource_start(pdev, 4) + 24;
+		probe_ent->port[3].scr_addr = ULI5287_BASE + ULI5287_OFFS*5;
 
 		ata_std_ports(&probe_ent->port[2]);
 		ata_std_ports(&probe_ent->port[3]);
 		break;
 
 	case uli_5289:
-		/* do nothing; ata_pci_init_native_mode did it all */
+		probe_ent->port[0].scr_addr = ULI5287_BASE;
+		probe_ent->port[1].scr_addr = ULI5287_BASE + ULI5287_OFFS;
+		break;
+
+	case uli_5281:
+		probe_ent->port[0].scr_addr = ULI5281_BASE;
+		probe_ent->port[1].scr_addr = ULI5281_BASE + ULI5281_OFFS;
 		break;
 
 	default:
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-12-27 15:58:11 -05:00
+++ b/include/linux/libata.h	2004-12-27 15:58:11 -05:00
@@ -340,6 +340,8 @@
 	void (*phy_reset) (struct ata_port *ap);
 	void (*post_set_mode) (struct ata_port *ap);
 
+	int (*check_atapi_dma) (struct ata_queued_cmd *qc);
+
 	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 

--------------040708070007020509090508--
