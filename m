Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E0C6FA8B
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 12:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiIPM2z (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiIPM2u (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 08:28:50 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10066B1B83
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 05:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663331328; x=1694867328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUJMkgz/IVMm8VFUSfpopFhoJpW8NPVy6S04t09ELU8=;
  b=R/asADhPBdxqdaL98ElocwFijVLsbpv3IQ1U5pyQmd3XyZp+Zx8D+ADS
   bHdt5o2NIhE8qy6wffesLsuud67wjq0K5QbFX7Me7yCwUpVOhYOaX9JPN
   5g6ojyuq+OmsF/yM9tbVneuB9m8M1mwckJjDYkzQLQM5Mf82AreEn6a0e
   1KDG2lF+W4e/J3uGMslLScOjt5Jk1SVYbu6BH92JBWSs3vZ9Xeu8AWGTa
   5TjHOWwqZf8l+yMbqE2NKakvwDvE4QtH2ZYR/FYeJZJhGCXObnTp3UYrx
   ETDHFLbub6eZ30I6ASAUg+LZsb96pkgpjQff8sum01XuFX46QIHmyy0+0
   A==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216701267"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 20:28:48 +0800
IronPort-SDR: Ht8beljPT2sIaYW4QEzlfgQuHQBX+d9tJLk5gSbJ7Gu5JzsZZzMVbRawdWgScKSUFTg5X4zSG0
 0V+l7AFH8S09d8rgJfcwM8y0b+xGNz/Sw4g7Viug0s0ORjRwUvUXUsO45W7r2tAYNDWcmCK1bh
 oshH3W8lH6KeyvrszEgAuxWjJUZnXtAd/uXppz7bw3/cwPNqMTIB8pXtTPBV7dvRXS1mncfTjF
 9S1cScQvwIsA4b2dSh0uT8GUmVNzlnWN5fUFEpb4o9iuDvhsYxec5WcBKDn6dYZ/8AOo9Hc/7k
 4PpggNQPDKxlyOdFtXr+xlIM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 04:48:59 -0700
IronPort-SDR: uPmMzG4aBjpOC5CvEGrC/pdoK9ihGfRMs1imht7/1DQ8f8BvR4porVZuTJ6SrG+WWuvFiH+clS
 j706+JtrnWYMY8UjOoKdOeISZI3+cJ0dvK3KCvAVW+2Kf/BZzT5t3UDOYM6qLBiDPY4hBR+Amb
 panYUdQhSjc4pEIkAufpG8lbhphodejWoCQpIhE6YSs3t78gT5yM6HBRXx+N8pmRJIiI1Hb3bv
 QZfXzPFzCE9h4ca7DoydmMKL6N/zJnmB//6OgsQCd14B7xffSR2pZFnIPse+0IoVtVCjYkZcSt
 gJc=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO x1-carbon.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2022 05:28:48 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 3/6] ata: fix ata_id_has_ncq_autosense()
Date:   Fri, 16 Sep 2022 14:28:34 +0200
Message-Id: <20220916122838.1190628-4-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916122838.1190628-1-niklas.cassel@wdc.com>
References: <20220916122838.1190628-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ACS-5 section
7.13.6.36 Word 78: Serial ATA features supported
states that:

If word 76 is not 0000h or FFFFh, word 78 reports the features supported
by the device. If this word is not supported, the word shall be cleared
to zero.

(This text also exists in really old ACS standards, e.g. ACS-3.)

Additionally, move the macro to the other ATA_ID_FEATURE_SUPP macros
(which already have this check), thus making it more likely that the
next ATA_ID_FEATURE_SUPP macro that is added will include this check.

Fixes: 5b01e4b9efa0 ("libata: Implement NCQ autosense")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/ata.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index bc136a43689f..4845443e0f08 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -570,6 +570,10 @@ struct ata_bmdma_prd {
 	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
 	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \
 	 ((id)[ATA_ID_FEATURE_SUPP] & (1 << 8)))
+#define ata_id_has_ncq_autosense(id) \
+	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
+	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \
+	 ((id)[ATA_ID_FEATURE_SUPP] & (1 << 7)))
 #define ata_id_iordy_disable(id) ((id)[ATA_ID_CAPABILITY] & (1 << 10))
 #define ata_id_has_iordy(id) ((id)[ATA_ID_CAPABILITY] & (1 << 11))
 #define ata_id_u32(id,n)	\
@@ -582,8 +586,6 @@ struct ata_bmdma_prd {
 
 #define ata_id_cdb_intr(id)	(((id)[ATA_ID_CONFIG] & 0x60) == 0x20)
 #define ata_id_has_da(id)	((id)[ATA_ID_SATA_CAPABILITY_2] & (1 << 4))
-#define ata_id_has_ncq_autosense(id) \
-				((id)[ATA_ID_FEATURE_SUPP] & (1 << 7))
 
 static inline bool ata_id_has_hipm(const u16 *id)
 {
-- 
2.37.3

