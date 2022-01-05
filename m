Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE6C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237429AbiAEFRo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:44 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:18406 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236210AbiAEFRn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:43 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHml5N7kz1VSkZ
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359863; x=1643951864; bh=JjEz6pZchQKgp6XFvg
        B4RGqJBXcm7P9Kh2qiKBoZNDE=; b=t3WFWieK1XDEg32jlMaC4703JdHLHYbVj4
        d16pOVsn8/MI0P7pYdhSbjzWnQ7paes5LGYkIb6l+b9dkn3CvjDLQO1bdkXL8XIn
        I7FVAeMtxggrRAslojnTp4v5VnNv3MnZGJS9xYWHKbDvzJkLukznfx2MC2iE8Zn7
        f/7AnxxFuRz6kryy61QbhhdtcHsW5BbQXRNChcCoSITQsywDyXEvHzNrhZ7yMC27
        hod+S86C53xre/S53WR6m7MEKbjnrBYw6yn1hHqDzU9QjR/Uun9pXQJjIZKfd/Gp
        YIPqPgG0JMyIN13895zx6C0R+B6gbQkRsNQoqLRodSTA9UMIKydw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UdioVD_5n24e for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:43 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmk6pTyz1VSkb;
        Tue,  4 Jan 2022 21:17:42 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 05/22] ata: ahci_st: add compile test support
Date:   Wed,  5 Jan 2022 14:17:18 +0900
Message-Id: <20220105051735.1871177-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_STI.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e9f919f17d09..83fac101744c 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -193,7 +193,7 @@ config AHCI_DM816
=20
 config AHCI_ST
 	tristate "ST AHCI SATA support"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for ST AHCI SATA controller.
--=20
2.31.1

