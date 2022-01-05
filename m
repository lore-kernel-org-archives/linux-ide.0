Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AA0C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiAEFRl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:41 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:18250 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236210AbiAEFRk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:40 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmh506cz1VSkZ
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359860; x=1643951861; bh=wpq/apHOU8t6CjuncZ
        sDFA2p/MmDtFnsJTOdsodbkgU=; b=BrAcnvkvr4cq/Mq+//uzxPOXJDc2tBPgZH
        GKjGCxiayxnEkfQMqdGLFCdkTPO5kr0RePSORgyiGRraBgpl234lcQ9ICJjnntjy
        3UNBQ4JEJiaWV2LpQvh+Fb+8IXJyzWaH5MBGvz5T6/ixV/wtd3BM9R9h8G5I1ntS
        JeJcaWeQypz5d+Wrcy35N27x7xM9RAi+55wb1SLyTKiWHscNuB/9uOyMeHS80eYY
        Qj/n99sCtO0Kc6tF/eve333OmSTSGPl4270Asx1BBedPjPXlgRQfXYcv3MBGSie9
        nttXzAhnhnU0lhab/G466hX9po1+K0rGVjSNR6oIleHXTN7vxHfg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ie-dIg-jV3nc for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:40 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmg6nNMz1VSkW;
        Tue,  4 Jan 2022 21:17:39 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 01/22] ata: sata_fsl: add compile test support
Date:   Wed,  5 Jan 2022 14:17:14 +0900
Message-Id: <20220105051735.1871177-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add dependendy on COMPILE_TEST to allow compile tests with configs that
do not enable FSL_SOC.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 9ebaa3c288dd..80bad7cba631 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -290,7 +290,7 @@ config AHCI_QORIQ
=20
 config SATA_FSL
 	tristate "Freescale 3.0Gbps SATA support"
-	depends on FSL_SOC
+	depends on FSL_SOC || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for Freescale 3.0Gbps SATA controller.
--=20
2.31.1

