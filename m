From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] libata: Ignore spurious PHY events on LPM policy change
Date: Sat, 25 Apr 2015 11:34:29 +0200
Message-ID: <1429954469-27892-1-git-send-email-gabriele.mzt@gmail.com>
References: <20150424214214.GD27034@htj.duckdns.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33331 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758757AbbDYJfM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Apr 2015 05:35:12 -0400
In-Reply-To: <20150424214214.GD27034@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>

When the LPM policy is set to ATA_LPM_MAX_POWER, the device might
generate a spurious PHY event that might cause errors on the link.
Ignore this event if it occurred within 10s after the policy change.

The timeout was chosen observing that on a Dell XPS13 9333 these
spurious events can occur up to roughly 6s after the policy change.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/ata/libahci.c   | 13 ++++++++++++-
 drivers/ata/libata-eh.c |  3 +++
 include/linux/libata.h  |  9 +++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 61a9c07..59a2517 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1700,6 +1700,9 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 	struct ahci_port_priv *pp = ap->private_data;
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	int resetting = !!(ap->pflags & ATA_PFLAG_RESETTING);
+	unsigned long lpm_timeout = ap->link.last_lpm_change +
+				    msecs_to_jiffies(ATA_TMOUT_SPURIOUS_PHY);
+	bool ignore_event = false;
 	u32 qc_active = 0;
 	int rc;
 
@@ -1707,8 +1710,16 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 	if (unlikely(resetting))
 		status &= ~PORT_IRQ_BAD_PMP;
 
+	/* ignore the first PHY event after the LPM policy changed
+	 * as it is might be spurious
+	 */
+	if ((ap->link.flags & ATA_LFLAG_CHANGED) &&
+	    time_before(jiffies, lpm_timeout))
+		ignore_event = true;
+
 	/* if LPM is enabled, PHYRDY doesn't mean anything */
-	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER) {
+	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER || ignore_event) {
+		ap->link.flags &= ~ATA_LFLAG_CHANGED;
 		status &= ~PORT_IRQ_PHYRDY;
 		ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
 	}
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 07f41be..cf0022e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3597,6 +3597,9 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		}
 	}
 
+	link->last_lpm_change = jiffies;
+	link->flags |= ATA_LFLAG_CHANGED;
+
 	return 0;
 
 fail:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8dad4a3..05dbff3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -205,6 +205,7 @@ enum {
 	ATA_LFLAG_SW_ACTIVITY	= (1 << 7), /* keep activity stats */
 	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
+	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
@@ -309,6 +310,12 @@ enum {
 	 */
 	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
 
+	/* When the LPM policy is set to ATA_LPM_MAX_POWER, there might
+	 * be a spurious PHY event, so ignore the first PHY event that
+	 * occurs within 10s after the policy change.
+	 */
+	ATA_TMOUT_SPURIOUS_PHY	= 10000,
+
 	/* ATA bus states */
 	BUS_UNKNOWN		= 0,
 	BUS_DMA			= 1,
@@ -788,6 +795,8 @@ struct ata_link {
 	struct ata_eh_context	eh_context;
 
 	struct ata_device	device[ATA_MAX_DEVICES];
+
+	unsigned long		last_lpm_change; /* when last LPM change happened */
 };
 #define ATA_LINK_CLEAR_BEGIN		offsetof(struct ata_link, active_tag)
 #define ATA_LINK_CLEAR_END		offsetof(struct ata_link, device[0])
-- 
2.1.4

