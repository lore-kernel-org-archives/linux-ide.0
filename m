From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 08/11] libata: stop dma before reset
Date: Thu,  7 Jul 2005 22:09:53 +0900 (KST)
Message-ID: <20050707130840.46AA6425@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.195]:63085 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261482AbVGGNKC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:10:02 -0400
Received: by wproxy.gmail.com with SMTP id 70so191853wra
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:09:59 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

08_libata_ahci-stop-dma-before-resetting.patch

	AHCI 1.1 mandates stopping dma before issueing COMMRESET.  The
	original code didn't and it resulted in occasional lockup of
	the controller during EH recovery.  This patch fixes the
	problem.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ahci.c |    2 ++
 1 files changed, 2 insertions(+)

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-07-07 22:08:36.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-07-07 22:08:37.000000000 +0900
@@ -474,7 +474,9 @@ static void ahci_phy_reset(struct ata_po
 	struct ata_device *dev = &ap->device[0];
 	u32 tmp;
 
+	ahci_stop_dma(ap);
 	__sata_phy_reset(ap);
+	ahci_start_dma(ap);
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;

