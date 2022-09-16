Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F070ECAAD8
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 12:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiIPM2x (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiIPM2s (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 08:28:48 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB93B24AA
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 05:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663331325; x=1694867325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6vmPIx6roDANIrbR5KXArLWL3Yr6rQf886XQTFmgVuE=;
  b=Ah0Tf56o/Wjiat5pYgXWZZJQaheNeVOK5Lk8NvD5X3PNYVgQPKyZwy0z
   dRXnVyFwIzyOXzT1hSJbNIPhFfKTBs8q6995LVLsvo47BIdwlt9iRyEKB
   iqZnCqj2COaLzrz8SnvDrgnO2lObYYpKcDFzxYchL26eaaNb0En9kPkEd
   H4IXq9UWzalo9oUuZso/A1qkKsyrV/ijDLWYgpCxJzwEzDV5L34EHMzyb
   owePDGOOpILbX1fhvxh3zk3Hsteen6DCmP5+reB1+/p0tBXEKqgpqXZrZ
   PQgwNaH7NcoMERrCrGgAljpDHqFmcL/y0/km7jbSYAj7/CiIsC4cczkdO
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216701265"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 20:28:45 +0800
IronPort-SDR: AIUVuRrSADTi6xDTMHzoFhyZYtaKiicL6kh5/dgvwPE/wWDmyKm3JctzJqid5ETMqWat64nu/O
 ncaU/sjWW56NTjgo22+nCzq3QR7IXAptS02omO1fnRsTGs/6t/xqBLVYpU1kL2J4g2l/7U+OI7
 TLGR9HfGtXFwCoDmciCEw6lrrDuMuCPb7oAl6I1vqHUsYAoVwI4Za9F2k9JsxM+5ATJTzjV/5k
 FP0p/yXqTVdyN1VTwul0F7ii8NrUglQkPJzpUWhmb31wWUG1uvoiFdpaw7Xkyb+9iCqVLZx3Sr
 3DiHRvs+caqxOtVuP26Z1Cen
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 04:48:55 -0700
IronPort-SDR: jwmgpW45vrj+UMZerckj4jAao+Bz92bI0q2frGdYzUdXdUX1DVTqzKSvu/csLKG4P584PifGNI
 EN7bmuEpPYZzE65nwrbYm08G33wWsB3mV9oZR4kKIYjwFJ5CokE3mnR4YyorhbDLMJPIGa4cED
 Kp0C/V4j4UR9mmIjhA6Yd+lVXdryIMJO6kkVs1C7iheqQ2X0aK66jvsSVItXQwWONaTd42sda/
 uPz6sbKbgLq7OGnDt/OK+OLSFVfDoQ9oKJOHB0cSip5Jkk4Q1nXrIKOR9gDPxZoqjZlmSestPc
 JzU=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO x1-carbon.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2022 05:28:43 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 1/6] ata: fix ata_id_sense_reporting_enabled() and ata_id_has_sense_reporting()
Date:   Fri, 16 Sep 2022 14:28:32 +0200
Message-Id: <20220916122838.1190628-2-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916122838.1190628-1-niklas.cassel@wdc.com>
References: <20220916122838.1190628-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ACS-5 section
7.13.6.41 Words 85..87, 120: Commands and feature sets supported or enabled
states that:

If bit 15 of word 86 is set to one, bit 14 of word 119 is set to one,
and bit 15 of word 119 is cleared to zero, then word 119 is valid.

If bit 15 of word 86 is set to one, bit 14 of word 120 is set to one,
and bit 15 of word 120 is cleared to zero, then word 120 is valid.

(This text also exists in really old ACS standards, e.g. ACS-3.)

Currently, ata_id_sense_reporting_enabled() and
ata_id_has_sense_reporting() both check bit 15 of word 86,
but neither of them check that bit 14 of word 119 is set to one,
or that bit 15 of word 119 is cleared to zero.

Additionally, make ata_id_sense_reporting_enabled() return false
if !ata_id_has_sense_reporting(), similar to how e.g.
ata_id_flush_ext_enabled() returns false if !ata_id_has_flush_ext().

Fixes: e87fd28cf9a2 ("libata: Implement support for sense data reporting")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/ata.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 21292b5bbb55..868bfd503aee 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -771,16 +771,21 @@ static inline bool ata_id_has_read_log_dma_ext(const u16 *id)
 
 static inline bool ata_id_has_sense_reporting(const u16 *id)
 {
-	if (!(id[ATA_ID_CFS_ENABLE_2] & (1 << 15)))
+	if (!(id[ATA_ID_CFS_ENABLE_2] & BIT(15)))
+		return false;
+	if ((id[ATA_ID_COMMAND_SET_3] & (BIT(15) | BIT(14))) != BIT(14))
 		return false;
-	return id[ATA_ID_COMMAND_SET_3] & (1 << 6);
+	return id[ATA_ID_COMMAND_SET_3] & BIT(6);
 }
 
 static inline bool ata_id_sense_reporting_enabled(const u16 *id)
 {
-	if (!(id[ATA_ID_CFS_ENABLE_2] & (1 << 15)))
+	if (!ata_id_has_sense_reporting(id))
+		return false;
+	/* ata_id_has_sense_reporting() == true, word 86 must have bit 15 set */
+	if ((id[ATA_ID_COMMAND_SET_4] & (BIT(15) | BIT(14))) != BIT(14))
 		return false;
-	return id[ATA_ID_COMMAND_SET_4] & (1 << 6);
+	return id[ATA_ID_COMMAND_SET_4] & BIT(6);
 }
 
 /**
-- 
2.37.3

