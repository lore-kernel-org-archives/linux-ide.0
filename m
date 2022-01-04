Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87234C4332F
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiADK6v (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:51 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:49552 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231759AbiADK6u (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:50 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNp2crgz1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:50 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293930; x=1643885931; bh=dAOK5AjayvnEjQDsxw
        7XvhvyvHcVM/A79B9+QGObfRU=; b=TTbFNrKpzuZqEYlG6/M/8mkt5QX+GX7vDp
        j5nP/NcWBzYiTMuv+CxDB2VLjxP5jIXnNm0I6ro6ZgJd5l6AA8tjtA3V0SnOopmN
        9VMIvkVtzka+JiF1KH0XJYc2xwNB7uva/j5klcKMCJl/ax6DcyCJLh34qkKeGtkG
        NsVUj9vmYWXFkIwp6zFTqdtXAWGSxGi0rwOfEwlWWK69qoOcS6sFe7Bv5z+3l3kN
        82TOUyq5Ua8QgkpHKeBL8XlmVLQ9qKNtHWWA3RdGs+ApjtR26eSVd4ZwOCUU4oa+
        6NIf9Qcm4serJsRk6WnI/iePgii71SfRfXiw8IvMnRdMVDDX1gIA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6N7NMIwWpI99 for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:50 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNn5Jfvz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:49 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 07/22] ata: ahci_mvebu: add compile test support
Date:   Tue,  4 Jan 2022 19:58:28 +0900
Message-Id: <20220104105843.1730172-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
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

