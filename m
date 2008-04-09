From: Jeff Garzik <jeff@garzik.org>
Subject: [git patches] libata fixes
Date: Wed, 9 Apr 2008 03:04:21 -0400
Message-ID: <20080409070421.GA26759@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754683AbYDIHEd@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


Please pull from 'upstream-linus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

to receive the following updates:

 drivers/ata/pata_sil680.c |    2 +-
 drivers/ata/sata_fsl.c    |    3 ---
 2 files changed, 1 insertions(+), 4 deletions(-)

Benjamin Herrenschmidt (1):
      pata_sil680: Fix build on arch/ppc

Johann Felix Soden (1):
      ata/sata_fsl: Remove unused variable in sata_fsl_probe

diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index 3988e44..7c5b2dd 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -270,7 +270,7 @@ static u8 sil680_init_chip(struct pci_dev *pdev, int *try_mmio)
 		tmpbyte & 1, tmpbyte & 0x30);
 
 	*try_mmio = 0;
-#ifdef CONFIG_PPC
+#ifdef CONFIG_PPC_MERGE
 	if (machine_is(cell))
 		*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
 #endif
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 4c19855..9d1e3ca 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1256,7 +1256,6 @@ static int sata_fsl_probe(struct of_device *ofdev,
 	void __iomem *ssr_base = NULL;
 	void __iomem *csr_base = NULL;
 	struct sata_fsl_host_priv *host_priv = NULL;
-	struct resource *r;
 	int irq;
 	struct ata_host *host;
 
@@ -1266,8 +1265,6 @@ static int sata_fsl_probe(struct of_device *ofdev,
 	dev_printk(KERN_INFO, &ofdev->dev,
 		   "Sata FSL Platform/CSB Driver init\n");
 
-	r = kmalloc(sizeof(struct resource), GFP_KERNEL);
-
 	hcr_base = of_iomap(ofdev->node, 0);
 	if (!hcr_base)
 		goto error_exit_with_cleanup;
