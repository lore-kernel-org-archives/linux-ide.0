From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/10] libata: increase PMP register access timeout to 3s
Date: Mon, 19 May 2008 01:15:10 +0900
Message-ID: <12111273191831-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:52680 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbYERQP1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:27 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1010112wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:27 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

This timeout was set low because previously PMP register access was
done via polling and register access timeouts could stack up.  This is
no longer the case.  One timeout will make all following accesses fail
immediately.

In rare cases both marvell and SIMG PMPs need almost a second.  Bump
it to 3s.

While at it, rename it to SATA_PMP_RW_TIMEOUT.  It's not specific to
SCR access.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-pmp.c |    4 ++--
 include/linux/libata.h   |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index f3ad024..04a486a 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -48,7 +48,7 @@ static unsigned int sata_pmp_read(struct ata_link *link, int reg, u32 *r_val)
 	tf.device = link->pmp;
 
 	err_mask = ata_exec_internal(pmp_dev, &tf, NULL, DMA_NONE, NULL, 0,
-				     SATA_PMP_SCR_TIMEOUT);
+				     SATA_PMP_RW_TIMEOUT);
 	if (err_mask)
 		return err_mask;
 
@@ -88,7 +88,7 @@ static unsigned int sata_pmp_write(struct ata_link *link, int reg, u32 val)
 	tf.lbah = (val >> 24) & 0xff;
 
 	return ata_exec_internal(pmp_dev, &tf, NULL, DMA_NONE, NULL, 0,
-				 SATA_PMP_SCR_TIMEOUT);
+				 SATA_PMP_RW_TIMEOUT);
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0f17643..95e4169 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -341,7 +341,7 @@ enum {
 	ATA_EH_PMP_TRIES	= 5,
 	ATA_EH_PMP_LINK_TRIES	= 3,
 
-	SATA_PMP_SCR_TIMEOUT	= 250,
+	SATA_PMP_RW_TIMEOUT	= 3000,		/* PMP read/write timeout */
 
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependant */
-- 
1.5.2.4

