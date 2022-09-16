Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1654C54EE9
	for <linux-ide@archiver.kernel.org>; Fri, 16 Sep 2022 12:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiIPM2y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 16 Sep 2022 08:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiIPM2s (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 16 Sep 2022 08:28:48 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C144B24AE
        for <linux-ide@vger.kernel.org>; Fri, 16 Sep 2022 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663331326; x=1694867326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bjxOt5GlRAvBDi+ES/Gbz/FfFJoyH5PD69W64ODuayA=;
  b=nNP3I3RycgUwjYe55l8s9NE1B7XNBlWJD4hCDoXGErIJei0EsOzz3Bo/
   ISV9DLkxhvSel2h8mRfiNg6G9Gqv/j8lRZup8vxUWHb2LLj+D3k3RMAtR
   BuKRv/QXNDtLFj7hlr3kGg0xZzC3n7KFH5oWLJ22ZG6VhpHlVeBRxNKuz
   RDm7PpKcaelDbrTCsKFGVUk6t3Ztv0yT9qXvuTOQ34k1NKdo1Iiqgup0F
   tP8n5bPK8Rrvw1xqFwBpUYe/8n/6ibXkqdAYjP4Mxt7oSwQVh9UiK2MJQ
   0IkALMjEppfmDXRN1mZN8Wq0WuAqvgoQ7Bm47NJEe+jpJHiMm1rFnoH0e
   w==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654531200"; 
   d="scan'208";a="216701266"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2022 20:28:46 +0800
IronPort-SDR: wivw46vyUIGuU1WntjRjpUuXVIDJws+Lur9lG3aNRNC4ZABb7NL5nhMTPJP+he0G0rszQzYqmh
 imhl92+YhU/mYmsl5OfuYnXRle38hDWjgYzApRtk1PLfry+k6JsdLEaYA7mA5JDdzwxcsvok1/
 mBEWKF/202VM8ifsKpNvBfaLH2ag6I9WryjdeMPZykZcg7esaYS8RC5cegyzc22W4yRfgHoUKf
 iODuWADdWkdSufv24i3Y3UM1FU7G/VcRX8h8uDqA/j5ymEq2RwnJCae5hrvt0OYQF9/hNM9hbX
 Aim2JFl32ASYavPGZce7XC0e
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2022 04:48:57 -0700
IronPort-SDR: kT/c/NOPY0jPmIiHtAsqSCLQeT8dQgnn1cWUFo/Nwnv7e3pUfo8wxLBYmPyM71jmwAmIhQLXNC
 BVVExkZ6JrxvAs97F+v+5/5oM2U+bpKfseFFAoalIcgODYgm5TB0EBZ1Ba9Lvm88P3iDLffI9s
 /XCQe7OleltLElXGeHCb1frH1DI2jxK7heu09gEYoRZ/0hXdFQbykqe3bj9h5vkdwZuWsK07k0
 agSy3XMgAinonIozFlUp5brPCC7w8WiVTMrQfMB+EzxivTHOoIU5Pm3g0iUmLfqOMMpY4lJK/q
 zPU=
WDCIronportException: Internal
Received: from dellx5.wdc.com (HELO x1-carbon.cphwdc) ([10.200.210.81])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Sep 2022 05:28:46 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Jeff Garzik <jgarzik@redhat.com>,
        Shane Huang <shane.huang@amd.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH 2/6] ata: fix ata_id_has_devslp()
Date:   Fri, 16 Sep 2022 14:28:33 +0200
Message-Id: <20220916122838.1190628-3-niklas.cassel@wdc.com>
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

Fixes: 65fe1f0f66a5 ("ahci: implement aggressive SATA device sleep support")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 include/linux/ata.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 868bfd503aee..bc136a43689f 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -566,6 +566,10 @@ struct ata_bmdma_prd {
 	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
 	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \
 	 ((id)[ATA_ID_FEATURE_SUPP] & (1 << 2)))
+#define ata_id_has_devslp(id)	\
+	((((id)[ATA_ID_SATA_CAPABILITY] != 0x0000) && \
+	  ((id)[ATA_ID_SATA_CAPABILITY] != 0xffff)) && \
+	 ((id)[ATA_ID_FEATURE_SUPP] & (1 << 8)))
 #define ata_id_iordy_disable(id) ((id)[ATA_ID_CAPABILITY] & (1 << 10))
 #define ata_id_has_iordy(id) ((id)[ATA_ID_CAPABILITY] & (1 << 11))
 #define ata_id_u32(id,n)	\
@@ -578,7 +582,6 @@ struct ata_bmdma_prd {
 
 #define ata_id_cdb_intr(id)	(((id)[ATA_ID_CONFIG] & 0x60) == 0x20)
 #define ata_id_has_da(id)	((id)[ATA_ID_SATA_CAPABILITY_2] & (1 << 4))
-#define ata_id_has_devslp(id)	((id)[ATA_ID_FEATURE_SUPP] & (1 << 8))
 #define ata_id_has_ncq_autosense(id) \
 				((id)[ATA_ID_FEATURE_SUPP] & (1 << 7))
 
-- 
2.37.3

