From: Jeff Garzik <jeff@garzik.org>
Subject: [git patches] libata updates
Date: Wed, 6 Feb 2008 07:14:16 -0500
Message-ID: <20080206121416.GA7068@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:35320 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762161AbYBFMOq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 07:14:46 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upst=
ream-linus

to receive the following updates:

 arch/arm/mach-rpc/riscpc.c                        |    2 +-
 arch/blackfin/mach-bf527/boards/ezkit.c           |    2 +-
 arch/blackfin/mach-bf533/boards/H8606.c           |    2 +-
 arch/blackfin/mach-bf533/boards/cm_bf533.c        |    2 +-
 arch/blackfin/mach-bf533/boards/ezkit.c           |    2 +-
 arch/blackfin/mach-bf533/boards/stamp.c           |    2 +-
 arch/blackfin/mach-bf537/boards/cm_bf537.c        |    2 +-
 arch/blackfin/mach-bf537/boards/generic_board.c   |    2 +-
 arch/blackfin/mach-bf537/boards/minotaur.c        |    2 +-
 arch/blackfin/mach-bf537/boards/stamp.c           |    2 +-
 arch/blackfin/mach-bf561/boards/cm_bf561.c        |    2 +-
 arch/blackfin/mach-bf561/boards/ezkit.c           |    2 +-
 arch/sh/boards/landisk/setup.c                    |    2 +-
 arch/sh/boards/lboxre2/setup.c                    |    2 +-
 arch/sh/boards/renesas/r7780rp/setup.c            |    2 +-
 arch/sh/boards/renesas/rts7751r2d/setup.c         |    2 +-
 arch/sh/boards/renesas/sdk7780/setup.c            |    2 +-
 arch/sh/boards/se/7722/setup.c                    |    2 +-
 drivers/ata/ahci.c                                |   35 +-
 drivers/ata/ata_piix.c                            |    3 +-
 drivers/ata/libata-core.c                         |    2 -
 drivers/ata/pata_of_platform.c                    |    2 +-
 drivers/ata/pata_platform.c                       |    2 +-
 drivers/ata/sata_fsl.c                            |    4 +-
 drivers/ata/sata_mv.c                             |  366 +++++++++++++=
+++++---
 drivers/ata/sata_nv.c                             |   78 ++++-
 drivers/ata/sata_via.c                            |    2 -
 drivers/ide/legacy/ide_platform.c                 |    2 +-
 include/linux/{pata_platform.h =3D> ata_platform.h} |   13 +-
 include/linux/libata.h                            |    2 -
 30 files changed, 440 insertions(+), 107 deletions(-)
 rename include/linux/{pata_platform.h =3D> ata_platform.h} (75%)

Adrian Bunk (1):
      ata_piix.c:piix_init_one() must be __devinit

Alejandro Riveira Fern=E1ndez (1):
      sata_via.c: Remove missleading comment.

Andrew Morton (1):
      ata: drivers/ata/sata_mv.c needs dmapool.h

David Milburn (1):
      libata-core: unblacklist HITACHI drives

James Bottomley (1):
      libata: kill now unused n_iter and fix sata_fsl

Jeff Garzik (1):
      Rename: linux/pata_platform.h to linux/ata_platform.h

Robert Hancock (1):
      sata_nv: fix ATAPI issues with memory over 4GB (v7)

Saeed Bishara (1):
      sata_mv: Support SoC controllers

Tejun Heo (1):
      ahci: fix CAP.NP and PI handling

diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index a454451..eca558c 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -17,7 +17,7 @@
 #include <linux/sched.h>
 #include <linux/device.h>
 #include <linux/serial_8250.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
=20
 #include <asm/elf.h>
 #include <asm/io.h>
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/ma=
ch-bf527/boards/ezkit.c
index f8c411a..1795aab 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -37,7 +37,7 @@
 #if defined(CONFIG_USB_ISP1362_HCD) || defined(CONFIG_USB_ISP1362_HCD_=
MODULE)
 #include <linux/usb/isp1362.h>
 #endif
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/usb/sl811.h>
diff --git a/arch/blackfin/mach-bf533/boards/H8606.c b/arch/blackfin/ma=
ch-bf533/boards/H8606.c
index a72c7a6..97378b0 100644
--- a/arch/blackfin/mach-bf533/boards/H8606.c
+++ b/arch/blackfin/mach-bf533/boards/H8606.c
@@ -38,7 +38,7 @@
 #if defined(CONFIG_USB_ISP1362_HCD) || defined(CONFIG_USB_ISP1362_HCD_=
MODULE)
 #include <linux/usb/isp1362.h>
 #endif
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
=20
 #include <asm/dma.h>
diff --git a/arch/blackfin/mach-bf533/boards/cm_bf533.c b/arch/blackfin=
/mach-bf533/boards/cm_bf533.c
index 21df2f3..886f260 100644
--- a/arch/blackfin/mach-bf533/boards/cm_bf533.c
+++ b/arch/blackfin/mach-bf533/boards/cm_bf533.c
@@ -34,7 +34,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/usb/isp1362.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
diff --git a/arch/blackfin/mach-bf533/boards/ezkit.c b/arch/blackfin/ma=
ch-bf533/boards/ezkit.c
index c37dd45..4026c2f 100644
--- a/arch/blackfin/mach-bf533/boards/ezkit.c
+++ b/arch/blackfin/mach-bf533/boards/ezkit.c
@@ -35,7 +35,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/usb/isp1362.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/ma=
ch-bf533/boards/stamp.c
index ac52b04..0185350 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -38,7 +38,7 @@
 #if defined(CONFIG_USB_ISP1362_HCD) || defined(CONFIG_USB_ISP1362_HCD_=
MODULE)
 #include <linux/usb/isp1362.h>
 #endif
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537.c b/arch/blackfin=
/mach-bf537/boards/cm_bf537.c
index 8703b67..f7c1f96 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537.c
@@ -36,7 +36,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/usb/isp1362.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
diff --git a/arch/blackfin/mach-bf537/boards/generic_board.c b/arch/bla=
ckfin/mach-bf537/boards/generic_board.c
index 3e52f3f..8a3397d 100644
--- a/arch/blackfin/mach-bf537/boards/generic_board.c
+++ b/arch/blackfin/mach-bf537/boards/generic_board.c
@@ -38,7 +38,7 @@
 #if defined(CONFIG_USB_ISP1362_HCD) || defined(CONFIG_USB_ISP1362_HCD_=
