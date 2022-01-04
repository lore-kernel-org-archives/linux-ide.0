Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD66C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiADK6u (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:50 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:23700 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230399AbiADK6u (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:50 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNn5NjRz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:49 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293929; x=1643885930; bh=792lI505cgjNMJYrLW
        2nFljLMhwS/PjP+AOIOF3ebN0=; b=WHkRCZ3xhVZrzsAh1aKjkjk2Bi2wKyVdKi
        MzjsHfNmtmWOrob6YqwNgl/B25zpdFVOq8RC6i6arvzXImCT209zfndzSH3iTLFC
        L0JiurlgwCXTFLV/JXTfu1eVnIbMolVtMF8CrX2ufyk3phwzrzMI8MjEMIPvYVsX
        ReVnri2DVkvmmTF4u+nso0nOnIz1XZUUVcvonfcat4UiIQlKu0tEQLDUcTM2xGsx
        AXNuxRgl7nqv+ajgtwbR16v4D2rWaBOpi+C9a7fqfGXxxJdiVVAbjU8dPOO9a+89
        JUzI3gm0tNUk05BHmGKhX0u3HokNACSPXdKUKe6+OTCZ2tbGLJbg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pAAYZoQnPNJw for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:49 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNn10Z1z1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:49 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 06/22] ata: ahci_mtk: add compile test support
Date:   Tue,  4 Jan 2022 19:58:27 +0900
Message-Id: <20220104105843.1730172-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_MEDIATEK.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 83fac101744c..1545201b9104 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -223,7 +223,7 @@ config AHCI_CEVA
=20
 config AHCI_MTK
 	tristate "MediaTek AHCI SATA support"
-	depends on ARCH_MEDIATEK
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select MFD_SYSCON
 	select SATA_HOST
 	help
--=20
2.31.1

