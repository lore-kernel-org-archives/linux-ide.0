From: Martin Hicks <mort@bork.org>
Subject: [PATCH] libata:  PHY reset requires writing 0x4 to SControl
Date: Wed, 5 Jul 2006 15:06:13 -0400
Message-ID: <20060705190613.GD16658@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galileo.bork.org ([134.117.69.57]:15492 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S964962AbWGETGO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jul 2006 15:06:14 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org


Hi,

Reading the Intel VSC and AHCI it seems like writing 0x302 is incorrect.
The only valid values are 4, 1 and 0.  Writing 4 disables the
PHY.

Signed-off-by: Martin Hicks <mort@bork.org>

---

 drivers/scsi/libata-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

99377743755ef015100ab52fd79ee950a783141b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6c66877..577fbcc 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2705,7 +2705,7 @@ int sata_std_hardreset(struct ata_port *
 		if ((rc = sata_scr_read(ap, SCR_CONTROL, &scontrol)))
 			return rc;
 
-		scontrol = (scontrol & 0x0f0) | 0x302;
+		scontrol = (scontrol & 0x0f0) | 0x304;
 
 		if ((rc = sata_scr_write(ap, SCR_CONTROL, scontrol)))
 			return rc;
-- 
1.3.2

