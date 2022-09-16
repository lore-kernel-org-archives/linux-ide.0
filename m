Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58282C54EE9
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 12:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiIPM25 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIPM2w (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 08:28:52 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436C8B1B83
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 05:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663331330; x=1694867330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ryyGwkW4FZX+WKKDusTpuBy9xintf8TQcTu8F0R4rLs=;
  b=ThohbiyvEQynvfMxHoTIOWPWGoHDQkOT36/C06M+G0suPwDJ85/BSWSG
   Ozl5Pqkk0Fh9EVyr3kRx4lGY5JhxC4G1dK0/CXP8OKOlcpvFeHeYlu0GE
   ou1qxV49lUloacr1qVvNzHeNZp8T4lNo8n0xFv1NjTTmR5tZS7PZkTUOZ
   3J73dO3qMTce8rNlEjmLh9Vs1bd1Qmyge6ilm9dbHuZ2icrOf2hGz/LaT
   kzE6wiGZ0MOvBA/Wv0GwTaSO3AmrSdzJAaa3/S+TGG/ZbQiayq5alWbjB
   O8Bkn8JiZVk+x8MPrM4y6eFjEvf8eVntkuvykD+49O8XXmbafaWTOIrPX
   g==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216701273"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 20:28:50 +0800
IronPort-SDR: sT/1Cq4MunFHT6g+tml9LIE9kM1Woi3wPbE/h0gIdW3HiAj3aZDU+yZxFhm/kGWdgIzDIHPJHm
 2h8D9uk4HlNThjQUdmbmlqMPK5zQnosayYeZ5Ug21QKu0fesKcc4WBRRx8+LecS2CdzhuyaTiX
 oout2LFtmghBNIrV22lAlC9knDwpeAQ47xA9YTrm27ZDy/nqISuHsjGSyWdg6ZhxDIZ3PVLYbX
 IRBPVmwaas9JqV26f9dtz/FxeItx/3MVqDYdPuXullyetg6yJRDm0dcso6c23dYLhkDTUhIue8
 ILvs0mr0ghR680BTR0kWzZol
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 04:49:02 -0700
IronPort-SDR: NJU/zCd8uJqJqB5xLhS/vsntOm0WwPsAVv7w1ha117ctFVsNskze403uQfaG7al561qEA3b5Iu
 E37XO0Qn/N2EU925jD/uDQaPkD9uJgp/V80YRp0vUvaxGRUbnRinrLFafRKV/tr8YBoJ/qQlAT
 NiggJTFD/dOb9otpquS3SfHI0ndFLjmdzZ0la9lrW4NKILep7Lzrt5HBHYdpO8IKltyLo8qANk
 9ygHGieXnFsc+Ojm/U1MczZYhaFWdzk02b68cfyHkHZfUalzLKqDRYKeCXAK8zc5GJhYaRE6QZ
 ogw=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO x1-carbon.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2022 05:28:50 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
        Jeff Garzik <jgarzik@redhat.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 4/6] ata: fix ata_id_has_dipm()
Date:   Fri, 16 Sep 2022 14:28:35 +0200
Message-Id: <20220916122838.1190628-5-niklas.cassel@wdc.com>
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

The problem with ata_id_has_dipm() is that the while it performs a
check against 0 and 0xffff, it performs the check against
ATA_ID_FEATURE_SUPP (word 78), the same word where the feature bit
is stored.

Fix this by performing the check against ATA_ID_SATA_CAPABILITY
(word 76), like required by the spec. The feature bit check itself
is of course still performed against ATA_ID_FEATURE_SUPP (word 78).

Additionally, move the macro to the other ATA_ID_FEATURE_SUPP macros
(which already have this check), thus making it more likely that the
next ATA_ID_FEATURE_SUPP macro that is added will include this check.

Fixes: ca77329fb713 ("[libata] Link power management infrastructure")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/ata.h | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 4845443e0f08..e3050e153a71 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -574,6 +574,10 @@ struct ata_bmdma_prd {
 	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
 	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \
 	 ((id)[ATA_ID_FEATURE_SUPP] & (1 << 7)))
+#define ata_id_has_dipm(id)	\
+	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
+	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \
+	 ((id)[ATA_ID_FEATURE_SUPP] & (1 << 3)))
 #define ata_id_iordy_disable(id) ((id)[ATA_ID_CAPABILITY] & (1 << 10))
 #define ata_id_has_iordy(id) ((id)[ATA_ID_CAPABILITY] & (1 << 11))
 #define ata_id_u32(id,n)	\
@@ -597,17 +601,6 @@ static inline bool ata_id_has_hipm(const u16 *id)
 	return val & (1 << 9);
 }
 
-static inline bool ata_id_has_dipm(const u16 *id)
-{
-	u16 val = id[ATA_ID_FEATURE_SUPP];
-
-	if (val == 0 || val == 0xffff)
-		return false;
-
-	return val & (1 << 3);
-}
-
-
 static inline bool ata_id_has_fua(const u16 *id)
 {
 	if ((id[ATA_ID_CFSSE] & 0xC000) != 0x4000)
-- 
2.37.3

