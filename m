Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301FFECAAD8
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 12:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiIPM3B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiIPM24 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 08:28:56 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97B4B1BBE
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 05:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663331334; x=1694867334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6Me3ZJCYlcCTqdCTrBcxTLOKt3PwCnG+vj+XEzhMec=;
  b=MPP03EtPhVaRz2x5SYjBN3HHo3Y4NKkoP98EyMDvrmsbKsS6UFPfkyaG
   H90+SAa7XUOch0H0xYsi/lxavnZ6zawtELBNynbsf8L7Zb7aZMbi8qSs6
   sFtdR5NiCgf6orBchpDZeWj7gGl0JEHOJ4/fUF5XeAcvya8yRbvtWJaFF
   iKb8a2xLZoV/lbfwz0+fNHV2uEeLsVahIhTeaK2e2GZ8LXrKCKdj6lHPm
   BF0sazJ/E/bKhbgvScSAHwrXc3TafwDWnH+ZtKIyZdc3c1EMCaneowFqF
   VDoxRULJZIgCS/v355Nlb11ZQqky+GWFj5vOnGHI2RswTe6OBPbBCqh5C
   A==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216701276"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 20:28:54 +0800
IronPort-SDR: 12/SIO0b47N8rEThYeXHJry+gcb/2liMBpfor1qitS30Wu88YCy6KPaY+g3EdqrocMdpzXAUDB
 t65LD3I531UeVRoN8QFOo4UdUOmbkt/B13SMXowjtzSSbW+uvTU2G2rGSHO5VvGogU1HTmdeek
 52iwASUp4DqYaQVsbwBokK0k+/vtyiUA37vsPmlDA4f5qy0hwnBpJLkcX7F5XyFGAmzWgqklgl
 dYcjT91adEcRMQCTTTSbyTuGhxf6sRLNz7dNYd/eTv1j5zVT3J8xk9RgeD21P59BKw3jmGUZeT
 lITZTFXvyEC8fAaPr3JMLe25
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 04:49:05 -0700
IronPort-SDR: aRBpAaorzPIOezNlU1N2OpLE9fKDzgfXqEQ9Vj7fyHficr6ZFnMY1r67aiC6MkA+Hah9suCa5l
 5QShBuuqn/Os0+VUqKTZIGq7klAuaq0BBWl/ZwE9TdVkpDSOcCkM20CB/8KGlNS+Sb/46y3GFd
 tmnGS1+D0NKrOG4yzZde/d6pO+ZxLOmHJiEKed+9nxjfC+ep6MuBqjFL0PQk/0khzx1/5IaQk8
 d1VcVhg/jVK6s67/Lv3v9baywyDSGl75VZqOM7PKlqY6tDm1KT14MXIvBek7782CikaQ37TpgT
 NGo=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO x1-carbon.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2022 05:28:54 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 6/6] ata: libata: drop superfluous ata_eh_analyze_tf() parameter
Date:   Fri, 16 Sep 2022 14:28:37 +0200
Message-Id: <20220916122838.1190628-7-niklas.cassel@wdc.com>
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
index 687f92129a81..f2286672e989 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1540,7 +1540,6 @@ static void ata_eh_analyze_serror(struct ata_link *link)
 /**
  *	ata_eh_analyze_tf - analyze taskfile of a failed qc
  *	@qc: qc to analyze
- *	@tf: Taskfile registers to analyze
  *
  *	Analyze taskfile of @qc and further determine cause of
  *	failure.  This function also requests ATAPI sense data if
@@ -1552,9 +1551,9 @@ static void ata_eh_analyze_serror(struct ata_link *link)
  *	RETURNS:
  *	Determined recovery action
  */
-static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc,
-				      const struct ata_taskfile *tf)
+static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
 {
+	const struct ata_taskfile *tf = &qc->result_tf;
 	unsigned int tmp, action = 0;
 	u8 stat = tf->status, err = tf->error;
 
@@ -1956,7 +1955,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		qc->err_mask |= ehc->i.err_mask;
 
 		/* analyze TF */
-		ehc->i.action |= ata_eh_analyze_tf(qc, &qc->result_tf);
+		ehc->i.action |= ata_eh_analyze_tf(qc);
 
 		/* DEV errors are probably spurious in case of ATA_BUS error */
 		if (qc->err_mask & AC_ERR_ATA_BUS)
-- 
2.37.3

