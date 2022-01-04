Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B20C433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiADJFR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:17 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:22055 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229906AbiADJFO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:14 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsj4ksfz1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287113; x=1643879114; bh=/GvDKtxdX9VjvMBma/
        QiNEIrA2bIi22q0A2ridi6MXU=; b=kgKQkGrP1YRJYJx0efbROo2fijBn97j/Id
        OtGdWZhCR5ufhNfz/RigGFk2fQ5CxMAU130i4vnLFbMfmrKAwhkjD4Nkgx/GWnVU
        n8OSDYW3MyhN0E4zlYeDf+EuaPfOIxXYthWfXnGdNL8nNwGkiK0C0SH2go2VpJ+J
        1ugzsoJVUk7RxhuZapYg8wxtCWZPIpTiP/xPmh6yhaxvizmA1S6+wVy0VsjQoe6k
        wRi36WGcSmPGV83Sbo+8NDkB0Mx6qL5fCf+nuAj2IVNGMQBt3fHqlii4v64Gxscy
        Mx8p7txpQowkxKg0FY0ly5ZzDq7T0HAmOLQSzpC20V4LiD7nao4Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wYpkgcel5CFM for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:13 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsj0PJxz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:12 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 05/21] ata: ahci_st: add compile test support
Date:   Tue,  4 Jan 2022 18:04:52 +0900
Message-Id: <20220104090508.1592589-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_STI.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

