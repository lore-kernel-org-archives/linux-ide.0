From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] sata_sil: add board ID for 3512
Date: Sat, 25 Feb 2006 13:52:30 +0900
Message-ID: <1140843150952-git-send-email-htejun@gmail.com>
References: <11408431492856-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:40824 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932675AbWBYEvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Feb 2006 23:51:24 -0500
Received: by zproxy.gmail.com with SMTP id 18so526724nzp
        for <linux-ide@vger.kernel.org>; Fri, 24 Feb 2006 20:51:23 -0800 (PST)
In-Reply-To: <11408431492856-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, hellan@acm.org, Carlos.Pardo@siliconimage.com, Raymond.Liu@siliconimage.com
Cc: Tejun Heo <htejun@gmail.com>

3512 is slightly different from 3112 errata-wise.  Differentiate it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

57cb119319e74c1d39981cf94669b4d38f326628
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 17f74d3..510c2e0 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -53,7 +53,8 @@ enum {
 
 	sil_3112		= 0,
 	sil_3112_m15w		= 1,
-	sil_3114		= 2,
+	sil_3512		= 2,
+	sil_3114		= 3,
 
 	SIL_FIFO_R0		= 0x40,
 	SIL_FIFO_W0		= 0x41,
@@ -90,7 +91,7 @@ static void sil_post_set_mode (struct at
 static const struct pci_device_id sil_pci_tbl[] = {
 	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
-	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3512 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
 	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
@@ -185,7 +186,8 @@ static const struct ata_port_info sil_po
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
-	}, /* sil_3112_15w - keep it sync'd w/ sil_3112 */
+	},
+	/* sil_3112_15w - keep it sync'd w/ sil_3112 */
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
@@ -195,7 +197,18 @@ static const struct ata_port_info sil_po
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
-	}, /* sil_3114 */
+	},
+	/* sil_3512 */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil_ops,
+	},
+	/* sil_3114 */
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-- 
1.2.1


