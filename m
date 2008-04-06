From: Johann Felix Soden <johfel@gmx.de>
Subject: [PATCH] ata/sata_fsl: Remove unused variable in sata_fsl_probe
Date: Sun, 06 Apr 2008 15:10:54 +0200
Message-ID: <1207487454.17097.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37750 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751747AbYDFNLE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Apr 2008 09:11:04 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Daniel =?ISO-8859-1?Q?Marjam=E4ki?= <danielm77@spray.se>

=46rom: Johann Felix Soden <johfel@users.sourceforge.net>

In sata_fsl_probe memory is allocated but never used or deallocated.
=46ixes: http://bugzilla.kernel.org/show_bug.cgi?id=3D10404

Thanks to Daniel Marjam=C3=A4ki for the bug report.

Reported-by: Daniel Marjam=C3=A4ki <danielm77@spray.se>
Signed-off-by: Johann Felix Soden <johfel@users.sourceforge.net>
---
 drivers/ata/sata_fsl.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 4c19855..9d1e3ca 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1256,7 +1256,6 @@ static int sata_fsl_probe(struct of_device *ofdev=
,
 	void __iomem *ssr_base =3D NULL;
 	void __iomem *csr_base =3D NULL;
 	struct sata_fsl_host_priv *host_priv =3D NULL;
-	struct resource *r;
 	int irq;
 	struct ata_host *host;
=20
@@ -1266,8 +1265,6 @@ static int sata_fsl_probe(struct of_device *ofdev=
,
 	dev_printk(KERN_INFO, &ofdev->dev,
 		   "Sata FSL Platform/CSB Driver init\n");
=20
-	r =3D kmalloc(sizeof(struct resource), GFP_KERNEL);
-
 	hcr_base =3D of_iomap(ofdev->node, 0);
 	if (!hcr_base)
 		goto error_exit_with_cleanup;
--=20
1.5.4.5



