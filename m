Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13762C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiAEFRs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:17:48 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:47311 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237433AbiAEFRr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:47 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmp4ssJz1VSkb
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359866; x=1643951867; bh=wC40IP6EGZu6/BELUl
        Di2evnxq+y6KzlmJyWBUKKnBQ=; b=aKtgHctMHup1rusLqtCDefcHm/a7ZDBTkR
        w3Ly4UB2RPqW1t80dxcEc6LWqsS4j4ru2k7DqURPDdwr5ZUCaV/fJWN4s+OtOE18
        FRc7TpFpenCI8hTYV2/F5jsB5sIpxZElY3VeWiCKfCgvebGwmv7wvjTuhLlNVg0C
        yKpGnZgTtG3EQiqM7na8uyS/hqmQy0SnwHA+I1Z9bzZPykWUrVhpLx/MADtiDQ+D
        C3D1rntlYYQ23u+EDYHJ8d/r3W/Sf1AHYEKXbVDTmPt+4CcsOvvYhjaT/S91ZV10
        fP9maE+Wj+G7Nm4Vfco5Zw2WiPVx0lDn2h49ompGTnw76ZrtusmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jf1C9lhfzeFx for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:46 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmn6jJDz1VSkW;
        Tue,  4 Jan 2022 21:17:45 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 09/22] ata: ahci_tegra: add compile test support
Date:   Wed,  5 Jan 2022 14:17:22 +0900
Message-Id: <20220105051735.1871177-10-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add Kconfig dependendy on COMPILE_TEST to allow compile tests with
configs that do not enable ARCH_TEGRA.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index db3f65ae1ed5..9def63c7e9ad 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -263,7 +263,7 @@ config AHCI_SUNXI
=20
 config AHCI_TEGRA
 	tristate "NVIDIA Tegra AHCI SATA support"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	select SATA_HOST
 	help
 	  This option enables support for the NVIDIA Tegra SoC's
--=20
2.31.1

