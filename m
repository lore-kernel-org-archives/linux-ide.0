From: Jeff Garzik <jgarzik@pobox.com>
Subject: [BK PATCHES] 2.6.x libata update
Date: Thu, 27 Jan 2005 18:44:19 -0500
Message-ID: <41F97CD3.6060007@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030705090508090006090306"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55682 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261299AbVA0Xod (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jan 2005 18:44:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030705090508090006090306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

update driver blacklist, and add a couple PCI IDs.

--------------030705090508090006090306
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/libata-2.6

This will update the following files:

 drivers/scsi/ahci.c     |    4 ++++
 drivers/scsi/sata_sil.c |    1 +
 2 files changed, 5 insertions(+)

through these ChangeSets:

<jason.d.gaston@intel.com> (05/01/27 1.2142)
   [PATCH] SATA AHCI support for Intel ICH7R
   
   This patch adds the Intel ICH7R DID's to the ahci.c SATA AHCI driver
   for ICH7R SATA support.
   
   Signed-off-by:  Jason Gaston <Jason.d.gaston@intel.com>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<haroldo.gamal@infolink.com.br> (05/01/27 1.2141)
   [libata sata_sil] add another Seagate driver to blacklist


--------------030705090508090006090306
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c	2005-01-27 18:42:36 -05:00
+++ b/drivers/scsi/ahci.c	2005-01-27 18:42:36 -05:00
@@ -246,6 +246,10 @@
 	  board_ahci }, /* ICH7 */
 	{ PCI_VENDOR_ID_INTEL, 0x27c5, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7M */
+	{ PCI_VENDOR_ID_INTEL, 0x27c2, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7R */
+	{ PCI_VENDOR_ID_INTEL, 0x27c3, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* ICH7R */
 	{ }	/* terminate list */
 };
 
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2005-01-27 18:42:36 -05:00
+++ b/drivers/scsi/sata_sil.c	2005-01-27 18:42:36 -05:00
@@ -90,6 +90,7 @@
 	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST3120026AS",	SIL_QUIRK_MOD15WRITE },
+	{ "ST3200822AS",	SIL_QUIRK_MOD15WRITE },
 	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
 	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },

--------------030705090508090006090306--
