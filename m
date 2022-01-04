Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F53C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiADJFM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:12 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:53546 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229888AbiADJFL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:11 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsg6H2rz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287111; x=1643879112; bh=kBJtz1rigrxYlXVUBu
        2zvTuqNDZF345Clzjqy7IR1Nw=; b=QjqBxCNfSA4vlMyI1fncNlqTgzpH9dsbQr
        vPHiLniZ5fyomLRYMGKTVdLQxNledJ75f814+YsfU+m5oNj9NjhU4O9Lz+g8W+15
        1u1nQ1UV/OIZD/xbdtwm66a10/oGzAnv/A3B94y/itZYvjWxKLqiICQX5hWy4LKB
        PbIJGtC84XbnLrkrBILFrdtWuEdC2IBcZxbh3bwEW1gEX1qvEm+3yupPdsm4UWLE
        iGeg55iQoitClXdQZ8T9q+MOToXrfb3ftKZUBRTZEoPBijNWgEe1J+M/ydJ00mWn
        jd1pmToXumVMBT3/AmN7vNfz3IWuCfwsexbpL17o6jJK0H1NRg5w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s7IkQ8t4BHFE for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:11 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsg1bsKz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:11 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 02/21] ata: ahci_brcm: add compile test support
Date:   Tue,  4 Jan 2022 18:04:49 +0900
Message-Id: <20220104090508.1592589-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_BRCMSTB, BMIPS_GENERIC or ARCH_BCM_XXX.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 80bad7cba631..3bf38a328851 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -163,7 +163,7 @@ config SATA_AHCI_PLATFORM
 config AHCI_BRCM
 	tristate "Broadcom AHCI SATA support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
-		   ARCH_BCM_63XX
+		   ARCH_BCM_63XX || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the AHCI SATA3 controller found on
--=20
2.31.1

