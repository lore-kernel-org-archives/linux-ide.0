From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/9] libata-acpi: ignore _GTM failure during suspend
Date: Fri, 14 Dec 2007 15:15:40 +0900
Message-ID: <11976129432474-git-send-email-htejun@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:60175 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbXLNGPw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 01:15:52 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1544730wah.23
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 22:15:52 -0800 (PST)
In-Reply-To: <11976129411285-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Don't fail suspend because of _GTM failure.  This might eventually
cause _GTF evaluation failure during resume but that's better than
failing suspend.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index e68e918..1981112 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -640,9 +640,12 @@ int ata_acpi_on_suspend(struct ata_port *ap)
 		ap->pflags &= ~ATA_PFLAG_GTM_VALID;
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (rc == -ENOENT)
-		rc = 0;
-	return rc;
+	/* Don't fail suspend because of _GTM failure.  This will skip
+	 * _STM during resume and has the possibility of failing _GTF
+	 * but that's better than failing suspend/resume.  After all,
+	 * libata doesn't depend on ACPI to configure devices.
+	 */
+	return 0;
 }
 
 /**
-- 
1.5.2.4

