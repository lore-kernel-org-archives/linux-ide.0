From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 03/07] sil24: add testing for PCI fault
Date: Sat, 30 Jul 2005 19:14:07 +0900 (KST)
Message-ID: <20050730101344.F6A4E6BD@htj.dyndns.org>
References: <20050730101344.1C985988@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.196]:36773 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263038AbVG3KOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2005 06:14:14 -0400
Received: by rproxy.gmail.com with SMTP id r35so1085920rna
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2005 03:14:11 -0700 (PDT)
In-Reply-To: <20050730101344.1C985988@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

03_sil24_add-test-for-PCI-fault.patch

	On entry to interrupt handler, PORT_SLOT_STAT register is read
	first.  Check if PCI fault or device removal has occurred by
	testing the value for 0xffffffff.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |    6 ++++++
 1 files changed, 6 insertions(+)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
@@ -539,6 +539,12 @@ static irqreturn_t sil24_interrupt(int i
 
 	status = readl(hpriv->host_base + HOST_IRQ_STAT);
 
+	if (status == 0xffffffff) {
+		printk(KERN_ERR DRV_NAME ": IRQ status == 0xffffffff, "
+		       "possible PCI fault or device removal\n");
+		goto out;
+	}
+
 	if (!(status & IRQ_STAT_4PORTS))
 		goto out;
 

