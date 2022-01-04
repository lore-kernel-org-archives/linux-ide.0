Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33576C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiADK65 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:57 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:30358 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230395AbiADK6z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:55 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNt0kQQz1VSkb
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293933; x=1643885934; bh=8/kv1OugAQEiCUrV7v
        GDCkqAWYWKLJ8UATMZudhn7yw=; b=o7FF89f/PNWK5OMkUwZngMN4jtuif/Re+B
        xsh+ZkoMDjnproKrOPy17BbAZNjQZr6FLb0q5rpZ2NRxC+7HTCcKBi1zMSI/Gvje
        UmQRjvNN9Wc1rfPPtve9JNdpdZIwOJzio8bKxouC9zyXileWvCfm3hzvLpVJ84zV
        Fv3HZw0nH70vQ0JZmYs1xL9XeRbcI3ecCjV1KcNpMgFLztqkATN/WNTEKCzhdQId
        qEjfs7x/526LI5+F+FXtpZGsTEfYqTXR7oQMK7NiA7SNLOjqqvRELcgqDjTZbLas
        h0S1XK9gSm0YJwsWxIxDabTOo+wrPZ+kJlIPInF1uD0HfoVQTRag==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EA2VMOZxeLyB for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:53 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNs3SSVz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:53 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 13/22] ata: pata_cs5535: add compile test support
Date:   Tue,  4 Jan 2022 19:58:34 +0900
Message-Id: <20220104105843.1730172-14-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not have X86_32 enabled.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index b706a3a64b11..daf57a4e8196 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -654,7 +654,7 @@ config PATA_CS5530
=20
 config PATA_CS5535
 	tristate "CS5535 PATA support (Experimental)"
-	depends on PCI && X86_32
+	depends on PCI && (X86_32 || COMPILE_TEST)
 	help
 	  This option enables support for the NatSemi/AMD CS5535
 	  companion chip used with the Geode processor family.
--=20
2.31.1

