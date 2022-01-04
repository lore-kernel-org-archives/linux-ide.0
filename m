Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BF9C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiADJF3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:29 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:52747 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229945AbiADJFV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:21 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmss4Mm6z1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:21 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287121; x=1643879122; bh=fnXKGNmAu/ePo+VMNr
        6X/hZ/aPnlP5tuu2LIvpaBymo=; b=rSV7gPPo1Yly03hBbv8qHz2I03RubcIdHX
        RGh3IdOM4+ErAa2n5r4f9xvNSzYu1oJiPnH3Pk9GJjQWb7ZYKvtKkIb7+tIoenQz
        1s15ty9VL5lwRAxHMRgDyDjiEYUQn0rOLTxmLkqhWNHn9c4fBsQFzDMj8zR8IQBp
        22w2kbFppneCskryKrL+Z2EB/nQHeM5xEWdPDTMMx8FCeKnK/sZ4oQ8uiB2ze4aZ
        R+hyq8CavFXK9NQp6nsvQ/DN7dLlR/qOuhSZeTKi5PEztuzdLEzA8hyVfDhkNyY6
        J+GTPpnPAQBuaiUekrlIjDiYMjNA3JJRHc9xp+O3ffgE7T7npwtw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2Bgk5Ui1XlgJ for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:21 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsr6zk6z1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:20 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 18/21] ata: pata_samsung_cf: add compile test support
Date:   Tue,  4 Jan 2022 18:05:05 +0900
Message-Id: <20220104090508.1592589-19-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable SAMSUNG_DEV_IDE.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 490f0856a271..8af5659a7676 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1162,7 +1162,7 @@ config PATA_RZ1000
=20
 config PATA_SAMSUNG_CF
 	tristate "Samsung SoC PATA support"
-	depends on SAMSUNG_DEV_IDE
+	depends on SAMSUNG_DEV_IDE || COMPILE_TEST
 	select PATA_TIMINGS
 	help
 	  This option enables basic support for Samsung's S3C/S5P board
--=20
2.31.1

