Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E06C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiADJFT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:19 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:21049 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229916AbiADJFS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:18 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsp0R89z1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287117; x=1643879118; bh=cqjQ/u/nAi1nsP7hMv
        ygIYhj+8OlOjgqEMjhLOKOa54=; b=hfrELPLxj807I5flO28MohftHNBOOG5Plo
        ca7QtpACt3uk1tBSHNrK42N9YhO6hxbXkxp4JDUsPza9MFxQk9t/t0FNRMWpViFh
        O1MsyY8uLQEMmN1NRuvZD8vGvgoxNBLNlZUdLx6qqts3SW7A0XwLwoxgZ50VKoOm
        rV2QLCufi5hUpa0HTACRvOYpuO4bkYsjCURx/jVL9aYMi7x42YPPcL0toWtaDizx
        WrEpM2nAyOrlneC1ATrX5My22QkXZ4KKRNvmdu7NWCM5cGl4zfapRSnrteC29Hrt
        ys5fyg3b95or/fCE5oP/fQYLsCyWTD9qKoMvmLZiCJkzYPD7NTeQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dEbeZgZeEBz8 for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:17 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsn2lhFz1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:17 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 12/21] ata: pata_bk3710: add compile test support
Date:   Tue,  4 Jan 2022 18:04:59 +0900
Message-Id: <20220104090508.1592589-13-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_DAVINCI.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 8df5b32e6879..b706a3a64b11 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -616,7 +616,7 @@ config PATA_ATP867X
=20
 config PATA_BK3710
 	tristate "Palmchip BK3710 PATA support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || COMPILE_TEST
 	select PATA_TIMINGS
 	help
 	  This option enables support for the integrated IDE controller on
--=20
2.31.1

