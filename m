From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] libata: use ULONG_MAX to terminate reset timeout table
Date: Tue, 20 May 2008 02:17:53 +0900
Message-ID: <12112174752587-git-send-email-htejun@gmail.com>
References: <12112174741373-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.237]:17113 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755145AbYESRSE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 13:18:04 -0400
Received: by qb-out-0506.google.com with SMTP id f11so3620180qba.15
        for <linux-ide@vger.kernel.org>; Mon, 19 May 2008 10:18:03 -0700 (PDT)
In-Reply-To: <12112174741373-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

This doesn't introduce any functional changes.  This is to make reset
timeout table consistent with to-be-added command timeout tables.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 5b5ae63..83d1451 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -90,7 +90,7 @@ static const unsigned long ata_eh_reset_timeouts[] = {
 	10000,	/* > 99% working drives spin up before 20sec */
 	35000,	/* give > 30 secs of idleness for retarded devices */
 	 5000,	/* and sweet one last chance */
-	/* > 1 min has elapsed, give up */
+	ULONG_MAX, /* > 1 min has elapsed, give up */
 };
 
 static void __ata_port_freeze(struct ata_port *ap);
@@ -2077,13 +2077,12 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		 ata_prereset_fn_t prereset, ata_reset_fn_t softreset,
 		 ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
 {
-	const int max_tries = ARRAY_SIZE(ata_eh_reset_timeouts);
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	unsigned int *classes = ehc->classes;
 	unsigned int lflags = link->flags;
 	int verbose = !(ehc->i.flags & ATA_EHI_QUIET);
-	int try = 0;
+	int max_tries = 0, try = 0;
 	struct ata_device *dev;
 	unsigned long deadline, now;
 	ata_reset_fn_t reset;
@@ -2094,6 +2093,9 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/*
 	 * Prepare to reset
 	 */
+	while (ata_eh_reset_timeouts[max_tries] != ULONG_MAX)
+		max_tries++;
+
 	now = jiffies;
 	deadline = ata_deadline(ehc->last_reset, ATA_EH_RESET_COOL_DOWN);
 	if (time_before(now, deadline))
-- 
1.5.2.4

