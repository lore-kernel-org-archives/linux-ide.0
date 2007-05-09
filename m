From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH] drivers/ata/pata_scc.c: compile error fix
Date: Wed, 09 May 2007 15:14:00 +0900
Message-ID: <200705090612.l496CGpU010558@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imx9.toshiba.co.jp ([202.33.96.51]:63513 "EHLO
	imx9.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934941AbXEIGlE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2007 02:41:04 -0400
Received: from imx12.toshiba.co.jp (imx12 [61.202.160.132])
	by imx9.toshiba.co.jp  with ESMTP id l496GLl1018115
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 9 May 2007 15:16:21 +0900 (JST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l496CJLt024365
	for <linux-ide@vger.kernel.org>; Wed, 9 May 2007 15:12:19 +0900 (JST)
Received: (from root@localhost)
	by wall11.toshiba.co.jp  id l496CJ3p024562
	for linux-ide@vger.kernel.org; Wed, 9 May 2007 15:12:19 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l496CHPk011260
	for <linux-ide@vger.kernel.org>; Wed, 9 May 2007 15:12:18 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp

The previous change (ata_probe_ent -> ata_host) was incomplete
and generated compile error. This patch fix it.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -purN -X linux-powerpc-git/Documentation/dontdiff linux-powerpc-git/drivers/ata/pata_scc.c linux-powerpc-git_mod/drivers/ata/pata_scc.c
--- linux-powerpc-git/drivers/ata/pata_scc.c	2007-05-08 09:41:52.000000000 +0900
+++ linux-powerpc-git_mod/drivers/ata/pata_scc.c	2007-05-09 14:13:15.000000000 +0900
@@ -1142,14 +1142,14 @@ static int scc_init_one (struct pci_dev 
 	static int printed_version;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	const struct ata_port_info *ppi[] = { &scc_port_info[board_idx], NULL };
-	struct device *dev = &pdev->dev;
+	struct ata_host *host;
 	int rc;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev,
 			   "version " DRV_VERSION "\n");
 
-	host = ata_port_alloc_pinfo(&pdev->dev, ppi, 1);
+	host = ata_host_alloc_pinfo(&pdev->dev, ppi, 1);
 	if (!host)
 		return -ENOMEM;
 
