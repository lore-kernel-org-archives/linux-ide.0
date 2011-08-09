From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] libata-eh: ata_eh_followup_srst_needed() does not need 'classes' parameter
Date: Tue, 9 Aug 2011 23:25:50 +0400
Message-ID: <201108092325.50800.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:45642 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750722Ab1HIT1t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Aug 2011 15:27:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

... since it does not use it.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/libata-eh.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/libata-eh.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-eh.c
+++ linux-2.6/drivers/ata/libata-eh.c
@@ -2532,8 +2532,7 @@ static int ata_do_reset(struct ata_link 
 	return reset(link, classes, deadline);
 }
 
-static int ata_eh_followup_srst_needed(struct ata_link *link,
-				       int rc, const unsigned int *classes)
+static int ata_eh_followup_srst_needed(struct ata_link *link, int rc)
 {
 	if ((link->flags & ATA_LFLAG_NO_SRST) || ata_link_offline(link))
 		return 0;
@@ -2726,7 +2725,7 @@ int ata_eh_reset(struct ata_link *link, 
 
 		/* perform follow-up SRST if necessary */
 		if (reset == hardreset &&
-		    ata_eh_followup_srst_needed(link, rc, classes)) {
+		    ata_eh_followup_srst_needed(link, rc)) {
 			reset = softreset;
 
 			if (!reset) {
