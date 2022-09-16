Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00802C54EE9
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 12:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiIPM3A (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiIPM2z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 08:28:55 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06360B1B83
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663331332; x=1694867332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQplvOiQjEOdLRCGtTe32NS+alg1Yiq6uX5VNstevaw=;
  b=oD5AoVnm1HnXf5tR8kTKjldCvu5RBwweFD18elVIqeIMA5iqFqlIgchu
   oYrtPvlMml5MJ+U3YFBO+wNIZNxycUryuk3s2y0ngqrvq1JsarNTnkFD1
   /E3e1i6OsXMe8f4iCR0dOFGFTf9NLNRU+ezQC2m/7Kr6zLANy7SvuOYWR
   rHgiYvLa5niZgMAR5Bw9GCCocsNJOMtEJuPk49pjTb718jeOgcnOEQji1
   hJWZliL/ZabDtUcay6vabEc1+z31yZloINCSUiEFtyTZBsuuAZbbnwwBn
   yONSFXqcahfEKi7hT3uirrFK2pWZdO5Nx1yK5nYuBvc43KQU+ibEpxbu+
   w==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216701275"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 20:28:52 +0800
IronPort-SDR: s0O8+bSXmQV9XeSGegT6nmdEkKJscSBYmOqmb+ziruQHVJ6KRihUiqbFZX9bCGXTjuUBLleuoW
 X0GwTb/m8bIKUi32nFivIu+UlGC3m57p6W+3oHbWXBAu1UqnsTt59E96LyVQ9rkET6t9S17tcW
 o2h8OC7/QrOXDxu2y1RIiQSqNehvie15rXT94ihjRZLR13YQZzy10wEyk4ge2tRIURutqslgP1
 lNXhbsyhiPRd7wrNYreCuFCO2+JK1E4GqiQ5q+aCc4u2i+8NWDPpUYCbdu/A5mCwBODJArBE+j
 ehC0SWz1tniptpmSctVrVnKS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 04:49:03 -0700
IronPort-SDR: EW84Rl5ky2Gcq+oQ5687aFaS6z14EmyY+PWA1u9izHnHbjLAjYqKtl9abxGkqJ5FrUMvTJsaUU
 5ZeuOjqueO3Yx0C122NDLanfnEwgvHqhW4kCVvbcVar6kEGc+Ld3+0G8Krr/VrSF7wb8kQCNTK
 UxYMEsEghzCSHDcO/J17apy9WPZPATi/qSBBLjwM1kR+bclb7E0JsfbAYIQT0kf7Bmd9ZZOUO3
 I6IAM6LQAvW2jx8S3ZiokG3TFplE7VS7mR41mN/XGqEo86GutgPUnBKQMLuJ9jc95mp81MjVrh
 lCM=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO x1-carbon.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2022 05:28:52 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 5/6] ata: libata: drop superfluous ata_eh_request_sense() parameter
Date:   Fri, 16 Sep 2022 14:28:36 +0200
Message-Id: <20220916122838.1190628-6-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916122838.1190628-1-niklas.cassel@wdc.com>
References: <20220916122838.1190628-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The parameter can easily be derived from struct ata_queued_cmd.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-eh.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7c128c89b454..687f92129a81 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1393,7 +1393,6 @@ unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
 /**
  *	ata_eh_request_sense - perform REQUEST_SENSE_DATA_EXT
  *	@qc: qc to perform REQUEST_SENSE_SENSE_DATA_EXT to
- *	@cmd: scsi command for which the sense code should be set
  *
  *	Perform REQUEST_SENSE_DATA_EXT after the device reported CHECK
  *	SENSE.  This function is an EH helper.
@@ -1401,9 +1400,9 @@ unsigned int atapi_eh_tur(struct ata_device *dev, u8 *r_sense_key)
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-static void ata_eh_request_sense(struct ata_queued_cmd *qc,
-				 struct scsi_cmnd *cmd)
+static void ata_eh_request_sense(struct ata_queued_cmd *qc)
 {
+	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_device *dev = qc->dev;
 	struct ata_taskfile tf;
 	unsigned int err_mask;
@@ -1579,7 +1578,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
 	switch (qc->dev->class) {
 	case ATA_DEV_ZAC:
 		if (stat & ATA_SENSE)
-			ata_eh_request_sense(qc, qc->scsicmd);
+			ata_eh_request_sense(qc);
 		fallthrough;
 	case ATA_DEV_ATA:
 		if (err & ATA_ICRC)
-- 
2.37.3

