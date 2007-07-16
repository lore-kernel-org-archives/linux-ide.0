From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 20/21] libata: schedule probing after SError access failure during autopsy
Date: Mon, 16 Jul 2007 14:29:41 +0900
Message-ID: <11845637811756-git-send-email-htejun@gmail.com>
References: <11845637782629-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:12055 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759344AbXGPF3z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jul 2007 01:29:55 -0400
Received: by nz-out-0506.google.com with SMTP id s18so736668nze
        for <linux-ide@vger.kernel.org>; Sun, 15 Jul 2007 22:29:54 -0700 (PDT)
In-Reply-To: <11845637782629-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

If SError isn't accessible, EH can't tell whether hotplug has happened
or not.  Report SError read failure with AC_ERR_OTHER and schedule
probing with hardreset.  This will be mainly useful for PMPs.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a5a8f84..e7e2ba2 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1478,8 +1478,12 @@ static void ata_eh_autopsy(struct ata_port *ap)
 	if (rc == 0) {
 		ehc->i.serror |= serror;
 		ata_eh_analyze_serror(ap);
-	} else if (rc != -EOPNOTSUPP)
+	} else if (rc != -EOPNOTSUPP) {
+		/* SError read failed, force hardreset and probing */
+		ata_ehi_schedule_probe(&ehc->i);
 		ehc->i.action |= ATA_EH_HARDRESET;
+		ehc->i.err_mask |= AC_ERR_OTHER;
+	}
 
 	/* analyze NCQ failure */
 	ata_eh_analyze_ncq_error(ap);
-- 
1.5.0.3


