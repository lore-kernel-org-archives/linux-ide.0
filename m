From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_hpt366: add hpt36x_find_mode() helper
Date: Fri, 27 Nov 2009 19:54:53 +0100
Message-ID: <200911271954.54019.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752918AbZK0S6W@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>
List-Id: linux-ide@vger.kernel.org

Factor out code for finding the register programming information
from hpt366_set_mode() to hpt36x_find_mode().

This makes pata_hpt366 driver more similar to pata_{37x,3x2n} ones.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Sergei, pata_hpt{37x,3x2n} drivers can also be made to use *set_mode()
helper but I don't want to interfere with your pending fixes there.

 drivers/ata/pata_hpt366.c |   35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

Index: b/drivers/ata/pata_hpt366.c
===================================================================
--- a/drivers/ata/pata_hpt366.c
+++ b/drivers/ata/pata_hpt366.c
@@ -114,6 +114,28 @@ static const struct hpt_clock hpt366_25[
 	{	0,		0x01208585	}
 };
 
+/**
+ *	hpt36x_find_mode	-	find the hpt36x timing
+ *	@ap: ATA port
+ *	@speed: transfer mode
+ *
+ *	Return the 32bit register programming information for this channel
+ *	that matches the speed provided.
+ */
+
+static u32 hpt36x_find_mode(struct ata_port *ap, int speed)
+{
+	struct hpt_clock *clocks = ap->host->private_data;
+
+	while (clocks->xfer_mode) {
+		if (clocks->xfer_mode == speed)
+			return clocks->timing;
+		clocks++;
+	}
+	BUG();
+	return 0xffffffffU;	/* silence compiler warning */
+}
+
 static const char *bad_ata33[] = {
 	"Maxtor 92720U8", "Maxtor 92040U6", "Maxtor 91360U4", "Maxtor 91020U3", "Maxtor 90845U3", "Maxtor 90650U2",
 	"Maxtor 91360D8", "Maxtor 91190D7", "Maxtor 91020D6", "Maxtor 90845D5", "Maxtor 90680D4", "Maxtor 90510D3", "Maxtor 90340D2",
@@ -238,11 +260,10 @@ static int hpt36x_prereset(struct ata_li
 static void hpt366_set_mode(struct ata_port *ap, struct ata_device *adev,
 			    u8 mode)
 {
-	struct hpt_clock *clocks = ap->host->private_data;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	u32 addr1 = 0x40 + 4 * (adev->devno + 2 * ap->port_no);
 	u32 addr2 = 0x51 + 4 * ap->port_no;
-	u32 mask, reg;
+	u32 mask, reg, t;
 	u8 fast;
 
 	/* Fast interrupt prediction disable, hold off interrupt disable */
@@ -260,13 +281,7 @@ static void hpt366_set_mode(struct ata_p
 	else
 		mask = 0x30070000;
 
-	while (clocks->xfer_mode) {
-		if (clocks->xfer_mode == mode)
-			break;
-		clocks++;
-	}
-	if (!clocks->xfer_mode)
-		BUG();
+	t = hpt36x_find_mode(ap, mode);
 
 	/*
 	 * Combine new mode bits with old config bits and disable
@@ -274,7 +289,7 @@ static void hpt366_set_mode(struct ata_p
 	 * problems handling I/O errors later.
 	 */
 	pci_read_config_dword(pdev, addr1, &reg);
-	reg = ((reg & ~mask) | (clocks->timing & mask)) & ~0xc0000000;
+	reg = ((reg & ~mask) | (t & mask)) & ~0xc0000000;
 	pci_write_config_dword(pdev, addr1, reg);
 }
 
