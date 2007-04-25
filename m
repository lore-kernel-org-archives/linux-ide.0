From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 2/3] libata: add hp-poll support to controllers with
	hotplug interrupts
Date: Wed, 25 Apr 2007 00:13:27 -0700
Message-ID: <20070425071327.GD7846@curie-int.orbis-terrarum.net>
References: <20070425062538.GU7810@curie-int.orbis-terrarum.net> <20070425062818.GA7846@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from b01.ext.isohunt.com ([208.71.112.51]:54768 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423240AbXDYHNY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2007 03:13:24 -0400
Content-Disposition: inline
In-Reply-To: <20070425062818.GA7846@curie-int.orbis-terrarum.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com, robbat2@gentoo.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch adds hp-poll support to the following drivers.

* ahci
* sata_nv (nf2 and c804 only)
* sata_sil
* sata_sil24

All the above controllers are capable of hotplug-by-interrupt and
hp-poll will be used only for watching disabled ports.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 drivers/ata/ahci.c       |    4 +++-
 drivers/ata/sata_nv.c    |    6 ++++++
 drivers/ata/sata_sil.c   |    3 +++
 drivers/ata/sata_sil24.c |    3 +++
 4 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7c61bc7..3968799 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -273,10 +273,12 @@ static const struct ata_port_operations ahci_ops =3D {
=20
 	.freeze			=3D ahci_freeze,
 	.thaw			=3D ahci_thaw,
-
 	.error_handler		=3D ahci_error_handler,
 	.post_internal_cmd	=3D ahci_post_internal_cmd,
=20
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
+
 #ifdef CONFIG_PM
 	.port_suspend		=3D ahci_port_suspend,
 	.port_resume		=3D ahci_port_resume,
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 0216974..bcf4934 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -394,7 +394,10 @@ static const struct ata_port_operations nv_nf2_ops =3D=
 {
 	.thaw			=3D nv_nf2_thaw,
 	.error_handler		=3D nv_error_handler,
 	.post_internal_cmd	=3D ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
 	.data_xfer		=3D ata_data_xfer,
+	.irq_handler		=3D nv_nf2_interrupt,
 	.irq_clear		=3D ata_bmdma_irq_clear,
 	.irq_on			=3D ata_irq_on,
 	.irq_ack		=3D ata_irq_ack,
@@ -420,7 +423,10 @@ static const struct ata_port_operations nv_ck804_ops =
=3D {
 	.thaw			=3D nv_ck804_thaw,
 	.error_handler		=3D nv_error_handler,
 	.post_internal_cmd	=3D ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
 	.data_xfer		=3D ata_data_xfer,
+	.irq_handler		=3D nv_ck804_interrupt,
 	.irq_clear		=3D ata_bmdma_irq_clear,
 	.irq_on			=3D ata_irq_on,
 	.irq_ack		=3D ata_irq_ack,
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 0a1e417..8f8cc5f 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -208,6 +208,9 @@ static const struct ata_port_operations sil_ops =3D {
 	.thaw			=3D sil_thaw,
 	.error_handler		=3D ata_bmdma_error_handler,
 	.post_internal_cmd	=3D ata_bmdma_post_internal_cmd,
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
+	.irq_handler		=3D sil_interrupt,
 	.irq_clear		=3D ata_bmdma_irq_clear,
 	.irq_on			=3D ata_irq_on,
 	.irq_ack		=3D ata_irq_ack,
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index e6223ba..81e6bef 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -412,6 +412,9 @@ static const struct ata_port_operations sil24_ops =3D {
 	.error_handler		=3D sil24_error_handler,
 	.post_internal_cmd	=3D sil24_post_internal_cmd,
=20
+	.hp_poll_activate	=3D sata_std_hp_poll_activate,
+	.hp_poll		=3D sata_std_hp_poll,
+
 	.port_start		=3D sil24_port_start,
 };

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGLv+XPpIsIjIzwiwRArLIAKDmxr1J2oi+vKmYoU8U81J25aPnngCfcGeb
zwtmXQEww7ayLThq9z1XSFk=
=/vQB
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
