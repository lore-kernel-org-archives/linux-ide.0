From: Ondrej Zary <linux@rainbow-software.org>
Subject: [RFC PATCH] sata_via: Apply WD workaround only when needed
Date: Mon, 15 Feb 2016 22:01:47 +0100
Message-ID: <1455570107-11520-1-git-send-email-linux@rainbow-software.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Joseph Chan <JosephChan@via.com.tw>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Currently, workaround for broken WD drives is applied always, slowing
down all drives. And it has a bug - it's not applied after resume.

Apply the workaround only if the error really appears
(SErr == 0x1000500). This allows unaffected drives to run at full speed
(provided that no affected drive is connected to the controller).
It also fixes the suspend/resume problem.

The downside is that first error always appears in the log.

Unaffected drive (Hitachi HDS721680PLA380):
Before:
$ hdparm -t --direct /dev/sdb
/dev/sdb:
 Timing O_DIRECT disk reads: 160 MB in  3.01 seconds =  53.16 MB/sec

After:
$ hdparm -t --direct /dev/sdb
/dev/sdb:
 Timing O_DIRECT disk reads: 200 MB in  3.01 seconds =  66.47 MB/sec

Affected drive (WDC WD5003ABYX-18WERA0):
Before:
$ hdparm -t --direct /dev/sda

/dev/sda:
 Timing O_DIRECT disk reads: 180 MB in  3.02 seconds =  59.51 MB/sec

After:
$ hdparm -t --direct /dev/sdb
/dev/sdb:
 Timing O_DIRECT disk reads: 156 MB in  3.03 seconds =  51.48 MB/sec
$ hdparm -t --direct /dev/sdb
/dev/sdb:
 Timing O_DIRECT disk reads: 180 MB in  3.02 seconds =  59.64 MB/sec

The first hdparm is slower because of the error:
[   80.964060] ata5.00: exception Emask 0x12 SAct 0x0 SErr 0x1000500 action 0x6
[   80.964095] ata5.00: BMDMA stat 0x5
[   80.964108] ata5: SError: { UnrecovData Proto TrStaTrns }
[   80.964125] ata5.00: failed command: READ DMA EXT
[   80.964143] ata5.00: cmd 25/00:90:00:00:00/00:04:00:00:00/e0 tag 0 dma 598016 in
         res 51/84:af:df:00:00/84:03:00:00:00/e0 Emask 0x12 (ATA bus error)
[   80.964173] ata5.00: status: { DRDY ERR }
[   80.964185] ata5.00: error: { ICRC ABRT }
[   80.964209] ata5: hard resetting link
[   81.284056] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   81.300531] ata5.00: configured for UDMA/133
[   81.300569] ata5: Incompatible drive (WD?): enabling workaround
[   81.300598] ata5: EH complete

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/ata/sata_via.c |   72 +++++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 17d31fc..65c9ab9 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -85,6 +85,7 @@ static void vt6420_bmdma_start(struct ata_queued_cmd *qc);
 static int vt6421_pata_cable_detect(struct ata_port *ap);
 static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev);
 static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev);
+static void svia_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
 	{ PCI_VDEVICE(VIA, 0x5337), vt6420 },
@@ -124,6 +125,7 @@ static struct ata_port_operations vt6420_sata_ops = {
 	.freeze			= svia_noop_freeze,
 	.prereset		= vt6420_prereset,
 	.bmdma_start		= vt6420_bmdma_start,
+	.error_handler		= svia_error_handler,
 };
 
 static struct ata_port_operations vt6421_pata_ops = {
@@ -137,6 +139,7 @@ static struct ata_port_operations vt6421_sata_ops = {
 	.inherits		= &svia_base_ops,
 	.scr_read		= svia_scr_read,
 	.scr_write		= svia_scr_write,
+	.error_handler		= svia_error_handler,
 };
 
 static struct ata_port_operations vt8251_ops = {
@@ -536,6 +539,47 @@ static int vt8251_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 	return 0;
 }
 
+static void svia_error_handler(struct ata_port *ap)
+{
+	u8 tmp8;
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	struct ata_eh_context *ehc = &ap->link.eh_context;
+
+	ata_sff_error_handler(ap);
+	/*
+	 * vt6420/1 has problems talking to some drives.  The following
+	 * is the fix from Joseph Chan <JosephChan@via.com.tw>.
+	 *
+	 * When host issues HOLD, device may send up to 20DW of data
+	 * before acknowledging it with HOLDA and the host should be
+	 * able to buffer them in FIFO.  Unfortunately, some WD drives
+	 * send up to 40DW before acknowledging HOLD and, in the
+	 * default configuration, this ends up overflowing vt6421's
+	 * FIFO, making the controller abort the transaction with
+	 * R_ERR.
+	 *
+	 * Rx52[2] is the internal 128DW FIFO Flow control watermark
+	 * adjusting mechanism enable bit and the default value 0
+	 * means host will issue HOLD to device when the left FIFO
+	 * size goes below 32DW.  Setting it to 1 makes the watermark
+	 * 64DW.
+	 *
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=15173
+	 * http://article.gmane.org/gmane.linux.ide/46352
+	 * http://thread.gmane.org/gmane.linux.kernel/1062139
+	 *
+	 * As the fix slows down data transfer, apply it only if the error
+	 * actually appears (symptom: SErr == 0x1000500)
+	 */
+	if (ehc->i.serror == 0x1000500) {
+		pci_read_config_byte(pdev, 0x52, &tmp8);
+		if (!(tmp8 & BIT(2))) {
+			ata_port_warn(ap, "Incompatible drive (WD?): enabling workaround");
+			pci_write_config_byte(pdev, 0x52, tmp8 | BIT(2));
+		}
+	}
+}
+
 static void svia_configure(struct pci_dev *pdev, int board_id)
 {
 	u8 tmp8;
@@ -571,34 +615,6 @@ static void svia_configure(struct pci_dev *pdev, int board_id)
 		tmp8 |= NATIVE_MODE_ALL;
 		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
 	}
-
-	/*
-	 * vt6420/1 has problems talking to some drives.  The following
-	 * is the fix from Joseph Chan <JosephChan@via.com.tw>.
-	 *
-	 * When host issues HOLD, device may send up to 20DW of data
-	 * before acknowledging it with HOLDA and the host should be
-	 * able to buffer them in FIFO.  Unfortunately, some WD drives
-	 * send up to 40DW before acknowledging HOLD and, in the
-	 * default configuration, this ends up overflowing vt6421's
-	 * FIFO, making the controller abort the transaction with
-	 * R_ERR.
-	 *
-	 * Rx52[2] is the internal 128DW FIFO Flow control watermark
-	 * adjusting mechanism enable bit and the default value 0
-	 * means host will issue HOLD to device when the left FIFO
-	 * size goes below 32DW.  Setting it to 1 makes the watermark
-	 * 64DW.
-	 *
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=15173
-	 * http://article.gmane.org/gmane.linux.ide/46352
-	 * http://thread.gmane.org/gmane.linux.kernel/1062139
-	 */
-	if (board_id == vt6420 || board_id == vt6421) {
-		pci_read_config_byte(pdev, 0x52, &tmp8);
-		tmp8 |= 1 << 2;
-		pci_write_config_byte(pdev, 0x52, tmp8);
-	}
 }
 
 static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
Ondrej Zary
