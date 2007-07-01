From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/12] libata-pmp-prep: implement sata_async_notification()
Date: Sun, 1 Jul 2007 19:26:09 +0900
Message-ID: <11832855693651-git-send-email-htejun@gmail.com>
References: <11832855672398-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:26395 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956AbXGAK0R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:26:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1884684wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:26:16 -0700 (PDT)
In-Reply-To: <11832855672398-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Implement SATA async notification handler sata_async_notification().
LLDs can call this function when it suspects SDB_NOTIFY has occurred.
This function will check SCR_NOTIFICATION if available and schedule
proper EH action.

Currently, only PMP notification is handled.  The function can be
easily extended to cover ATAPI notification later.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    1 +
 drivers/ata/libata-eh.c   |   49 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |    1 +
 3 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 17b1734..2d960da 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -7051,6 +7051,7 @@ EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
 EXPORT_SYMBOL_GPL(ata_link_abort);
 EXPORT_SYMBOL_GPL(ata_port_abort);
 EXPORT_SYMBOL_GPL(ata_port_freeze);
+EXPORT_SYMBOL_GPL(sata_async_notification);
 EXPORT_SYMBOL_GPL(ata_eh_freeze_port);
 EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index f4dae06..03b1665 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -773,6 +773,55 @@ int ata_port_freeze(struct ata_port *ap)
 }
 
 /**
+ *	sata_async_notification - SATA async notification handler
+ *	@ap: ATA port where async notification is received
+ *
+ *	Handler to be called when async notification via SDB FIS is
+ *	received.  This function schedules EH if necessary.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ *	RETURNS:
+ *	1 if EH is scheduled, 0 otherwise.
+ */
+int sata_async_notification(struct ata_port *ap)
+{
+	u32 sntf;
+	int rc;
+
+	if (!(ap->flags & ATA_FLAG_SDB_NOTIFY))
+		return 0;
+
+	rc = sata_scr_read(&ap->link, SCR_NOTIFICATION, &sntf);
+	if (rc == 0) {
+		if (!sntf)
+			return 0;
+
+		/* clear it */
+		sata_scr_write(&ap->link, SCR_NOTIFICATION, sntf);
+
+		/* PMP is reporting that PHY status of some downstream
+		 * ports have changed.  Schedule EH.
+		 */
+		if (ap->nr_pmp_links && (sntf & (1 << SATA_PMP_CTRL_PORT))) {
+			ata_port_schedule_eh(ap);
+			return 1;
+		}
+	} else {
+		/* Dunno what's going on.  Schedule EH if PMP is
+		 * attached.  It might be reporting PHY status change.
+		 */
+		if (ap->nr_pmp_links) {
+			ata_port_schedule_eh(ap);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/**
  *	ata_eh_freeze_port - EH helper to freeze port
  *	@ap: ATA port to freeze
  *
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d41da74..09959a7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -947,6 +947,7 @@ extern void ata_port_schedule_eh(struct ata_port *ap);
 extern int ata_link_abort(struct ata_link *link);
 extern int ata_port_abort(struct ata_port *ap);
 extern int ata_port_freeze(struct ata_port *ap);
+extern int sata_async_notification(struct ata_port *ap);
 
 extern void ata_eh_freeze_port(struct ata_port *ap);
 extern void ata_eh_thaw_port(struct ata_port *ap);
-- 
1.5.0.3


