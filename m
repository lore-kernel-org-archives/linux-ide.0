Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C569C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbiAEFRq (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:46 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:16984 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236210AbiAEFRp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:45 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmn1W0bz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359864; x=1643951865; bh=FJAb2Uo7KyE4FG1mAi
        np17hYCgnWfS9qlKBeUzLjgxM=; b=Ex+UwM2jPAysBfqJ/eBrlUKZgX/38jYsiY
        Yezqx6IzJFM+XWwmYK15G8BcXn1uoNC860ZJvf0nV7zJW458AQjtdmLnRlcLcQDC
        XaPFNfkWKWlTd5I+Oxblsto32HYs3eRCZksW8ukF59Nvjx7Qa1xUV6ug/fDKqCQH
        8L5GtsgJe0yTJgi8FbVyNiTs6eGQt2x8AfwMSdaEjtamYfcdPv624czH1Hhv7sI/
        x4fYSs/pUN+mbWyxnPEU+RjIuu0a/fN4Gya3KKYy6nSxcUCjFSlf0dgpfLFCVz30
        pX//BhHaZDC621co9s860kEwT8RkH05ICkRrUTC2qFx/4/D1SXYQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EKksKNjqiBZi for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:44 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmm3JcZz1VSkW;
        Tue,  4 Jan 2022 21:17:44 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 07/22] ata: ahci_mvebu: add compile test support
Date:   Wed,  5 Jan 2022 14:17:20 +0900
Message-Id: <20220105051735.1871177-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_MVEBU.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1545201b9104..237124624db4 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -234,7 +234,7 @@ config AHCI_MTK
=20
 config AHCI_MVEBU
 	tristate "Marvell EBU AHCI SATA support"
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the Marvebu EBU SoC's
--=20
2.31.1

