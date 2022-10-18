Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6886C43219
	for <linux-ide@archiver.kernel.org>; Tue, 18 Oct 2022 19:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJRTLO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJRTLD (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Oct 2022 15:11:03 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD541F2DC
        for <linux-ide@vger.kernel.org>; Tue, 18 Oct 2022 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666120262; x=1697656262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YqqAv9Yqf41OrfCSGIwM1W/yjX8UlkXu7OkJOCCBTI8=;
  b=aiTa5B+jjogjikGyDRMduF0n2CRmAnRmwDu6srQMI9Va/RdtEGTQ8SGU
   ESjbGB+wyyNqUxJ/rSWkSCwRIbiBUvGlms4rHhD9dFEWLkaTa2+2D/MXU
   4VgXGJCW6Vn4PT81J3e/vEzKPzUxaSSlfnTTQ/nLymldxNwmla+mmxogL
   VOWvfe1URTFmoUReMtKQDDcvkpgkHjFO6lX4eGC0pxKNkaF/rD+wfZcrm
   iM/0745Xz6vuTwzFYks6yXRXNUbNvqWSR5m/a4RunE2rVhLHfDvbXF+j5
   MtfB+YUaQ2bJ9nElYTWKjS0R6F6qzLycLrRRdqh7oCagrjeoqXJMxXQ/v
   w==;
X-IronPort-AV: E=Sophos;i="5.95,194,1661788800"; 
   d="scan'208";a="214533339"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2022 03:11:02 +0800
IronPort-SDR: fvhFowEIWHYSow4ZNP8fT8ZB87tHuHB2pyKxLx8uMFyp0kLB9quj/N+bZviMU6hSkWR7kU8n7v
 x2T9BTc8dz2xT29Qurl5i7YTJyTdDXkTABB42KfZgWnw6dYqIqseG4cDxqrABQz+JM9BQvB1dc
 0u9hBxow9XgKTnD3Y7IwIUHG0CmYXqUQwnanJI0duDiuD7H4lwctahPp+1mdTzo7MRCy3ptuTV
 1VzlQCjEVyM92N5l0tfokW4dpYbHsOOSLpP7D61OArmee4vHQ1gZkBuaL/ku94RdItzVmpiH/I
 ziWlFIkFaoeYy3fHqR3j0cgp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2022 11:30:34 -0700
IronPort-SDR: vqiXYqj3E81yFGBI8bOR/EcwqFSlbJcW4xslsIzACE+pR7M3pWm8q6EqIZaCud6sPUcDjwV6/Z
 PCVjEFCMiznlt/HuI9rDFQuzRDCfF5x/OX8hL4+nytjkOPGms511AqgBS7bryJHxW0K3XntTfc
 TGL15j4EBi2ILtJn85RQC3tUa2wPL7FzD7vHtam0bhYdqIbbScgut285glhvJzMoHDp20vr5zL
 BBlzwh7McO4fYIPrLS0Gz/6FubLyCe6L4/VOLLI4XZMQxO8myHeWhKkyMbI1iudFcU7Yb8da4+
 wvE=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Oct 2022 12:11:01 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 2/3] ata: remove unused helper ata_id_flush_enabled()
Date:   Tue, 18 Oct 2022 21:10:53 +0200
Message-Id: <20221018191055.2367325-2-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018191055.2367325-1-niklas.cassel@wdc.com>
References: <20221018191055.2367325-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Not only is this function unused, but even worse, the bit it is checking
is actually used for signaling if the feature is supported, not enabled.
Therefore, remove the unused helper function ata_id_flush_enabled().

ata_id_has_flush() is left unmodified, since this extra supported bit
(Bit 12 of word 86) is simply a copy of the bit that ata_id_has_flush()
already checks (Bit 12 of word 83), see ACS-5 r10:
7.13.6.41 Words 85..87, 120: Commands and feature sets supported or enabled

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/ata.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index c04aca58448a..b32d62542e26 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -615,15 +615,6 @@ static inline bool ata_id_has_flush(const u16 *id)
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 12);
 }
 
-static inline bool ata_id_flush_enabled(const u16 *id)
-{
-	if (ata_id_has_flush(id) == 0)
-		return false;
-	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
-		return false;
-	return id[ATA_ID_CFS_ENABLE_2] & (1 << 12);
-}
-
 static inline bool ata_id_has_flush_ext(const u16 *id)
 {
 	if ((id[ATA_ID_COMMAND_SET_2] & 0xC000) != 0x4000)
-- 
2.37.3

