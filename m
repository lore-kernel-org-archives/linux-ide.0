Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ACAC433FE
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbiAEFRs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:48 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:50712 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237434AbiAEFRr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:47 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmq39ygz1VSkc
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359867; x=1643951868; bh=GqdkJVhJuAG8Kx6iB6
        6ShBb94M43gcmqE8y5KJH7ohI=; b=iJ2kdeP6kCzsge/pvi3tWqKtJ7AWC+rMeI
        BtSLd4NU9rrNb+pk5kyE638TqQpHoCeKsCeFoYx+zjEFXzEwRXsFmg/WyAnc3YJS
        +i9tp3jacCUdZ5t0usdyiKtJHH/Ed+XkbcazfN20D9mtO61wB5yBA3frlWhN5I73
        yaCsQR98VaMe+eI6EtbB9UOzqdvZjKtlRmvoUWXRqcmFXp0mwE/X49gu1TCe62R0
        qQDE8aKPPqA5p6yzldE0ttR10kbp4aQD4Q3Z/5e1/cQUpU9qpDOQkXmcwWdLQxTj
        BCpB7j3IJpmv+hHTKvX3OPZ8IP5gI7Wh0t0gycW/uCYueivJZ+NA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KCjAf43Pdqm0 for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:47 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmp4phDz1VSkZ;
        Tue,  4 Jan 2022 21:17:46 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 10/22] ata: ahci_xgene: add compile test support
Date:   Wed,  5 Jan 2022 14:17:23 +0900
Message-Id: <20220105051735.1871177-11-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable PHY_XGENE.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

