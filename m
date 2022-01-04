Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76B4C43219
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 10:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiADK7B (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 05:59:01 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:23489 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231768AbiADK65 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 05:58:57 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSqNw45t6z1VSkd
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:56 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641293936; x=1643885937; bh=fAXPgWQpkquWuoIUky
        T8B4i5/laBgCWhX7Dl3oxQ82s=; b=uEPglfh/9Vfgqh5DWpD1Lk/87eFd9alM6Q
        76PT5+nQPB7XyxS6bEB24DAm2G4HORHfz5+J54O/MDFRUT+upOgpVO8yDchEKMIb
        5/NZyC3AcIXOiK/EZnPOgUlxTaTGhyB0M+N0tYyPH0XswDryCs6EkpR1vImThgjI
        xk/GK9bwnF056qx2OMwBbEcSIzn+wMLj1sinvu+thULnuUnGSR8AFI4lQpKVJ7l4
        o/a8nxpPtlQWdM9fzvBXzeWwU+sxrrjFETMWmoR7ZuIjbzLKKSIdiCmwviBuWnnM
        XdZgcbiciqKsvPl1SYg4YxO1pDnS64Y+cKS7YOaIaUG4wU+l++Ow==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i3KvOJuKARHs for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 02:58:56 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSqNv70bbz1VSkc
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 02:58:55 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH v2 17/22] ata: pata_legacy: add compile test support
Date:   Tue,  4 Jan 2022 19:58:38 +0900
Message-Id: <20220104105843.1730172-18-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
References: <20220104105843.1730172-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ISA.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