MODULE)
 #include <linux/usb/isp1362.h>
 #endif
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/usb/sl811.h>
diff --git a/arch/blackfin/mach-bf537/boards/minotaur.c b/arch/blackfin=
/mach-bf537/boards/minotaur.c
index b8bbba8..d71e0be 100644
--- a/arch/blackfin/mach-bf537/boards/minotaur.c
+++ b/arch/blackfin/mach-bf537/boards/minotaur.c
@@ -10,7 +10,7 @@
 #if defined(CONFIG_USB_ISP1362_HCD) || defined(CONFIG_USB_ISP1362_HCD_=
MODULE)
 #include <linux/usb_isp1362.h>
 #endif
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/usb_sl811.h>
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/ma=
ch-bf537/boards/stamp.c
index 7725415..119e6ea 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -38,7 +38,7 @@
 #if defined(CONFIG_USB_ISP1362_HCD) || defined(CONFIG_USB_ISP1362_HCD_=
MODULE)
 #include <linux/usb/isp1362.h>
 #endif
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/usb/sl811.h>
diff --git a/arch/blackfin/mach-bf561/boards/cm_bf561.c b/arch/blackfin=
/mach-bf561/boards/cm_bf561.c
index 3a79a90..bf9e738 100644
--- a/arch/blackfin/mach-bf561/boards/cm_bf561.c
+++ b/arch/blackfin/mach-bf561/boards/cm_bf561.c
@@ -34,7 +34,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
 #include <linux/usb/isp1362.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/irq.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
diff --git a/arch/blackfin/mach-bf561/boards/ezkit.c b/arch/blackfin/ma=
ch-bf561/boards/ezkit.c
index 7601c3b..ed863ce 100644
--- a/arch/blackfin/mach-bf561/boards/ezkit.c
+++ b/arch/blackfin/mach-bf561/boards/ezkit.c
@@ -35,7 +35,7 @@
 #include <linux/spi/spi.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <asm/dma.h>
 #include <asm/bfin5xx_spi.h>
 #include <asm/portmux.h>
diff --git a/arch/sh/boards/landisk/setup.c b/arch/sh/boards/landisk/se=
tup.c
index eda7176..2b708ec 100644
--- a/arch/sh/boards/landisk/setup.c
+++ b/arch/sh/boards/landisk/setup.c
@@ -14,7 +14,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/pm.h>
 #include <linux/mm.h>
 #include <asm/machvec.h>
diff --git a/arch/sh/boards/lboxre2/setup.c b/arch/sh/boards/lboxre2/se=
tup.c
index 9c830fd..c74440d 100644
--- a/arch/sh/boards/lboxre2/setup.c
+++ b/arch/sh/boards/lboxre2/setup.c
@@ -13,7 +13,7 @@
=20
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <asm/machvec.h>
 #include <asm/addrspace.h>
 #include <asm/lboxre2.h>
diff --git a/arch/sh/boards/renesas/r7780rp/setup.c b/arch/sh/boards/re=
nesas/r7780rp/setup.c
index a43b477..f7a8d5c 100644
--- a/arch/sh/boards/renesas/r7780rp/setup.c
+++ b/arch/sh/boards/renesas/r7780rp/setup.c
@@ -15,7 +15,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/types.h>
 #include <net/ax88796.h>
 #include <asm/machvec.h>
diff --git a/arch/sh/boards/renesas/rts7751r2d/setup.c b/arch/sh/boards=
/renesas/rts7751r2d/setup.c
index 3452b07..a0ef81b 100644
--- a/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ b/arch/sh/boards/renesas/rts7751r2d/setup.c
@@ -10,7 +10,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/serial_8250.h>
 #include <linux/sm501.h>
 #include <linux/sm501-regs.h>
diff --git a/arch/sh/boards/renesas/sdk7780/setup.c b/arch/sh/boards/re=
nesas/sdk7780/setup.c
index 5df32f2..acc5932 100644
--- a/arch/sh/boards/renesas/sdk7780/setup.c
+++ b/arch/sh/boards/renesas/sdk7780/setup.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <asm/machvec.h>
 #include <asm/sdk7780.h>
 #include <asm/heartbeat.h>
