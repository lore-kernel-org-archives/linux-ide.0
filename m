From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 07/07] sil24: add FIXME comment above ata_device_add
Date: Sat, 30 Jul 2005 19:14:28 +0900 (KST)
Message-ID: <20050730101345.00A9ECB9@htj.dyndns.org>
References: <20050730101344.1C985988@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.204]:63926 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263044AbVG3KOe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2005 06:14:34 -0400
Received: by rproxy.gmail.com with SMTP id i8so1042185rne
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2005 03:14:31 -0700 (PDT)
In-Reply-To: <20050730101344.1C985988@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

07_sil24_add-FIXME-ata_device_add-return_value.patch

	Add FIXME comment above ata_device_add.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-07-30 19:13:41.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-07-30 19:13:41.000000000 +0900
@@ -768,6 +768,7 @@ static int sil24_init_one(struct pci_dev
 
 	pci_set_master(pdev);
 
+	/* FIXME: check ata_device_add return value */
 	ata_device_add(probe_ent);
 
 	kfree(probe_ent);

