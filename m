Return-Path: <SRS0=YTe+=65=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D135BC433E0
	for <linux-ide@archiver.kernel.org>; Fri, 15 May 2020 11:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87D7206B6
	for <linux-ide@archiver.kernel.org>; Fri, 15 May 2020 11:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgEOLJ3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 15 May 2020 07:09:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51867 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgEOLJ3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2020 07:09:29 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jZYDV-00069M-33; Fri, 15 May 2020 11:09:25 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     axboe@kernel.dk
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        John Garry <john.garry@huawei.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] libata: Use per port sync for detach
Date:   Fri, 15 May 2020 19:09:15 +0800
Message-Id: <20200515110916.11556-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Commit 130f4caf145c ("libata: Ensure ata_port probe has completed before
detach") may cause system freeze during suspend.

Using async_synchronize_full() in PM callbacks is wrong, since async
callbacks that are already scheduled may wait for not-yet-scheduled
callbacks, causes a circular dependency.

Instead of using big hammer like async_synchronize_full(), use async
cookie to make sure port probe are synced, without affecting other
scheduled PM callbacks.

Fixes: 130f4caf145c ("libata: Ensure ata_port probe has completed before detach")
BugLink: https://bugs.launchpad.net/bugs/1867983
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/ata/libata-core.c | 6 +++---
 include/linux/libata.h    | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index beca5f91bb4c..4a698f6388cd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -42,7 +42,6 @@
 #include <linux/workqueue.h>
 #include <linux/scatterlist.h>
 #include <linux/io.h>
-#include <linux/async.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/glob.h>
@@ -5778,7 +5777,7 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 	/* perform each probe asynchronously */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
-		async_schedule(async_port_probe, ap);
+		ap->cookie = async_schedule(async_port_probe, ap);
 	}
 
 	return 0;
@@ -5921,7 +5920,8 @@ void ata_host_detach(struct ata_host *host)
 	int i;
 
 	/* Ensure ata_port probe has completed */
-	async_synchronize_full();
+	for (i = 0; i < host->n_ports; i++)
+		async_synchronize_cookie(host->ports[i]->cookie);
 
 	for (i = 0; i < host->n_ports; i++)
 		ata_port_detach(host->ports[i]);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index cffa4714bfa8..ae6dfc107ea8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -22,6 +22,7 @@
 #include <linux/acpi.h>
 #include <linux/cdrom.h>
 #include <linux/sched.h>
+#include <linux/async.h>
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -872,6 +873,8 @@ struct ata_port {
 	struct timer_list	fastdrain_timer;
 	unsigned long		fastdrain_cnt;
 
+	async_cookie_t		cookie;
+
 	int			em_message_type;
 	void			*private_data;
 
-- 
2.17.1

