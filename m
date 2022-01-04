Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BCEC4321E
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiADJFT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:19 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:1348 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229919AbiADJFR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:17 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsm5Qptz1VSkf
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287116; x=1643879117; bh=Ik/iJN29saoAXaf9Dx
        VMrXJzk9JqPNovwcbKk5tDEs8=; b=UmXpKqZXk0pHqPQgag4hczbEW6WatCQ5dM
        1ehg5jhNhoG/43M5s30qmHbCi7b2adL+CGg2f2mR0vccwx5AaKa2HiSZTNPrUgqR
        VFW4u2QKVYDy8flqFAVmwQZmSG5ISgVVhh5hwm+CUDd6FZkwrIthgs2PsCjkKcny
        mCYMkLp7/dKdF0G1zKLceJuERXOvhWlXR3uh9emDnaJgrI9X26HpOiCfUrKapaPY
        h7d3GSZT42szMk6cje72bcJgvTpW7aWnqE/Z2mox13CxHfpSvVed0rX80BCm3qSO
        bMbWPtnFsMRMhhdxGAdofTYrJ5716llg0FPHy8TsttYdvcDt34Fw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gKMPNwmNvht4 for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:16 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsm0sq5z1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:16 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 10/21] ata: ahci_xgene: add compile test support
Date:   Tue,  4 Jan 2022 18:04:57 +0900
Message-Id: <20220104090508.1592589-11-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable PHY_XGENE.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 9def63c7e9ad..1be6a14e46e1 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -273,7 +273,7 @@ config AHCI_TEGRA
=20
 config AHCI_XGENE
 	tristate "APM X-Gene 6.0Gbps AHCI SATA host controller support"
-	depends on PHY_XGENE
+	depends on PHY_XGENE || COMPILE_TEST
 	select SATA_HOST
 	help
 	 This option enables support for APM X-Gene SoC SATA host controller.
--=20
2.31.1

