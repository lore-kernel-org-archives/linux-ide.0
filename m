Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C50C43217
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiADK66 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:58 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:12300 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230408AbiADK6z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:55 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNt50VVz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293934; x=1643885935; bh=nRJ4bJ8Op3GncU+S7p
        4VpliHyoYOo0rARw/PVhc9Mtk=; b=paE3fjw5Cdv3i3qXdLvweBFkKmxLxjIM+d
        k/F1vf59lWxDdBVmRSAsE+6Ai0I5/joLTqKBHr015UTSlTFOMxz9nivrelVYtYMD
        D1/QijMCQ7Wd+cFbbde8tZQx2LHnH2SrF7ak7VMrHfQ0BuIAOC5Itfx9tm4p5yDe
        BDgXL+FsRCcSdt9mfll18ukOMO/WitBp3nXY4TXjmNaqf2nAvRLdTKdwjt+A+OLr
        hRvI5j/nxKx1INwpkDo0xgXpmAwIMX6Yw8Rete4O09O3ksEIprNk7LykXgD/jyFc
        v98//KQ96La4A+WfXzIBzAtm0rjS8r6MYcA+1Av76fi5Lol4gvXg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UOtacS9UB-cL for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:54 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNt0h20z1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:53 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 14/22] ata: pata_ftide010: add compile test support
Date:   Tue,  4 Jan 2022 19:58:35 +0900
Message-Id: <20220104105843.1730172-15-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARM.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index daf57a4e8196..1b18de61e8df 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -702,7 +702,7 @@ config PATA_EP93XX
 config PATA_FTIDE010
 	tristate "Faraday Technology FTIDE010 PATA support"
 	depends on OF
-	depends on ARM
+	depends on ARM || COMPILE_TEST
 	depends on SATA_GEMINI
 	help
 	  This option enables support for the Faraday FTIDE010
--=20
2.31.1

