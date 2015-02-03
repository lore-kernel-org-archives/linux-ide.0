From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] sata_mv: More error handling for phy_power_off() in mv_platform_remove()
Date: Tue, 03 Feb 2015 09:36:01 +0100
Message-ID: <54D08871.6030304@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net> <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.so
 urceforge.net> <54D08732.4050601@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:64320 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbbBCIgT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Feb 2015 03:36:19 -0500
In-Reply-To: <54D08732.4050601@users.sourceforge.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 2 Feb 2015 23:30:34 +0100

The return value from the phy_power_off() function was not used by the
mv_platform_remove() function.

Let us improve error detection and eventually return a corresponding
failure code.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/ata/sata_mv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index f8c33e3..4f9bc33 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4203,7 +4203,7 @@ static int mv_platform_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 	struct mv_host_priv *hpriv = host->private_data;
-	int port;
+	int port, rc;
 	ata_host_detach(host);
 
 	if (!IS_ERR(hpriv->clk)) {
@@ -4215,7 +4215,9 @@ static int mv_platform_remove(struct platform_device *pdev)
 			clk_disable_unprepare(hpriv->port_clks[port]);
 			clk_put(hpriv->port_clks[port]);
 		}
-		phy_power_off(hpriv->port_phys[port]);
+		rc = phy_power_off(hpriv->port_phys[port]);
+		if (rc)
+			return rc;
 	}
 	return 0;
 }
-- 
2.2.2

