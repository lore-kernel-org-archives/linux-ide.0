From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_sil: update device hotplug handling, take #2
Date: Mon, 12 Jun 2006 18:45:55 +0900
Message-ID: <20060612094555.GA5751@htj.dyndns.org>
References: <20060612051822.GE9166@htj.dyndns.org> <448D04C5.9030603@pobox.com> <448D1AD7.3000807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:12432 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751354AbWFLJqA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 05:46:00 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1590618nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 02:45:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <448D1AD7.3000807@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

SIEN on some 3112 controllers doesn't mask SATA IRQ properly.  IRQ
stays asserted even after SIEN is masked and IRQ is acked.  Also, even
while frozen, any SATA PHY event including hardreset raises SATA IRQ.
Clearing SError seems to be the only way to deassert SATA IRQ.

This patch makes sil_host_intr() clear SError on SATA IRQs and ignore
SATA IRQs reported while frozen so that hardreset doesn't trigger
hotplug event (which ends up hardresetting again).

In such cases, the port still gets re-frozen to minimize the danger of
screaming interrupts.  This results in one nil EH repeat on
controllers with broken SIEN but other than that does no harm.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Here's the revised version.  The PCMCIA 3112 controller simply cannot
mask SATA IRQs w/ SIEN.  I've tested it w/ discrete 3112 and 3114
cards and the PCMCIA one.  All work fine with this patch applied.

 drivers/scsi/sata_sil.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

590d11f6b5303ea1b695e255d69eb7008e298913
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index a7e99a1..ec30a5c 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -344,7 +344,25 @@ static void sil_host_intr(struct ata_por
 	u8 status;
 
 	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
-		ata_ehi_hotplugged(&ap->eh_info);
+		u32 serror;
+
+		/* SIEN doesn't mask SATA IRQs on some 3112s.  Those
+		 * controllers continue to assert IRQ as long as
+		 * SError bits are pending.  Clear SError immediately.
+		 */
+		serror = sil_scr_read(ap, SCR_ERROR);
+		sil_scr_write(ap, SCR_ERROR, serror);
+
+		/* Trigger hotplug and accumulate SError only if the
+		 * port isn't already frozen.  Otherwise, PHY events
+		 * during hardreset makes controllers with broken SIEN
+		 * repeat probing needlessly.
+		 */
+		if (!(ap->flags & ATA_FLAG_FROZEN)) {
+			ata_ehi_hotplugged(&ap->eh_info);
+			ap->eh_info.serror |= serror;
+		}
+
 		goto freeze;
 	}
 
-- 
1.3.2

