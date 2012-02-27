From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH Resend] ata/pata_arasan_cf: Add Hibernation support
Date: Mon, 27 Feb 2012 11:15:05 +0530
Message-ID: <e15cd253cc3e5dae10b8e986219206ec7047ff7e.1330321341.git.viresh.kumar@st.com>
References: <788f006c530a7577380d75a60ba9ab23e8d975c9.1329989550.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:59127 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753728Ab2B0Fpd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Feb 2012 00:45:33 -0500
In-Reply-To: <788f006c530a7577380d75a60ba9ab23e8d975c9.1329989550.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com, bhavna.yadav@st.com, vincenzo.frascino@st.com, mirko.gardi@st.com, salvatore.dedominicis@st.com

This patch adds in Hibernation related callbacks. Also we don't really need to
free DMA channel on suspend.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
Changes in Resend:
 - Moved arasan_cf_pm_ops outside of #ifdef, #endif

 drivers/ata/pata_arasan_cf.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index 048589f..3239517 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -925,11 +925,10 @@ static int arasan_cf_suspend(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct arasan_cf_dev *acdev = host->ports[0]->private_data;
 
-	if (acdev->dma_chan) {
+	if (acdev->dma_chan)
 		acdev->dma_chan->device->device_control(acdev->dma_chan,
 				DMA_TERMINATE_ALL, 0);
-		dma_release_channel(acdev->dma_chan);
-	}
+
 	cf_exit(acdev);
 	return ata_host_suspend(host, PMSG_SUSPEND);
 }
@@ -944,22 +943,17 @@ static int arasan_cf_resume(struct device *dev)
 
 	return 0;
 }
-
-static const struct dev_pm_ops arasan_cf_pm_ops = {
-	.suspend	= arasan_cf_suspend,
-	.resume		= arasan_cf_resume,
-};
 #endif
 
+static SIMPLE_DEV_PM_OPS(arasan_cf_pm_ops, arasan_cf_suspend, arasan_cf_resume);
+
 static struct platform_driver arasan_cf_driver = {
 	.probe		= arasan_cf_probe,
 	.remove		= __devexit_p(arasan_cf_remove),
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
-#ifdef CONFIG_PM
-		.pm		= &arasan_cf_pm_ops,
-#endif
+		.pm	= &arasan_cf_pm_ops,
 	},
 };
 
-- 
1.7.8.110.g4cb5d

