From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 01/08] sil24: add FIXME comment above ata_device_add
Date: Wed, 17 Aug 2005 13:08:42 +0900 (KST)
Message-ID: <20050817040611.C16368A5@htj.dyndns.org>
References: <20050817040611.C0A53974@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.203]:60070 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750809AbVHQEIr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2005 00:08:47 -0400
Received: by rproxy.gmail.com with SMTP id r35so75258rna
        for <linux-ide@vger.kernel.org>; Tue, 16 Aug 2005 21:08:46 -0700 (PDT)
In-Reply-To: <20050817040611.C0A53974@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com, Carlos.Pardo@siliconimage.com
Cc: linux-ide@vger.kernel.org

01_sil24_add-FIXME-comment.patch

	Add FIXME comment above ata_device_add.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-08-17 12:32:41.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-08-17 13:06:06.000000000 +0900
@@ -749,6 +749,7 @@ static int sil24_init_one(struct pci_dev
 
 	pci_set_master(pdev);
 
+	/* FIXME: check ata_device_add return value */
 	ata_device_add(probe_ent);
 
 	kfree(probe_ent);

