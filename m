From: Tejun Heo <tj@kernel.org>
Subject: [GIT PULL] libata fixes for v4.17-rc6
Date: Thu, 24 May 2018 07:10:14 -0700
Message-ID: <20180524141014.GC1351649@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello, Linus.

Nothing too interesting.  Four patches to update blacklist and
controller type.

Thanks.

The following changes since commit 0d74d872c3f8b9cb3d096fb932a063b43b37f188:

  driver core: add __printf verification to __ata_ehi_pushv_desc (2018-05-07 08:32:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.17-fixes

for you to fetch changes up to 4544e403eb25552aed7f0ee181a7a506b8800403:

  ahci: Add PCI ID for Cannon Lake PCH-LP AHCI (2018-05-24 07:03:32 -0700)

----------------------------------------------------------------
François Cami (1):
      libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.

Mika Westerberg (1):
      ahci: Add PCI ID for Cannon Lake PCH-LP AHCI

Sudip Mukherjee (1):
      libata: blacklist Micron 500IT SSD with MU01 firmware

Tejun Heo (1):
      libata: Blacklist some Sandisk SSDs for NCQ

 drivers/ata/ahci.c        | 1 +
 drivers/ata/libata-core.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6389c88..738fb22 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -334,6 +334,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_mobile }, /* Lynx LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_mobile }, /* Lynx LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_mobile }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_mobile }, /* Cannon Lake PCH-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 68596bd4..346b163 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4493,6 +4493,10 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=15573 */
 	{ "C300-CTFDDAC128MAG",	"0001",		ATA_HORKAGE_NONCQ, },
 
+	/* Some Sandisk SSDs lock up hard with NCQ enabled.  Reported on
+	   SD7SN6S256G and SD8SN8U256G */
+	{ "SanDisk SD[78]SN*G",	NULL,		ATA_HORKAGE_NONCQ, },
+
 	/* devices which puke on READ_NATIVE_MAX */
 	{ "HDS724040KLSA80",	"KFAOA20N",	ATA_HORKAGE_BROKEN_HPA, },
 	{ "WDC WD3200JD-00KLB0", "WD-WCAMR1130137", ATA_HORKAGE_BROKEN_HPA },
@@ -4549,13 +4553,16 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
 						ATA_HORKAGE_NOLPM, },
 
-	/* This specific Samsung model/firmware-rev does not handle LPM well */
+	/* These specific Samsung models/firmware-revs do not handle LPM well */
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
 
 	/* Sandisk devices which are known to not handle LPM well */
 	{ "SanDisk SD7UB3Q*G1001",	NULL,	ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
+	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Micron_M500_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "Crucial_CT*M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
