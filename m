Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B011DC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbiAEFRu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:50 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:12353 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237436AbiAEFRu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:50 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHms5cY7z1VSkZ
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:49 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359869; x=1643951870; bh=vvXnmQjAnWRpaLmJ6l
        yqv6JBVLmj2aI7pfq/lp3loZk=; b=Dx5ByF/FyRGxI7BLQ1OQi3Uads/1TokOrN
        rhq29FPgdKHKPL6iL7ltb1k5iIEFj81hBqz+P8UZlXsJNLusF2afR8+1Gu92ZL7c
        Qc8aczL11HShHCE6Xefv/CSlqszsNjhganQbyIa83f9+o30xXYh4rrK6NFkjtXnw
        yEVjuKwm/vzh7FkQGYPtkNCuPr5bX5/olk/jQaCJae56SksMwbJmS5WqM2b8v/vi
        AEwxQ7gfH1VPve4+LnX3mU1H2yR+qitSW5XSArzMIMok+LQ5WcdDNYILJyvBoAY8
        E8EWwg05of0TC2Xv30sM7edFA24VvIoPyBSU5h0HYZtrYWPfxvQg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TiFHbKhRwNjS for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:49 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHms04Dyz1VSkW;
        Tue,  4 Jan 2022 21:17:48 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 13/22] ata: pata_cs5535: add compile test support
Date:   Wed,  5 Jan 2022 14:17:26 +0900
Message-Id: <20220105051735.1871177-14-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not have X86_32 enabled.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

