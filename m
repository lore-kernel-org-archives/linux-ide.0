Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0712C43217
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiADK6v (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:58:51 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:13826 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230399AbiADK6v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:51 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNq0G79z1VSkW
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293930; x=1643885931; bh=F+1TZiCHXmN7exk/qR
        /ALfealxxOO04LLZqYfZU/6Rg=; b=p9r/8zurixDQsxcRFhehFgkn07BThJUeyR
        5bmwuMskT+tgx/vQmuMd83OTxLgoTk7Cad0U9ZtKZ+Cc1US3zdnC3Wq0AaaZtBaY
        IKWV9jBPpeRZP18drkJvmFjt6guc06vXXM+Rlq6ouh1uwD+puhfGxdtOWSV2p++7
        JkICDE5Cp4W91yo+lE/Qn/M6MWceU3jYAXlA29BrnibCK05NAwM/918YBwHrgynZ
        pbibSCLGQTBD3cqZh0wtqnq5k6a5wqOXLjpC6BVv/JRSFsal2cwc41089sIcMfPd
        wTC7+HYgD5HlcKsECJB4Za/OfcDhq6tOx260q+iNDu55EMMFIAcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9zwOR5QdWm5R for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:50 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNp2ZJtz1VSjC
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:50 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 08/22] ata: ahci_sunxi: add compile test support
Date:   Tue,  4 Jan 2022 19:58:29 +0900
Message-Id: <20220104105843.1730172-9-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_SUNXI.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 237124624db4..db3f65ae1ed5 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -253,7 +253,7 @@ config AHCI_OCTEON
=20
 config AHCI_SUNXI
 	tristate "Allwinner sunxi AHCI SATA support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the Allwinner sunxi SoC's
--=20
2.31.1

