Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001FFC433F5
	for <linux-ide@archiver.kernel.org>; Tue,  1 Feb 2022 20:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiBAUuO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:50:14 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:43878 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbiBAUuN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 1 Feb 2022 15:50:13 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 57C7C20937B4
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] libata: kill ata_acpi_on_suspend()
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <75f6ca58-3fac-9919-d7ae-39e7730e045a@omp.ru>
Date:   Tue, 1 Feb 2022 23:50:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Since the commit c05e6ff035c1b25d17364a685432 ("libata-acpi: implement
and use ata_acpi_init_gtm()") ata_acpi_on_suspend() just returns 0, so
its call from ata_eh_handle_port_suspend() doesn't make sense anymore.
Remove the function completely, at last...

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'for-next' branch of Damien Le Moal's 'libata.git'
repo.

Changes in version 2:
- added the 'drivers/ata/libata.h' file update.

 drivers/ata/libata-acpi.c |   21 ---------------------
 drivers/ata/libata-eh.c   |    7 +------
 drivers/ata/libata.h      |    2 --
 3 files changed, 1 insertion(+), 29 deletions(-)

Index: libata/drivers/ata/libata-acpi.c
===================================================================
--- libata.orig/drivers/ata/libata-acpi.c
+++ libata/drivers/ata/libata-acpi.c
@@ -800,27 +800,6 @@ static int ata_acpi_push_id(struct ata_d
 }
 
 /**
- * ata_acpi_on_suspend - ATA ACPI hook called on suspend
- * @ap: target ATA port
- *
- * This function is called when @ap is about to be suspended.  All
- * devices are already put to sleep but the port_suspend() callback
- * hasn't been executed yet.  Error return from this function aborts
- * suspend.
- *
- * LOCKING:
- * EH context.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int ata_acpi_on_suspend(struct ata_port *ap)
-{
-	/* nada */
-	return 0;
-}
-
-/**
  * ata_acpi_on_resume - ATA ACPI hook called on resume
  * @ap: target ATA port
  *
Index: libata/drivers/ata/libata-eh.c
===================================================================
--- libata.orig/drivers/ata/libata-eh.c
+++ libata/drivers/ata/libata-eh.c
@@ -3902,11 +3902,6 @@ static void ata_eh_handle_port_suspend(s
 		}
 	}
 
-	/* tell ACPI we're suspending */
-	rc = ata_acpi_on_suspend(ap);
-	if (rc)
-		goto out;
-
 	/* suspend */
 	ata_eh_freeze_port(ap);
 
@@ -3914,7 +3909,7 @@ static void ata_eh_handle_port_suspend(s
 		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
 
 	ata_acpi_set_state(ap, ap->pm_mesg);
- out:
+
 	/* update the flags */
 	spin_lock_irqsave(ap->lock, flags);
 
Index: libata/drivers/ata/libata.h
===================================================================
--- libata.orig/drivers/ata/libata.h
+++ libata/drivers/ata/libata.h
@@ -107,7 +107,6 @@ static inline void ata_sas_free_tag(unsi
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
 extern void ata_acpi_dissociate(struct ata_host *host);
-extern int ata_acpi_on_suspend(struct ata_port *ap);
 extern void ata_acpi_on_resume(struct ata_port *ap);
 extern int ata_acpi_on_devcfg(struct ata_device *dev);
 extern void ata_acpi_on_disable(struct ata_device *dev);
@@ -117,7 +116,6 @@ extern void ata_acpi_bind_dev(struct ata
 extern acpi_handle ata_dev_acpi_handle(struct ata_device *dev);
 #else
 static inline void ata_acpi_dissociate(struct ata_host *host) { }
-static inline int ata_acpi_on_suspend(struct ata_port *ap) { return 0; }
 static inline void ata_acpi_on_resume(struct ata_port *ap) { }
 static inline int ata_acpi_on_devcfg(struct ata_device *dev) { return 0; }
 static inline void ata_acpi_on_disable(struct ata_device *dev) { }
