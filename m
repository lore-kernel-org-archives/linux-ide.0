Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8E3C4332F
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbiAEFRt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:49 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:25356 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237430AbiAEFRs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:48 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmr1ZX6z1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359867; x=1643951868; bh=Kaezhe0fixmdn2qCJ0
        sjPgP6IAhCQnPJywqGW7NKMhU=; b=Htqd0oKKGRqk/g1lSMypG5mIwfgkP8Qda/
        zn++4iMCRfRyOBaCd67vwtZDNXGFzUIr32FyuHLRzyVvoVaGOj9zlCJuoiomFCx/
        q1gMl8UPNQDeH5i49qo39YLRvKkYfpWxPaTr6eOdXyWc7zjXaY1kH77kQDxFx/ZR
        hbCm4PBtJQ358lv99ISWSI4jrjKio/BunKYphnNW9TxsKxpwiVEuCdkJSUmIdP0m
        Bn4fAMQyBFqwLaPKfBrjaoFq8EV3AViD0XyIohQENPPt+EuXLSjGx4ZXDLo4GSCs
        b9T5mQArImECpkeBVCNmHYxv5IOw8ENnUlSoTjBIdWsCkghaTR9g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rp9tlDD3T_8Y for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:47 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmq2z4Tz1VSkY;
        Tue,  4 Jan 2022 21:17:47 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 11/22] ata: ahci_seattle: add compile test support
Date:   Wed,  5 Jan 2022 14:17:24 +0900
Message-Id: <20220105051735.1871177-12-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_SEATTLE.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1be6a14e46e1..8df5b32e6879 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -311,7 +311,7 @@ config SATA_GEMINI
=20
 config SATA_AHCI_SEATTLE
 	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
-	depends on ARCH_SEATTLE
+	depends on ARCH_SEATTLE || COMPILE_TEST
 	select SATA_HOST
 	help
 	 This option enables support for AMD Seattle SATA host controller.
--=20
2.31.1

