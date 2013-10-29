From: Levente Kurusa <levex@linux.com>
Subject: [PATCH trivial v2] ata: libata-eh: Remove unnecessary snprintf arithmetic
Date: Tue, 29 Oct 2013 20:01:46 +0100
Message-ID: <5270061A.3080108@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux IDE/ATA Dev <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Remove an unnecessary arithmetic operation from a call to snprintf, because
the size parameter of snprintf includes the trailing null space.
Also, initialize the buffer on definition instead of a memset call.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f9476fb..b7c4146 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2394,7 +2399,7 @@ static void ata_eh_link_report(struct ata_link *link)
 	struct ata_port *ap = link->ap;
 	struct ata_eh_context *ehc = &link->eh_context;
 	const char *frozen, *desc;
-	char tries_buf[6];
+	char tries_buf[6] = "";
 	int tag, nr_failed = 0;

 	if (ehc->i.flags & ATA_EHI_QUIET)
@@ -2425,9 +2432,8 @@ static void ata_eh_link_report(struct ata_link *link)
 	if (ap->pflags & ATA_PFLAG_FROZEN)
 		frozen = " frozen";

-	memset(tries_buf, 0, sizeof(tries_buf));
 	if (ap->eh_tries < ATA_EH_MAX_TRIES)
-		snprintf(tries_buf, sizeof(tries_buf) - 1, " t%d",
+		snprintf(tries_buf, sizeof(tries_buf), " t%d",
 			 ap->eh_tries);

 	if (ehc->i.dev) {
