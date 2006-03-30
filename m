From: "Anatoli Antonovitch" <antonovi@ati.com>
Subject: [PATCH 2.6.16-g6ac37e95-dirty]  scsi: ATI SB600 SATA support
Date: Thu, 30 Mar 2006 16:49:15 -0500
Message-ID: <CAB45F03F8EF5B4992E343DBFC52032803076EB1@torcaexmb1.atitech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:28266 "EHLO
	outbound2-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1750853AbWC3Vta convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Mar 2006 16:49:30 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Description
This patch adds support for the SATA devices on ATI SB600.

Patch
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c index
ffba656..1bd82c4 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -293,6 +293,10 @@ static const struct pci_device_id ahci_p
        board_ahci }, /* JMicron JMB360 */
      { 0x197b, 0x2363, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
        board_ahci }, /* JMicron JMB363 */
+     { PCI_VENDOR_ID_ATI, 0x4380, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+       board_ahci }, /* ATI SB600 non-raid */
+     { PCI_VENDOR_ID_ATI, 0x4381, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+       board_ahci }, /* ATI SB600 raid */
      { }   /* terminate list */
 };

Signed-off-by: Felix Kuehling <fkuehlin@ati.com>


