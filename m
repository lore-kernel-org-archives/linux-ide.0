From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: move ata_id_n_sectors() upward
Date: Thu, 16 Aug 2007 03:06:02 +0900
Message-ID: <20070815180602.GE21623@htj.dyndns.org>
References: <20070815180508.GD21623@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:24518 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763597AbXHOSGI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 14:06:08 -0400
Received: by rv-out-0910.google.com with SMTP id k20so3781rvb
        for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 11:06:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070815180508.GD21623@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Move ata_id_n_sectors() upward right below ata_id_c_string().  This is
to accomodate later changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -816,6 +816,21 @@ void ata_id_c_string(const u16 *id, unsi
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
@@ -1016,21 +1031,6 @@ static u64 ata_hpa_resize(struct ata_dev
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
