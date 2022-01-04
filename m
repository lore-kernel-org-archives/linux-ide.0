Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA4C433FE
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiADK7A (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:59:00 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:57557 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231774AbiADK65 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:57 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNx17pqz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293936; x=1643885937; bh=fnXKGNmAu/ePo+VMNr
        6X/hZ/aPnlP5tuu2LIvpaBymo=; b=ciRHDM/Gi8+1jMJqxpTGVHswpjGFH74kI0
        BIhWqlJNCUkEUoKz4KyHQzSN5A35+fjzviPy3NxT6kWRfL97M4tbLVZYx/zub6Mt
        GIyqpMzE2El10cSmmY+yCi+V2kAUEjTiOB8kFf4lhXxmWzWa35MNMyjC6LQWDpZV
        D2aDfr+EUhY5MBxg7U4h0maHt0+74O/QIwFyiXC8Yz7GO1InvzpRg/mzJdEAaOSg
        DqnLgQtjW5lozJaP1sZz+cFKXc8/99CohGNsFa5n665GNr9dcadeIqIgF73vWDYL
        gx4h7pBKMj/efX6pX2hQdMKp3s8lOQeyFKe20j9UsugvXDUgXF7w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2_z0Qz5dOSnG for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:56 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNw3vhjz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:56 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 18/22] ata: pata_samsung_cf: add compile test support
Date:   Tue,  4 Jan 2022 19:58:39 +0900
Message-Id: <20220104105843.1730172-19-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
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

