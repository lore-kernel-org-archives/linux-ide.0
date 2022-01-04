Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863BC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiADK66 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:58 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:61966 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230427AbiADK65 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:57 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNv6xfTz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293935; x=1643885936; bh=TdNadDRWZWO0UR/NUk
        DS73txm02UaRoH6IpNbWDmrVw=; b=O6YMRszZy0mdiR6Cn6mrUBj3h5Thx69wZm
        pv6zJGdhB/1cDs3VF3F3OAk9Q/mm5Hl1AwVAT5Ar2jcz2sdz8IVbqVpZ7Z5IZZMy
        lOqXU3jGd+3kaZ6qIUtt+s8U0FTFHtmXLRIKw3wKBkETiHfuc9shghqK/g9Z+Z8r
        Gswr5kxWKCzyyi5bhxqtHRpB5ne0NBTv/V6EjojqQVY+ATkhivNNVRU3RgM80iXB
        k/HzhFn0OugfdvyTBk6zkB6EXI6E6CoOiSDWjUduJO5Iy7rpl+L7MTx8PIxhJF3N
        6Peua5bUQdlf2qqF3E81Qd9vNyvpGuLirZANTuTbCweEP6Yg0p0A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3Iez2VLTIrFW for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:55 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNv2FPvz1VSkd
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:55 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 16/22] ata: pata_pxa: add compile test support
Date:   Tue,  4 Jan 2022 19:58:37 +0900
Message-Id: <20220104105843.1730172-17-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_PXA.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e4e4460cb1fe..59576f92c730 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -986,7 +986,7 @@ config PATA_VIA
=20
 config PATA_PXA
 	tristate "PXA DMA-capable PATA support"
-	depends on ARCH_PXA
+	depends on ARCH_PXA || COMPILE_TEST
 	help
 	  This option enables support for harddrive attached to PXA CPU's bus.
=20
--=20
2.31.1

