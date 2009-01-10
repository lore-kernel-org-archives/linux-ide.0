From: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH 2/2] libata: only ports >= 0 need to synchronize
Date: Sat, 10 Jan 2009 16:27:11 -0500
Message-ID: <20090110162711.6f99e4ca@infradead.org>
References: <20090109161455.08d5a54c@infradead.org>
	<alpine.LFD.2.00.0901091655530.6528@localhost.localdomain>
	<20090110162629.4c1d4769@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39742 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbZAJVZY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Jan 2009 16:25:24 -0500
In-Reply-To: <20090110162629.4c1d4769@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jgarzik@pobox.com

>From 68db7c1eff38c2e121ccc922fd365f4f086369dc Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Sat, 10 Jan 2009 10:18:44 -0800
Subject: [PATCH] libata: only ports >= 0 need to synchronize

In a discussio with Jeff Garzik, he mentioned that the serialization
for the libata port probes only needs to be within the domain of a host.
This means that for the first port of each host (with ID 0), we don't
need to wait, so we can relax our serialization a little.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/ata/libata-core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 31c0f22..71218d7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5925,10 +5925,12 @@ static void async_port_probe(void *data, async_cookie_t cookie)
 	 * If we're not allowed to scan this host in parallel,
 	 * we need to wait until all previous scans have completed
 	 * before going further.
+	 * Jeff Garzik says this is only within a controller, so we
+	 * don't need to wait for port 0, only for later ports.
 	 */
-	if (!(ap->host->flags & ATA_HOST_PARALLEL_SCAN))
+	if (!(ap->host->flags & ATA_HOST_PARALLEL_SCAN) && ap->port_no != 0)
 		async_synchronize_cookie(cookie);
-	
+
 	/* probe */
 	if (ap->ops->error_handler) {
 		struct ata_eh_info *ehi = &ap->link.eh_info;
-- 
1.6.0.6



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
