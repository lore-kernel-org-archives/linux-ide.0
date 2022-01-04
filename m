Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24922C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiADK6t (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:49 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:45962 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230319AbiADK6t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:49 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNm6jS6z1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293928; x=1643885929; bh=zMLwERhoWNNnEFd7AR
        ZgfZfAmC8QwMMSK6J5TkE+NOs=; b=R3CKID5Gqyaej0x/WqTy+1fmfuKHFazabG
        AGZTik2ew2FDYK2s6iVGTKp57v7a+M7jhaQRHXPTE32rkKx4VanqjsnpFi1L5l+C
        9A9CoMTtCy+ctZiyyMAfF+BSvITMg991vJYhBgE0aUk4NCezH26cMbzY9oZG3W67
        GTxX9qx7/K4yG4nP47pTPiCDS504wrgv9PmvVHefOxjlpxgM05oK/KaYVGL2s+30
        9W/dCA4FBDCklFUSSSxdu3bTFuL0BjAWoqbxFwb56UVRQ6If/VdJ0LPpDQBMAPWk
        lYo9z5xiP/8IvQJKHWdmilOpzdHpwCCGv6MejXwcNM5DcBAj6Osg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 87vsT-gF4E_u for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:48 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNl6dtyz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:47 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 04/22] ata: ahci_dm816: add compile test support
Date:   Tue,  4 Jan 2022 19:58:25 +0900
Message-Id: <20220104105843.1730172-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
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

