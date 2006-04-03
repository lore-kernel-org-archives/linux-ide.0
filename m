From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ata_piix: convert to new EH
Date: Mon, 3 Apr 2006 12:40:58 +0900
Message-ID: <11440356582985-git-send-email-htejun@gmail.com>
References: <11440356574107-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:18384 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964822AbWDCDlI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:41:08 -0400
Received: by zproxy.gmail.com with SMTP id o37so1664795nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:41:07 -0700 (PDT)
In-Reply-To: <11440356574107-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_piix can use stock BMDMA EH routines.  Convert to new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

b1f5e082114555527205661d02f4f3876a1ae650
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 24e71b5..13cc588 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -244,7 +244,9 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -272,7 +274,9 @@ static const struct ata_port_operations 
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.eng_timeout		= ata_eng_timeout,
+	.freeze			= ata_bmdma_freeze,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
-- 
1.2.4


