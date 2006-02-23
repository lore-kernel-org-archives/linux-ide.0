From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil24: add a new PCI ID for SiI 3124
Date: Thu, 23 Feb 2006 10:46:47 +0900
Message-ID: <20060223014647.GA31451@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:43800 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750924AbWBWBpu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Feb 2006 20:45:50 -0500
Received: by zproxy.gmail.com with SMTP id 9so1686482nzo
        for <linux-ide@vger.kernel.org>; Wed, 22 Feb 2006 17:45:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>

Add a new PCI ID for SiI 3124.  Reported by Silicon Image.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Carlos Pardo <Carlos.Pardo@siliconimage.com>

diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index a0e35a2..5c5822e 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -262,6 +262,7 @@ static int sil24_init_one(struct pci_dev
 
 static const struct pci_device_id sil24_pci_tbl[] = {
 	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
+	{ 0x8086, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
 	{ 0x1095, 0x3132, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3132 },
 	{ 0x1095, 0x3131, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3131 },
 	{ 0x1095, 0x3531, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3131 },
