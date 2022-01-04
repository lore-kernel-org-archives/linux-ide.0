Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03723C43217
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiADJFS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:18 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:41437 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229911AbiADJFP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:15 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsk6grPz1VSkZ
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287114; x=1643879115; bh=dAOK5AjayvnEjQDsxw
        7XvhvyvHcVM/A79B9+QGObfRU=; b=B9r2jgcNn/3oqxuotHa2WAMWqA+CHqWQV3
        j7U7JpwKZ4q8kybFblXETeD8ctQks/QttFaYBifrMKBR0cW+ced4DoA1zqj5S35r
        cUgMQhPR1Dy5cep81TVK3iq7EHyjWN5Yq4eP5d1NQ/F+cshLbD6IyWpyszLGESGV
        UghPahJJwaoQ+2fCyuz7meUTDu1EXi5FUbI2w24WKBYhin3cXtpmWa674U+Zvm4h
        Em8IgnVqbHSkSsAjYI2vm6SNZZ+ZXWHy4ekY4bhDsWlE+ITM6aHiyjvx547EcbEG
        8joY3Re5HKct9/dz7x+QyLnmTEREn/CJ7rLuAyBVc4iO2vYnzrCA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9PIG9G60b3s9 for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:14 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsk274Cz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:14 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 07/21] ata: ahci_mvebu: add compile test support
Date:   Tue,  4 Jan 2022 18:04:54 +0900
Message-Id: <20220104090508.1592589-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_MVEBU.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

