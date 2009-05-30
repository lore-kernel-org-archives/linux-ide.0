From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: add warning messages for hp laptops
 with broken suspend
Date: Sat, 30 May 2009 20:50:12 +0900
Message-ID: <4A211D74.5070208@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40926 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756567AbZE3Lvd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 May 2009 07:51:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
Cc: kernel.org@epperson.homelinux.net, emisca@gmail.com, Gadi Cohen <dragon@wastelands.net>, Paul Swanson <paul@procursa.com>, s@ourada.org, Trevor Davenport <trevor.davenport@gmail.com>, corruptor1972 <steven_tierney@yahoo.co.uk>, Victoria Wilson <mail@vwilson.co.uk>, khiraly <khiraly.list@gmail.com>, Sean <wollombi@gmail.com>

Harddisks on HP dv[4-6] and HDX18 fail to come online after resume on
earlier BIOSen.  Fortunately, HP recently released BIOS updates for
all machines to fix the issue.  Detect old BIOSen, warn the user to
update BIOS on boot and suspend attempts and fail suspend.

Kudos to all the bug reporters.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: kernel.org@epperson.homelinux.net
Cc: emisca@gmail.com
Cc: Gadi Cohen <dragon@wastelands.net>
Cc: Paul Swanson <paul@procursa.com>
Cc: s@ourada.org
Cc: Trevor Davenport <trevor.davenport@gmail.com>
Cc: corruptor1972 <steven_tierney@yahoo.co.uk>
Cc: Victoria Wilson <mail@vwilson.co.uk>
Cc: khiraly <khiraly.list@gmail.com>
Cc: Sean <wollombi@gmail.com>
---
 drivers/ata/ahci.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 08186ec..6b91c26 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -220,6 +220,7 @@ enum {
 	AHCI_HFLAG_NO_HOTPLUG		= (1 << 7), /* ignore PxSERR.DIAG.N */
 	AHCI_HFLAG_SECT255		= (1 << 8), /* max 255 sectors */
 	AHCI_HFLAG_YES_NCQ		= (1 << 9), /* force NCQ cap on */
+	AHCI_HFLAG_NO_SUSPEND		= (1 << 10), /* don't suspend */
 
 	/* ap->flags bits */
 
@@ -2316,9 +2317,17 @@ static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = host->iomap[AHCI_PCI_BAR];
 	u32 ctl;
 
+	if (mesg.event & PM_EVENT_SUSPEND &&
+	    hpriv->flags & AHCI_HFLAG_NO_SUSPEND) {
+		dev_printk(KERN_ERR, &pdev->dev,
+			   "BIOS update required for suspend/resume\n");
+		return -EIO;
+	}
+
 	if (mesg.event & PM_EVENT_SLEEP) {
 		/* AHCI spec rev1.1 section 8.3.3:
 		 * Software must disable interrupts prior to requesting a
@@ -2610,6 +2619,63 @@ static bool ahci_broken_system_poweroff(struct pci_dev *pdev)
 	return false;
 }
 
+static bool ahci_broken_suspend(struct pci_dev *pdev)
+{
+	static const struct dmi_system_id sysids[] = {
+		/*
+		 * On HP dv[4-6] and HDX18 with earlier BIOSen, link
+		 * to the harddisk doesn't become online after
+		 * resuming from STR.  Warn and fail suspend.
+		 */
+		{
+			.ident = "dv4",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+				DMI_MATCH(DMI_PRODUCT_NAME,
+					  "HP Pavilion dv4 Notebook PC"),
+			},
+			.driver_data = "F.30", /* cutoff BIOS version */
+		},
+		{
+			.ident = "dv5",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+				DMI_MATCH(DMI_PRODUCT_NAME,
+					  "HP Pavilion dv5 Notebook PC"),
+			},
+			.driver_data = "F.16", /* cutoff BIOS version */
+		},
+		{
+			.ident = "dv6",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+				DMI_MATCH(DMI_PRODUCT_NAME,
+					  "HP Pavilion dv6 Notebook PC"),
+			},
+			.driver_data = "F.21",	/* cutoff BIOS version */
+		},
+		{
+			.ident = "HDX18",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+				DMI_MATCH(DMI_PRODUCT_NAME,
+					  "HP HDX18 Notebook PC"),
+			},
+			.driver_data = "F.23",	/* cutoff BIOS version */
+		},
+		{ }	/* terminate list */
+	};
+	const struct dmi_system_id *dmi = dmi_first_match(sysids);
+	const char *ver;
+
+	if (!dmi || pdev->bus->number || pdev->devfn != PCI_DEVFN(0x1f, 2))
+		return false;
+
+	ver = dmi_get_system_info(DMI_BIOS_VERSION);
+
+	return !ver || strcmp(ver, dmi->driver_data) < 0;
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -2715,6 +2781,12 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			"quirky BIOS, skipping spindown on poweroff\n");
 	}
 
+	if (ahci_broken_suspend(pdev)) {
+		hpriv->flags |= AHCI_HFLAG_NO_SUSPEND;
+		dev_printk(KERN_WARNING, &pdev->dev,
+			   "BIOS update required for suspend/resume\n");
+	}
+
 	/* CAP.NP sometimes indicate the index of the last enabled
 	 * port, at other times, that of the last possible port, so
 	 * determining the maximum port number requires looking at
