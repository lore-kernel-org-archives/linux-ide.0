From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH] sata_fsl: fix build with ATA_VERBOSE_DEBUG
Date: Fri, 22 Feb 2008 19:54:25 +0300
Message-ID: <20080222165425.GA27460@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:39581 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758424AbYBVQy1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 11:54:27 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

This patch fixes build and few warnings when ATA_VERBOSE_DEBUG
is defined:

  CC      drivers/ata/sata_fsl.o
drivers/ata/sata_fsl.c: In function =E2=80=98sata_fsl_fill_sg=E2=80=99:
drivers/ata/sata_fsl.c:338: warning: format =E2=80=98%x=E2=80=99 expect=
s type =E2=80=98unsigned int=E2=80=99, but argument 3 has type =E2=80=98=
void *=E2=80=99
drivers/ata/sata_fsl.c:338: warning: format =E2=80=98%x=E2=80=99 expect=
s type =E2=80=98unsigned int=E2=80=99, but argument 4 has type =E2=80=98=
struct prde *=E2=80=99
drivers/ata/sata_fsl.c: In function =E2=80=98sata_fsl_qc_issue=E2=80=99=
:
drivers/ata/sata_fsl.c:459: error: =E2=80=98csr_base=E2=80=99 undeclare=
d (first use in this function)
drivers/ata/sata_fsl.c:459: error: (Each undeclared identifier is repor=
ted only once
drivers/ata/sata_fsl.c:459: error: for each function it appears in.)
drivers/ata/sata_fsl.c: In function =E2=80=98sata_fsl_freeze=E2=80=99:
drivers/ata/sata_fsl.c:525: error: =E2=80=98csr_base=E2=80=99 undeclare=
d (first use in this function)
make[2]: *** [drivers/ata/sata_fsl.o] Error 1

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ata/sata_fsl.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 9ac36df..93789bf 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -335,7 +335,7 @@ static unsigned int sata_fsl_fill_sg(struct ata_que=
ued_cmd *qc, void *cmd_desc,
 	dma_addr_t indirect_ext_segment_paddr;
 	unsigned int si;
=20
-	VPRINTK("SATA FSL : cd =3D 0x%x, prd =3D 0x%x\n", cmd_desc, prd);
+	VPRINTK("SATA FSL : cd =3D 0x%p, prd =3D 0x%p\n", cmd_desc, prd);
=20
 	indirect_ext_segment_paddr =3D cmd_desc_paddr +
 	    SATA_FSL_CMD_DESC_OFFSET_TO_PRDT + SATA_FSL_MAX_PRD_DIRECT * 16;
@@ -459,7 +459,8 @@ static unsigned int sata_fsl_qc_issue(struct ata_qu=
eued_cmd *qc)
 	VPRINTK("CE=3D0x%x, DE=3D0x%x, CC=3D0x%x, CmdStat =3D 0x%x\n",
 		ioread32(CE + hcr_base),
 		ioread32(DE + hcr_base),
-		ioread32(CC + hcr_base), ioread32(COMMANDSTAT + csr_base));
+		ioread32(CC + hcr_base),
+		ioread32(COMMANDSTAT + host_priv->csr_base));
=20
 	return 0;
 }
@@ -522,7 +523,8 @@ static void sata_fsl_freeze(struct ata_port *ap)
 		ioread32(CQ + hcr_base),
 		ioread32(CA + hcr_base),
 		ioread32(CE + hcr_base), ioread32(DE + hcr_base));
-	VPRINTK("CmdStat =3D 0x%x\n", ioread32(csr_base + COMMANDSTAT));
+	VPRINTK("CmdStat =3D 0x%x\n",
+		ioread32(host_priv->csr_base + COMMANDSTAT));
=20
 	/* disable interrupts on the controller/port */
 	temp =3D ioread32(hcr_base + HCONTROL);
--=20
1.5.2.2
