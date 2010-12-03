From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata-sff: fix HSM_ST_ERR handling in __ata_sff_port_intr()
Date: Fri, 03 Dec 2010 15:19:13 +0100
Message-ID: <4CF8FC61.8060606@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35466 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758226Ab0LCOTj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Dec 2010 09:19:39 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Antonio Toma <antonio.toma@gmail.com>, stable <stable@kernel.org>

While separating out BMDMA irq handler from SFF, commit c3b28894
(libata-sff: separate out BMDMA irq handler) incorrectly made
__ata_sff_port_intr() consider an IRQ to be an idle one if the host
state was transitioned to HSM_ST_ERR by ata_bmdma_port_intr().

This makes BMDMA drivers ignore IRQs reporting host bus error which
leads to timeouts instead of triggering EH immediately.  Fix it by
making __ata_sff_port_intr() consider the IRQ to be an idle one iff
the state is HSM_ST_IDLE.  This is equivalent to adding HSM_ST_ERR to
the "break"ing case but less error-prone.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Antonio Toma <antonio.toma@gmail.com>
Cc: stable@kernel.org
---
 drivers/ata/libata-sff.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index d05387d..484697f 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1532,11 +1532,10 @@ static unsigned int __ata_sff_port_intr(struct ata_port *ap,
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
 			return ata_sff_idle_irq(ap);
 		break;
-	case HSM_ST:
-	case HSM_ST_LAST:
-		break;
-	default:
+	case HSM_ST_IDLE:
 		return ata_sff_idle_irq(ap);
+	default:
+		break;
 	}

 	/* check main status, clearing INTRQ if needed */
