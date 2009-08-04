From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: add workaround for on-board 5723s on
 some gigabyte boards
Date: Tue, 04 Aug 2009 14:30:08 +0900
Message-ID: <4A77C760.1010300@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55156 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596AbZHDFad (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 01:30:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>, Nicolas.Mailhot@LaPoste.net, marcbowes@gmail.com, Andrew Morton <akpm@linux-foundation.org>

Some gigabytes have on-board SIMG5723s connected to JMB ahcis.  These
are used to implement hardware raid.  Unfortunately some firmware
revisions on these 5723s don't bring the link down when all the
downstream ports are unoccupied while not responding to reset protocol
which makes libata think that there's device attached to the port but
is not responding and retry.  This results in painfully wrong boot
detection time for these ports when they're empty.

This patch quirks those boards such that ahci gives up after the
initial timeout.  Combined with parallel probing, this gives quick
enough probing and also is safe because SIMG5723 will respond to the
first try if any of the downstream ports is occupied.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Marc Bowes <marcbowes@gmail.com>
Reported-by: Nicolas Mailhot <Nicolas.Mailhot@LaPoste.net>
---
 drivers/ata/ahci.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 958c1fa..49317f6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -219,6 +219,8 @@ enum {
 	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
 	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */
 	AHCI_HFLAG_NO_SUSPEND		= (1 << 10), /* don't suspend */
+	AHCI_HFLAG_SRST_TOUT_IS_OFFLINE	= (1 << 11), /* treat SRST timeout as
+							link offline */
 
 	/* ap->flags bits */
 
@@ -1663,6 +1665,7 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 			     int (*check_ready)(struct ata_link *link))
 {
 	struct ata_port *ap = link->ap;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	const char *reason = NULL;
 	unsigned long now, msecs;
 	struct ata_taskfile tf;
@@ -1701,12 +1704,21 @@ static int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 
 	/* wait for link to become ready */
 	rc = ata_wait_after_reset(link, deadline, check_ready);
-	/* link occupied, -ENODEV too is an error */
-	if (rc) {
+	if (rc == -EBUSY && hpriv->flags & AHCI_HFLAG_SRST_TOUT_IS_OFFLINE) {
+		/*
+		 * Workaround for cases where link online status can't
+		 * be trusted.  Treat device readiness timeout as link
+		 * offline.
+		 */
+		ata_link_printk(link, KERN_INFO,
+				"device not ready, treating as offline\n");
+		*class = ATA_DEV_NONE;
+	} else if (rc) {
+		/* link occupied, -ENODEV too is an error */
 		reason = "device not ready";
 		goto fail;
-	}
-	*class = ahci_dev_classify(ap);
+	} else
+		*class = ahci_dev_classify(ap);
 
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
@@ -2726,6 +2738,56 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 	return !ver || strcmp(ver, dmi->driver_data) < 0;
 }
 
+static bool ahci_broken_online(struct pci_dev *pdev)
+{
+#define ENCODE_BUSDEVFN(bus, slot, func)			\
+	(void *)(unsigned long)(((bus) << 8) | PCI_DEVFN((slot), (func)))
+	static const struct dmi_system_id sysids[] = {
+		/*
+		 * There are several gigabyte boards which use
+		 * SIMG5723s configured as hardware RAID.  Certain
+		 * 5723 firmware revisions shipped there keep the link
+		 * online but fail to answer properly to SRST or
+		 * IDENTIFY when no device is attached downstream
+		 * causing libata to retry quite a few times leading
+		 * to excessive detection delay.
+		 *
+		 * As these firmwares respond to the second reset try
+		 * with invalid device signature, considering unknown
+		 * sig as offline works around the problem acceptably.
+		 */
+		{
+			.ident = "EP45-DQ6",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "Gigabyte Technology Co., Ltd."),
+				DMI_MATCH(DMI_BOARD_NAME, "EP45-DQ6"),
+			},
+			.driver_data = ENCODE_BUSDEVFN(0x0a, 0x00, 0),
+		},
+		{
+			.ident = "EP45-DS5",
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR,
+					  "Gigabyte Technology Co., Ltd."),
+				DMI_MATCH(DMI_BOARD_NAME, "EP45-DS5"),
+			},
+			.driver_data = ENCODE_BUSDEVFN(0x03, 0x00, 0),
+		},
+		{ }	/* terminate list */
+	};
+#undef ENCODE_BUSDEVFN
+	const struct dmi_system_id *dmi = dmi_first_match(sysids);
+	unsigned int val;
+
+	if (!dmi)
+		return false;
+
+	val = (unsigned long)dmi->driver_data;
+
+	return pdev->bus->number == (val >> 8) && pdev->devfn == (val & 0xff);
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -2841,6 +2903,12 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   "BIOS update required for suspend/resume\n");
 	}
 
+	if (ahci_broken_online(pdev)) {
+		hpriv->flags |= AHCI_HFLAG_SRST_TOUT_IS_OFFLINE;
+		dev_info(&pdev->dev,
+			 "online status unreliable, applying workaround\n");
+	}
+
 	/* CAP.NP sometimes indicate the index of the last enabled
 	 * port, at other times, that of the last possible port, so
 	 * determining the maximum port number requires looking at

