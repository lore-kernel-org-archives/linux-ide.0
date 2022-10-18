Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A664BC4332F
	for <linux-ide@archiver.kernel.org>; Tue, 18 Oct 2022 19:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJRTLP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJRTLG (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 18 Oct 2022 15:11:06 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A51F2DC
        for <linux-ide@vger.kernel.org>; Tue, 18 Oct 2022 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666120265; x=1697656265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XBi5JONUHLkgh5GrOiwpON56BlPI5qhx2/e44LRDZes=;
  b=DvCV/eG+RcHdJxGy6RTj9zpKuv6JrUQ2g0vwYJtZNXDv4emfnp4YJ9y2
   46O+V4kKTCUXhoeFI0GI0pn+sijgybDDzmRYL+/r019fn/kagIUk3mG1h
   z6+Vn6rppkV3T1AhLxFbyerwi57G9Rg4w5Hz3grV3r+U/b9NQ8sR6FNKA
   DFVwcsPVgE155fUHZoeaeBaQmo1yNpjjfrD37UXA//Dci1WgZTYQMAy8Z
   eQ+YpwlE//W9z6sSPVUaEUAxzaaK7jQRXCvL1jnvNdj81aUDik4DxH6lN
   qfv31qoqsmQxzLfM8ClJjBUr3n5UN/CTVnQzPfVcy5T5Wjap2FClLgQEY
   g==;
X-IronPort-AV: E=Sophos;i="5.95,194,1661788800"; 
   d="scan'208";a="214533342"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2022 03:11:05 +0800
IronPort-SDR: upgv+o+F7204O+722ZnC8WHdk7puCadVpVMN2DLTwv4HaaiN4UBmcYXV4QVVuLKzeTwbB5xLC9
 3/Qr5tRVuql16Ai9sAHWVLd2BhRq/asYAEwEXnnj5pVT5M9USkMPWtRalCvfb5UguT0IIu4lqZ
 KTj91uiMOIMISnYjJ8dGa9jlcTD34gU5ijtOLc7D7R6rcRYwY3NivcxgHuIFm7ULDwXxukPiHc
 ZNGXw6va6qMTwvAxoGb5fe9JD8Q+x5JrajeKhUNso/s2S3fERpWmfi2ZGyf2zLNE6BaCoXHhQD
 VTCu9tEB2U7IcRWNnFekHSh4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Oct 2022 11:30:36 -0700
IronPort-SDR: WaPvmmvnj7BQnI459j3p5xRVh9JGb/neAu3HLvd+IjrdGvlYQNd/tSjqrrLAlCcVn/QUzNFJqL
 ZUaEiWwD01ztkj8taMXvYKKXKtMbOG9ZGsWgBxBA/X5WSV43FbfaCF61Dxq7FX0QN6YrDseSxM
 DxJIIvxaSIss1X7stGwlztWV9gw3/nGty8yX8LQzKUnrslKFEKKU3PdmcFpyzGTE11bKp0e2JL
 Fiz/hQBais6bATVbl2sN/gza0dVR1u4n5xzR1K1AydMVyrT0rlKl7T+ZFjjGgQGvXYpyHTiA+a
 m54=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 18 Oct 2022 12:11:04 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 3/3] ata: remove unused helper ata_id_flush_ext_enabled()
Date:   Tue, 18 Oct 2022 21:10:54 +0200
Message-Id: <20221018191055.2367325-3-niklas.cassel@wdc.com>
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
Therefore, remove the unused helper function ata_id_flush_ext_enabled().

ata_id_has_flush_ext() is left unmodified, since this extra supported bit
(Bit 13 of word 86) is simply a copy of the bit that ata_id_has_flush_ext()
already checks (Bit 13 of word 83), see ACS-5 r10:
7.13.6.41 Words 85..87, 120: Commands and feature sets supported or enabled

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/ata.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index b32d62542e26..0c18499f60b6 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -622,19 +622,6 @@ static inline bool ata_id_has_flush_ext(const u16 *id)
 	return id[ATA_ID_COMMAND_SET_2] & (1 << 13);
 }
 
-static inline bool ata_id_flush_ext_enabled(const u16 *id)
-{
-	if (ata_id_has_flush_ext(id) == 0)
-		return false;
-	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
-		return false;
-	/*
-	 * some Maxtor disks have bit 13 defined incorrectly
-	 * so check bit 10 too
-	 */
-	return (id[ATA_ID_CFS_ENABLE_2] & 0x2400) == 0x2400;
-}
-
 static inline u32 ata_id_logical_sector_size(const u16 *id)
 {
 	/* T13/1699-D Revision 6a, Sep 6, 2008. Page 128.
-- 
2.37.3

