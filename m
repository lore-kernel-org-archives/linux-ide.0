From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] libata: restore SControl on detach
Date: Thu, 31 Jul 2008 16:09:34 +0900
Message-ID: <4891652E.6020108@kernel.org>
References: <48916498.20703@kernel.org> <489164D2.9000009@kernel.org> <489164F6.4080602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39838 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbYGaHKh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 31 Jul 2008 03:10:37 -0400
In-Reply-To: <489164F6.4080602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Save SControl during probing and restore it on detach.  This prevents
adjustments made by libata drivers to seep into the next driver which
gets attached (be it a libata one or not).

It's not clear whether SControl also needs to be restored on suspend.
The next system to have control (ACPI or kexec'd kernel) would
probably like to see the original SControl value but there's no
guarantee that a link is gonna keep working after SControl is adjusted
without a reset and adding a reset and modified recovery cycle soley
for this is an overkill.  For now, do it only for detach.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   10 +++++-----
 include/linux/libata.h    |    1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9bef1a8..9481937 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5158,15 +5158,14 @@ void ata_link_init(struct ata_port *ap, struct ata_link *link, int pmp)
  */
 int sata_link_init_spd(struct ata_link *link)
 {
-	u32 scontrol;
 	u8 spd;
 	int rc;
 
-	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
+	rc = sata_scr_read(link, SCR_CONTROL, &link->saved_scontrol);
 	if (rc)
 		return rc;
 
-	spd = (scontrol >> 4) & 0xf;
+	spd = (link->saved_scontrol >> 4) & 0xf;
 	if (spd)
 		link->hw_sata_spd_limit &= (1 << spd) - 1;
 
@@ -5753,9 +5752,10 @@ static void ata_port_detach(struct ata_port *ap)
 	ata_port_wait_eh(ap);
 
 	/* EH is now guaranteed to see UNLOADING - EH context belongs
-	 * to us.  Disable all existing devices.
+	 * to us.  Restore SControl and disable all existing devices.
 	 */
-	ata_port_for_each_link(link, ap) {
+	__ata_port_for_each_link(link, ap) {
+		sata_scr_write(link, SCR_CONTROL, link->saved_scontrol);
 		ata_link_for_each_dev(dev, link)
 			ata_dev_disable(dev);
 	}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5b247b8..3437c11 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -646,6 +646,7 @@ struct ata_link {
 
 	unsigned int		flags;		/* ATA_LFLAG_xxx */
 
+	u32			saved_scontrol;	/* SControl on probe */
 	unsigned int		hw_sata_spd_limit;
 	unsigned int		sata_spd_limit;
 	unsigned int		sata_spd;	/* current SATA PHY speed */
-- 
1.5.4.5

