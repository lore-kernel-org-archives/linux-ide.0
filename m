From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: [RESEND][PATCH] sata_via: Add SATA support for vt8237a
Date: Sun, 13 Aug 2006 22:10:30 -0500
Message-ID: <20060814031030.GA3088@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:53735 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1751808AbWHNDKb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Aug 2006 23:10:31 -0400
Received: from ibm63aec.bellsouth.net ([70.152.106.237])
          by imf21aec.mail.bellsouth.net with ESMTP
          id <20060814031030.XKGA15881.imf21aec.mail.bellsouth.net@ibm63aec.bellsouth.net>
          for <linux-ide@vger.kernel.org>; Sun, 13 Aug 2006 23:10:30 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

The initial submittal of this patch was erroneously sent to the wrong
list (linux-scsi), and I neglected to cc the maintainer.  Never
received an ACK.

This patch adds support for the VIA Technologies VT8237A SATA controller.

Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>

---
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 03baec2..d939fc8 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -76,6 +76,7 @@ static u32 svia_scr_read (struct ata_por
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
 
 static const struct pci_device_id svia_pci_tbl[] = {
+	{ 0x1106, 0x0591, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
 	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
 
