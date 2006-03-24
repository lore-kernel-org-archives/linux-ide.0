From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: implement ata_unpack_xfermask()
Date: Fri, 24 Mar 2006 14:07:49 +0900
Message-ID: <11431768693233-git-send-email-htejun@gmail.com>
References: <11431768691564-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.200]:9188 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932192AbWCXFHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 00:07:55 -0500
Received: by xproxy.gmail.com with SMTP id t10so445375wxc
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 21:07:54 -0800 (PST)
In-Reply-To: <11431768691564-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_unpack_xfermask().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

6ff994d5a30bdaef8a055301f569b781307801a7
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f3c115b..1514cb5 100644
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


