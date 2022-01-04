Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A7DC43219
	for <linux-ide@archiver.kernel.org>; Tue,  4 Jan 2022 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiADJFT (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 4 Jan 2022 04:05:19 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:44540 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229903AbiADJFR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 4 Jan 2022 04:05:17 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JSmsn2hnzz1VSkV
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641287117; x=1643879118; bh=q9BWiVvZt3MIOYJ2V8
        /iUiTqcAk0PBCTR0I0ldil8n0=; b=bfVFECK/Ai0t3YwDDtRYrvOFHC3XJKDcFH
        yQtrqJp5ApK15YpUaGEcGqCtCOIfM5k06Mm/GxSgzb6mZdOq9polQvKGyO9Y+ZW0
        RoUCWjRRXZSWIPNy1JCztAqy0XuzJtVKDc8HJJDZ3NppYpdv6bRtUfbmhmocDZOO
        UWks2ljarp+zhhdqxeBUysdiKYNX8AFozjtmj3aEHlWNrreQHs6exO43JcJDCGFF
        5Uw35GaC/jvTn27zDRnNaJSyyCpzlPBG4l6k6e+MJARsa0ZOPUgiGUjf8Ab/SNkq
        tuEXx9HHSl8cWCOxILuhNv/ruVEpRyYrfY75bOg0U/rxzXgvaBcg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wPHwaE8zBeHn for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 01:05:17 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JSmsm5J5gz1VSkd
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 01:05:16 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 11/21] ata: ahci_seattle: add compile test support
Date:   Tue,  4 Jan 2022 18:04:58 +0900
Message-Id: <20220104090508.1592589-12-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
References: <20220104090508.1592589-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_SEATTLE.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 1be6a14e46e1..8df5b32e6879 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -311,7 +311,7 @@ config SATA_GEMINI
=20
 config SATA_AHCI_SEATTLE
 	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
-	depends on ARCH_SEATTLE
+	depends on ARCH_SEATTLE || COMPILE_TEST
 	select SATA_HOST
 	help
 	 This option enables support for AMD Seattle SATA host controller.
--=20
2.31.1

