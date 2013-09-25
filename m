From: Xiangliang Yu <yxlraid@gmail.com>
Subject: [PATCH 1/1] AHCI: disabled FBS before softreset handling. According to chapter 9.3.9 in AHCI spec, controller should disable FBS before softreset.
Date: Wed, 25 Sep 2013 22:46:28 +0800
Message-ID: <1380120388-13375-1-git-send-email-yxlraid@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:51902 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab3IYOrb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2013 10:47:31 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so6164337pdj.2
        for <linux-ide@vger.kernel.org>; Wed, 25 Sep 2013 07:47:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Xiangliang Yu <yxlraid@gmail.com>


Signed-off-by: Xiangliang Yu <yxlraid@gmail.com>
---
 drivers/ata/libahci.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index acfd0f7..8d024a4 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1267,9 +1267,11 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 {
 	struct ata_port *ap = link->ap;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
+	struct ahci_port_priv *pp = ap->private_data;
 	const char *reason = NULL;
 	unsigned long now, msecs;
 	struct ata_taskfile tf;
+	bool flag = FALSE;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -1279,6 +1281,11 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	if (rc && rc != -EOPNOTSUPP)
 		ata_link_warn(link, "failed to reset engine (errno=%d)\n", rc);
 
+	if (!ata_is_host_link(link) && pp->fbs_enabled) {
+		ahci_disable_fbs(ap);
+		flag = TRUE;
+	}
+
 	ata_tf_init(link->device, &tf);
 
 	/* issue the first D2H Register FIS */
@@ -1319,6 +1326,9 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	} else
 		*class = ahci_dev_classify(ap);
 
+	if (flag)
+		ahci_enable_fbs(ap);
+
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
-- 
1.7.1

