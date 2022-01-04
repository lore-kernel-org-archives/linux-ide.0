Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BFEC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiADK6w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:52 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:10944 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230399AbiADK6v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:51 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNq4RpGz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293931; x=1643885932; bh=SCvkBYdKfuGT2m+IA4
        iyaRLSez8GFuNXeAdrXDqLwwM=; b=IJkI/6vL0DX6DRqKT79gfWtvCOAubpeWj0
        NQ8sbXa2R4NxMek0n/t98EfXLiwz4igRaTvLE7/bSR6eeCzrqgPZCjJ+UArffkdR
        YmPGWz4GmNpmOOIpMOOTjSj63WBOWg6P1rMljc7BeSjq56zCgLnFUi185cXkdETU
        kfGFoEUpD7+YMNh8Ff9dM4mam3RDQZDuJsCiylh4+V7y/C7KfTPRF65YY4Q5HhKO
        pJdFdWYH+9sj+LQQEEXVhRkiZ2zQ1rVS+mfJgJGV0ejsOPPDnWtoQEfGDqa8BZyY
        miuYRoPzq4YXWvCrKnuuvazCaPp48ez/xXRriqAD6IusUliyw7PA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w2aKYW-lkgrN for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:51 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNq06k0z1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:50 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 09/22] ata: ahci_tegra: add compile test support
Date:   Tue,  4 Jan 2022 19:58:30 +0900
Message-Id: <20220104105843.1730172-10-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_TEGRA.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index db3f65ae1ed5..9def63c7e9ad 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -263,7 +263,7 @@ config AHCI_SUNXI
=20
 config AHCI_TEGRA
 	tristate "NVIDIA Tegra AHCI SATA support"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the NVIDIA Tegra SoC's
--=20
2.31.1

