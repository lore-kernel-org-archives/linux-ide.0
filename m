Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42942C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiADJFR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:17 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:36000 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229916AbiADJFP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:15 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsl3gt1z1VSkb
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:15 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287115; x=1643879116; bh=F+1TZiCHXmN7exk/qR
        /ALfealxxOO04LLZqYfZU/6Rg=; b=Wl/3/v4G/JOCY22Q+sZwmIn89adg8ouwTj
        n6N1iWBRicEbluWOBuWcFf4IdT6pU57fcQR4ZB5AjycftFS7lyBLwQcDcB6y7+gI
        dI9aSRzad1Od64ILPM+bGf3gXEFjXof+XzBsOZY4WY3Pnhp24k15OmN6Im6MCA4U
        kycIW/k0kyTJFcSJPTTMC7wVpliufs5awY7NtjFSaJKV4oDAdPU4vfCqYX1vkkvY
        +fBIsT0SLaNUGKahdWorB2QCERgUWDOTl8MyY9H++WvHZJP/RUoGkUdh/4BkwJOF
        TqPeCTKBo3au4NNTz44w7nhKDoYl7ymu455yYL1fonhBPg6FHO+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JXC83hXlrfao for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:15 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsk6Pmbz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:14 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 08/21] ata: ahci_sunxi: add compile test support
Date:   Tue,  4 Jan 2022 18:04:55 +0900
Message-Id: <20220104090508.1592589-9-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_SUNXI.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 237124624db4..db3f65ae1ed5 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -253,7 +253,7 @@ config AHCI_OCTEON
=20
 config AHCI_SUNXI
 	tristate "Allwinner sunxi AHCI SATA support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the Allwinner sunxi SoC's
--=20
2.31.1

