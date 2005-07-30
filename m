From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 06/07] sil24: add IO flushing after masking irq during initialization
Date: Sat, 30 Jul 2005 19:14:23 +0900 (KST)
Message-ID: <20050730101345.6815C41F@htj.dyndns.org>
References: <20050730101344.1C985988@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.196]:6787 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263043AbVG3KO2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2005 06:14:28 -0400
Received: by wproxy.gmail.com with SMTP id i6so812887wra
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2005 03:14:27 -0700 (PDT)
In-Reply-To: <20050730101344.1C985988@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

06_sil24_add-flusing-after-masking-irq.patch

	Add IO flushing after masking irq during initialization.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-07-30 19:13:41.000000000 +0900
@@ -706,6 +706,7 @@ static int sil24_init_one(struct pci_dev
 
 	/* Mask interrupts during initialization */
 	writel(0, host_base + HOST_CTRL);
+	readl(host_base + HOST_CTRL);	/* sync */
 
 	for (i = 0; i < probe_ent->n_ports; i++) {
 		void *port = port_base + i * PORT_REGS_SIZE;

