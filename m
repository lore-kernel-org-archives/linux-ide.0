Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE34FC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbiAEFRn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:43 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:54548 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237424AbiAEFRn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:43 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmk46nPz1VSkX
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359861; x=1643951862; bh=aS4iYYUIF147k6DBdn
        N3ScC2ihDfSZm4snsrzufKepY=; b=UH6CMSV8M5zjaHuqJNp+PW6wItVIM3+1HM
        jVivP34IOV8U7msdN3/XRoZxWebIK77qm3iZAJOs+wJL4WtDzUfQC8NJwvHTn1/E
        If7i8A4gn0MkuQr0UxNm9Y6ZQW+BRZGt1Ka2VHC0kt07mj/LyLHFXsGR3l0EQuTM
        ICZqCshhhVBmdqBzp4u4jXVfGmvuFJtubg/YI+8b4aPXZRhIdn5BohYMxMY2RvuV
        NnQR90dsyKwJ26KS3V0zJiuiNlFB6mRgySIJVLtsBVk9LkJ5h8qYr9szps7ENIzs
        Kiv2rLYw9n9hLszL3TXAk7YecbMlyEGVj2alrrnPVw73oSpJ212w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QJHZSBx-4YaG for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:41 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmj3Mj6z1VSkb;
        Tue,  4 Jan 2022 21:17:41 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 03/22] ata: ahci_da850: add compile test support
Date:   Wed,  5 Jan 2022 14:17:16 +0900
Message-Id: <20220105051735.1871177-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_DAVINCI_DA850.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 3bf38a328851..9f1288fd5482 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -173,7 +173,7 @@ config AHCI_BRCM
=20
 config AHCI_DA850
 	tristate "DaVinci DA850 AHCI SATA support"
-	depends on ARCH_DAVINCI_DA850
+	depends on ARCH_DAVINCI_DA850 || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the DaVinci DA850 SoC's
--=20
2.31.1

