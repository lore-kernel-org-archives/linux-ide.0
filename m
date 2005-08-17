From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 03/08] sil24: add testing for PCI fault
Date: Wed, 17 Aug 2005 13:08:52 +0900 (KST)
Message-ID: <20050817040611.8772AD4E@htj.dyndns.org>
References: <20050817040611.C0A53974@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:64781 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750829AbVHQEI5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 00:08:57 -0400
Received: by wproxy.gmail.com with SMTP id i20so86156wra
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 21:08:56 -0700 (PDT)
In-Reply-To: <20050817040611.C0A53974@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com, Carlos.Pardo@siliconimage.com
Cc: linux-ide@vger.kernel.org

03_sil24_add-pci-fault-check.patch

	On entry to interrupt handler, PORT_SLOT_STAT register is read
        first.  Check if PCI fault or device removal has occurred by
        testing the value for 0xffffffff.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |    6 ++++++
 1 files changed, 6 insertions(+)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-08-17 13:06:07.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-08-17 13:06:07.000000000 +0900
@@ -527,6 +527,12 @@ static irqreturn_t sil24_interrupt(int i
 
 	status = readl(hpriv->host_base + HOST_IRQ_STAT);
 
+	if (status == 0xffffffff) {
+		printk(KERN_ERR DRV_NAME ": IRQ status == 0xffffffff, "
+		       "PCI fault or device removal?\n");
+		goto out;
+	}
+
 	if (!(status & IRQ_STAT_4PORTS))
 		goto out;
 

