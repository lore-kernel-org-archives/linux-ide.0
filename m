From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/5] pata_hpt366: remove redundant code
Date: Mon, 7 Dec 2009 23:36:15 +0400
Message-ID: <200912072236.15718.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:56896 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932170AbZLGTe4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 14:34:56 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

There's no need to clear the fast interrupt bit in hpt366_set_mode() since
we're doing it in hpt366_init_chipset() already.

While at it, rename 'addr1' local variable to 'addr' and exclude 'ap->port_no'
from its calculation as HPT36x are single-channel-per-function chips.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_hpt366.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt366.c
+++ linux-2.6/drivers/ata/pata_hpt366.c
@@ -27,7 +27,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.6.7"
+#define DRV_VERSION	"0.6.8"
 
 struct hpt_clock {
 	u8	xfer_mode;
@@ -207,17 +207,8 @@ static void hpt366_set_mode(struct ata_p
 {
 	struct hpt_clock *clocks = ap->host->private_data;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	u32 addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
-	u32 addr2 = 0x51 + 4 * ap->port_no;
+	u32 addr = 0x40 + 4 * adev->devno;
 	u32 mask, reg;
-	u8 fast;
-
-	/* Fast interrupt prediction disable, hold off interrupt disable */
-	pci_read_config_byte(pdev, addr2, &fast);
-	if (fast & 0x80) {
-		fast &= ~0x80;
-		pci_write_config_byte(pdev, addr2, fast);
-	}
 
 	/* determine timing mask and find matching clock entry */
 	if (mode < XFER_MW_DMA_0)
@@ -240,9 +231,9 @@ static void hpt366_set_mode(struct ata_p
 	 * on-chip PIO FIFO/buffer (and PIO MST mode as well) to avoid
 	 * problems handling I/O errors later.
 	 */
-	pci_read_config_dword(pdev, addr1, &reg);
+	pci_read_config_dword(pdev, addr, &reg);
 	reg = ((reg & ~mask) | (clocks->timing & mask)) & ~0xc0000000;
-	pci_write_config_dword(pdev, addr1, reg);
+	pci_write_config_dword(pdev, addr, reg);
 }
 
 /**

