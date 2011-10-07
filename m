From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] sata_mv: release clock on ata_host_activate() failure
Date: Fri, 7 Oct 2011 19:22:33 +0400
Message-ID: <201110071922.33410.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:55925 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752781Ab1JGPai (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2011 11:30:38 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

mv_platfrom_probe() forgets to call clk_disable() and clk_put() iff
ata_host_activate() fails...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---

 drivers/ata/sata_mv.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/sata_mv.c
===================================================================
--- linux-2.6.orig/drivers/ata/sata_mv.c
+++ linux-2.6/drivers/ata/sata_mv.c
@@ -4087,8 +4087,11 @@ static int mv_platform_probe(struct plat
 	dev_info(&pdev->dev, "slots %u ports %d\n",
 		 (unsigned)MV_MAX_Q_DEPTH, host->n_ports);
 
-	return ata_host_activate(host, platform_get_irq(pdev, 0), mv_interrupt,
-				 IRQF_SHARED, &mv6_sht);
+	rc = ata_host_activate(host, platform_get_irq(pdev, 0), mv_interrupt,
+			       IRQF_SHARED, &mv6_sht);
+	if (!rc)
+		return 0;
+
 err:
 #if defined(CONFIG_HAVE_CLK)
 	if (!IS_ERR(hpriv->clk)) {
