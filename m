Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5644CC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiADJFV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:21 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:13821 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229933AbiADJFU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:20 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsr31FPz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287120; x=1643879121; bh=TdNadDRWZWO0UR/NUk
        DS73txm02UaRoH6IpNbWDmrVw=; b=iJiT5qvotrWzLckYaDySQ+tWyuDbIjBXD4
        gm95cOzIkv+oYAG1TRd7v1ZXZFqUxwXhspoNXUQs1xMIITYWeS/VO+d18cdyWTu7
        qUwY9TBd378eYqNsmEUk+6I/IKQzzKKVbyjxkT/cjw8g3jUAnCuMtmpzcf+DDcLD
        Q9XLrgu0eCJWYRsZj4Wef3SINPs7vN2tXwmJ9iwhFJr41NYNjXefaYApme8lZE5b
        qv1z8AgNG39X4+Kfow/myEjaeqdEgJyhaRosrpKHmtrEPlEQG6S6Rg77p5OSo1Ha
        2IQWDeyBvvlCVWxYwUEhqK4ZMQUW68l1M8jPQNb35FrP4RsAuH4w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A4fcBFo0_UuS for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:20 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsq5p24z1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:19 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 16/21] ata: pata_pxa: add compile test support
Date:   Tue,  4 Jan 2022 18:05:03 +0900
Message-Id: <20220104090508.1592589-17-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_PXA.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e4e4460cb1fe..59576f92c730 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -986,7 +986,7 @@ config PATA_VIA
=20
 config PATA_PXA
 	tristate "PXA DMA-capable PATA support"
-	depends on ARCH_PXA
+	depends on ARCH_PXA || COMPILE_TEST
 	help
 	  This option enables support for harddrive attached to PXA CPU's bus.
=20
--=20
2.31.1

