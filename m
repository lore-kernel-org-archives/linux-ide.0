From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] libata: kill ata_irq_on() prototype
Date: Thu, 6 May 2010 22:15:22 +0400
Message-ID: <201005062215.22697.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:44588 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752448Ab0EFSQM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 May 2010 14:16:12 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Commit 9363c3825ea9ad76561eb48a395349dd29211ed6 renamed ata_irq_on() to
ata_sff_irq_on() but forgot to rename its prototype in "libata.h". This
prototype is duplicate anyway, as the function is already declared in
<linux/libata.h>, so remove it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/libata.h |    1 -
 1 file changed, 1 deletion(-)

Index: linux-2.6/drivers/ata/libata.h
===================================================================
--- linux-2.6.orig/drivers/ata/libata.h
+++ linux-2.6/drivers/ata/libata.h
@@ -204,7 +204,6 @@ static inline int sata_pmp_attach(struct
 #ifdef CONFIG_ATA_SFF
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
-extern u8 ata_irq_on(struct ata_port *ap);
 extern void ata_pio_task(struct work_struct *work);
 #endif /* CONFIG_ATA_SFF */
 
