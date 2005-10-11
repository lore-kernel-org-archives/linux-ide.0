From: Jeff Garzik <jgarzik@pobox.com>
Subject: [git patch] libata driver fix
Date: Tue, 11 Oct 2005 02:00:52 -0400
Message-ID: <20051011060052.GA9375@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751383AbVJKGAy@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Don't presume that newer NV SATA chips follow the same register scheme
as older chips.

 drivers/scsi/sata_nv.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)


commit 9621904012de3c8d0d4e2904dcc7170b3012119e
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Tue Oct 11 01:52:39 2005 -0400

    sata_nv: Fixed bug introduced by 0.08's MCP51 and MCP55 support.


diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -29,6 +29,8 @@
  *  NV-specific details such as register offsets, SATA phy location,
  *  hotplug info, etc.
  *
+ *  0.09
+ *     - Fixed bug introduced by 0.08's MCP51 and MCP55 support.
  *
  *  0.08
  *     - Added support for MCP51 and MCP55.
@@ -132,9 +134,7 @@ enum nv_host_type
 	GENERIC,
 	NFORCE2,
 	NFORCE3,
-	CK804,
-	MCP51,
-	MCP55
+	CK804
 };
 
 static struct pci_device_id nv_pci_tbl[] = {
@@ -153,13 +153,13 @@ static struct pci_device_id nv_pci_tbl[]
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SATA2,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, CK804 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP51_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP51 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, MCP55 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, GENERIC },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 		PCI_ANY_ID, PCI_ANY_ID,
 		PCI_CLASS_STORAGE_IDE<<8, 0xffff00, GENERIC },
