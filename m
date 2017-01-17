From: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 09/14] sata: ahci: export ahci_do_hardreset() locally
Date: Tue, 17 Jan 2017 13:26:11 +0100
Message-ID: <1484655976-25382-10-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484655976-25382-1-git-send-email-bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

We need a way to retrieve the information about the online state of
the link in the ahci-da850 driver.

Create a new function: ahci_do_hardreset() which is called from
ahci_hardreset() for backwards compatibility, but has an additional
argument: 'online' - which can be used to check if the link is online
after this function returns.

The new routine will be used in the ahci-da850 driver to avoid code
duplication when implementing a workaround for tha da850 SATA
controller quirk/instability.

Signed-off-by: Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/ata/ahci.h    |  3 +++
 drivers/ata/libahci.c | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0cc08f8..5db6ab2 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -398,6 +398,9 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 		      int pmp, unsigned long deadline,
 		      int (*check_ready)(struct ata_link *link));
 
+int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
+		      unsigned long deadline, bool *online);
+
 unsigned int ahci_qc_issue(struct ata_queued_cmd *qc);
 int ahci_stop_engine(struct ata_port *ap);
 void ahci_start_fis_rx(struct ata_port *ap);
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ee7db31..3159f9e 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1519,8 +1519,8 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
 	return rc;
 }
 
-static int ahci_hardreset(struct ata_link *link, unsigned int *class,
-			  unsigned long deadline)
+int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
+		      unsigned long deadline, bool *online)
 {
 	const unsigned long *timing = sata_ehc_deb_timing(&link->eh_context);
 	struct ata_port *ap = link->ap;
@@ -1528,7 +1528,6 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
 	struct ata_taskfile tf;
-	bool online;
 	int rc;
 
 	DPRINTK("ENTER\n");
@@ -1540,17 +1539,26 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
-	rc = sata_link_hardreset(link, timing, deadline, &online,
+	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 
 	hpriv->start_engine(ap);
 
-	if (online)
+	if (*online)
 		*class = ahci_dev_classify(ap);
 
 	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ahci_do_hardreset);
+
+static int ahci_hardreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline)
+{
+	bool online;
+
+	return ahci_do_hardreset(link, class, deadline, &online);
+}
 
 static void ahci_postreset(struct ata_link *link, unsigned int *class)
 {
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
