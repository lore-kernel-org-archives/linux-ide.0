Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4A3C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiAEFRn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:43 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:35232 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236210AbiAEFRn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:43 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmk6r5dz1VSkc
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359862; x=1643951863; bh=+Ray7Qrj5mv1nXuZ27
        o6Ua+uTdh5soOglcOPNzqKg4U=; b=EZeOr7HLHWBKK1hR1vC0B+8ClAbZ/9J/GK
        +yNv4gAnoZ9DN6ibKQF2NWarXPnNvp5Onxb1IJxx77pUzYKYIK8hcgGAzxpgSPnv
        HXpBfKu1NLrwbRGOOtdvRujcDVjKN27sQGmYGP8Img6lBw7nJ5MeykEQo0hKzr6Z
        VsYStMZQ0tu7CU6uZRrln4jgSedXVKYEADpCa0jKD171oJ8Ryy5lCdEBqpnY5Hov
        hooBCb+Hvgsntb2WbosBm/KyqQGLF/bk6YPL3Li62s9AnOvLIImbXq7d+F6POZs5
        YgUnb24f/ycPvciLv7H1y7sl5IpnHxsoG7Lw9KNzoogSETQdplvA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZVN2w6nb6ZW6 for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:42 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmk1RCNz1VSkV;
        Tue,  4 Jan 2022 21:17:42 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 04/22] ata: ahci_dm816: add compile test support
Date:   Wed,  5 Jan 2022 14:17:17 +0900
Message-Id: <20220105051735.1871177-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_OMAP2PLUS.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

