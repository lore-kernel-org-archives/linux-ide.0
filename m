From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCH] 2.6.x libata update
Date: Wed, 12 Jan 2005 01:34:04 -0500
Message-ID: <41E4C4DC.3070901@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060109020200040804000902"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25480 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261256AbVALGeX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Jan 2005 01:34:23 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060109020200040804000902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------060109020200040804000902
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/sata_sil.c |    2 ++
 1 files changed, 2 insertions(+)

through these ChangeSets:

<fli@ati.com> (05/01/12 1.2504)
   [libata sata_sil] support ATI IXP300/IXP400 SATA


--------------060109020200040804000902
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-01-12 01:07:04 -05:00
+++ b/drivers/scsi/sata_sil.c	2005-01-12 01:07:04 -05:00
@@ -71,6 +71,8 @@
 	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
+	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ }	/* terminate list */
 };
 

--------------060109020200040804000902--
