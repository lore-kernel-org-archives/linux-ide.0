From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 03/11] libata: convert sata_sil and ata_piix to use new EH
Date: Thu,  7 Jul 2005 22:09:28 +0900 (KST)
Message-ID: <20050707130840.13A31B92@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:34151 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261469AbVGGNJi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:09:38 -0400
Received: by wproxy.gmail.com with SMTP id i1so202517wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:09:33 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

03_libata_convert-drivers-to-new-eh.patch

	This patch converts sata_sil and ata_piix to use new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ata_piix.c |    4 ++--
 sata_sil.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: work/drivers/scsi/ata_piix.c
===================================================================
--- work.orig/drivers/scsi/ata_piix.c	2005-07-07 22:08:35.000000000 +0900
+++ work/drivers/scsi/ata_piix.c	2005-07-07 22:08:35.000000000 +0900
@@ -146,7 +146,7 @@ static struct ata_port_operations piix_p
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= ata_error_handler,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
@@ -174,7 +174,7 @@ static struct ata_port_operations piix_s
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= ata_error_handler,
 
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
Index: work/drivers/scsi/sata_sil.c
===================================================================
--- work.orig/drivers/scsi/sata_sil.c	2005-07-07 22:08:35.000000000 +0900
+++ work/drivers/scsi/sata_sil.c	2005-07-07 22:08:35.000000000 +0900
@@ -154,7 +154,7 @@ static struct ata_port_operations sil_op
 	.bmdma_status		= ata_bmdma_status,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
-	.eng_timeout		= ata_eng_timeout,
+	.error_handler		= ata_error_handler,
 	.irq_handler		= ata_interrupt,
 	.irq_clear		= ata_bmdma_irq_clear,
 	.scr_read		= sil_scr_read,

