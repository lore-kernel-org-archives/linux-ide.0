Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000D0C43219
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiADK66 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:58 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:61339 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230412AbiADK65 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:57 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNv2FVdz1VSkf
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293935; x=1643885936; bh=TJjSjqk2jqeCRQBA08
        y636HzB4bhESj8V304CjrWi90=; b=AGqJCx1UXNEUOSBTfgTbClQxM00ZqBfBSw
        B8rhCjRFekhnkOTdzcQ7nzQ9kYTiB7vbkeM2PYbq8IznCcvAu21dPrg+UsLVTjPD
        l2sGYku197cU+0xZCw5iLqfjS3MiucgjU09jdZ9VVlmYWUmuCOtF8zL2yrV27CQp
        +MVk5cFIQdPZp/tGAy41AzOpllm9NUGDbGlyzOzdn81rikvSDemzNpWhzhia/duZ
        Ll5Qq1VgjR0ZZSVgZsO8Ot3X0+wktxv87dEcXn5nqVCQ1oo9Hq2WO8tEi+mj5L1j
        xRWYSKEW8mOBWMBtOShFG3wF8+ogWddGmp2iS/I+jcMadGHRs9wA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9_LW0ZU6XuaT for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:55 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNt4ywzz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:54 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 15/22] ata: pata_imx: add compile test support
Date:   Tue,  4 Jan 2022 19:58:36 +0900
Message-Id: <20220104105843.1730172-16-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_MXC.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1b18de61e8df..e4e4460cb1fe 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -765,7 +765,7 @@ config PATA_ICSIDE
=20
 config PATA_IMX
 	tristate "PATA support for Freescale iMX"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select PATA_TIMINGS
 	help
 	  This option enables support for the PATA host available on Freescale
--=20
2.31.1

