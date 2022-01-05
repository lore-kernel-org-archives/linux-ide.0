Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE87C43219
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiAEFR7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:59 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:6042 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237441AbiAEFRx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:53 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmx3wz8z1VSkd
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:53 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359873; x=1643951874; bh=GAbFtbPK/nfY7kZOkp
        MiUbAcWrDLUclmHpgq1LgTyz4=; b=b8pKMRi6QqMVfwwN+qLhTK2ORWDgkDYb/A
        xKu0do9DUXsadR9yyTHov3KJgzumi6SG8I4KB9J+15ZHLX5e5XTt7Aj0qHsRFqXw
        vQML5h/4jhdA9cu8HI6qcUQWwXeJCWC6CWVwxkzeCMhx2uRIe7yhjVQBtk2TNqDD
        mWg4vXLYdJ2RPkvixRCLPIJ+6THvcZPRtZoxm/plQLV5Xb93BcKyHXhSdGUlwsdk
        CnNIrNacwTNqrL3VXVanqOgOp18uZg9Ck3ycKZ1YFxAIgxmql2NlMcGSJ63hsms0
        PiCtUSBgwnKAWOppZtuwFOOQxl/KR8Cgxp40iU0/UwxEttwF0zdA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xKgPM__LBRMs for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:53 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmw5TJ5z1VSkZ;
        Tue,  4 Jan 2022 21:17:52 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 18/22] ata: pata_samsung_cf: add compile test support
Date:   Wed,  5 Jan 2022 14:17:31 +0900
Message-Id: <20220105051735.1871177-19-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable SAMSUNG_DEV_IDE.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

