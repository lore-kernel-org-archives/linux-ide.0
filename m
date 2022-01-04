Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0028BC4332F
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiADJFN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:13 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:31846 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229899AbiADJFM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:12 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsh3npSz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287112; x=1643879113; bh=3hYZDjs/rqX6vqy59X
        Xgi5huuytYCAxggqNYj8+rm3g=; b=QCt97kG5iZp8r/WKEwnGM/yRzFQn8Emh4y
        BD9cwySgmks32gWrLoy1diQPA2laWkKTybnM0kpXccfhibRvW9+LSxUD0weAxrtY
        yN4kbKkUb0t9ojQXPngjHbLfukuOr5lirX4ZjtJ3Lf8uChvLqJ7ezqgnretPMyta
        XdfF/uvqgGYnBFo/70Eblj1Z/sk65umaZ+BW/dBc6X4XiCCRnVVuub/DVKEq1jJL
        iQL0iwkq8W+oKw50UdXVjHas1dz5qPQx6laYrVIkO29R+/Reo7hKMhfBHUAiiusC
        AuQwmuHuaOb+8ijLTAEzgHDYCXknDqbdggxcl3LIGYhDYgXsuDvw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s9NwhY6PX5Qb for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:12 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsg60k3z1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:11 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 03/21] ata: ahci_da850: add compile test support
Date:   Tue,  4 Jan 2022 18:04:50 +0900
Message-Id: <20220104090508.1592589-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_DAVINCI_DA850.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 3bf38a328851..9f1288fd5482 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -173,7 +173,7 @@ config AHCI_BRCM
=20
 config AHCI_DA850
 	tristate "DaVinci DA850 AHCI SATA support"
-	depends on ARCH_DAVINCI_DA850
+	depends on ARCH_DAVINCI_DA850 || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the DaVinci DA850 SoC's
--=20
2.31.1

