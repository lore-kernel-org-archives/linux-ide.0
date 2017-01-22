From: Darren Stevens <darren@stevens-zone.net>
Subject: [PATCH v2] libata:pata_atiixp: Don't use unconnected secondary
 port on SB600/SB700
Date: Sun, 22 Jan 2017 19:37:03 +0000 (GMT)
Message-ID: <4978cadcbc.52dc8905@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_BOUNDARY.6e32c8306ded2586.4f"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63808 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdAVTk5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2017 14:40:57 -0500
Received: from mintppc.lan ([86.156.215.177]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.163]) with ESMTPA (Nemesis) id 0M0Y1e-1cFdVY2OEQ-00upTV
 for <linux-ide@vger.kernel.org>; Sun, 22 Jan 2017 20:40:54 +0100
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

----=_BOUNDARY.6e32c8306ded2586.4f
Content-Type: text/plain

The SB600 and SB700 southbridge chips from ATI/AMD only have
connections for the primary IDE port. As these chips have unique
pci device ID's use these to mark the secondary port as 'dummy'

Signed-off-by: Darren Stevens <darren@stevens-zone.net>
---

 v2: Moved comment to a more sensible place. No functional changes.
----=_BOUNDARY.6e32c8306ded2586.4f
Content-Type: text/plain;
	name="ati_ata.patch"
Content-Disposition: attachment;
	filename="ati_ata.patch";
	size=620

diff --git a/drivers/ata/pata_atiixp.c b/drivers/ata/pata_atiixp.c
index 49d705c..83c158b 100644
--- a/drivers/ata/pata_atiixp.c
+++ b/drivers/ata/pata_atiixp.c
@@ -278,6 +278,11 @@ static int atiixp_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	};
 	const struct ata_port_info *ppi[] = { &info, &info };
 
+	/* SB600/700 don't have secondary port wired */
+	if ((pdev->device == PCI_DEVICE_ID_ATI_IXP600_IDE) ||
+		(pdev->device == PCI_DEVICE_ID_ATI_IXP700_IDE))
+		ppi[1] = &ata_dummy_port_info;
+
 	return ata_pci_bmdma_init_one(pdev, ppi, &atiixp_sht, NULL,
 				      ATA_HOST_PARALLEL_SCAN);
 }

----=_BOUNDARY.6e32c8306ded2586.4f--


