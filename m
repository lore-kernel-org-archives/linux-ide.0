From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/23] libata-sff: kill unused prototype and make ata_dev_select() static
Date: Mon, 10 May 2010 21:41:29 +0200
Message-ID: <1273520507-32459-6-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44929 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069Ab0EJTmO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:14 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

ata_irq_on() was renamed to ata_sff_irq_on() and exported a while ago
but prototype for the original function lingered in
drivers/ata/libata.h.  Kill it.  Also, ata_dev_select() is only used
inside drivers/ata/libata-sff.c.  Make it static.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |    2 +-
 drivers/ata/libata.h     |    3 ---
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 10af348..2a9b1b2 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -491,7 +491,7 @@ EXPORT_SYMBOL_GPL(ata_sff_dev_select);
  *	LOCKING:
  *	caller.
  */
-void ata_dev_select(struct ata_port *ap, unsigned int device,
+static void ata_dev_select(struct ata_port *ap, unsigned int device,
 			   unsigned int wait, unsigned int can_sleep)
 {
 	if (ata_msg_probe(ap))
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 823e630..132da80 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -202,9 +202,6 @@ static inline int sata_pmp_attach(struct ata_device *dev)
 
 /* libata-sff.c */
 #ifdef CONFIG_ATA_SFF
-extern void ata_dev_select(struct ata_port *ap, unsigned int device,
-                           unsigned int wait, unsigned int can_sleep);
-extern u8 ata_irq_on(struct ata_port *ap);
 extern void ata_pio_task(struct work_struct *work);
 #endif /* CONFIG_ATA_SFF */
 
-- 
1.6.4.2

