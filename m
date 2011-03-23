From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 4/4] davinci: da850 evm: register SATA device
Date: Wed, 23 Mar 2011 17:02:29 +0530
Message-ID: <1300879949-16379-4-git-send-email-nsekhar@ti.com>
References: <1300879949-16379-1-git-send-email-nsekhar@ti.com>
 <1300879949-16379-2-git-send-email-nsekhar@ti.com>
 <1300879949-16379-3-git-send-email-nsekhar@ti.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33695 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932487Ab1CWLco (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Mar 2011 07:32:44 -0400
In-Reply-To: <1300879949-16379-3-git-send-email-nsekhar@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: Kevin Hilman <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, linux-ide@vger.kernel.org

Register the platform device for SATA interface
present on the DA850/OMAP-L138/AM18x EVM.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Cc: linux-ide@vger.kernel.org
---
 arch/arm/mach-davinci/board-da850-evm.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..3d2c0d7 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1117,6 +1117,8 @@ static __init int da850_evm_init_cpufreq(void)
 static __init int da850_evm_init_cpufreq(void) { return 0; }
 #endif
 
+#define DA850EVM_SATA_REFCLKPN_RATE	(100 * 1000 * 1000)
+
 static __init void da850_evm_init(void)
 {
 	int ret;
@@ -1237,6 +1239,11 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warning("da850_evm_init: spi 1 registration failed: %d\n",
 				ret);
+
+	ret = da850_register_sata(DA850EVM_SATA_REFCLKPN_RATE);
+	if (ret)
+		pr_warning("da850_evm_init: sata registration failed: %d\n",
+				ret);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
1.7.3.2

