From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 4/4] libata: skip debounce delay on link resume
Date: Thu,  7 Jan 2016 16:03:33 -0800
Message-ID: <1452211413-1350-5-git-send-email-f.fainelli@gmail.com>
References: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452211413-1350-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, computersforpeace@gmail.com, gregory.0xf0@gmail.com, Danesh Petigara <dpetigara@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-ide@vger.kernel.org

From: Danesh Petigara <dpetigara@broadcom.com>

The link resume logic uses a 200msec delay while debouncing
the SControl register. The rationale behind that delay is
to accommodate some PHYs that behave badly if their SStatus/
SControl registers are pounded immediately on resume.
The Broadcom STB SATA PHY does not seem to have this issue.
This patch introduces a new link flag that allows platforms
to skip the debounce delay if it isn't needed.

Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/ata/ahci_brcmstb.c | 1 +
 drivers/ata/libata-core.c  | 3 ++-
 include/linux/libata.h     | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
index e518a992e774..9d57a27944bc 100644
--- a/drivers/ata/ahci_brcmstb.c
+++ b/drivers/ata/ahci_brcmstb.c
@@ -86,6 +86,7 @@ struct brcm_ahci_priv {
 static const struct ata_port_info ahci_brcm_port_info = {
 	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
 	.flags2		= ATA_FLAG2_WAKE_BEFORE_STOP,
+	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_platform_ops,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c6117e1ad373..b7b578522a13 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3597,7 +3597,8 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		 * immediately after resuming.  Delay 200ms before
 		 * debouncing.
 		 */
-		ata_msleep(link->ap, 200);
+		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
+			ata_msleep(link->ap, 200);
 
 		/* is SControl restored correctly? */
 		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f278ca897274..e8b1759ff855 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -205,6 +205,7 @@ enum {
 	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
 	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
+	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
-- 
2.1.0
