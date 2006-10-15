From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/18] [PATCH] libata: generate hotplug event on SError read failure
Date: Mon, 16 Oct 2006 07:54:39 +0900
Message-ID: <11609528792467-git-send-email-htejun@gmail.com>
References: <1160952879581-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:50102 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422926AbWJOWys (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Oct 2006 18:54:48 -0400
Received: by nf-out-0910.google.com with SMTP id c2so626620nfe
        for <linux-ide@vger.kernel.org>; Sun, 15 Oct 2006 15:54:47 -0700 (PDT)
In-Reply-To: <1160952879581-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_eh_autopsy() used to schedule hardreset for phys which failed to
return SError, which isn't enough for some cases.  Assume the worst
and generate hotplug event instead.  Note that scr_read() is
guaranteed to succeed for host ports.  This change affects only PMP
links.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 6787fbc..2067db0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1327,8 +1327,10 @@ static void ata_eh_autopsy(struct ata_po
 	if (rc == 0) {
 		ehc->i.serror |= serror;
 		ata_eh_analyze_serror(ap);
-	} else if (rc != -EOPNOTSUPP)
-		ehc->i.action |= ATA_EH_HARDRESET;
+	} else if (rc != -EOPNOTSUPP) {
+		/* hmmm, assume the worst and generate hotplug event */
+		__ata_ehi_hotplugged(&ehc->i);
+	}
 
 	/* analyze NCQ failure */
 	ata_eh_analyze_ncq_error(ap);
-- 
1.4.2.3


