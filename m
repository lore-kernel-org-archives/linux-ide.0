Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62269C433EF
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiAEFR5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:57 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:8637 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237439AbiAEFRw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:52 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmw07C6z1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359871; x=1643951872; bh=yUhtYSxghBQyNb1rjp
        /UmEXI5ReoP8/BxAOG/bjErWA=; b=Lvm4OMUKeiaH5saKDEEITaBxhoQlWrVudK
        XEefMzsjWDm7cuvL1mJ1zuJIeO41BEjbPldvvpJswMjgjYrGfdJsYaG9ckSHl+bC
        y9s4J/Ej2ISLQCj+HisIMNlYp+o/l0X1NOcE6y72nXpH3wui3/gkdQ/qkM+LqOds
        q8Fezq6ZIzLfHwPt4ZurEnOQlHGMfZr26d6DOuMYOdhHuz1ztADGW52I5mhDMDPb
        17EwEyt7lf/gfctaGsDdalU03cLTFs6SaJ7tdRmQ4pOHaQ0xR5OqB0Rju4icfL+A
        QgPb66bFNKBIVLYuwyoWPVIZxBMmtZqqpNtCIXUWktkrUQwz+y0g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1Mna4DlUpBa6 for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:51 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmv1yGQz1VSkV;
        Tue,  4 Jan 2022 21:17:51 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 16/22] ata: pata_pxa: add compile test support
Date:   Wed,  5 Jan 2022 14:17:29 +0900
Message-Id: <20220105051735.1871177-17-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_PXA.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

