From: Youquan Song <youquan.song@intel.com>
Subject: [PATCH] ata: Fix DVD not dectected at some platform with Wellsburg PCH
Date: Wed,  3 Jul 2013 10:17:48 -0400
Message-ID: <1372861068-18221-1-git-send-email-youquan.song@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, jgarzik@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: seth.heasley@intel.com, james.d.ralston@intel.com, ed.ciechanowski@intel.com, Youquan Song <youquan.song@linux.intel.com>, Youquan Song <youquan.song@intel.com>
List-Id: linux-ide@vger.kernel.org

There is a patch b55f84e2d527182e7c611d466cd0bb6ddce201de "ata_piix: Fix DVD
 not dectected at some Haswell platforms" to fix an issue of DVD not 
recognized on Haswell Desktop platform with Lynx Point. 
Recently, it is also found the same issue at some platformas with Wellsburg PCH.

So deliver a similar patch to fix it by disables 32bit PIO in IDE mode.

Signed-off-by: Youquan Song <youquan.song@intel.com>
---
 drivers/ata/ata_piix.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 9a8a674..424bcbe 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -330,7 +330,7 @@ static const struct pci_device_id piix_pci_tbl[] = {
 	/* SATA Controller IDE (Wellsburg) */
 	{ 0x8086, 0x8d00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
 	/* SATA Controller IDE (Wellsburg) */
-	{ 0x8086, 0x8d08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
+	{ 0x8086, 0x8d08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata_snb },
 	/* SATA Controller IDE (Wellsburg) */
 	{ 0x8086, 0x8d60, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata_snb },
 	/* SATA Controller IDE (Wellsburg) */
-- 
1.6.4.2
