From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH RFC 2/2] ahci: remove AHCI_HFLAG_NO_FBS setting
Date: Wed, 18 Jun 2014 12:54:09 +0800
Message-ID: <1403067249-8021-3-git-send-email-zhangfei.gao@linaro.org>
References: <xuwei5@hisilicon.com, kefeng.wang@linaro.org,>
 <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49402 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616AbaFREy0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2014 00:54:26 -0400
Received: by mail-pb0-f42.google.com with SMTP id ma3so326009pbc.1
        for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2014 21:54:25 -0700 (PDT)
In-Reply-To: <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com, arnd@arndb.de, mark.rutland@arm.com
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

AHCI_HFLAG can be set directly in dts.

For example
ahci:sata@f9900000 {
	no-fbs;
	no-ncq;
};

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/ata/ahci_platform.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index ebe505c17763..d6dedaa94280 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -57,9 +57,6 @@ static int ahci_probe(struct platform_device *pdev)
 			goto disable_resources;
 	}
 
-	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
-		hflags |= AHCI_HFLAG_NO_FBS;
-
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
 				     hflags, 0, 0);
 	if (rc)
-- 
1.7.9.5

