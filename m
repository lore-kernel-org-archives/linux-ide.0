From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ide: add IDE to libata host drivers conversion table document
Date: Fri, 07 Aug 2015 20:14:39 +0200
Message-ID: <2270946.hqZQQORTj1@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:51964 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbbHGSPo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2015 14:15:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Document relationships between IDE subsystem and libata PATA
host drivers by adding a simple lookup table (for easing conversion
from IDE to libata).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 Documentation/ide/00-INDEX                    |   2 +
 Documentation/ide/host-drivers-conversion.txt | 119 ++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 Documentation/ide/host-drivers-conversion.txt

diff --git a/Documentation/ide/00-INDEX b/Documentation/ide/00-INDEX
index 22f98ca..4290b31 100644
--- a/Documentation/ide/00-INDEX
+++ b/Documentation/ide/00-INDEX
@@ -10,5 +10,7 @@ ide-tape.txt
 	- info on the IDE ATAPI streaming tape driver
 ide.txt
 	- important info for users of ATA devices (IDE/EIDE disks and CD-ROMS).
+host-drivers-conversion.txt
+	- IDE to libata host drivers conversion table
 warm-plug-howto.txt
 	- using sysfs to remove and add IDE devices.
\ No newline at end of file
diff --git a/Documentation/ide/host-drivers-conversion.txt b/Documentation/ide/host-drivers-conversion.txt
new file mode 100644
index 0000000..43f2c92
--- /dev/null
+++ b/Documentation/ide/host-drivers-conversion.txt
@@ -0,0 +1,119 @@
+-----------------------------------------------------------------------------
+IDE subsystem                           | libata PATA                       |
+----------------------------------------|-----------------------------------|
+config option           driver name     | config option    driver name      |
+----------------------------------------|-----------------------------------|
+                                        |                                   |
+BLK_DEV_IDECS           ide-cs          | PATA_PCMCIA      pata_pcmcia      |
+                                        |                                   |
+BLK_DEV_DELKIN          delkin_cb       | PATA_NINJA32     pata_ninja32     |
+                                        |                                   |
+IDE_GENERIC             ide-generic     | PATA_LEGACY      pata_legacy      |
+BLK_DEV_ALI14XX         ali14xx         |                                   |
+BLK_DEV_DTC2278         dtc2278         |                                   |
+BLK_DEV_HT6560B         ht6560b         |                                   |
+BLK_DEV_QD65XX          qd65xx          |                                   |
+BLK_DEV_UMC8672         umc8672         |                                   |
+                                        |                                   |
+BLK_DEV_PLATFORM        ide_platform    | PATA_PLATFORM    pata_platform    |
+                                        |                                   |
+BLK_DEV_CMD640          cmd640          | PATA_CMD640_PCI  pata_cmd640_pci  |
+                                        |                                   |
+BLK_DEV_IDEPNP          ide-pnp         | PATA_ISAPNP      pata_isapnp      |
+                                        |                                   |
+BLK_DEV_GENERIC         ide-pci-generic | ATA_GENERIC      ata_generic      |
+                                        |                                   |
+BLK_DEV_OPTI621         opti621         | PATA_OPTI        pata_opti        |
+                                        |                                   |
+BLK_DEV_RZ1000          rz1000          | PATA_RZ1000      pata_rz1000      |
+                                        |                                   |
+BLK_DEV_AEC62XX         aec62xx         | PATA_ARTOP       pata_artop       |
+                                        |                                   |
+BLK_DEV_ALI15X3         alim15x3        | PATA_ALI         pata_ali         |
+                                        |                                   |
+BLK_DEV_AMD74XX         amd74xx         | PATA_AMD         pata_amd         |
+                                        |                                   |
+BLK_DEV_ATIIXP          atiixp          | PATA_ATIIXP      pata_atiixp      |
+                                        |                                   |
+BLK_DEV_CMD64X          cmd64x          | PATA_CMD64X      pata_cmd64x      |
+                                        |                                   |
+BLK_DEV_TRIFLEX         triflex         | PATA_TRIFLEX     pata_triflex     |
+                                        |                                   |
+BLK_DEV_CY82C693        cy82c693        | PATA_CYPRESS     pata_cypress     |
+                                        |                                   |
+BLK_DEV_CS5520          cs5520          | PATA_CS5520      pata_cs5520      |
+                                        |                                   |
+BLK_DEV_CS5530          cs5530          | PATA_CS5530      pata_cs5530      |
+                                        |                                   |
+BLK_DEV_CS5535          cs5535          | PATA_CS5535      pata_cs5535      |
+                                        |                                   |
+BLK_DEV_CS5536          cs5536          | PATA_CS5536      pata_cs5536      |
+                                        |                                   |
+BLK_DEV_HPT366          hpt366          | PATA_HPT366      pata_hpt366      |
+                                        | PATA_HPT37X      pata_37x         |
+                                        | PATA_HPT3X2N     pata_hpt3x2n     |
+                                        |                                   |
+BLK_DEV_JMICRON         jmicron         | PATA_JMICRON     pata_jmicron     |
+                                        |                                   |
+BLK_DEV_SC1200          sc1200          | PATA_SC1200      pata_sc1200      |
+                                        |                                   |
+BLK_DEV_PIIX            piix            | ATA_PIIX         ata_piix         |
+                                        | PATA_MPIIX       pata_mpiix       |
+                                        |                                   |
+BLK_DEV_IT8172          it8172          | -                -                |
+                                        |                                   |
+BLK_DEV_IT8213          it8213          | PATA_IT8213      pata_it8213      |
+                                        |                                   |
+BLK_DEV_IT821X          it821x          | PATA_IT821X      pata_it821x      |
+                                        |                                   |
+BLK_DEV_NS87415         ns87415         | PATA_NS87415     pata_ns87415     |
+                                        |                                   |
+BLK_DEV_PDC202XX_OLD    pdc202xx_old    | PATA_PDC_OLD     pata_pdc_old     |
+                                        |                                   |
+BLK_DEV_PDC202XX_NEW    pdc202xx_new    | PATA_PDC2027X    pata_pdc2027x    |
+                                        |                                   |
+BLK_DEV_SVWKS           serverworks     | PATA_SERVERWORKS pata_serverworks |
+                                        |                                   |
+BLK_DEV_SGIIOC4         sgiioc4         | -                -                |
+                                        |                                   |
+BLK_DEV_SIIMAGE         siimage         | PATA_SIL680      pata_sil680      |
+                                        |                                   |
+BLK_DEV_SIS5513         sis5513         | PATA_SIS         pata_sis         |
+                                        |                                   |
+BLK_DEV_SL82C105        sl82c105        | PATA_WINBOND     pata_winbond     |
+                                        |                                   |
+BLK_DEV_SLC90E66        slc90e66        | PATA_EFAR        pata_efar        |
+                                        |                                   |
+BLK_DEV_TRM290          trm290          | -                -                |
+                                        |                                   |
+BLK_DEV_VIA82CXXX       via82cxxx       | PATA_VIA         pata_via         |
+                                        |                                   |
+BLK_DEV_TC86C001        tc86c001        | -                -                |
+                                        |                                   |
+BLK_DEV_IDE_PMAC        pmac            | PATA_MACIO       pata_macio       |
+                                        |                                   |
+BLK_DEV_IDE_AU1XXX      au1xxx-ide      | -                -                |
+                                        |                                   |
+BLK_DEV_IDE_TX4938      tx4938ide       | -                -                |
+                                        |                                   |
+BLK_DEV_IDE_TX4939      tx4939ide       | -                -                |
+                                        |                                   |
+BLK_DEV_IDE_ICSIDE      icside          | PATA_ICSIDE      pata_icside      |
+                                        |                                   |
+BLK_DEV_IDE_RAPIDE      rapide          | -                -                |
+                                        |                                   |
+BLK_DEV_GAYLE           gayle           | -                -                |
+                                        |                                   |
+BLK_DEV_BUDDHA          buddha          | -                -                |
+                                        |                                   |
+BLK_DEV_FALCON_IDE      falconide       | -                -                |
+                                        |                                   |
+BLK_DEV_MAC_IDE         macide          | -                -                |
+                                        |                                   |
+BLK_DEV_Q40IDE          q40ide          | -                -                |
+                                        |                                   |
+BLK_DEV_PALMCHIP_BK3710 palm_bk3710     | -                -                |
+                                        |                                   |
+BLK_DEV_4DRIVES         ide-4drives     | -                -                |
+                                        |                                   |
+-----------------------------------------------------------------------------
-- 
1.9.1


