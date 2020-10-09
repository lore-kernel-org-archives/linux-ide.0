Return-Path: <SRS0=vYjz=DQ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598A6C433E7
	for <linux-ide@archiver.kernel.org>; Fri,  9 Oct 2020 08:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F187922269
	for <linux-ide@archiver.kernel.org>; Fri,  9 Oct 2020 08:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602232987;
	bh=1tPbrUnuRvd+9kdjyNxALYwFuoG3rcdxGM7JrBH24vw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Wcji9qXpOpMRGapZkCRU53s3MXDoIsEPBo4nkk+UPnKny9805KotkdFm5IM2sxpND
	 bUlgV6ifl/QyZgLwUnhY4wxrVcEPrC+y3IIH61Au7By4hYsPvqIsJMFqCJ9F/uMsbv
	 c4PWZuuk02yRv7AJHo24+lSnobSjb3ezml1OcWB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbgJIInG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Oct 2020 04:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730726AbgJIInG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 9 Oct 2020 04:43:06 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57AB9215A4;
        Fri,  9 Oct 2020 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602232985;
        bh=1tPbrUnuRvd+9kdjyNxALYwFuoG3rcdxGM7JrBH24vw=;
        h=From:To:Cc:Subject:Date:From;
        b=sqRQ4+LU0aUTLhStZvG9aJ5KvlgKk4mI0nOf+0k9VLoTtX60PIWrdq+HFSyT7rvEi
         c2f5TSVJYyfJcCG8DvJzUIX8Cqtyw5ayKXFTQsGXLDkyLqqD2UN3L0qjB6TtPGsua/
         pxQ16GCsXCV5cJwRuVe9UNKSTbkP0L14qol7q8p8=
Received: by pali.im (Postfix)
        id DE9EA515; Fri,  9 Oct 2020 10:43:02 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Andre Heider <a.heider@gmail.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: ahci: mvebu: Make SATA PHY optional for Armada 3720
Date:   Fri,  9 Oct 2020 10:42:44 +0200
Message-Id: <20201009084244.29156-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Older ATF does not provide SMC call for SATA phy power on functionality and
therefore initialization of ahci_mvebu is failing when older version of ATF
is using. In this case phy_power_on() function returns -EOPNOTSUPP.

This patch adds a new hflag AHCI_HFLAG_IGN_NOTSUPP_POWER_ON which cause
that ahci_platform_enable_phys() would ignore -EOPNOTSUPP errors from
phy_power_on() call.

It fixes initialization of ahci_mvebu on Espressobin boards where is older
Marvell's Arm Trusted Firmware without SMC call for SATA phy power.

This is regression introduced in commit 8e18c8e58da64 ("arm64: dts: marvell:
armada-3720-espressobin: declare SATA PHY property") where SATA phy was
defined and therefore ahci_platform_enable_phys() on Espressobin started
failing.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Fixes: 8e18c8e58da64 ("arm64: dts: marvell: armada-3720-espressobin: declare SATA PHY property")
Cc: <stable@vger.kernel.org> # 5.1+: ea17a0f153af: phy: marvell: comphy: Convert internal SMCC firmware return codes to errno
---
 drivers/ata/ahci.h             | 2 ++
 drivers/ata/ahci_mvebu.c       | 2 +-
 drivers/ata/libahci_platform.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index d991dd46e89c..98b8baa47dc5 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -240,6 +240,8 @@ enum {
 							as default lpm_policy */
 	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
 							suspend/resume */
+	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 27), /* ignore -EOPNOTSUPP
+							from phy_power_on() */
 
 	/* ap->flags bits */
 
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index d4bba3ace45d..3ad46d26d9d5 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -227,7 +227,7 @@ static const struct ahci_mvebu_plat_data ahci_mvebu_armada_380_plat_data = {
 
 static const struct ahci_mvebu_plat_data ahci_mvebu_armada_3700_plat_data = {
 	.plat_config = ahci_mvebu_armada_3700_config,
-	.flags = AHCI_HFLAG_SUSPEND_PHYS,
+	.flags = AHCI_HFLAG_SUSPEND_PHYS | AHCI_HFLAG_IGN_NOTSUPP_POWER_ON,
 };
 
 static const struct of_device_id ahci_mvebu_of_match[] = {
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 86261deeb4c5..de638dafce21 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -59,7 +59,7 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 		}
 
 		rc = phy_power_on(hpriv->phys[i]);
-		if (rc) {
+		if (rc && !(rc == -EOPNOTSUPP && (hpriv->flags & AHCI_HFLAG_IGN_NOTSUPP_POWER_ON))) {
 			phy_exit(hpriv->phys[i]);
 			goto disable_phys;
 		}
-- 
2.20.1

