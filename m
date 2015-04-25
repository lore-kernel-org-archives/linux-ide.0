From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v2 2/2] libata: Ignore spurious PHY event on LPM policy change
Date: Sat, 25 Apr 2015 19:52:37 +0200
Message-ID: <1429984357-2223-3-git-send-email-gabriele.mzt@gmail.com>
References: <1429984357-2223-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429984357-2223-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-ide@vger.kernel.org

When the LPM policy is set to ATA_LPM_MAX_POWER, the device might
generate a spurious PHY event that cuases errors on the link.
Ignore this event if it occured within 10s after the policy change.

The timeout was chosen observing that on a Dell XPS13 9333 these
spurious events can occur up to roughly 6s after the policy change.

Link: http://lkml.kernel.org/g/3352987.ugV1Ipy7Z5@xps13
Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/ata/libata-core.c | 15 ++++++++++++++-
 drivers/ata/libata-eh.c   |  3 +++
 include/linux/libata.h    |  9 +++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 12adcf7..85e6599 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6766,8 +6766,21 @@ u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask, u32 val,
  */
 bool sata_lpm_ignore_phy_events(struct ata_link *link)
 {
+	unsigned long lpm_timeout = link->last_lpm_change +
+				    msecs_to_jiffies(ATA_TMOUT_SPURIOUS_PHY);
+
 	/* if LPM is enabled, PHYRDY doesn't mean anything */
-	return !!(link->lpm_policy > ATA_LPM_MAX_POWER);
+	if (link->lpm_policy > ATA_LPM_MAX_POWER)
+		return true;
+
+	/* ignore the first PHY event after the LPM policy changed
+	 * as it is might be spurious
+	 */
+	if ((link->flags & ATA_LFLAG_CHANGED) &&
+	    time_before(jiffies, lpm_timeout))
+		return true;
+
+	return false;
 }
 EXPORT_SYMBOL_GPL(sata_lpm_ignore_phy_events);
 
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
index 6138d87..28aeae4 100644
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
