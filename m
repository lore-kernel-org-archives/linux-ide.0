From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 10/24] ahci: Ensure that we don't grab both functions
Date: Tue, 4 Jul 2006 18:14:56 +0000 (UTC)
Message-ID: <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361102106-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036111326-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361121401-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361123190-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48270 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932308AbWGDSO3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:29 -0400
Date: Maw, 04 Gor 2006 19:01:34 +0100
In-Reply-To: <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

When we force the chip into dual fn mode so we get PATA and AHCI we must
be sure we don't then do anything dumb like try and grab both with the AHCI
driver.

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/ahci.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

6241745ff9aab30eb502b2da46d8cbaaad22716d
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index f059467..1edfade 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1323,6 +1323,17 @@ static int ahci_init_one (struct pci_dev
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	/* JMicron-specific fixup: make sure we're in AHCI mode */
+	/* This is protected from races with ata_jmicron by the pci probe
+	   locking */
+	if (pdev->vendor == PCI_VENDOR_ID_JMICRON) {
+		/* AHCI enable, AHCI on function 0 */
+		pci_write_config_byte(pdev, 0x41, 0xa1);
+		/* Function 1 is the PATA controller */
+		if (PCI_FUNC(pdev->devfn))
+			return -ENODEV;
+	}
+
 	rc = pci_enable_device(pdev);
 	if (rc)
 		return rc;
@@ -1378,10 +1389,6 @@ static int ahci_init_one (struct pci_dev
 	if (have_msi)
 		hpriv->flags |= AHCI_FLAG_MSI;
 
-	/* JMicron-specific fixup: make sure we're in AHCI mode */
-	if (pdev->vendor == 0x197b)
-		pci_write_config_byte(pdev, 0x41, 0xa1);
-
 	/* initialize adapter */
 	rc = ahci_host_init(probe_ent);
 	if (rc)
-- 
1.2.GIT

