Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7E8C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiADJFS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:18 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:38110 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229910AbiADJFO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:14 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsk2H4gz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287114; x=1643879115; bh=792lI505cgjNMJYrLW
        2nFljLMhwS/PjP+AOIOF3ebN0=; b=g1BL8BumWHavWrJcsfru9Mv6NJiyhagzRz
        vWvpHvIGcYyHVPiwSkk1QA4VkcHIt0qANrzbSJwsbdQowKsYgRn4cKvOIvqYM6t2
        E6lo+NDymvJPEvlt3sXfRoqvsZfFb4U/ZUkdTZ207IZ+odsp3GK0HmEvVZATMDlm
        7FlJNM2WLbBFEWgpzSU+jTfyNVwaadSFq96CUuYTWEJAZJyrUZs882w9eKlhHCz+
        hJrkqWBZcSfMexS+aYfZiVFjS77/DRo68Vqk53fdFw5CRWLuxvP9ZUVA2d182ujB
        1feGPqY61EVu/LmiMpJCEE3DeSseYl00HwaQAB4XVT9G+ycIcJQg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VB5N3Tlr5-CQ for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:14 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsj4hZKz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:13 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 06/21] ata: ahci_mtk: add compile test support
Date:   Tue,  4 Jan 2022 18:04:53 +0900
Message-Id: <20220104090508.1592589-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
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

