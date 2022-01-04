Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8280C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiADJFU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:20 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:31546 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229921AbiADJFS (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:18 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsp4NFxz1VSkZ
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:18 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287118; x=1643879119; bh=8/kv1OugAQEiCUrV7v
        GDCkqAWYWKLJ8UATMZudhn7yw=; b=nCcqeJUcEVCJrz8D+k6xRS/TDzRYNZhc2Q
        ODisruEPX/hWMCX3BOL+cECMBca9o7GxzFJpRMQm1JXtBlrXte8w7D0qg02hh0g9
        USBe/7nfU06gJbMByJR9fE5Ra5pf3XXtT0/PVoczJf0NKsUNpMi9bdNjU8vRfi5m
        epfLtah4ZudapNZafXvHdxVmmXOreRcfBybauHCMbxcK+mXWCj0dOw+HX/S/sLsP
        kfWuxYzovirpKOhl3ElvMD6s5tyM4kgvp/jPVCHa/ElgoNqcXqimUpR7kQF/dk6c
        M6bHwa85mOeMnnMmiN18OVBvEmmIRhpOEimz8O9/hMnnOq/4VXWw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PWl8Rqxz7av5 for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:18 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsn74tGz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:17 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 13/21] ata: pata_cs5535: add compile test support
Date:   Tue,  4 Jan 2022 18:05:00 +0900
Message-Id: <20220104090508.1592589-14-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not have X86_32 enabled.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index b706a3a64b11..daf57a4e8196 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -654,7 +654,7 @@ config PATA_CS5530
=20
 config PATA_CS5535
 	tristate "CS5535 PATA support (Experimental)"
-	depends on PCI && X86_32
+	depends on PCI && (X86_32 || COMPILE_TEST)
 	help
 	  This option enables support for the NatSemi/AMD CS5535
 	  companion chip used with the Geode processor family.
--=20
2.31.1

