From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/14] libata-link: update Power Management to handle PMP links
Date: Mon, 6 Aug 2007 18:36:24 +0900
Message-ID: <11863929841830-git-send-email-htejun@gmail.com>
References: <11863929823677-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:47325 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761299AbXHFJgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 05:36:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1076043rvb
        for <linux-ide@vger.kernel.org>; Mon, 06 Aug 2007 02:36:37 -0700 (PDT)
In-Reply-To: <11863929823677-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update Power Management to consider PMP links.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 50721bc..d9e59e9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5893,6 +5893,7 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
+		struct ata_link *link;
 
 		/* Previous resume operation might still be in
 		 * progress.  Wait for PM_PENDING to clear.
@@ -5912,8 +5913,10 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 		}
 
 		ap->pflags |= ATA_PFLAG_PM_PENDING;
-		ap->link.eh_info.action |= action;
-		ap->link.eh_info.flags |= ehi_flags;
+		__ata_port_for_each_link(link, ap) {
+			link->eh_info.action |= action;
+			link->eh_info.flags |= ehi_flags;
+		}
 
 		ata_port_schedule_eh(ap);
 
-- 
1.5.0.3


