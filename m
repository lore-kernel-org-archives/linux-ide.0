From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/13] libata: separate ATA_EHI_DID_RESET into DID_SOFTRESET and DID_HARDRESET
Date: Mon, 23 Apr 2007 02:41:05 +0900
Message-ID: <11772636652710-git-send-email-htejun@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:25346 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbXDVRlM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:41:12 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1332009wra
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 10:41:11 -0700 (PDT)
In-Reply-To: <11772636651400-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Separate ATA_EHI_DID_RESET into ATA_EHI_DID_SOFTRESET and
ATA_EHI_DID_HARDRESET.  ATA_EHI_DID_RESET is redefined as OR of the
two flags.  This patch doesn't introduce any behavior change.  This
will be used later to determine whether _SDD is necessary or not.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    5 ++++-
 include/linux/libata.h  |   10 ++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 67bf150..2bff9ad 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1671,7 +1671,10 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
 				reset == softreset ? "soft" : "hard");
 
 	/* mark that this EH session started with reset */
-	ehc->i.flags |= ATA_EHI_DID_RESET;
+	if (reset == hardreset)
+		ehc->i.flags |= ATA_EHI_DID_HARDRESET;
+	else
+		ehc->i.flags |= ATA_EHI_DID_SOFTRESET;
 
 	rc = ata_do_reset(ap, reset, classes);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 73b86dd..d8cfc72 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -282,11 +282,13 @@ enum {
 	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
 
-	ATA_EHI_DID_RESET	= (1 << 16), /* already reset this port */
-	ATA_EHI_PRINTINFO	= (1 << 17), /* print configuration info */
-	ATA_EHI_SETMODE		= (1 << 18), /* configure transfer mode */
-	ATA_EHI_POST_SETMODE	= (1 << 19), /* revaildating after setmode */
+	ATA_EHI_DID_SOFTRESET	= (1 << 16), /* already soft-reset this port */
+	ATA_EHI_DID_HARDRESET	= (1 << 17), /* already soft-reset this port */
+	ATA_EHI_PRINTINFO	= (1 << 18), /* print configuration info */
+	ATA_EHI_SETMODE		= (1 << 19), /* configure transfer mode */
+	ATA_EHI_POST_SETMODE	= (1 << 20), /* revaildating after setmode */
 
+	ATA_EHI_DID_RESET	= ATA_EHI_DID_SOFTRESET | ATA_EHI_DID_HARDRESET,
 	ATA_EHI_RESET_MODIFIER_MASK = ATA_EHI_RESUME_LINK,
 
 	/* max repeat if error condition is still set after ->error_handler */
-- 
1.5.0.3


