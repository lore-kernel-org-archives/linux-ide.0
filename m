Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9189C43219
	for <linux-ide@archiver.kernel.org>; Wed, 12 Oct 2022 13:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiJLNLQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiJLNLO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2022 09:11:14 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76167AC0D
        for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2022 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665580271; x=1697116271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sqxBUnvzDNUFqNGYaIQPjO4k3Z2Z8faQlIic70/PaPA=;
  b=WEQUnqe2LO/b2rilkJbxSLxkrlTfRICThf/6xLdjS5YB0ypApEyyK+If
   sVKb3QRF1xGKyk0sHSfHINdMvrJw+2joWKLVLkevZ5ELw3cnfYsT1x/D3
   ZJFSrQQRy0JkoZwZoUrMIDtl4hOjsQTsobFQiTyO06pxwZ4IyY/YtoRIJ
   tMP5wj+JfuSg2C/bXPw3VAUW65kYEINwgTJdkUiIZuScf8GVxPXbQHUY6
   lWi2N4AE491unXrErQ+/NWmVu0TYtx71dKKsUrZD9rgWRTx/c5DaUdHXb
   yjMpu6Atw2Lj6rcKNHiDYz5a9kmuToKYC8OalgdFuoHf9gCeUXSPXLcpC
   w==;
X-IronPort-AV: E=Sophos;i="5.95,179,1661810400"; 
   d="scan'208";a="26709681"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Oct 2022 15:11:09 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 12 Oct 2022 15:11:09 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 12 Oct 2022 15:11:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665580269; x=1697116269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sqxBUnvzDNUFqNGYaIQPjO4k3Z2Z8faQlIic70/PaPA=;
  b=T09tdufLaONRHpNrjkVv0x7t1fVbFjpKuJttx2Bu9NZ7/170qkeQlmmd
   oVb3mIdXdx8huc2r3RAl+7jDKOnw6lJ/0I1SVTlNHWJn1X94y6/+digSo
   RTmEMS+Hr1z792UQ+socb+5vzeNnbU4tyFaq+EvAV8pTl6+/ALeq2rr6A
   q/utwptEn+pWfXWe2dLkzN5rOPtLRlJESkLziuGUXHJz8Lwo/maphmc0v
   crIZMZE1ixtZT5XhC5+iHN/Jms3fiH0no6VtxSRQeLFpYiB+3RoXAxwyi
   SmbWmIeQFWY66td4FpMHlIOmAc+PLtMD9aNobbWwHERLbNoj7GU6gcscu
   A==;
X-IronPort-AV: E=Sophos;i="5.95,179,1661810400"; 
   d="scan'208";a="26709680"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Oct 2022 15:11:08 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B0648280056;
        Wed, 12 Oct 2022 15:11:08 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/1] ata: ahci-imx: Fix MODULE_ALIAS
Date:   Wed, 12 Oct 2022 15:11:05 +0200
Message-Id: <20221012131105.725258-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

'ahci:' is an invalid prefix, preventing the module from autoloading.
Fix this by using the 'platform:' prefix and DRV_NAME.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/ata/ahci_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index b734e069034d..632caa301458 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1235,4 +1235,4 @@ module_platform_driver(imx_ahci_driver);
 MODULE_DESCRIPTION("Freescale i.MX AHCI SATA platform driver");
 MODULE_AUTHOR("Richard Zhu <Hong-Xing.Zhu@freescale.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("ahci:imx");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.25.1

