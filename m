From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/12] libata-pmp: update ata_eh_reset() for PMP
Date: Mon, 16 Oct 2006 08:47:17 +0900
Message-ID: <11609560371799-git-send-email-htejun@gmail.com>
References: <11609560371552-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:14479 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932078AbWJOXrZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 19:47:25 -0400
Received: by nf-out-0910.google.com with SMTP id c2so636805nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 16:47:23 -0700 (PDT)
In-Reply-To: <11609560371552-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

PMP always requires SRST to be enabled.  Also, hardreset reports
classification code from the first device when PMP is attached.
Update ata_eh_reset() such that followup softreset is performed if the
controller is PMP capable.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 103fc5e..2c302c9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1565,13 +1565,16 @@ static int ata_do_reset(struct ata_link 
 	return 0;
 }
 
-static int ata_eh_followup_srst_needed(int rc, int classify,
+static int ata_eh_followup_srst_needed(struct ata_port *ap,
+				       int rc, int classify,
 				       const unsigned int *classes)
 {
 	if (rc == -EAGAIN)
 		return 1;
 	if (rc != 0)
 		return 0;
+	if (ap->flags & ATA_FLAG_PMP)
+		return 1;
 	if (classify && classes[0] == ATA_DEV_UNKNOWN)
 		return 1;
 	return 0;
@@ -1653,7 +1656,7 @@ int ata_eh_reset(struct ata_link *link, 
 
 	did_followup_srst = 0;
 	if (reset == hardreset &&
-	    ata_eh_followup_srst_needed(rc, classify, classes)) {
+	    ata_eh_followup_srst_needed(link->ap, rc, classify, classes)) {
 		/* okay, let's do follow-up softreset */
 		did_followup_srst = 1;
 		reset = softreset;
-- 
1.4.2.3


