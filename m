From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v3.14-rc3
Date: Thu, 20 Feb 2014 09:25:52 -0500
Message-ID: <20140220142552.GC6897@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:63681 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978AbaBTOZ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Feb 2014 09:25:56 -0500
Received: by mail-qc0-f181.google.com with SMTP id c9so3013451qcz.12
        for <linux-ide@vger.kernel.org>; Thu, 20 Feb 2014 06:25:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org

Hello, Linus.

Various device specific fixes.  Nothing too interesting; however,
pulling this in will create the following merge conflict in
drivers/sata_mv.c

		if (IS_ERR(hpriv->port_phys[port])) {
			rc = PTR_ERR(hpriv->port_phys[port]);
			hpriv->port_phys[port] = NULL;
<<<<<<< HEAD
			if (rc != -EPROBE_DEFER)
				dev_warn(&pdev->dev, "error getting phy %d",
					rc);
=======
			if ((rc != -EPROBE_DEFER) && (rc != -ENODEV))
				dev_warn(&pdev->dev, "error getting phy");

			/* Cleanup only the initialized ports */
			hpriv->n_ports = port;
>>>>>>> 67809f85d31eac600f6b28defa5386c9d2a13b1d
			goto err;
		} else
			phy_power_on(hpriv->port_phys[port]);

This is between the following two commits.

90aa2997029f ("ata: sata_mv: Fix probe failures with optional phys")
8ad116e649b2 ("ata: sata_mv: Cleanup only the initialized ports")

The former one got routed with other phy changes and conflicts with
the latter one which was applied to libata/for-3.14-fixes.  The
conflict is a context one.  The two changes need to be combined like
the following.

		if (IS_ERR(hpriv->port_phys[port])) {
			rc = PTR_ERR(hpriv->port_phys[port]);
			hpriv->port_phys[port] = NULL;
			if (rc != -EPROBE_DEFER)
				dev_warn(&pdev->dev, "error getting phy %d",
					rc);

			/* Cleanup only the initialized ports */
			hpriv->n_ports = port;
			goto err;
		} else
			phy_power_on(hpriv->port_phys[port]);

An example merge is available in the following git branch.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git test-merge-for-3.14-fixes

The following changes since commit 0e47c969c65e213421450c31043353ebe3c67e0c:

  Merge tag 'for-linus-20140127' of git://git.infradead.org/linux-mtd (2014-01-28 18:56:37 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-3.14-fixes

for you to fetch changes up to 67809f85d31eac600f6b28defa5386c9d2a13b1d:

  ahci: disable NCQ on Samsung pci-e SSDs on macbooks (2014-02-18 10:22:17 -0500)

Thanks.

----------------------------------------------------------------
Andrew Lunn (1):
      ATA: SATA_MV: Add missing Kconfig select statememnt

Denis V. Lunev (1):
      ata: enable quirk from jmicron JMB350 for JMB394

Ezequiel Garcia (1):
      ata: sata_mv: Cleanup only the initialized ports

Fabio Estevam (1):
      ata: pata_imx: Check the return value from clk_prepare_enable()

Levente Kurusa (1):
      ahci: disable NCQ on Samsung pci-e SSDs on macbooks

Tejun Heo (1):
      sata_sil: apply MOD15WRITE quirk to TOSHIBA MK2561GSYN

 drivers/ata/Kconfig      |  1 +
 drivers/ata/ahci.c       | 14 ++++++++++++++
 drivers/ata/libata-pmp.c |  7 +++++--
 drivers/ata/pata_imx.c   |  8 ++++++--
 drivers/ata/sata_mv.c    |  9 +++++++--
 drivers/ata/sata_sil.c   |  1 +
 6 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4e73772..868429a 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -247,6 +247,7 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
+	select GENERIC_PHY
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] PCI(-X) chips,
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index dc2756f..7df81576 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -61,6 +61,7 @@ enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
 	board_ahci_ign_iferr,
+	board_ahci_noncq,
 	board_ahci_nosntf,
 	board_ahci_yes_fbs,
 
@@ -121,6 +122,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_noncq] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_NO_NCQ),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_nosntf] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_SNTF),
 		.flags		= AHCI_FLAG_COMMON,
@@ -452,6 +460,12 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
 	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
 
+	/*
+	 * Samsung SSDs found on some macbooks.  NCQ times out.
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=60731
+	 */
+	{ PCI_VDEVICE(SAMSUNG, 0x1600), board_ahci_noncq },
+
 	/* Enmotus */
 	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
 
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 20fd337..7ccc084 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -447,8 +447,11 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |= ATA_LFLAG_NO_RETRY;
-	} else if (vendor == 0x197b && devid == 0x2352) {
-		/* chip found in Thermaltake BlackX Duet, jmicron JMB350? */
+	} else if (vendor == 0x197b && (devid == 0x2352 || devid == 0x0325)) {
+		/*
+		 * 0x2352: found in Thermaltake BlackX Duet, jmicron JMB350?
+		 * 0x0325: jmicron JMB394.
+		 */
 		ata_for_each_link(link, ap, EDGE) {
 			/* SRST breaks detection and disks get misclassified
 			 * LPM disabled to avoid potential problems
diff --git a/drivers/ata/pata_imx.c b/drivers/ata/pata_imx.c
index 26386f0..b0b18ec 100644
--- a/drivers/ata/pata_imx.c
+++ b/drivers/ata/pata_imx.c
@@ -119,7 +119,9 @@ static int pata_imx_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->clk);
 	}
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host) {
@@ -212,7 +214,9 @@ static int pata_imx_resume(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	struct pata_imx_priv *priv = host->private_data;
 
-	clk_prepare_enable(priv->clk);
+	int ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	__raw_writel(priv->ata_ctl, priv->host_regs + PATA_IMX_ATA_CONTROL);
 
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 20a7517..9c1a11d 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4104,7 +4104,6 @@ static int mv_platform_probe(struct platform_device *pdev)
 	if (!hpriv->port_phys)
 		return -ENOMEM;
 	host->private_data = hpriv;
-	hpriv->n_ports = n_ports;
 	hpriv->board_idx = chip_soc;
 
 	host->iomap = NULL;
@@ -4132,11 +4131,17 @@ static int mv_platform_probe(struct platform_device *pdev)
 			hpriv->port_phys[port] = NULL;
 			if ((rc != -EPROBE_DEFER) && (rc != -ENODEV))
 				dev_warn(&pdev->dev, "error getting phy");
+
+			/* Cleanup only the initialized ports */
+			hpriv->n_ports = port;
 			goto err;
 		} else
 			phy_power_on(hpriv->port_phys[port]);
 	}
 
+	/* All the ports have been initialized */
+	hpriv->n_ports = n_ports;
+
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
@@ -4174,7 +4179,7 @@ err:
 		clk_disable_unprepare(hpriv->clk);
 		clk_put(hpriv->clk);
 	}
-	for (port = 0; port < n_ports; port++) {
+	for (port = 0; port < hpriv->n_ports; port++) {
 		if (!IS_ERR(hpriv->port_clks[port])) {
 			clk_disable_unprepare(hpriv->port_clks[port]);
 			clk_put(hpriv->port_clks[port]);
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index d67fc35..b7695e8 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -157,6 +157,7 @@ static const struct sil_drivelist {
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
+	{ "TOSHIBA MK2561GSYN",	SIL_QUIRK_MOD15WRITE },
 	{ "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
 	{ }
 };
