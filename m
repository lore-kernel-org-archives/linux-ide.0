From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH Linux 2.6.12 07/09] NCQ: stop dma before reset
Date: Mon, 27 Jun 2005 00:21:42 +0900 (KST)
Message-ID: <20050626152105.F3C5D2FC@htj.dyndns.org>
References: <20050626152105.D86561FB@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:958 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261320AbVFZPVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2005 11:21:47 -0400
Received: by zproxy.gmail.com with SMTP id o37so96697nzf
        for <linux-ide@vger.kernel.org>; Sun, 26 Jun 2005 08:21:47 -0700 (PDT)
In-Reply-To: <20050626152105.D86561FB@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, linux-ide@vger.kernel.org

07_NCQ_ahci-stop-dma-before-reset.patch

	AHCI 1.1 mandates stopping dma before issueing COMMRESET.  The
	original code didn't and it resulted in occasional lockup of
	the controller during EH recovery.  This patch fixes the
	problem.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ahci.c |    2 ++
 1 files changed, 2 insertions(+)

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-06-27 00:20:31.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-06-27 00:20:31.000000000 +0900
@@ -474,7 +474,9 @@ static void ahci_phy_reset(struct ata_po
 	struct ata_device *dev = &ap->device[0];
 	u32 tmp;
 
+	ahci_stop_dma(ap);
 	__sata_phy_reset(ap);
+	ahci_start_dma(ap);
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;

