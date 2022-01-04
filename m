Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549FAC433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiADK6u (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:50 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:26843 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230392AbiADK6t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:49 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNn1P9Jz1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:49 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293928; x=1643885929; bh=/GvDKtxdX9VjvMBma/
        QiNEIrA2bIi22q0A2ridi6MXU=; b=oj+vZpR69Ay4ClLX4A82fo65whHVfkKKD7
        ORVG59wIqOXsQG1BFFe57vxcS3qXB4hKM/DNs6qAo08u6thXbadO3jgMy2sHKnhW
        RiwryDrVXbjrChgx4Azdu/AvgLSgcnp4VOM0AbkGKYvUxV5gP/+KbcvJvlRwqR8j
        mhUZZpn9wWqcCikQMpqh4/oC8IogVf7dadTv/x7YZMWvZM+SSl4S3mK8GKUPiL2s
        DMtvhBT5CF1oC4ObkIlm/iMsY6nJoTdDbslsGrFbELo84rNAJB5Rb79Xv3O0dyk/
        32cVwSVFTthHmuTRh32NJi1ND46L1ZigBEVkgDVNiWKjJczM7hPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cHHHZU2XdV8l for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:48 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNm3qBHz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:48 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 05/22] ata: ahci_st: add compile test support
Date:   Tue,  4 Jan 2022 19:58:26 +0900
Message-Id: <20220104105843.1730172-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
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

