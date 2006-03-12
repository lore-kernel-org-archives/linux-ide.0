From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: implement ata_unpack_xfermask()
Date: Sun, 12 Mar 2006 16:02:35 +0900
Message-ID: <114214695594-git-send-email-htejun@gmail.com>
References: <11421469551948-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.183]:30025 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751451AbWCLHCk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 02:02:40 -0500
Received: by pproxy.gmail.com with SMTP id d42so679701pyd
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 23:02:40 -0800 (PST)
In-Reply-To: <11421469551948-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_unpack_xfermask().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

70ca1eb15f59fa81dc3dd8b8eaff40f7b4e07c95
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 42d43b5..96954c7 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -252,6 +252,29 @@ static unsigned int ata_pack_xfermask(un
 		((udma_mask << ATA_SHIFT_UDMA) & ATA_MASK_UDMA);
 }
 
+/**
+ *	ata_unpack_xfermask - Unpack xfer_mask into pio, mwdma and udma masks
+ *	@xfer_mask: xfer_mask to unpack
+ *	@pio_mask: resulting pio_mask
+ *	@mwdma_mask: resulting mwdma_mask
+ *	@udma_mask: resulting udma_mask
+ *
+ *	Unpack @xfer_mask into @pio_mask, @mwdma_mask and @udma_mask.
+ *	Any NULL distination masks will be ignored.
+ */
+static void ata_unpack_xfermask(unsigned int xfer_mask,
+				unsigned int *pio_mask,
+				unsigned int *mwdma_mask,
+				unsigned int *udma_mask)
+{
+	if (pio_mask)
+		*pio_mask = (xfer_mask & ATA_MASK_PIO) >> ATA_SHIFT_PIO;
+	if (mwdma_mask)
+		*mwdma_mask = (xfer_mask & ATA_MASK_MWDMA) >> ATA_SHIFT_MWDMA;
+	if (udma_mask)
+		*udma_mask = (xfer_mask & ATA_MASK_UDMA) >> ATA_SHIFT_UDMA;
+}
+
 static const struct ata_xfer_ent {
 	unsigned int shift, bits;
 	u8 base;
-- 
1.2.4


