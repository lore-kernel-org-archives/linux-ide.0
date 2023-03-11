Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F1FC6FD1F
	for <linux-ide@archiver.kernel.org>; Sat, 11 Mar 2023 21:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCKVo4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 11 Mar 2023 16:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCKVoz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2023 16:44:55 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F325B67813;
        Sat, 11 Mar 2023 13:44:54 -0800 (PST)
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 3C9497A0158;
        Sat, 11 Mar 2023 22:44:54 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pata_parport: fix possible memory leak
Date:   Sat, 11 Mar 2023 22:44:47 +0100
Message-Id: <20230311214447.7359-1-linux@zary.sk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <202303112239.21234.linux@zary.sk>
References: <202303112239.21234.linux@zary.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When ida_alloc() fails, "pi" is not freed although the misleading
comment says otherwise.
Move the ida_alloc() call up so we really don't have to free it.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202303111822.IHNchbkp-lkp@intel.com/
Signed-off-by: Ondrej Zary <linux@zary.sk>
---
 drivers/ata/pata_parport/pata_parport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index 6165ee9aa7da..a9eff6003098 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -503,18 +503,19 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	if (bus_for_each_dev(&pata_parport_bus_type, NULL, &match, pi_find_dev))
 		return NULL;
 
+	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
+	if (id < 0)
+		return NULL;
+
 	pi = kzalloc(sizeof(struct pi_adapter), GFP_KERNEL);
 	if (!pi)
-		return NULL;
+		goto out_ida_free;
 
 	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
 	pi->dev.parent = &pata_parport_bus;
 	pi->dev.bus = &pata_parport_bus_type;
 	pi->dev.driver = &pr->driver;
 	pi->dev.release = pata_parport_dev_release;
-	id = ida_alloc(&pata_parport_bus_dev_ids, GFP_KERNEL);
-	if (id < 0)
-		return NULL; /* pata_parport_dev_release will do kfree(pi) */
 	pi->dev.id = id;
 	dev_set_name(&pi->dev, "pata_parport.%u", pi->dev.id);
 	if (device_register(&pi->dev)) {
@@ -571,7 +572,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 out_unreg_dev:
 	device_unregister(&pi->dev);
 out_ida_free:
-	ida_free(&pata_parport_bus_dev_ids, pi->dev.id);
+	ida_free(&pata_parport_bus_dev_ids, id);
 	return NULL;
 }
 
-- 
Ondrej Zary

