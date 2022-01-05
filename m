Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601B7C433FE
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbiAEFR6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:58 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:5096 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237440AbiAEFRw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:52 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmw5S57z1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359872; x=1643951873; bh=uX8gW9KER/6N8q11Or
        jMiG+STHeJDQHKYbjeq5pWaAw=; b=OWIaY4eypCWVoB1DQ+GC+BL9GZmvI9bH10
        rPvcr/neFhOWsXWRZu2CXTgF/l7LYnMIC8ELUZYxW8I3uNRv4zPP9HXFV9sODSKp
        2xuZwhsgt6DYduQiS6VM3QOzLwYu9V0uwkui9UG9rE9gM7tmXU5dvnZxi6ItdXZn
        OhBOIaAFoz4paqze1oZgz/SF1FoWCaSLFHtJp0j/Sw5C6qpPa78nkyIleMVp8VAZ
        7TzCLtu0lfNASGMJwzsLuMb5ODJQmrW8cenv3CVcPRv/Zc02sjvRCYSE9aIHunqL
        CLg2yL+p/xWbncpLaPbRPkIdLNJE2JX+AGynQlSaF9JS0vL3F9TA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z4hPSRGOGpiD for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:52 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmw0P81z1VSkb;
        Tue,  4 Jan 2022 21:17:51 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 17/22] ata: pata_legacy: add compile test support
Date:   Wed,  5 Jan 2022 14:17:30 +0900
Message-Id: <20220105051735.1871177-18-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ISA.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 59576f92c730..490f0856a271 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -1137,7 +1137,7 @@ config PATA_OF_PLATFORM
=20
 config PATA_QDI
 	tristate "QDI VLB PATA support"
-	depends on ISA
+	depends on ISA || COMPILE_TEST
 	select PATA_LEGACY
 	help
 	  Support for QDI 6500 and 6580 PATA controllers on VESA local bus.
@@ -1172,7 +1172,7 @@ config PATA_SAMSUNG_CF
=20
 config PATA_WINBOND_VLB
 	tristate "Winbond W83759A VLB PATA support (Experimental)"
-	depends on ISA
+	depends on ISA || COMPILE_TEST
 	select PATA_LEGACY
 	help
 	  Support for the Winbond W83759A controller on Vesa Local Bus
--=20
2.31.1

