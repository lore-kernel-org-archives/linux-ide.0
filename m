From: Jeff Garzik <jeff@garzik.org>
Subject: Improving sata_vsc PCI ID usage...
Date: Mon, 26 Jun 2006 20:54:45 -0400
Message-ID: <44A081D5.80905@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020905010600040309050804"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53457 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964793AbWF0Ays (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jun 2006 20:54:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: bcasavan@sgi.com, jes@sgi.com, akpm@osdl.org, gregkh@suse.de

This is a multi-part message in MIME format.
--------------020905010600040309050804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

FYI, I just committed the attached patch to libata-dev.git...

	Jeff



--------------020905010600040309050804
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

commit 438bc9c3dec27ab37f0ff78471d0b8b91addd2dd
Author: Jeff Garzik <jeff@garzik.org>
Date:   Mon Jun 26 20:52:17 2006 -0400

    [libata] sata_vsc: partially revert a PCI ID-related commit

    Partially revert 74d0a988d3aa359b6b8a8536c8cb92cce02ca5d5:

        [PATCH] PCI: Move various PCI IDs to header file

    libata policy is to avoid use of named PCI device ID constants.
    These are often single-use constants, which have little value over
    direct numeric constants save for constant include/linux/pci_ids.h
    patching/merging headaches.

    Signed-off-by: Jeff Garzik <jeff@garzik.org>

 drivers/scsi/sata_vsc.c |   10 +++-------
 include/linux/pci_ids.h |    1 -
 2 files changed, 3 insertions(+), 8 deletions(-)


438bc9c3dec27ab37f0ff78471d0b8b91addd2dd
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
index 01893a0..616fd96 100644
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -443,16 +443,12 @@ err_out:
 }
 
 
-/*
- * Intel 31244 is supposed to be identical.
- * Compatibility is untested as of yet.
- */
 static const struct pci_device_id vsc_sata_pci_tbl[] = {
-	{ PCI_VENDOR_ID_VITESSE, PCI_DEVICE_ID_VITESSE_VSC7174,
+	{ PCI_VENDOR_ID_VITESSE, 0x7174,
 	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_GD31244,
+	{ PCI_VENDOR_ID_INTEL, 0x3200,
 	  PCI_ANY_ID, PCI_ANY_ID, 0x10600, 0xFFFFFF, 0 },
-	{ }
+	{ }	/* terminate list */
 };
 
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c2fd2d1..6abd276 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2170,7 +2170,6 @@ #define PCI_DEVICE_ID_INTEL_ICH8_3	0x281
 #define PCI_DEVICE_ID_INTEL_ICH8_4	0x2815
 #define PCI_DEVICE_ID_INTEL_ICH8_5	0x283e
 #define PCI_DEVICE_ID_INTEL_ICH8_6	0x2850
-#define PCI_DEVICE_ID_INTEL_GD31244	0x3200
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577

--------------020905010600040309050804--
