From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 04/10] sata: hardreset: retry if phys link is down
Date: Fri, 13 Jan 2017 13:37:58 +0100
Message-ID: <1484311084-31547-5-git-send-email-bgolaszewski@baylibre.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The sata core driver already retries to resume the link because some
controllers ignore writes to the SControl register.

We have a use case with the da850 SATA controller where at PLL0
frequency of 456MHz (needed to properly service the LCD controller)
the chip becomes unstable and the hardreset operation is ignored the
first time 50% of times.

Retrying just the resume operation doesn't work - we need to issue
the phy/wake reset again to make it work.

If ata_phys_link_offline() returns true in sata_link_hardreset(),
retry a couple times before really giving up.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/ata/libata-core.c | 16 ++++++++++++----
 include/linux/libata.h    |  4 +++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9cd0a2d..3b848a3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3985,8 +3985,8 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 			unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *))
 {
+	int rc, retry = ATA_LINK_RESET_TRIES;
 	u32 scontrol;
-	int rc;
 
 	DPRINTK("ENTER\n");
 
@@ -4009,7 +4009,7 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 
 		sata_set_spd(link);
 	}
-
+retry:
 	/* issue phy wake/reset */
 	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
 		goto out;
@@ -4028,9 +4028,17 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	rc = sata_link_resume(link, timing, deadline);
 	if (rc)
 		goto out;
-	/* if link is offline nothing more to do */
-	if (ata_phys_link_offline(link))
+
+	if (ata_phys_link_offline(link)) {
+		if (retry--) {
+			ata_link_warn(link,
+				      "link still offline after hardreset - retrying\n");
+			goto retry;
+		}
+
+		/* if link is still offline nothing more to do */
 		goto out;
+	}
 
 	/* Link is online.  From this point, -ENODEV too is an error. */
 	if (online)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c170be5..2c840c0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -392,8 +392,10 @@ enum {
 	/* max tries if error condition is still set after ->error_handler */
 	ATA_EH_MAX_TRIES	= 5,
 
-	/* sometimes resuming a link requires several retries */
+	/* sometimes resuming a link requires several retries... */
 	ATA_LINK_RESUME_TRIES	= 5,
+	/* ... and sometimes we need to retry the whole reset procedure */
+	ATA_LINK_RESET_TRIES	= 5,
 
 	/* how hard are we gonna try to probe/recover devices */
 	ATA_PROBE_MAX_TRIES	= 3,
-- 
2.9.3
