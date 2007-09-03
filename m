From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: move ata_id_n_sectors() upward
Date: Mon, 3 Sep 2007 12:31:58 +0900
Message-ID: <20070903033158.GB16890@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:51899 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbXICDcH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 23:32:07 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1751956wah
        for <linux-ide@vger.kernel.org>; Sun, 02 Sep 2007 20:32:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Move ata_id_n_sectors() upward right below ata_id_c_string().  This is
to accomodate later changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dc5031f..b7b0c42 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -821,6 +821,21 @@ void ata_id_c_string(const u16 *id, unsigned char *s,
 	*p = '\0';
 }
 
+static u64 ata_id_n_sectors(const u16 *id)
+{
+	if (ata_id_has_lba(id)) {
+		if (ata_id_has_lba48(id))
+			return ata_id_u64(id, 100);
+		else
+			return ata_id_u32(id, 60);
+	} else {
+		if (ata_id_current_chs_valid(id))
+			return ata_id_u32(id, 57);
+		else
+			return id[1] * id[3] * id[6];
+	}
+}
+
 static u64 ata_tf_to_lba48(struct ata_taskfile *tf)
 {
 	u64 sectors = 0;
@@ -1021,21 +1036,6 @@ static u64 ata_hpa_resize(struct ata_device *dev)
 	return sectors;
 }
 
-static u64 ata_id_n_sectors(const u16 *id)
-{
-	if (ata_id_has_lba(id)) {
-		if (ata_id_has_lba48(id))
-			return ata_id_u64(id, 100);
-		else
-			return ata_id_u32(id, 60);
-	} else {
-		if (ata_id_current_chs_valid(id))
-			return ata_id_u32(id, 57);
-		else
-			return id[1] * id[3] * id[6];
-	}
-}
-
 /**
  *	ata_id_to_dma_mode	-	Identify DMA mode from id block
  *	@dev: device to identify
-- 
1.5.0.3

