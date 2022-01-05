Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D796C43217
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiAEFRt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:49 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:10715 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237436AbiAEFRt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:49 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHms09lMz1VSkY
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:49 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359868; x=1643951869; bh=QePm0qMtQiSXXJHsne
        Mi2jUEAKCeHKT4V7XdGHeURmQ=; b=ippho2M0rysF3F1DzuRew/iwFkj06tzUWa
        okGLbZK74IX+COvVBU5b3mQ/akEPpWfZdeB0AC900CDBYbtHb/rhFRIBDuHYgaXy
        TR8tqqK7eBOFVcCbmL+UbR+F/AiCVjcBzHfzgGZE+y1T9oDhTzBLNw3o6hGIXz+H
        /U+vS/MI3WZ7josSRKCIELElWecuEoFKyzz3LBt2dggCvbyHLUb5wZcHuQs7N3r3
        p7Zp6e5tu8P8ITekXyeD5CaQ7lp1L8vw+BvDBDmpNl2x2CD1UluHvlkILcAWxrOb
        hUB32znVXsYAFJVzGTiyeDE6ROIDsXwLiW+iFpGcn1DhmSxSFFJg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6ik35oc5IfXn for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:48 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmr1kHjz1VSkZ;
        Tue,  4 Jan 2022 21:17:48 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 12/22] ata: pata_bk3710: add compile test support
Date:   Wed,  5 Jan 2022 14:17:25 +0900
Message-Id: <20220105051735.1871177-13-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_DAVINCI.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 8df5b32e6879..b706a3a64b11 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -616,7 +616,7 @@ config PATA_ATP867X
=20
 config PATA_BK3710
 	tristate "Palmchip BK3710 PATA support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || COMPILE_TEST
 	select PATA_TIMINGS
 	help
 	  This option enables support for the integrated IDE controller on
--=20
2.31.1

