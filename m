From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] pata_arasan_cf: fix ata_host_activate() failure handling
Date: Mon, 14 Apr 2014 18:01:47 +0200
Message-ID: <1706948.xQXQIMFS2B@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22947 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbaDNQB5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 12:01:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, linux-ide@vger.kernel.org, spear-devel@list.st.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Add missing cf_exit() and clk_put() calls to ata_host_activate()
failure path.

Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- re-order code and then drop redundant goto statement

 drivers/ata/pata_arasan_cf.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_arasan_cf.c
===================================================================
--- a/drivers/ata/pata_arasan_cf.c	2014-04-14 17:26:27.308294246 +0200
+++ b/drivers/ata/pata_arasan_cf.c	2014-04-14 17:44:41.868314795 +0200
@@ -898,9 +898,12 @@ static int arasan_cf_probe(struct platfo
 
 	cf_card_detect(acdev, 0);
 
-	return ata_host_activate(host, acdev->irq, irq_handler, 0,
-			&arasan_cf_sht);
+	ret = ata_host_activate(host, acdev->irq, irq_handler, 0,
+				&arasan_cf_sht);
+	if (!ret)
+		return 0;
 
+	cf_exit(acdev);
 free_clk:
 	clk_put(acdev->clk);
 	return ret;

