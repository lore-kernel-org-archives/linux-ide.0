Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91636C433FE
	for <linux-ide@archiver.kernel.org>; Tue, 18 Oct 2022 19:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJRTLN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJRTLB (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Oct 2022 15:11:01 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A6D28724
        for <linux-ide@vger.kernel.org>; Tue, 18 Oct 2022 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666120260; x=1697656260;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uFx+cIF2B48EL7XjK41r06t1GGAXOyurA9GNTPL1qWg=;
  b=iSq+n/ylASUMZksiyNTaHsIkMltliULMEWcmA6jbmKnuYqcyrpL6/hRq
   CSFqPQNjzjTiXyOYwZGsVnHDEmXSCuNLV6hrG53KLjQI1jnIGejBwBNuy
   hflSma8xZ5NHYutVDBHmHGxx9tY2KKrep9Bcqv/GBF/FxLQMc5aBZpREy
   Et3zprDMmG5r3PxkjV0PKdtrlrZpH47yCpYkgZc2H4NGX/dnsmRy8otq+
   x0lAtgEESXMgQ7m9A7Fwggrv7bfNpfB36flD1Wwxf313IgSwMpT1iG/H2
   S/oy0xc9v6k26mXUn4KjZqAOeG3mbz/V1m2+KjTiWYSKXyMX0708/FT9o
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,194,1661788800"; 
   d="scan'208";a="214533335"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2022 03:10:59 +0800
IronPort-SDR: v3nDmihTBLIS1nLqHQevGcHPtpC8fiRrhYtt++vSNm1036rrjK8B/nYee/I8pS2dE4hkl8B2UD
 dH3qClDqx0F3/TPH/u6HAva586a5bVOa5UVvrd5zFB1wYPzcUmsGUNWQdb1KxNvW+qgQm/uXUi
 0g1MhQgTQFzYUw0hK6hSgbI/4ClepD6c4HHRPNTl2Pkv0yam9dZZ7rKfHcU+pgtSMACpc9l8Gb
 KH2bZv2DYSJRJ8mdQKutzt7Tu9VR3rOewfnm7d0xGyZs/24cNPiloiX2EAk56kapTU6vBNArpn
 wloHuZW9qnbUDpuMTNgKCWCv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2022 11:30:30 -0700
IronPort-SDR: x5+ZUPcj+P1KOwcRhHqoScFWljic0JVC/kq2x8ZcfLRKDIKEIKyhCCVJq8g2BPMm1Y4llI/Sl1
 0wgttfQZu3rVXJB/8X2u76ckzZL/3cjG47FSWhg17cM1h+mtNj9azOCG9BRvsqy9HFq45gGRnR
 bhW7CYquO5NrRklsXr6B2OXmYC2g25I+t/woduenXgDlwoYa+PAIlQ/Ry9IpjPBwOHx3XzhUCH
 uR0LgGQ2dle9Ru6K+n049X/GTHhPm/W1UA4Sg76biohCT6kVpJ8ddve0jPekQ9ZSzQZwmqlMpn
 2OU=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Oct 2022 12:10:58 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 1/3] ata: remove unused helper ata_id_lba48_enabled()
Date:   Tue, 18 Oct 2022 21:10:52 +0200
Message-Id: <20221018191055.2367325-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Not only is this function unused, but even worse, the bit it is checking
is actually used for signaling if the feature is supported, not enabled.
Therefore, remove the unused helper function ata_id_lba48_enabled().

ata_id_has_lba48() is left unmodified, since this extra supported bit
(Bit 10 of word 86) is simply a copy of the bit that ata_id_has_lba48()
already checks (Bit 10 of word 83), see ACS-5 r10:
7.13.6.41 Words 85..87, 120: Commands and feature sets supported or enabled

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/ata.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index e3050e153a71..c04aca58448a 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -698,15 +698,6 @@ static inline bool ata_id_has_lba48(const u16 *id)
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 10);
 }
 
-static inline bool ata_id_lba48_enabled(const u16 *id)
-{
-	if (ata_id_has_lba48(id) == 0)
-		return false;
-	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
-		return false;
-	return id[ATA_ID_CFS_ENABLE_2] & (1 << 10);
-}
-
 static inline bool ata_id_hpa_enabled(const u16 *id)
 {
 	/* Yes children, word 83 valid bits cover word 82 data */
-- 
2.37.3

