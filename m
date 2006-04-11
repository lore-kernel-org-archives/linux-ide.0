From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 15/15] sata_sil24: add hotplug support
Date: Tue, 11 Apr 2006 23:14:08 +0900
Message-ID: <11447648483948-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:45939 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751301AbWDKOOT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:19 -0400
Received: by zproxy.gmail.com with SMTP id o37so1102581nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:19 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add hotplug support by enabling PORT_IRQ_PHYRDY_CHG and scheduling
probe when either of PORT_IRQ_PHYRDY_CHG or PORT_IRQ_DEV_XCHG happens.
Explicit ata_schedule_probe() is necessary because sil24's SError
doesn't always reflect DEV_XCHG or PHYRDY_CHG conditions properly.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

dc756727b3be5cf5bff4a327bc13604235419fc6
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 1ca76f7..06c0ab0 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -156,7 +156,8 @@ enum {
 	PORT_IRQ_HANDSHAKE	= (1 << 10), /* handshake error threshold */
 	PORT_IRQ_SDB_NOTIFY	= (1 << 11), /* SDB notify received */
 
-	PORT_IRQ_FREEZE		= PORT_IRQ_DEV_XCHG | PORT_IRQ_UNK_FIS,
+	PORT_IRQ_FREEZE		= PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG |
+				  PORT_IRQ_UNK_FIS,
 	DEF_PORT_IRQ		= PORT_IRQ_FREEZE |
 				  PORT_IRQ_COMPLETE | PORT_IRQ_ERROR,
 
@@ -770,15 +771,20 @@ static unsigned int sil24_eh_autopsy(str
 	desc += rc;
 	desc_sz -= rc;
 
-	if (irq_stat & PORT_IRQ_DEV_XCHG) {
+	if (irq_stat & (PORT_IRQ_PHYRDY_CHG | PORT_IRQ_DEV_XCHG)) {
 		err_mask |= AC_ERR_ATA_BUS;
 		/* sil24 doesn't recover very well from phy
 		 * disconnection with a softreset.  Force hardreset.
 		 */
 		action |= ATA_PORT_HARDRESET;
-		rc = scnprintf(desc, desc_sz, ", device exchanged");
+		rc = scnprintf(desc, desc_sz, ", %s",
+			       irq_stat & PORT_IRQ_PHYRDY_CHG ?
+			       "PHY RDY changed" : "device exchanged");
 		desc += rc;
 		desc_sz -= rc;
+
+		/* request probing */
+		ata_schedule_probe(ap);
 	}
 
 	if (irq_stat & PORT_IRQ_UNK_FIS) {
-- 
1.2.4


