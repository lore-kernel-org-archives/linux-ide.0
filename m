From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/5] ahci: st: Standardise naming conventions
Date: Wed, 12 Mar 2014 12:39:38 +0000
Message-ID: <1394627982-23726-2-git-send-email-lee.jones@linaro.org>
References: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:49328 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbaCLMkI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2014 08:40:08 -0400
Received: by mail-wi0-f180.google.com with SMTP id hm4so2300893wib.13
        for <linux-ide@vger.kernel.org>; Wed, 12 Mar 2014 05:40:06 -0700 (PDT)
In-Reply-To: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tj@kernel.org
Cc: lee.jones@linaro.org, kernel@stlinux.com, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org

Other devices have adopted similar naming conventions which have been
accepted as the standard. This patch brings any mention of the the ST
AHCI driver into line with them.

Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Kconfig   | 6 +++---
 drivers/ata/ahci_st.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ee7a3dc..ffc5d9d 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -97,12 +97,12 @@ config SATA_AHCI_PLATFORM
 
 	  If unsure, say N.
 
-config SATA_AHCI_ST
-	tristate "ST SATA support"
+config AHCI_ST
+	tristate "ST AHCI SATA support"
 	depends on SATA_AHCI_PLATFORM
 	select GENERIC_PHY
 	help
-	  This option enables support for ST SATA controller.
+	  This option enables support for ST AHCI SATA controller.
 
 	  If unsure, say N.
 
diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 2f95133..f5af660 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -235,5 +235,5 @@ module_platform_driver(st_ahci_driver);
 
 MODULE_AUTHOR("Alexandre Torgue <alexandre.torgue@st.com>");
 MODULE_AUTHOR("Francesco Virlinzi <francesco.virlinzi@st.com>");
-MODULE_DESCRIPTION("STMicroelectronics Sata Ahci driver");
+MODULE_DESCRIPTION("STMicroelectronics SATA AHCI Driver");
 MODULE_LICENSE("GPL v2");
-- 
1.8.3.2

