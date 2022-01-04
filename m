Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F033C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiADJFQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:16 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:49693 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229903AbiADJFN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:13 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsj0V5Pz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287112; x=1643879113; bh=zMLwERhoWNNnEFd7AR
        ZgfZfAmC8QwMMSK6J5TkE+NOs=; b=Qc6zY4rkET9V/v3lHvsU9MiLBMZ88W9/DJ
        mmXej4nKg6SC/HZ5qb7EpkfWzuqqr7amEBXl2pCiebY/E08P/waNxrOrSxBw+vTF
        rcyEcsrkesL+s0rA//u8gVlarNq6Nsr1s4cY4p2mpZTwcBiue0tQprVhcOM8sG0S
        YAgmLRE7S2nqsRZ1NtaaldPC8/WiVr0QFgwGnJu2YqQh504CUc204uFEKsFM86o+
        Tho5Ycqg1DmjbLp+8HLXz2D/lwWGyBjbf2DOS0lilvBRkRNfsQ3kDY2/bFBSdqWM
        bWHjULjsBArVL2koFJHhvOD6/1IZbGZQRdFhOjfMQtgQQLB8HLSw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ocKhypaMMmJz for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:12 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsh3ChTz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:12 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 04/21] ata: ahci_dm816: add compile test support
Date:   Tue,  4 Jan 2022 18:04:51 +0900
Message-Id: <20220104090508.1592589-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_OMAP2PLUS.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 9f1288fd5482..e9f919f17d09 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -183,7 +183,7 @@ config AHCI_DA850
=20
 config AHCI_DM816
 	tristate "DaVinci DM816 AHCI SATA support"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the DaVinci DM816 SoC's
--=20
2.31.1

