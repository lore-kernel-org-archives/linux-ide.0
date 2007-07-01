From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 16/16] libata-link: update Power Management to handle PMP links
Date: Sun, 1 Jul 2007 19:06:01 +0900
Message-ID: <11832843613177-git-send-email-htejun@gmail.com>
References: <11832843581399-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:52817 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225AbXGAKGL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:06:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879664wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:06:11 -0700 (PDT)
In-Reply-To: <11832843581399-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Update Power Management to consider PMP links.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ed6c5ed..f4863b6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5838,6 +5838,7 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
+		struct ata_link *link;
 
 		/* Previous resume operation might still be in
 		 * progress.  Wait for PM_PENDING to clear.
@@ -5857,8 +5858,10 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
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


