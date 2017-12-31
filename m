From: Darren Stevens <darren@stevens-zone.net>
Subject: [PATCH] libata:pata_atiixp: Don't use unconnected secondary port
 on SB600
Date: Sun, 31 Dec 2017 21:11:05 +0000 (GMT)
Message-ID: <4b3d1364126.4c1d107e@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_BOUNDARY.6c368940385b1c2e.63"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:65443 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdLaWQx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 31 Dec 2017 17:16:53 -0500
Received: from [127.0.0.1] ([86.161.101.150]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.179]) with ESMTPA (Nemesis) id 0MANKs-1ectj71RJi-00BbWI
 for <linux-ide@vger.kernel.org>; Sun, 31 Dec 2017 23:16:51 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Warning: This is a message in MIME format. Your mail reader does
not support MIME. Some parts of this message will be readable as
plain text. To see the rest, you will need to upgrade your mail
reader. Following are some URLs where you can find MIME-capable
mail programs for common platforms:

  AmigaOS...........: http://yam.ch/
  Unix/MacOS/Windows: http://www.mozilla.com/thunderbird/

General information about MIME can be found at:
http://en.wikipedia.org/wiki/MIME

----=_BOUNDARY.6c368940385b1c2e.63
Content-Type: text/plain

    The AMD SB600 southbridge has an PATA IDE interface, but the
    secondary port has no physical connections, so is disabled in
    the PCI header which makes it appear as a legacy port.
    
    On most systems this causes no trouble, but the Amigaone X1000 has
    an SB600 connected to a PowerPC SoC PCI-e root port, with an
    emulated ISA bus. On this system a kernel panic occurs at boot
    time during device attach for the secondary port.
    
    Mark the port as 'dummy' to prevent this. As a bonus, disabling
    this will slightly speed up booting on PC systems using an
    SB600 as they will now skip 2 known empty ports.
    
    Signed-off-by: Darren Stevens <Darren@stevens-zone.net>

---
----=_BOUNDARY.6c368940385b1c2e.63
Content-Type: text/plain;
	name="ati.patch"
Content-Disposition: attachment;
	filename="ati.patch";
	size=564

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 49d705c..4d49fd3 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -278,6 +278,10 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	const struct ata_port_info *ppi[] = { &info, &info };
 
+	/* SB600 doesn't have secondary port wired */
+	if((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE))
+		ppi[1] = &ata_dummy_port_info;
+
 	return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
 				      ATA_HOST_PARALLEL_SCAN);
 }

----=_BOUNDARY.6c368940385b1c2e.63--


