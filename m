From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 3/3] libata: add hp-poll support to controllers without
	hotplug interrupts
Date: Wed, 25 Apr 2007 00:15:58 -0700
Message-ID: <20070425071558.GE7846@curie-int.orbis-terrarum.net>
References: <20070425062538.GU7810@curie-int.orbis-terrarum.net> <20070425062818.GA7846@curie-int.orbis-terrarum.net> <20070425071327.GD7846@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:38753 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423247AbXDYHPz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 03:15:55 -0400
Content-Disposition: inline
In-Reply-To: <20070425071327.GD7846@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com, robbat2@gentoo.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds hp-poll support to the following drivers.

* sata_nv (generic)
* sata_sil (SIL_FLAG_NO_SATA_IRQ replaced w/ ATA_FLAG_HP_POLLING)
* sata_sis
* sata_svw
* sata_uli
* sata_vsc

All the above drivers currently don't support hotplug interrupts (H/W
restrictions or lack of doc/effort) and all hotplug operations should
be done via hp-poll; thus, ATA_FLAG_HP_POLLING is set for these
drivers.

sata_via is excluded because it randomly locks up on SCR register
access.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 drivers/ata/sata_nv.c  |    6 +++++-
 drivers/ata/sata_sil.c |    9 ++++-----
 drivers/ata/sata_sis.c |    6 +++++-
 drivers/ata/sata_svw.c |   25 +++++++++++++++++++++++++
 drivers/ata/sata_uli.c |    7 ++++++-
 drivers/ata/sata_vsc.c |   17 +++++++++++++++++
 6 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index bcf4934..a205991 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -368,7 +368,10 @@ static const struct ata_port_operations nv_generic_ops=
 =3D {
 	.thaw			=3D ata_bmdma_thaw,
 	.error_handler		=3D nv_error_handler,
 	.post_internal_cmd	=3D ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
 	.data_xfer		=3D ata_data_xfer,
+	.irq_handler		=3D nv_generic_interrupt,
 	.irq_clear		=3D ata_bmdma_irq_clear,
 	.irq_on			=3D ata_irq_on,
 	.irq_ack		=3D ata_irq_ack,
@@ -474,7 +477,8 @@ static struct ata_port_info nv_port_info[] =3D {
 	{
 		.sht		=3D &nv_sht,
 		.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_HRST_TO_RESUME,
+				  ATA_FLAG_HRST_TO_RESUME |=20
+				  ATA_FLAG_HP_POLLING,
 		.pio_mask	=3D NV_PIO_MASK,
 		.mwdma_mask	=3D NV_MWDMA_MASK,
 		.udma_mask	=3D NV_UDMA_MASK,
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 8f8cc5f..fa3b0e8 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -54,7 +54,6 @@ enum {
 	/*
 	 * host flags
 	 */
-	SIL_FLAG_NO_SATA_IRQ	=3D (1 << 28),
 	SIL_FLAG_RERR_ON_DMA_ACT =3D (1 << 29),
 	SIL_FLAG_MOD15WRITE	=3D (1 << 30),
=20
@@ -231,7 +230,7 @@ static const struct ata_port_info sil_port_info[] =3D {
 	/* sil_3112_no_sata_irq */
 	{
 		.flags		=3D SIL_DFL_PORT_FLAGS | SIL_FLAG_MOD15WRITE |
-				  SIL_FLAG_NO_SATA_IRQ,
+				  ATA_FLAG_HP_POLLING,
 		.pio_mask	=3D 0x1f,			/* pio0-4 */
 		.mwdma_mask	=3D 0x07,			/* mwdma0-2 */
 		.udma_mask	=3D 0x3f,			/* udma0-5 */
@@ -480,8 +479,8 @@ static irqreturn_t sil_interrupt(int irq, void *dev_ins=
tance)
 		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
 			continue;
=20
-		/* turn off SATA_IRQ if not supported */
-		if (ap->flags & SIL_FLAG_NO_SATA_IRQ)
+		/* ignore SATA_IRQ if not supported */
+		if (ap->flags & ATA_FLAG_HP_POLLING)
 			bmdma2 &=3D ~SIL_DMA_SATA_IRQ;
=20
 		if (bmdma2 =3D=3D 0xffffffff ||
@@ -522,7 +521,7 @@ static void sil_thaw(struct ata_port *ap)
 	ata_bmdma_irq_clear(ap);
=20
 	/* turn on SATA IRQ if supported */
-	if (!(ap->flags & SIL_FLAG_NO_SATA_IRQ))
+	if (!(ap->flags & ATA_FLAG_HP_POLLING))
 		writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
=20
 	/* turn on IRQ */
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index d8ee062..fbfe0bf 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -121,6 +121,9 @@ static const struct ata_port_operations sis_ops =3D {
 	.thaw			=3D ata_bmdma_thaw,
 	.error_handler		=3D ata_bmdma_error_handler,
 	.post_internal_cmd	=3D ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
+	.irq_handler		=3D ata_interrupt,
 	.irq_clear		=3D ata_bmdma_irq_clear,
 	.irq_on			=3D ata_irq_on,
 	.irq_ack		=3D ata_irq_ack,
@@ -130,7 +133,8 @@ static const struct ata_port_operations sis_ops =3D {
 };
=20
 static struct ata_port_info sis_port_info =3D {
-	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
+	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+			  ATA_FLAG_HP_POLLING,
 	.pio_mask	=3D 0x1f,
 	.mwdma_mask	=3D 0x7,
 	.udma_mask	=3D 0x7f,
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index cc07aac..8777e90 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -345,6 +345,9 @@ static const struct ata_port_operations k2_sata_ops =3D=
 {
 	.thaw			=3D ata_bmdma_thaw,
 	.error_handler		=3D ata_bmdma_error_handler,
 	.post_internal_cmd	=3D ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
+	.irq_handler		=3D ata_interrupt,
 	.irq_clear		=3D ata_bmdma_irq_clear,
 	.irq_on			=3D ata_irq_on,
 	.irq_ack		=3D ata_irq_ack,
@@ -465,6 +468,28 @@ static int k2_sata_init_one (struct pci_dev *pdev, con=
st struct pci_device_id *e
 	writel(0xffffffff, mmio_base + K2_SATA_SCR_ERROR_OFFSET);
 	writel(0x0, mmio_base + K2_SATA_SIM_OFFSET);
=20
+	probe_ent->sht =3D &k2_sata_sht;
+	probe_ent->port_flags =3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				ATA_FLAG_MMIO | ATA_FLAG_HP_POLLING;
+	probe_ent->port_ops =3D &k2_sata_ops;
+	probe_ent->n_ports =3D 4;
+	probe_ent->irq =3D pdev->irq;
+	probe_ent->irq_flags =3D IRQF_SHARED;
+	probe_ent->mmio_base =3D mmio_base;
+
+	/* We don't care much about the PIO/UDMA masks, but the core won't like us
+	 * if we don't fill these
+	 */
+	probe_ent->pio_mask =3D 0x1f;
+	probe_ent->mwdma_mask =3D 0x7;
+	probe_ent->udma_mask =3D 0x7f;
+
+	/* different controllers have different number of ports - currently 4 or =
8 */
+	/* All ports are on the same function. Multi-function device is no
+	 * longer available. This should not be seen in any system. */
+	for (i =3D 0; i < ent->driver_data; i++)
+		k2_sata_setup_port(&probe_ent->port[i], base + i * K2_SATA_PORT_OFFSET);
+
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, ata_interrupt, IRQF_SHARED,
 				 &k2_sata_sht);
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index f74e383..533c5d3 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -115,6 +115,10 @@ static const struct ata_port_operations uli_ops =3D {
 	.error_handler		=3D ata_bmdma_error_handler,
 	.post_internal_cmd	=3D ata_bmdma_post_internal_cmd,
=20
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
+
+	.irq_handler		=3D ata_interrupt,
 	.irq_clear		=3D ata_bmdma_irq_clear,
 	.irq_on			=3D ata_irq_on,
 	.irq_ack		=3D ata_irq_ack,
@@ -127,7 +131,8 @@ static const struct ata_port_operations uli_ops =3D {
=20
 static struct ata_port_info uli_port_info =3D {
 	.flags		=3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-			  ATA_FLAG_IGN_SIMPLEX,
+			  ATA_FLAG_IGN_SIMPLEX |
+			  ATA_FLAG_HP_POLLING,
 	.pio_mask       =3D 0x1f,		/* pio0-4 */
 	.udma_mask      =3D 0x7f,		/* udma0-6 */
 	.port_ops       =3D &uli_ops,
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index 80126f8..df8782f 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -333,6 +333,9 @@ static const struct ata_port_operations vsc_sata_ops =
=3D {
 	.thaw			=3D vsc_thaw,
 	.error_handler		=3D ata_bmdma_error_handler,
 	.post_internal_cmd	=3D ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
+	.irq_handler		=3D vsc_sata_interrupt,
 	.irq_clear		=3D ata_bmdma_irq_clear,
 	.irq_on			=3D ata_irq_on,
 	.irq_ack		=3D ata_irq_ack,
@@ -425,6 +428,20 @@ static int __devinit vsc_sata_init_one (struct pci_dev=
 *pdev, const struct pci_d
 	 * Due to a bug in the chip, the default cache line size can't be
 	 * used (unless the default is non-zero).
 	 */
+	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
+
+	probe_ent->sht =3D &vsc_sata_sht;
+	probe_ent->port_flags =3D ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				ATA_FLAG_MMIO | ATA_FLAG_HP_POLLING;
+	probe_ent->port_ops =3D &vsc_sata_ops;
+	probe_ent->n_ports =3D 4;
+	probe_ent->irq =3D pdev->irq;
+	probe_ent->irq_flags =3D IRQF_SHARED;
+	probe_ent->mmio_base =3D mmio_base;
+
+	/* We don't care much about the PIO/UDMA masks, but the core won't like us
+	 * if we don't fill these
+	 */
 	pci_read_config_byte(pdev, PCI_CACHE_LINE_SIZE, &cls);
 	if (cls =3D=3D 0x00)
 		pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGLwAuPpIsIjIzwiwRAqM5AKDg5UT+zhcAoSWnpT4mbVz9gu3GFgCgqPSM
Z9uftGA7oLTrIHeWKC8E2EY=
=iZ12
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
