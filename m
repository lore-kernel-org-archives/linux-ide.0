From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ahci: imx: Fix imx_ahci_resume()
Date: Mon, 26 May 2014 16:29:37 -0300
Message-ID: <1401132577-24999-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bl2lp0205.outbound.protection.outlook.com ([207.46.163.205]:52794
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751524AbaEZTqW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 May 2014 15:46:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: shawn.guo@freescale.com, linux-ide@vger.kernel.org, festevam@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>

The following warning is seen after suspend/resume sequence:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 661 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
Modules linked in:
CPU: 0 PID: 661 Comm: sh Tainted: G        W     3.15.0-rc5-next-20140521-000027
Backtrace:
[<80011c90>] (dump_backtrace) from [<80011e2c>] (show_stack+0x18/0x1c)
 r6:803a22f4 r5:00000000 r4:00000000 r3:00000000
[<80011e14>] (show_stack) from [<80661e60>] (dump_stack+0x88/0xa4)
[<80661dd8>] (dump_stack) from [<80028fdc>] (warn_slowpath_common+0x70/0x94)
 r5:00000009 r4:00000000
[<80028f6c>] (warn_slowpath_common) from [<80029024>] (warn_slowpath_null+0x24/)
 r8:808f68c4 r7:00000000 r6:00000000 r5:00000000 r4:e0810004
[<80029000>] (warn_slowpath_null) from [<803a22f4>] (ahci_enable_ahci+0x74/0x80)
[<803a2280>] (ahci_enable_ahci) from [<803a2324>] (ahci_reset_controller+0x24/0)
 r8:ddcd9410 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:e0810000 r3:ddf35e90
[<803a2300>] (ahci_reset_controller) from [<803a2c68>] (ahci_platform_resume_ho)
 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:ddcd9410
[<803a2c30>] (ahci_platform_resume_host) from [<803a38f0>] (imx_ahci_resume+0x2)
 r5:00000000 r4:ddcd9410
[<803a38c4>] (imx_ahci_resume) from [<803511ac>] (platform_pm_resume+0x34/0x54)
....

Add the missing ahci_platform_resume_host() call in order to fix the resume
of the driver.

Tested on imx6q-sabresd and imx53-qsb boards.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/ata/ahci_imx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 8befeb6..1941896 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -468,11 +468,25 @@ static int imx_ahci_resume(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int ret;
 
-	ret = imx_sata_enable(hpriv);
+	ret = ahci_platform_enable_resources(hpriv);
 	if (ret)
 		return ret;
 
-	return ahci_platform_resume_host(dev);
+	ret = imx_sata_enable(hpriv);
+	if (ret)
+		goto disable_resources;
+
+	ret = ahci_platform_resume_host(dev);
+	if (ret)
+		goto disable_sata;
+
+	return 0;
+
+disable_sata:
+	imx_sata_disable(hpriv);
+disable_resources:
+	ahci_platform_disable_resources(hpriv);
+	return ret;
 }
 #endif
 
-- 
1.8.3.2

