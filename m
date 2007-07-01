From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] libata: schedule probing after SError access failure during autopsy
Date: Sun, 1 Jul 2007 18:53:38 +0900
Message-ID: <11832836183512-git-send-email-htejun@gmail.com>
References: <118328361627-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:29872 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755575AbXGAJxs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 05:53:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1876617wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 02:53:48 -0700 (PDT)
In-Reply-To: <118328361627-git-send-email-htejun@gmail.com>
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
index 6518108..fe4be8a 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1413,8 +1413,12 @@ static void ata_eh_autopsy(struct ata_port *ap)
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


