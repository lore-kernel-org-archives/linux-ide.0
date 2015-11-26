From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] sata_sil: disable trim
Date: Thu, 26 Nov 2015 12:00:59 -0500 (EST)
Message-ID: <alpine.LRH.2.02.1511261128250.31851@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39586 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbbKZRBA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 26 Nov 2015 12:01:00 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

When I connect an Intel SSD to SATA SIL controller (PCI ID 1095:3114), any
TRIM command results in I/O errors being reported in the log. There is
other similar error reported with TRIM and the SIL controller:
https://bugs.centos.org/view.php?id=5880

Apparently the controller doesn't support TRIM commands. This patch
disables TRIM support on the SATA SIL controller.

ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
ata7.00: BMDMA2 stat 0x50001
ata7.00: failed command: DATA SET MANAGEMENT
ata7.00: cmd 06/01:01:00:00:00/00:00:00:00:00/a0 tag 0 dma 512 out
         res 51/04:01:00:00:00/00:00:00:00:00/a0 Emask 0x1 (device error)
ata7.00: status: { DRDY ERR }
ata7.00: error: { ABRT }
ata7.00: device reported invalid CHS sector 0
sd 8:0:0:0: [sdb] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
sd 8:0:0:0: [sdb] tag#0 Sense Key : Illegal Request [current] [descriptor]
sd 8:0:0:0: [sdb] tag#0 Add. Sense: Unaligned write command
sd 8:0:0:0: [sdb] tag#0 CDB: Write same(16) 93 08 00 00 00 00 00 21 95 88 00 20 00 00 00 00
blk_update_request: I/O error, dev sdb, sector 2200968

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@kernel.org

---
 drivers/ata/sata_sil.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-4.4-rc2/drivers/ata/sata_sil.c
===================================================================
--- linux-4.4-rc2.orig/drivers/ata/sata_sil.c	2015-11-26 17:17:43.000000000 +0100
+++ linux-4.4-rc2/drivers/ata/sata_sil.c	2015-11-26 17:20:57.000000000 +0100
@@ -630,6 +630,9 @@ static void sil_dev_config(struct ata_de
 	unsigned int n, quirks = 0;
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 
+	/* This controller doesn't support trim */
+	dev->horkage |= ATA_HORKAGE_NOTRIM;
+
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
 	for (n = 0; sil_blacklist[n].product; n++)
