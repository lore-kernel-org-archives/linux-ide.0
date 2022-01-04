Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC725C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiADJFM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:12 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:37268 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229886AbiADJFL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:11 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsg1vJmz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287111; x=1643879112; bh=oIlYaVkPxQUjn4NCN0
        AwZIo2HUS6Qq4HYCWHJkcny9A=; b=sagexWIEjJFHb/xvRffj3pqqtYQJKrVziK
        0KuFx0EYpq0M/E7jlWALPVPtfuFWxZsEFhhqP4JdrZja+lpJQAsKEQNUhkdATAUF
        nrQ+HdofF9MFeL8NwlKcPq54Z9AKBJCkauBAaAvsUj9eW+vtrztGc/fZOYelcQzq
        1d7VmZpmbnXrjBSj05zW4elOXot78V56y6v6Z14SmV7RJCejHLqiSWW7lgpDOeLI
        FyhZAaRuTBIY+DcopeuWXOiHve06S46NbT0a3Jkek1Sj6YLG/mr9IdjdCo4nzmrR
        fBmmqT3yahFN6/mdEcNIMwJcIaDxeq69Nx/+K3YmiKUF5ct2nPWw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oP-2ND74YtBq for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:11 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsf463lz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:10 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 01/21] ata: sata_fsl: add compile test support
Date:   Tue,  4 Jan 2022 18:04:48 +0900
Message-Id: <20220104090508.1592589-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add dependendy on COMPILE_TEST to allow compile tests with configs that
do not enable FSL_SOC.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 9ebaa3c288dd..80bad7cba631 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -290,7 +290,7 @@ config AHCI_QORIQ
=20
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
-	depends on FSL_SOC
+	depends on FSL_SOC || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for Freescale 3.0Gbps SATA controller.
--=20
2.31.1

