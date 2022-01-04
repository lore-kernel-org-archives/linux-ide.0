Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9562DC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiADJF3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:29 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:47145 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229934AbiADJFV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:21 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmss0209z1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287120; x=1643879121; bh=fAXPgWQpkquWuoIUky
        T8B4i5/laBgCWhX7Dl3oxQ82s=; b=TVLqFFzcfYOdRzL1TWXp6WPyTZTNhsomgj
        yhmuvLxFSx9q+cQAqQXqNT15k8MVXX6ymnNygA0Ny7fyMwyh3FyCbQqVl+C60c5Y
        GZ2DH9YFJA1Qx3ZHopq5O6FM/2dTU40/+m2BM4ZR1c1K9lygy6ZS7go2JhW7b9YV
        I6Oh+9yHW56qK6TA0saZdM0bZPUZFnJPsus9cYdvmozrMsVeR+/UAeEvOjo4r2NB
        qPVtGUncu3bqNfd0w0E05Sq8lwCmGOO5X4XYyDs98To1jRYjRP5/IzQfnlu1vZJ4
        Vjss/PYeIqVERWF+4/3dUT86saYjksDsYhQY/s+sizO3ZMkQhdmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZCpnIFUJWqp2 for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:20 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsr2zCLz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:20 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 17/21] ata: pata_legacy: add compile test support
Date:   Tue,  4 Jan 2022 18:05:04 +0900
Message-Id: <20220104090508.1592589-18-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ISA.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 59576f92c730..490f0856a271 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1137,7 +1137,7 @@ config PATA_OF_PLATFORM
=20
 config PATA_QDI
 	tristate "QDI VLB PATA support"
-	depends on ISA
+	depends on ISA || COMPILE_TEST
 	select PATA_LEGACY
 	help
 	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
@@ -1172,7 +1172,7 @@ config PATA_SAMSUNG_CF
=20
 config PATA_WINBOND_VLB
 	tristate "Winbond W83759A VLB PATA support (Experimental)"
-	depends on ISA
+	depends on ISA || COMPILE_TEST
 	select PATA_LEGACY
 	help
 	  Support for the Winbond W83759A controller on Vesa Local Bus
--=20
2.31.1

