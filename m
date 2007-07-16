From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/14] libata-link: update Power Management to handle PMP links
Date: Mon, 16 Jul 2007 18:34:41 +0900
Message-ID: <11845784813364-git-send-email-htejun@gmail.com>
References: <11845784783033-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:64330 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756174AbXGPJe4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 05:34:56 -0400
Received: by py-out-1112.google.com with SMTP id d32so2168488pye
        for <linux-ide@vger.kernel.org>; Mon, 16 Jul 2007 02:34:55 -0700 (PDT)
In-Reply-To: <11845784783033-git-send-email-htejun@gmail.com>
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
index f2d3233..19e831a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5891,6 +5891,7 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
 
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
+		struct ata_link *link;
 
 		/* Previous resume operation might still be in
 		 * progress.  Wait for PM_PENDING to clear.
@@ -5910,8 +5911,10 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
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


