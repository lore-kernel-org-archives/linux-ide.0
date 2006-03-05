From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] sata_sil: replace sil_3112_m15w board id with sil_3112
Date: Sun, 5 Mar 2006 16:03:52 +0900
Message-ID: <11415422321160-git-send-email-htejun@gmail.com>
References: <11415422323592-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:32029 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751898AbWCEHD5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 02:03:57 -0500
Received: by zproxy.gmail.com with SMTP id 9so1010994nzo
        for <linux-ide@vger.kernel.org>; Sat, 04 Mar 2006 23:03:56 -0800 (PST)
In-Reply-To: <11415422323592-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

All 3112's have m15w.  Replace sil_3112_m15w with sil_3112 and flag
sil_3112 with SIL_FLAG_MOD15WRITE.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>

---

 drivers/scsi/sata_sil.c |   25 +++++++------------------
 1 files changed, 7 insertions(+), 18 deletions(-)

8ba88e0e2e3356e2364f1defdac5c269bc03d93c
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index cdf800e..8cb662d 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -53,9 +53,8 @@ enum {
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
 	sil_3112		= 0,
-	sil_3112_m15w		= 1,
-	sil_3512		= 2,
-	sil_3114		= 3,
+	sil_3512		= 1,
+	sil_3114		= 2,
 
 	SIL_FIFO_R0		= 0x40,
 	SIL_FIFO_W0		= 0x41,
@@ -90,13 +89,13 @@ static void sil_post_set_mode (struct at
 
 
 static const struct pci_device_id sil_pci_tbl[] = {
-	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
-	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3512 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
-	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
-	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
-	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ }	/* terminate list */
 };
 
@@ -182,16 +181,6 @@ static const struct ata_port_info sil_po
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO,
-		.pio_mask	= 0x1f,			/* pio0-4 */
-		.mwdma_mask	= 0x07,			/* mwdma0-2 */
-		.udma_mask	= 0x3f,			/* udma0-5 */
-		.port_ops	= &sil_ops,
-	},
-	/* sil_3112_15w - keep it sync'd w/ sil_3112 */
-	{
-		.sht		= &sil_sht,
-		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | SIL_FLAG_MOD15WRITE,
 		.pio_mask	= 0x1f,			/* pio0-4 */
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
-- 
1.2.1


