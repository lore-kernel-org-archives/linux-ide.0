Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3855EC433F5
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiAEFRp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:45 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:6056 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237430AbiAEFRo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:44 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmm3NHnz1VSkZ
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:44 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359864; x=1643951865; bh=JI1IBD/flDYpvKcFG6
        nyTcUQJpORmfPPFVNhujm+BPY=; b=YE9QzUsn3dftPWqga810I96bloQ+e0LnoN
        uzW6wY/iUi/f0Ag3X9jow7tvGdpN8Q6Rh4G66X54hI5MSKZl6VYt4j98D4zXZpkw
        VuSv/M86Fz+Ba+C8GfJJ0KtRPSW3WU/5lPOxj93lHdaY14y77+oxwGOCC5kT5lC/
        E/BpDSiYgZz/BKAK92ZsM9SnW8JaJmI4LczyHEhwbkfsoKuPS01FmlAy5uFXdNsU
        bdfWcTn9z6L0XXZfUsx6WACExcIngIQu/RADvbgP6OIIWt+54gorrMTrCB2dNf8K
        NgMq9KRQdTBOHmJ8camp964iGfSoz8XgcT139EAkTjWfXuppW0xg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ORWo-0WS3bmd for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:44 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHml5GBNz1VSkX;
        Tue,  4 Jan 2022 21:17:43 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 06/22] ata: ahci_mtk: add compile test support
Date:   Wed,  5 Jan 2022 14:17:19 +0900
Message-Id: <20220105051735.1871177-7-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_MEDIATEK.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

