Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E1FC433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiADJFV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:21 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:31073 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229903AbiADJFU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:20 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsq5xQyz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287119; x=1643879120; bh=TJjSjqk2jqeCRQBA08
        y636HzB4bhESj8V304CjrWi90=; b=K4Vk4eaJcFEgCt/TsrB7aUWJhFx8cPlAi+
        DiU9t1eo3g9CTE1w+J1kNOUwaBK/4Tfkj3iEeHaonheawNEUfPO3lBD3Ta644Eq8
        bRdqXHpwrDmXEphyEDHpBacd5S396wr/j6DaGSOPuDpIUhx06lOw8lOdsvdQ3BSs
        VEoiGasqZx8YcT5kvg45dq9sxG33dIbBY5D+HV8ePM8vLv9SRjgvk1MZM4iD+0Pc
        hhuzt9MhOICBUMF6lE162VYFFjvn35NpgkdTnLAXhW/7JzGqsV7MGDSIue8GgmP0
        wKoQhH3jl8oJUP8OnYSIeJXlP+FU3WQg5UAataATs0qWivjmWQqQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id I8a6xdZYBDTR for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:19 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsq1Tzmz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:19 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 15/21] ata: pata_imx: add compile test support
Date:   Tue,  4 Jan 2022 18:05:02 +0900
Message-Id: <20220104090508.1592589-16-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
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

