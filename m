Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AEEC433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 04:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiADE5w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 3 Jan 2022 23:57:52 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:41304 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230188AbiADE5v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2022 23:57:51 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSgNH59Lsz1VSkW
        for <linux-ide@vger.kernel.org>; Mon,  3 Jan 2022 20:57:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1641272270;
         x=1643864271; bh=WfjTSRltEFuogKzS4MZSkPECgRD6er0P4NtA1ezfXYA=; b=
        MWZk6iooSoH5RTe3CNNYSWSYUyjtx8DDNwrAdliFcWbMz96jG2YSUVh9vUjvGbn2
        jrSsiKz8JlH7DyqgXn4RqTgwkTTKX6pWUky6Fo5LbrLG3PdnEBwZtAUXgsnl3OKQ
        BJwuxNctVPFFqSuW4jNOm9nEuFpIa5GlU5qb25fcsNiFlojVloZE6TdmXJJGVcxl
        v/C73FntDY/jLOitJJWSpBi/6ECQ0cmy+2GOdSKdhQZm6QGAmR4pKIPto5s+2jO+
        ZlTcTvv55eCzu79ZmkJ4C1+nEoXcoTgh2FGoQ1YdD+kqsmto3u/qVywOROKj11hl
        9T++POUXLJfLjQsMYOB1EQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BU76EdJuy9fa for <linux-ide@vger.kernel.org>;
        Mon,  3 Jan 2022 20:57:50 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSgNG1sKxz1VSjC;
        Mon,  3 Jan 2022 20:57:50 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] ata: sata_fsl: add compile test support
Date:   Tue,  4 Jan 2022 13:57:48 +0900
Message-Id: <20220104045748.1171439-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
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
index f6e943c74001..af6bf1b8902a 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -273,7 +273,7 @@ config AHCI_QORIQ
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