diff --git a/arch/sh/boards/se/7722/setup.c b/arch/sh/boards/se/7722/se=
tup.c
index eb97dca..b1a3d9d 100644
--- a/arch/sh/boards/se/7722/setup.c
+++ b/arch/sh/boards/se/7722/setup.c
@@ -12,7 +12,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <asm/machvec.h>
 #include <asm/se7722.h>
 #include <asm/io.h>
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 27c8d56..29e71bd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -679,24 +679,20 @@ static void ahci_save_initial_config(struct pci_d=
ev *pdev,
=20
 	/* cross check port_map and cap.n_ports */
 	if (port_map) {
-		u32 tmp_port_map =3D port_map;
-		int n_ports =3D ahci_nr_ports(cap);
+		int map_ports =3D 0;
=20
-		for (i =3D 0; i < AHCI_MAX_PORTS && n_ports; i++) {
-			if (tmp_port_map & (1 << i)) {
-				n_ports--;
-				tmp_port_map &=3D ~(1 << i);
-			}
-		}
+		for (i =3D 0; i < AHCI_MAX_PORTS; i++)
+			if (port_map & (1 << i))
+				map_ports++;
=20
-		/* If n_ports and port_map are inconsistent, whine and
-		 * clear port_map and let it be generated from n_ports.
+		/* If PI has more ports than n_ports, whine, clear
+		 * port_map and let it be generated from n_ports.
 		 */
-		if (n_ports || tmp_port_map) {
+		if (map_ports > ahci_nr_ports(cap)) {
 			dev_printk(KERN_WARNING, &pdev->dev,
-				   "nr_ports (%u) and implemented port map "
-				   "(0x%x) don't match, using nr_ports\n",
-				   ahci_nr_ports(cap), port_map);
+				   "implemented port map (0x%x) contains more "
+				   "ports than nr_ports (%u), using nr_ports\n",
+				   port_map, ahci_nr_ports(cap));
 			port_map =3D 0;
 		}
 	}
@@ -2201,7 +2197,7 @@ static int ahci_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
 	struct device *dev =3D &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	struct ata_host *host;
-	int i, rc;
+	int n_ports, i, rc;
=20
 	VPRINTK("ENTER\n");
=20
@@ -2255,7 +2251,14 @@ static int ahci_init_one(struct pci_dev *pdev, c=
onst struct pci_device_id *ent)
 	if (hpriv->cap & HOST_CAP_PMP)
 		pi.flags |=3D ATA_FLAG_PMP;
=20
-	host =3D ata_host_alloc_pinfo(&pdev->dev, ppi, fls(hpriv->port_map));
+	/* CAP.NP sometimes indicate the index of the last enabled
+	 * port, at other times, that of the last possible port, so
+	 * determining the maximum port number requires looking at
+	 * both CAP.NP and port_map.
+	 */
+	n_ports =3D max(ahci_nr_ports(hpriv->cap), fls(hpriv->port_map));
+
+	host =3D ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
 	if (!host)
 		return -ENOMEM;
 	host->iomap =3D pcim_iomap_table(pdev);
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 4b99ed0..9c2515f 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1603,7 +1603,8 @@ static void piix_iocfg_bit18_quirk(struct pci_dev=
 *pdev)
  *	Zero on success, or -ERRNO value.
  */
=20
-static int piix_init_one(struct pci_dev *pdev, const struct pci_device=
_id *ent)
+static int __devinit piix_init_one(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
 {
 	static int printed_version;
 	struct device *dev =3D &pdev->dev;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 361cf50..3011919 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4154,8 +4154,6 @@ static const struct ata_blacklist_entry ata_devic=
e_blacklist [] =3D {
 	/* NCQ is broken */
 	{ "Maxtor *",		"BANC*",	ATA_HORKAGE_NONCQ },
 	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
-	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
-	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
 	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
 	{ "ST3160023AS",	"3.42",		ATA_HORKAGE_NONCQ },
=20
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platf=
orm.c
index 938f48a..408da30 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
=20
 static int __devinit pata_of_platform_probe(struct of_device *ofdev,
 					    const struct of_device_id *match)
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 224bb6c..aad7adc 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -19,7 +19,7 @@
 #include <linux/ata.h>
 #include <linux/libata.h>
 #include <linux/platform_device.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
=20
 #define DRV_NAME "pata_platform"
 #define DRV_VERSION "1.2"
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 922d7b2..efcb66b 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -355,8 +355,8 @@ static unsigned int sata_fsl_fill_sg(struct ata_que=
ued_cmd *qc, void *cmd_desc,
 			ata_port_printk(qc->ap, KERN_ERR,
 					"s/g len unaligned : 0x%x\n", sg_len);
=20
-		if ((num_prde =3D=3D (SATA_FSL_MAX_PRD_DIRECT - 1)) &&
-		    (qc->n_iter + 1 !=3D qc->n_elem)) {
+		if (num_prde =3D=3D (SATA_FSL_MAX_PRD_DIRECT - 1) &&
+		    sg_next(sg) !=3D NULL) {
 			VPRINTK("setting indirect prde\n");
 			prd_ptr_to_indirect_ext =3D prd;
 			prd->dba =3D cpu_to_le32(indirect_ext_segment_paddr);
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 3c1b5c9..080b836 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -69,8 +69,11 @@
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/dmapool.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -179,6 +182,8 @@ enum {
=20
 	HC_MAIN_IRQ_CAUSE_OFS	=3D 0x1d60,
 	HC_MAIN_IRQ_MASK_OFS	=3D 0x1d64,
+	HC_SOC_MAIN_IRQ_CAUSE_OFS =3D 0x20020,
+	HC_SOC_MAIN_IRQ_MASK_OFS =3D 0x20024,
 	PORT0_ERR		=3D (1 << 0),	/* shift by port # */
 	PORT0_DONE		=3D (1 << 1),	/* shift by port # */
 	HC0_IRQ_PEND		=3D 0x1ff,	/* bits 0-8 =3D HC0's ports */
@@ -194,11 +199,13 @@ enum {
 	TWSI_INT		=3D (1 << 24),
 	HC_MAIN_RSVD		=3D (0x7f << 25),	/* bits 31-25 */
 	HC_MAIN_RSVD_5		=3D (0x1fff << 19), /* bits 31-19 */
+	HC_MAIN_RSVD_SOC 	=3D (0x3fffffb << 6),     /* bits 31-9, 7-6 */
 	HC_MAIN_MASKED_IRQS	=3D (TRAN_LO_DONE | TRAN_HI_DONE |
 				   PORTS_0_7_COAL_DONE | GPIO_INT | TWSI_INT |
 				   HC_MAIN_RSVD),
 	HC_MAIN_MASKED_IRQS_5	=3D (PORTS_0_3_COAL_DONE | PORTS_4_7_COAL_DONE =
|
 				   HC_MAIN_RSVD_5),
+	HC_MAIN_MASKED_IRQS_SOC =3D (PORTS_0_3_COAL_DONE | HC_MAIN_RSVD_SOC),
=20
 	/* SATAHC registers */
 	HC_CFG_OFS		=3D 0,
@@ -368,6 +375,7 @@ enum chip_type {
 	chip_608x,
 	chip_6042,
 	chip_7042,
+	chip_soc,
 };
=20
 /* Command ReQuest Block: 32B */
@@ -424,6 +432,10 @@ struct mv_host_priv {
 	u32			hp_flags;
 	struct mv_port_signal	signal[8];
 	const struct mv_hw_ops	*ops;
+	int			n_ports;
+	void __iomem		*base;
+	void __iomem		*main_cause_reg_addr;
+	void __iomem		*main_mask_reg_addr;
 	u32			irq_cause_ofs;
 	u32			irq_mask_ofs;
 	u32			unmask_all_irqs;
@@ -482,6 +494,15 @@ static void mv6_read_preamp(struct mv_host_priv *h=
priv, int idx,
 static int mv6_reset_hc(struct mv_host_priv *hpriv, void __iomem *mmio=
,
 			unsigned int n_hc);
 static void mv6_reset_flash(struct mv_host_priv *hpriv, void __iomem *=
mmio);
+static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
+				      void __iomem *mmio);
+static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
+				      void __iomem *mmio);
+static int mv_soc_reset_hc(struct mv_host_priv *hpriv,
+				  void __iomem *mmio, unsigned int n_hc);
+static void mv_soc_reset_flash(struct mv_host_priv *hpriv,
+				      void __iomem *mmio);
+static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio=
);
 static void mv_reset_pci_bus(struct ata_host *host, void __iomem *mmio=
);
 static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem =
*mmio,
 			     unsigned int port_no);
@@ -661,6 +682,12 @@ static const struct ata_port_info mv_port_info[] =3D=
 {
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &mv_iie_ops,
 	},
+	{  /* chip_soc */
+		.flags =3D MV_COMMON_FLAGS | MV_FLAG_SOC,
+		.pio_mask =3D 0x1f,      /* pio0-4 */
+		.udma_mask =3D ATA_UDMA6,
+		.port_ops =3D &mv_iie_ops,
+	},
 };
=20
 static const struct pci_device_id mv_pci_tbl[] =3D {
@@ -711,6 +738,15 @@ static const struct mv_hw_ops mv6xxx_ops =3D {
 	.reset_bus		=3D mv_reset_pci_bus,
 };
=20
+static const struct mv_hw_ops mv_soc_ops =3D {
+	.phy_errata		=3D mv6_phy_errata,
+	.enable_leds		=3D mv_soc_enable_leds,
+	.read_preamp		=3D mv_soc_read_preamp,
+	.reset_hc		=3D mv_soc_reset_hc,
+	.reset_flash		=3D mv_soc_reset_flash,
+	.reset_bus		=3D mv_soc_reset_bus,
+};
+
 /*
  * Functions
  */
@@ -749,9 +785,15 @@ static inline void __iomem *mv_port_base(void __io=
mem *base, unsigned int port)
 		(mv_hardport_from_port(port) * MV_PORT_REG_SZ);
 }
=20
+static inline void __iomem *mv_host_base(struct ata_host *host)
+{
+	struct mv_host_priv *hpriv =3D host->private_data;
+	return hpriv->base;
+}
+
 static inline void __iomem *mv_ap_base(struct ata_port *ap)
 {
-	return mv_port_base(ap->host->iomap[MV_PRIMARY_BAR], ap->port_no);
+	return mv_port_base(mv_host_base(ap->host), ap->port_no);
 }
=20
 static inline int mv_get_hc_count(unsigned long port_flags)
@@ -1649,16 +1691,21 @@ static void mv_intr_edma(struct ata_port *ap)
  */
 static void mv_host_intr(struct ata_host *host, u32 relevant, unsigned=
 int hc)
 {
-	void __iomem *mmio =3D host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv =3D host->private_data;
+	void __iomem *mmio =3D hpriv->base;
 	void __iomem *hc_mmio =3D mv_hc_base(mmio, hc);
 	u32 hc_irq_cause;
-	int port, port0;
+	int port, port0, last_port;
=20
 	if (hc =3D=3D 0)
 		port0 =3D 0;
 	else
 		port0 =3D MV_PORTS_PER_HC;
=20
+	if (HAS_PCI(host))
+		last_port =3D port0 + MV_PORTS_PER_HC;
+	else
+		last_port =3D port0 + hpriv->n_ports;
 	/* we'll need the HC success int register in most cases */
 	hc_irq_cause =3D readl(hc_mmio + HC_IRQ_CAUSE_OFS);
 	if (!hc_irq_cause)
@@ -1669,7 +1716,7 @@ static void mv_host_intr(struct ata_host *host, u=
32 relevant, unsigned int hc)
 	VPRINTK("ENTER, hc%u relevant=3D0x%08x HC IRQ cause=3D0x%08x\n",
 		hc, relevant, hc_irq_cause);
=20
-	for (port =3D port0; port < port0 + MV_PORTS_PER_HC; port++) {
+	for (port =3D port0; port < port0 + last_port; port++) {
 		struct ata_port *ap =3D host->ports[port];
 		struct mv_port_priv *pp =3D ap->private_data;
 		int have_err_bits, hard_port, shift;
@@ -1764,13 +1811,15 @@ static void mv_pci_error(struct ata_host *host,=
 void __iomem *mmio)
 static irqreturn_t mv_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host =3D dev_instance;
+	struct mv_host_priv *hpriv =3D host->private_data;
 	unsigned int hc, handled =3D 0, n_hcs;
-	void __iomem *mmio =3D host->iomap[MV_PRIMARY_BAR];
+	void __iomem *mmio =3D hpriv->base;
 	u32 irq_stat, irq_mask;
=20
 	spin_lock(&host->lock);
-	irq_stat =3D readl(mmio + HC_MAIN_IRQ_CAUSE_OFS);
-	irq_mask =3D readl(mmio + HC_MAIN_IRQ_MASK_OFS);
+
+	irq_stat =3D readl(hpriv->main_cause_reg_addr);
+	irq_mask =3D readl(hpriv->main_mask_reg_addr);
=20
 	/* check the cases where we either have nothing pending or have read
 	 * a bogus register value which can indicate HW removal or PCI fault
@@ -1827,7 +1876,8 @@ static unsigned int mv5_scr_offset(unsigned int s=
c_reg_in)
=20
 static int mv5_scr_read(struct ata_port *ap, unsigned int sc_reg_in, u=
32 *val)
 {
-	void __iomem *mmio =3D ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv =3D ap->host->private_data;
+	void __iomem *mmio =3D hpriv->base;
 	void __iomem *addr =3D mv5_phy_base(mmio, ap->port_no);
 	unsigned int ofs =3D mv5_scr_offset(sc_reg_in);
=20
@@ -1840,7 +1890,8 @@ static int mv5_scr_read(struct ata_port *ap, unsi=
gned int sc_reg_in, u32 *val)
=20
 static int mv5_scr_write(struct ata_port *ap, unsigned int sc_reg_in, =
u32 val)
 {
-	void __iomem *mmio =3D ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv =3D ap->host->private_data;
+	void __iomem *mmio =3D hpriv->base;
 	void __iomem *addr =3D mv5_phy_base(mmio, ap->port_no);
 	unsigned int ofs =3D mv5_scr_offset(sc_reg_in);
=20
@@ -2178,6 +2229,93 @@ static void mv6_phy_errata(struct mv_host_priv *=
hpriv, void __iomem *mmio,
 	writel(m2, port_mmio + PHY_MODE2);
 }
=20
+/* TODO: use the generic LED interface to configure the SATA Presence =
*/
+/* & Acitivy LEDs on the board */
+static void mv_soc_enable_leds(struct mv_host_priv *hpriv,
+				      void __iomem *mmio)
+{
+	return;
+}
+
+static void mv_soc_read_preamp(struct mv_host_priv *hpriv, int idx,
+			   void __iomem *mmio)
+{
+	void __iomem *port_mmio;
+	u32 tmp;
+
+	port_mmio =3D mv_port_base(mmio, idx);
+	tmp =3D readl(port_mmio + PHY_MODE2);
+
+	hpriv->signal[idx].amps =3D tmp & 0x700;	/* bits 10:8 */
+	hpriv->signal[idx].pre =3D tmp & 0xe0;	/* bits 7:5 */
+}
+
+#undef ZERO
+#define ZERO(reg) writel(0, port_mmio + (reg))
+static void mv_soc_reset_hc_port(struct mv_host_priv *hpriv,
+					void __iomem *mmio, unsigned int port)
+{
+	void __iomem *port_mmio =3D mv_port_base(mmio, port);
+
+	writelfl(EDMA_DS, port_mmio + EDMA_CMD_OFS);
+
+	mv_channel_reset(hpriv, mmio, port);
+
+	ZERO(0x028);		/* command */
+	writel(0x101f, port_mmio + EDMA_CFG_OFS);
+	ZERO(0x004);		/* timer */
+	ZERO(0x008);		/* irq err cause */
+	ZERO(0x00c);		/* irq err mask */
+	ZERO(0x010);		/* rq bah */
+	ZERO(0x014);		/* rq inp */
+	ZERO(0x018);		/* rq outp */
+	ZERO(0x01c);		/* respq bah */
+	ZERO(0x024);		/* respq outp */
+	ZERO(0x020);		/* respq inp */
+	ZERO(0x02c);		/* test control */
+	writel(0xbc, port_mmio + EDMA_IORDY_TMOUT);
+}
+
+#undef ZERO
+
+#define ZERO(reg) writel(0, hc_mmio + (reg))
+static void mv_soc_reset_one_hc(struct mv_host_priv *hpriv,
+				       void __iomem *mmio)
+{
+	void __iomem *hc_mmio =3D mv_hc_base(mmio, 0);
+
+	ZERO(0x00c);
+	ZERO(0x010);
+	ZERO(0x014);
+
+}
+
+#undef ZERO
+
+static int mv_soc_reset_hc(struct mv_host_priv *hpriv,
+				  void __iomem *mmio, unsigned int n_hc)
+{
+	unsigned int port;
+
+	for (port =3D 0; port < hpriv->n_ports; port++)
+		mv_soc_reset_hc_port(hpriv, mmio, port);
+
+	mv_soc_reset_one_hc(hpriv, mmio);
+
+	return 0;
+}
+
+static void mv_soc_reset_flash(struct mv_host_priv *hpriv,
+				      void __iomem *mmio)
+{
+	return;
+}
+
+static void mv_soc_reset_bus(struct ata_host *host, void __iomem *mmio=
)
+{
+	return;
+}
+
 static void mv_channel_reset(struct mv_host_priv *hpriv, void __iomem =
*mmio,
 			     unsigned int port_no)
 {
@@ -2342,7 +2480,7 @@ static int mv_hardreset(struct ata_link *link, un=
signed int *class,
 {
 	struct ata_port *ap =3D link->ap;
 	struct mv_host_priv *hpriv =3D ap->host->private_data;
-	void __iomem *mmio =3D ap->host->iomap[MV_PRIMARY_BAR];
+	void __iomem *mmio =3D hpriv->base;
=20
 	mv_stop_dma(ap);
=20
@@ -2383,7 +2521,7 @@ static void mv_error_handler(struct ata_port *ap)
=20
 static void mv_eh_freeze(struct ata_port *ap)
 {
-	void __iomem *mmio =3D ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv =3D ap->host->private_data;
 	unsigned int hc =3D (ap->port_no > 3) ? 1 : 0;
 	u32 tmp, mask;
 	unsigned int shift;
@@ -2397,13 +2535,14 @@ static void mv_eh_freeze(struct ata_port *ap)
 	mask =3D 0x3 << shift;
=20
 	/* disable assertion of portN err, done events */
-	tmp =3D readl(mmio + HC_MAIN_IRQ_MASK_OFS);
-	writelfl(tmp & ~mask, mmio + HC_MAIN_IRQ_MASK_OFS);
+	tmp =3D readl(hpriv->main_mask_reg_addr);
+	writelfl(tmp & ~mask, hpriv->main_mask_reg_addr);
 }
=20
 static void mv_eh_thaw(struct ata_port *ap)
 {
-	void __iomem *mmio =3D ap->host->iomap[MV_PRIMARY_BAR];
+	struct mv_host_priv *hpriv =3D ap->host->private_data;
+	void __iomem *mmio =3D hpriv->base;
 	unsigned int hc =3D (ap->port_no > 3) ? 1 : 0;
 	void __iomem *hc_mmio =3D mv_hc_base(mmio, hc);
 	void __iomem *port_mmio =3D mv_ap_base(ap);
@@ -2430,8 +2569,8 @@ static void mv_eh_thaw(struct ata_port *ap)
 	writel(hc_irq_cause, hc_mmio + HC_IRQ_CAUSE_OFS);
=20
 	/* enable assertion of portN err, done events */
-	tmp =3D readl(mmio + HC_MAIN_IRQ_MASK_OFS);
-	writelfl(tmp | mask, mmio + HC_MAIN_IRQ_MASK_OFS);
+	tmp =3D readl(hpriv->main_mask_reg_addr);
+	writelfl(tmp | mask, hpriv->main_mask_reg_addr);
 }
=20
 /**
@@ -2598,9 +2737,13 @@ static int mv_chip_id(struct ata_host *host, uns=
igned int board_idx)
 			break;
 		}
 		break;
+	case chip_soc:
+		hpriv->ops =3D &mv_soc_ops;
+		hp_flags |=3D MV_HP_ERRATA_60X1C0;
+		break;
=20
 	default:
-		dev_printk(KERN_ERR, &pdev->dev,
+		dev_printk(KERN_ERR, host->dev,
 			   "BUG: invalid board index %u\n", board_idx);
 		return 1;
 	}
@@ -2633,15 +2776,25 @@ static int mv_chip_id(struct ata_host *host, un=
signed int board_idx)
 static int mv_init_host(struct ata_host *host, unsigned int board_idx)
 {
 	int rc =3D 0, n_hc, port, hc;
-	void __iomem *mmio =3D host->iomap[MV_PRIMARY_BAR];
 	struct mv_host_priv *hpriv =3D host->private_data;
-
-	/* global interrupt mask */
-	writel(0, mmio + HC_MAIN_IRQ_MASK_OFS);
+	void __iomem *mmio =3D hpriv->base;
=20
 	rc =3D mv_chip_id(host, board_idx);
 	if (rc)
-		goto done;
+	goto done;
+
+	if (HAS_PCI(host)) {
+		hpriv->main_cause_reg_addr =3D hpriv->base +
+		  HC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_mask_reg_addr =3D hpriv->base + HC_MAIN_IRQ_MASK_OFS;
+	} else {
+		hpriv->main_cause_reg_addr =3D hpriv->base +
+		  HC_SOC_MAIN_IRQ_CAUSE_OFS;
+		hpriv->main_mask_reg_addr =3D hpriv->base +
+		  HC_SOC_MAIN_IRQ_MASK_OFS;
+	}
+	/* global interrupt mask */
+	writel(0, hpriv->main_mask_reg_addr);
=20
 	n_hc =3D mv_get_hc_count(host->ports[0]->flags);
=20
@@ -2672,13 +2825,15 @@ static int mv_init_host(struct ata_host *host, =
unsigned int board_idx)
 	for (port =3D 0; port < host->n_ports; port++) {
 		struct ata_port *ap =3D host->ports[port];
 		void __iomem *port_mmio =3D mv_port_base(mmio, port);
-		unsigned int offset =3D port_mmio - mmio;
=20
 		mv_port_init(&ap->ioaddr, port_mmio);
=20
 #ifdef CONFIG_PCI
-		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
-		ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
+		if (HAS_PCI(host)) {
+			unsigned int offset =3D port_mmio - mmio;
+			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, -1, "mmio");
+			ata_port_pbar_desc(ap, MV_PRIMARY_BAR, offset, "port");
+		}
 #endif
 	}
=20
@@ -2694,35 +2849,141 @@ static int mv_init_host(struct ata_host *host,=
 unsigned int board_idx)
 		writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
 	}
=20
-	/* Clear any currently outstanding host interrupt conditions */
-	writelfl(0, mmio + hpriv->irq_cause_ofs);
+	if (HAS_PCI(host)) {
+		/* Clear any currently outstanding host interrupt conditions */
+		writelfl(0, mmio + hpriv->irq_cause_ofs);
=20
-	/* and unmask interrupt generation for host regs */
-	writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
+		/* and unmask interrupt generation for host regs */
+		writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
+		if (IS_GEN_I(hpriv))
+			writelfl(~HC_MAIN_MASKED_IRQS_5,
+				 hpriv->main_mask_reg_addr);
+		else
+			writelfl(~HC_MAIN_MASKED_IRQS,
+				 hpriv->main_mask_reg_addr);
+
+		VPRINTK("HC MAIN IRQ cause/mask=3D0x%08x/0x%08x "
+			"PCI int cause/mask=3D0x%08x/0x%08x\n",
+			readl(hpriv->main_cause_reg_addr),
+			readl(hpriv->main_mask_reg_addr),
+			readl(mmio + hpriv->irq_cause_ofs),
+			readl(mmio + hpriv->irq_mask_ofs));
+	} else {
+		writelfl(~HC_MAIN_MASKED_IRQS_SOC,
+			 hpriv->main_mask_reg_addr);
+		VPRINTK("HC MAIN IRQ cause/mask=3D0x%08x/0x%08x\n",
+			readl(hpriv->main_cause_reg_addr),
+			readl(hpriv->main_mask_reg_addr));
+	}
+done:
+	return rc;
+}
=20
-	if (IS_GEN_I(hpriv))
-		writelfl(~HC_MAIN_MASKED_IRQS_5, mmio + HC_MAIN_IRQ_MASK_OFS);
-	else
-		writelfl(~HC_MAIN_MASKED_IRQS, mmio + HC_MAIN_IRQ_MASK_OFS);
+/**
+ *      mv_platform_probe - handle a positive probe of an soc Marvell
+ *      host
+ *      @pdev: platform device found
+ *
+ *      LOCKING:
+ *      Inherited from caller.
+ */
+static int mv_platform_probe(struct platform_device *pdev)
+{
+	static int printed_version;
+	const struct mv_sata_platform_data *mv_platform_data;
+	const struct ata_port_info *ppi[] =3D
+	    { &mv_port_info[chip_soc], NULL };
+	struct ata_host *host;
+	struct mv_host_priv *hpriv;
+	struct resource *res;
+	int n_ports, rc;
=20
-	VPRINTK("HC MAIN IRQ cause/mask=3D0x%08x/0x%08x "
-		"PCI int cause/mask=3D0x%08x/0x%08x\n",
-		readl(mmio + HC_MAIN_IRQ_CAUSE_OFS),
-		readl(mmio + HC_MAIN_IRQ_MASK_OFS),
-		readl(mmio + hpriv->irq_cause_ofs),
-		readl(mmio + hpriv->irq_mask_ofs));
+	if (!printed_version++)
+		dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
=20
-done:
-	return rc;
+	/*
+	 * Simple resource validation ..
+	 */
+	if (unlikely(pdev->num_resources !=3D 2)) {
+		dev_err(&pdev->dev, "invalid number of resources\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Get the register base first
+	 */
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res =3D=3D NULL)
+		return -EINVAL;
+
+	/* allocate host */
+	mv_platform_data =3D pdev->dev.platform_data;
+	n_ports =3D mv_platform_data->n_ports;
+
+	host =3D ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
+	hpriv =3D devm_kzalloc(&pdev->dev, sizeof(*hpriv), GFP_KERNEL);
+
+	if (!host || !hpriv)
+		return -ENOMEM;
+	host->private_data =3D hpriv;
+	hpriv->n_ports =3D n_ports;
+
+	host->iomap =3D NULL;
+	hpriv->base =3D ioremap(res->start, res->end - res->start + 1);
+	hpriv->base -=3D MV_SATAHC0_REG_BASE;
+
+	/* initialize adapter */
+	rc =3D mv_init_host(host, chip_soc);
+	if (rc)
+		return rc;
+
+	dev_printk(KERN_INFO, &pdev->dev,
+		   "slots %u ports %d\n", (unsigned)MV_MAX_Q_DEPTH,
+		   host->n_ports);
+
+	return ata_host_activate(host, platform_get_irq(pdev, 0), mv_interrup=
t,
+				 IRQF_SHARED, &mv6_sht);
+}
+
+/*
+ *
+ *      mv_platform_remove    -       unplug a platform interface
+ *      @pdev: platform device
+ *
+ *      A platform bus SATA device has been unplugged. Perform the nee=
ded
+ *      cleanup. Also called on module unload for any active devices.
+ */
+static int __devexit mv_platform_remove(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct ata_host *host =3D dev_get_drvdata(dev);
+	struct mv_host_priv *hpriv =3D host->private_data;
+	void __iomem *base =3D hpriv->base;
+
+	ata_host_detach(host);
+	iounmap(base);
+	return 0;
 }
=20
+static struct platform_driver mv_platform_driver =3D {
+	.probe			=3D mv_platform_probe,
+	.remove			=3D __devexit_p(mv_platform_remove),
+	.driver			=3D {
+				   .name =3D DRV_NAME,
+				   .owner =3D THIS_MODULE,
+				  },
+};
+
+
 #ifdef CONFIG_PCI
-static int mv_init_one(struct pci_dev *pdev, const struct pci_device_i=
d *ent);
+static int mv_pci_init_one(struct pci_dev *pdev,
+			   const struct pci_device_id *ent);
+
=20
 static struct pci_driver mv_pci_driver =3D {
 	.name			=3D DRV_NAME,
 	.id_table		=3D mv_pci_tbl,
-	.probe			=3D mv_init_one,
+	.probe			=3D mv_pci_init_one,
 	.remove			=3D ata_pci_remove_one,
 };
=20
@@ -2828,14 +3089,15 @@ static int mv_create_dma_pools(struct mv_host_p=
riv *hpriv, struct device *dev)
 }
=20
 /**
- *      mv_init_one - handle a positive probe of a Marvell host
+ *      mv_pci_init_one - handle a positive probe of a PCI Marvell hos=
t
  *      @pdev: PCI device found
  *      @ent: PCI device ID entry for the matched host
  *
  *      LOCKING:
  *      Inherited from caller.
  */
-static int mv_init_one(struct pci_dev *pdev, const struct pci_device_i=
d *ent)
+static int mv_pci_init_one(struct pci_dev *pdev,
+			   const struct pci_device_id *ent)
 {
 	static int printed_version;
 	unsigned int board_idx =3D (unsigned int)ent->driver_data;
@@ -2855,6 +3117,7 @@ static int mv_init_one(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
 	if (!host || !hpriv)
 		return -ENOMEM;
 	host->private_data =3D hpriv;
+	hpriv->n_ports =3D n_ports;
=20
 	/* acquire resources */
 	rc =3D pcim_enable_device(pdev);
@@ -2867,6 +3130,7 @@ static int mv_init_one(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
 	if (rc)
 		return rc;
 	host->iomap =3D pcim_iomap_table(pdev);
+	hpriv->base =3D host->iomap[MV_PRIMARY_BAR];
=20
 	rc =3D pci_go_64(pdev);
 	if (rc)
@@ -2895,11 +3159,22 @@ static int mv_init_one(struct pci_dev *pdev, co=
nst struct pci_device_id *ent)
 }
 #endif
=20
+static int mv_platform_probe(struct platform_device *pdev);
+static int __devexit mv_platform_remove(struct platform_device *pdev);
+
 static int __init mv_init(void)
 {
 	int rc =3D -ENODEV;
 #ifdef CONFIG_PCI
 	rc =3D pci_register_driver(&mv_pci_driver);
+	if (rc < 0)
+		return rc;
+#endif
+	rc =3D platform_driver_register(&mv_platform_driver);
+
+#ifdef CONFIG_PCI
+	if (rc < 0)
+		pci_unregister_driver(&mv_pci_driver);
 #endif
 	return rc;
 }
@@ -2909,6 +3184,7 @@ static void __exit mv_exit(void)
 #ifdef CONFIG_PCI
 	pci_unregister_driver(&mv_pci_driver);
 #endif
+	platform_driver_unregister(&mv_platform_driver);
 }
=20
 MODULE_AUTHOR("Brett Russ");
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index bfe92a4..ed5473b 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -247,6 +247,7 @@ struct nv_adma_port_priv {
 	void __iomem		*ctl_block;
 	void __iomem		*gen_block;
 	void __iomem		*notifier_clear_block;
+	u64			adma_dma_mask;
 	u8			flags;
 	int			last_issue_ncq;
 };
@@ -715,9 +716,10 @@ static int nv_adma_slave_config(struct scsi_device=
 *sdev)
 {
 	struct ata_port *ap =3D ata_shost_to_port(sdev->host);
 	struct nv_adma_port_priv *pp =3D ap->private_data;
+	struct nv_adma_port_priv *port0, *port1;
+	struct scsi_device *sdev0, *sdev1;
 	struct pci_dev *pdev =3D to_pci_dev(ap->host->dev);
-	u64 bounce_limit;
-	unsigned long segment_boundary;
+	unsigned long segment_boundary, flags;
 	unsigned short sg_tablesize;
 	int rc;
 	int adma_enable;
@@ -729,6 +731,8 @@ static int nv_adma_slave_config(struct scsi_device =
*sdev)
 		/* Not a proper libata device, ignore */
 		return rc;
=20
+	spin_lock_irqsave(ap->lock, flags);
+
 	if (ap->link.device[sdev->id].class =3D=3D ATA_DEV_ATAPI) {
 		/*
 		 * NVIDIA reports that ADMA mode does not support ATAPI commands.
@@ -737,7 +741,6 @@ static int nv_adma_slave_config(struct scsi_device =
*sdev)
 		 * Restrict DMA parameters as required by the legacy interface
 		 * when an ATAPI device is connected.
 		 */
-		bounce_limit =3D ATA_DMA_MASK;
 		segment_boundary =3D ATA_DMA_BOUNDARY;
 		/* Subtract 1 since an extra entry may be needed for padding, see
 		   libata-scsi.c */
@@ -748,7 +751,6 @@ static int nv_adma_slave_config(struct scsi_device =
*sdev)
 		adma_enable =3D 0;
 		nv_adma_register_mode(ap);
 	} else {
-		bounce_limit =3D *ap->dev->dma_mask;
 		segment_boundary =3D NV_ADMA_DMA_BOUNDARY;
 		sg_tablesize =3D NV_ADMA_SGTBL_TOTAL_LEN;
 		adma_enable =3D 1;
@@ -774,12 +776,49 @@ static int nv_adma_slave_config(struct scsi_devic=
e *sdev)
 	if (current_reg !=3D new_reg)
 		pci_write_config_dword(pdev, NV_MCP_SATA_CFG_20, new_reg);
=20
-	blk_queue_bounce_limit(sdev->request_queue, bounce_limit);
+	port0 =3D ap->host->ports[0]->private_data;
+	port1 =3D ap->host->ports[1]->private_data;
+	sdev0 =3D ap->host->ports[0]->link.device[0].sdev;
+	sdev1 =3D ap->host->ports[1]->link.device[0].sdev;
+	if ((port0->flags & NV_ADMA_ATAPI_SETUP_COMPLETE) ||
+	    (port1->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)) {
+		/** We have to set the DMA mask to 32-bit if either port is in
+		    ATAPI mode, since they are on the same PCI device which is
+		    used for DMA mapping. If we set the mask we also need to set
+		    the bounce limit on both ports to ensure that the block
+		    layer doesn't feed addresses that cause DMA mapping to
+		    choke. If either SCSI device is not allocated yet, it's OK
+		    since that port will discover its correct setting when it
+		    does get allocated.
+		    Note: Setting 32-bit mask should not fail. */
+		if (sdev0)
+			blk_queue_bounce_limit(sdev0->request_queue,
+					       ATA_DMA_MASK);
+		if (sdev1)
+			blk_queue_bounce_limit(sdev1->request_queue,
+					       ATA_DMA_MASK);
+
+		pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	} else {
+		/** This shouldn't fail as it was set to this value before */
+		pci_set_dma_mask(pdev, pp->adma_dma_mask);
+		if (sdev0)
+			blk_queue_bounce_limit(sdev0->request_queue,
+					       pp->adma_dma_mask);
+		if (sdev1)
+			blk_queue_bounce_limit(sdev1->request_queue,
+					       pp->adma_dma_mask);
+	}
+
 	blk_queue_segment_boundary(sdev->request_queue, segment_boundary);
 	blk_queue_max_hw_segments(sdev->request_queue, sg_tablesize);
 	ata_port_printk(ap, KERN_INFO,
-		"bounce limit 0x%llX, segment boundary 0x%lX, hw segs %hu\n",
-		(unsigned long long)bounce_limit, segment_boundary, sg_tablesize);
+		"DMA mask 0x%llX, segment boundary 0x%lX, hw segs %hu\n",
+		(unsigned long long)*ap->host->dev->dma_mask,
+		segment_boundary, sg_tablesize);
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
 	return rc;
 }
=20
@@ -1140,10 +1179,20 @@ static int nv_adma_port_start(struct ata_port *=
ap)
 	void *mem;
 	dma_addr_t mem_dma;
 	void __iomem *mmio;
+	struct pci_dev *pdev =3D to_pci_dev(dev);
 	u16 tmp;
=20
 	VPRINTK("ENTER\n");
=20
+	/* Ensure DMA mask is set to 32-bit before allocating legacy PRD and
+	   pad buffers */
+	rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (rc)
+		return rc;
+	rc =3D pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (rc)
+		return rc;
+
 	rc =3D ata_port_start(ap);
 	if (rc)
 		return rc;
@@ -1159,6 +1208,15 @@ static int nv_adma_port_start(struct ata_port *a=
p)
 	pp->notifier_clear_block =3D pp->gen_block +
 	       NV_ADMA_NOTIFIER_CLEAR + (4 * ap->port_no);
=20
+	/* Now that the legacy PRD and padding buffer are allocated we can
+	   safely raise the DMA mask to allocate the CPB/APRD table.
+	   These are allowed to fail since we store the value that ends up
+	   being used to set as the bounce limit in slave_config later if
+	   needed. */
+	pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
+	pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
+	pp->adma_dma_mask =3D *dev->dma_mask;
+
 	mem =3D dmam_alloc_coherent(dev, NV_ADMA_PORT_PRIV_DMA_SZ,
 				  &mem_dma, GFP_KERNEL);
 	if (!mem)
@@ -2417,12 +2475,6 @@ static int nv_init_one(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
 	hpriv->type =3D type;
 	host->private_data =3D hpriv;
=20
-	/* set 64bit dma masks, may fail */
-	if (type =3D=3D ADMA) {
-		if (pci_set_dma_mask(pdev, DMA_64BIT_MASK) =3D=3D 0)
-			pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
-	}
-
 	/* request and iomap NV_MMIO_BAR */
 	rc =3D pcim_iomap_regions(pdev, 1 << NV_MMIO_BAR, DRV_NAME);
 	if (rc)
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 3ef072f..30caa03 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -30,8 +30,6 @@
  *  Hardware documentation available under NDA.
  *
  *
- *  To-do list:
- *  - VT6421 PATA support
  *
  */
=20
diff --git a/drivers/ide/legacy/ide_platform.c b/drivers/ide/legacy/ide=
_platform.c
index 26c82ce..688fcae 100644
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -17,7 +17,7 @@
 #include <linux/ide.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <linux/pata_platform.h>
+#include <linux/ata_platform.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
=20
diff --git a/include/linux/ata_platform.h b/include/linux/ata_platform.=
h
new file mode 100644
index 0000000..b856a2a
--- /dev/null
+++ b/include/linux/ata_platform.h
@@ -0,0 +1,34 @@
+#ifndef __LINUX_ATA_PLATFORM_H
+#define __LINUX_ATA_PLATFORM_H
+
+struct pata_platform_info {
+	/*
+	 * I/O port shift, for platforms with ports that are
+	 * constantly spaced and need larger than the 1-byte
+	 * spacing used by ata_std_ports().
+	 */
+	unsigned int ioport_shift;
+	/*=20
+	 * Indicate platform specific irq types and initial
+	 * IRQ flags when call request_irq()
+	 */
+	unsigned int irq_flags;
+};
+
+extern int __devinit __pata_platform_probe(struct device *dev,
+					   struct resource *io_res,
+					   struct resource *ctl_res,
+					   struct resource *irq_res,
+					   unsigned int ioport_shift,
+					   int __pio_mask);
+
+extern int __devexit __pata_platform_remove(struct device *dev);
+
+/*
+ * Marvell SATA private data
+ */
+struct mv_sata_platform_data {
+	int	n_ports; /* number of sata ports */
+};
+
+#endif /* __LINUX_ATA_PLATFORM_H */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 4374c42..bc5a8d0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -457,7 +457,6 @@ struct ata_queued_cmd {
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
 	unsigned int		n_elem;
-	unsigned int		n_iter;
 	unsigned int		mapped_n_elem;
=20
 	int			dma_dir;
@@ -1367,7 +1366,6 @@ static inline void ata_qc_reinit(struct ata_queue=
d_cmd *qc)
 	qc->nbytes =3D qc->raw_nbytes =3D qc->curbytes =3D 0;
 	qc->n_elem =3D 0;
 	qc->mapped_n_elem =3D 0;
-	qc->n_iter =3D 0;
 	qc->err_mask =3D 0;
 	qc->pad_len =3D 0;
 	qc->last_sg =3D NULL;
diff --git a/include/linux/pata_platform.h b/include/linux/pata_platfor=
m.h
deleted file mode 100644
index 6a7a92d..0000000
--- a/include/linux/pata_platform.h
+++ /dev/null
@@ -1,27 +0,0 @@
-#ifndef __LINUX_PATA_PLATFORM_H
-#define __LINUX_PATA_PLATFORM_H
-
-struct pata_platform_info {
-	/*
-	 * I/O port shift, for platforms with ports that are
-	 * constantly spaced and need larger than the 1-byte
-	 * spacing used by ata_std_ports().
-	 */
-	unsigned int ioport_shift;
-	/*=20
-	 * Indicate platform specific irq types and initial
-	 * IRQ flags when call request_irq()
-	 */
-	unsigned int irq_flags;
-};
-
-extern int __devinit __pata_platform_probe(struct device *dev,
-					   struct resource *io_res,
-					   struct resource *ctl_res,
-					   struct resource *irq_res,
-					   unsigned int ioport_shift,
-					   int __pio_mask);
-
-extern int __devexit __pata_platform_remove(struct device *dev);
-
-#endif /* __LINUX_PATA_PLATFORM_H */
