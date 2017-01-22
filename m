From: Darren Stevens <darren@stevens-zone.net>
Subject: [PATCH v2] libata-sff: Don't scan disabled ports when checking for
 legacy mode.
Date: Sun, 22 Jan 2017 19:34:30 +0000 (GMT)
Message-ID: <4978ca2860b.2931a5b8@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="--=_BOUNDARY.6e32c83044f66f54.18"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54574 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdAVTk6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2017 14:40:58 -0500
Received: from mintppc.lan ([86.156.215.177]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.163]) with ESMTPA (Nemesis) id 0Lwioi-1cTR1y0OZU-016MaN
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

----=_BOUNDARY.6e32c83044f66f54.18
Content-Type: text/plain

libata-sff.c checks for legacy mode by testing if both primary
and secondary ports on a controller are in legacy mode and selects
legacy if either one is. However on some southbridge chips (e.g
AMD SB600/SB700) the secondary port is not wired, and when it is 
disabled by setting the disable bit in the PCI header it appears
as a fixed legacy port.
Prevent incorrect detection by not testing ports that are marked
as 'dummy'

Signed-off-by: Darren Stevens <darren@stevens-zone.net>
---

 v2: Changed to using 2 if statements instead of binary logic

----=_BOUNDARY.6e32c83044f66f54.18
Content-Type: text/plain;
	name="libata.patch"
Content-Disposition: attachment;
	filename="libata.patch";
	size=992

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 051b615..09bed5d 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2427,11 +2427,21 @@ int ata_pci_sff_activate_host(struct ata_host *host,
 		return rc;
 
 	if ((pdev->class >> 8) == PCI_CLASS_STORAGE_IDE) {
-		u8 tmp8, mask;
+		u8 tmp8, mask = 0;
 
-		/* TODO: What if one channel is in native mode ... */
+		/*
+		 * ATA spec says we should use legacy mode when one
+		 * port is in legacy mode, but disabled ports on some
+		 * PCI hosts appear as fixed legacy ports, e.g SB600/700
+		 * on which the secondary port is not wired, so
+		 * ignore ports that are marked as 'dummy' during
+		 * this check
+		 */
 		pci_read_config_byte(pdev, PCI_CLASS_PROG, &tmp8);
-		mask = (1 << 2) | (1 << 0);
+		if (! ata_port_is_dummy(host->ports[1]))
+			mask = mask | (1 << 2);
+		if (! ata_port_is_dummy(host->ports[0]))
+			mask = mask | (1 << 0);
 		if ((tmp8 & mask) != mask)
 			legacy_mode = 1;
 	}

----=_BOUNDARY.6e32c83044f66f54.18--


