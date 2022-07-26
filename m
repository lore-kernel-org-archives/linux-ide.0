Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1426EC00140
	for <linux-ide@archiver.kernel.org>; Tue, 26 Jul 2022 15:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbiGZPqG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGZPqF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2022 11:46:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC69933D;
        Tue, 26 Jul 2022 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658850362; x=1690386362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YhPaHyAlPYK+8PuEbbQb07ky4zl8I4qJArCYBzMhLvs=;
  b=IzbPv8hoYBL2L1+WhaI4e75CVs8pYksvnD3qqEgb5iOCWRp/+gp6q76t
   4oDLuZ2lmPF/sQaL9UJ94orTd8xOQhoeq2PHceIUxSiNsUPuQTltCC03C
   QgkVMKNNAilnVlgtaY9GZOTRFmvS0Q6V1GVr92h+yjyRyAd/WkbS1y+zo
   Sv3armULbQdglSGxPsguuxjIWL1grO/Eat3IAuCn14eNgc1BuYPE3kxie
   Jg/3mPLRLG9cwl+152EI1L5Qxyyu2GsIE5TQlDO27pAPVax2XvIW0XKZ/
   hCrU3a5KU4OXA4m2nSn4mbN50xieve29MJ6DxsvmSF2BvvqTWqJ4q3vcF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="374287222"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="374287222"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 08:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="575540251"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2022 08:45:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AD304F1; Tue, 26 Jul 2022 18:45:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ata: libata-scsi: Refactor scsi_6_lba_len() with use of get_unaligned_be24()
Date:   Tue, 26 Jul 2022 18:45:18 +0300
Message-Id: <20220726154518.73248-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Refactor scsi_6_lba_len() with use of get_unaligned_be24() to make it
consistent with other similar helper implementations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/libata-scsi.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 29e2f55c6faa..857996add897 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1318,17 +1318,8 @@ static unsigned int ata_scsi_flush_xlat(struct ata_queued_cmd *qc)
  */
 static void scsi_6_lba_len(const u8 *cdb, u64 *plba, u32 *plen)
 {
-	u64 lba = 0;
-	u32 len;
-
-	lba |= ((u64)(cdb[1] & 0x1f)) << 16;
-	lba |= ((u64)cdb[2]) << 8;
-	lba |= ((u64)cdb[3]);
-
-	len = cdb[4];
-
-	*plba = lba;
-	*plen = len;
+	*plba = get_unaligned_be24(cdb[1]) & 0x1fffff;
+	*plen = cdb[4];
 }
 
 /**
-- 
2.35.1

