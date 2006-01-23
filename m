From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: stop engine during hard reset
Date: Mon, 23 Jan 2006 16:31:53 +0900
Message-ID: <20060123073153.GA27470@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:20176 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964879AbWAWHi7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jan 2006 02:38:59 -0500
Received: by zproxy.gmail.com with SMTP id o1so1001330nzf
        for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2006 23:38:59 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

AHCI spec mandates engine to be stopped during hard resets.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, saner version of stopping engine during AHCI hard reset.

diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 604c4d1..b378cde 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -504,7 +504,9 @@ static void ahci_phy_reset(struct ata_po
 	struct ata_device *dev = &ap->device[0];
 	u32 new_tmp, tmp;
 
+	ahci_stop_engine(ap);
 	__sata_phy_reset(ap);
+	ahci_start_engine(ap);
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
