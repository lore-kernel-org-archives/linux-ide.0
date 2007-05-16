From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ide/pci/serverworks.c: Fix corruption/timeouts with MegaIDE
 in RAID mode
Date: Wed, 16 May 2007 13:37:15 +0100
Message-ID: <20070516133715.23194a96@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59376 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758419AbXEPMcq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 08:32:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, bzolnier@gmail.com

It turns out from customer reports to Red Hat and some PCI dumps that the
MegaIDE in RAID mode doesn't provide the drive tuning data that the
serverworks driver expects but sometimes does provide something that
fools the code.

For the RAID class case skip the oem setup and don't trust the BIOS data.
We then tune from scratch and this sorts it out. (This has been confirmed
on an afflicted IBM blade)

[libata serverworks.c never trusts the BIOS in the first place so is
accidentally immune]

Signed-off-by: Alan Cox <alan@redhat.com>

--- drivers/ide/pci/serverworks.c~	2007-05-16 13:10:16.428324088 +0100
+++ drivers/ide/pci/serverworks.c	2007-05-16 13:10:16.428324088 +0100
@@ -158,6 +158,12 @@
 	pci_read_config_word(dev, 0x4A, &csb5_pio);
 	pci_read_config_byte(dev, 0x54, &ultra_enable);
 
+	/* If we are in RAID mode (eg AMI MegaIDE) then we can't it
+	   turns out trust the firmware configuration */
+
+	if ((dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
+		goto oem_setup_failed;
+
 	/* Per Specified Design by OEM, and ASIC Architect */
 	if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE) ||
 	    (dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2)) {
