From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/15] libata: make ata_set_mode() handle no-device case properly
Date: Sat, 1 Apr 2006 01:38:18 +0900
Message-ID: <11438230981553-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:2842 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751395AbWCaQi3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:29 -0500
Received: by zproxy.gmail.com with SMTP id o37so955071nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:28 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_set_mode() return without doing anything if there is no
device on the port.  This is in preparation for ata_bus_probe()
changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

62f7d91fc4040f3acd6b6f0ed8b8c863c40727d4
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c10c550..913e378 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1823,7 +1823,7 @@ static void ata_host_set_dma(struct ata_
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	int i, rc, used_dma = 0;
+	int i, rc, used_dma = 0, found = 0;
 
 	/* step 1: calculate xfer_mask */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
@@ -1842,9 +1842,12 @@ static void ata_set_mode(struct ata_port
 		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
 		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
 
+		found = 1;
 		if (dev->dma_mode)
 			used_dma = 1;
 	}
+	if (!found)
+		return;
 
 	/* step 2: always set host PIO timings */
 	rc = ata_host_set_pio(ap);
-- 
1.2.4


