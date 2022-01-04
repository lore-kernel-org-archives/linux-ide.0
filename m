Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCB1C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiADJFU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:20 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:47174 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229917AbiADJFT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:19 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsq1TRwz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287118; x=1643879119; bh=nRJ4bJ8Op3GncU+S7p
        4VpliHyoYOo0rARw/PVhc9Mtk=; b=j7B775CO4cm4acG6AzVHRjeIY3LlFXJILM
        YtvZHfSBUF6YZeMbv+eiSLezid0z41xgu8JdmZDOtDXvtChif7ppyEj2+bU765mX
        0GiJQ96invIJv9srb/BuSymf8wBTa9GIYgOXf11T5rhTmJTYgHZFil+bYmux2jju
        yit6TH8H2nmrmD22LbmkhmRgvwuAVdVJVYHZhVDhNQOlgusZjiu5HJgmk9qd52+H
        FB9fO2DwOVY1MBLvwJgL7sa1euiO5Wt+PxY7h0NMbhm26DXu/bWpkqsJ9WuzBIUx
        LRh/jUhUqz6sDixOz+alOt2zoKEnAq10jQvxG70EwUOCnmI7t/5w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y-R9E9B2Idqo for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:18 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsp4FSDz1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:18 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 14/21] ata: pata_ftide010: add compile test support
Date:   Tue,  4 Jan 2022 18:05:01 +0900
Message-Id: <20220104090508.1592589-15-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
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

