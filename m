From: Christian Dietrich <christian.dietrich@informatik.uni-erlangen.de>
Subject: [PATCH] ide: icside.c: Fix compile with CONFIG_BLK_DEV_IDEDMA_ICS=n
Date: Tue, 29 May 2012 12:30:02 +0200
Message-ID: <20120529103002.GA13283@faui49q.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, vamos-dev@lists.cs.fau.de
List-Id: linux-ide@vger.kernel.org

The icside driver can be configured without DMA support, but it
doesn't compile in this case, because DMA operations are referenced.

drivers/ide/icside.c:523: error: =E2=80=98icside_v6_port_ops=E2=80=99 u=
ndeclared
drivers/ide/icside.c:522: error: =E2=80=98icside_dma_init=E2=80=99 unde=
clared

Signed-off-by: Christian Dietrich <christian.dietrich@informatik.uni-er=
langen.de>
---
 drivers/ide/icside.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

I attach the configuration, that exposes this compilation error. This p=
atch was
*NOT* tested on real hardware. I don't if the fix really does solve the
problem, but at least it is a hint that there is a problem.

diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index 8716066..62c59c1 100644
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -271,7 +271,7 @@ static void icside_set_dma_mode(ide_hwif_t *hwif, i=
de_drive_t *drive)
=20
 	ide_set_drivedata(drive, (void *)cycle_time);
=20
-	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
+	printk("%s: %s selected (peak %ldMB/s)\n", drive->name,
 		ide_xfer_verbose(xfer_mode),
 		2000 / (unsigned long)ide_get_drivedata(drive));
 }
@@ -456,7 +456,9 @@ err_free:
 static const struct ide_port_info icside_v6_port_info __initdata =3D {
 	.init_dma		=3D icside_dma_off_init,
 	.port_ops		=3D &icside_v6_no_dma_port_ops,
+#ifdef CONFIG_BLK_DEV_IDEDMA_ICS
 	.dma_ops		=3D &icside_v6_dma_ops,
+#endif
 	.host_flags		=3D IDE_HFLAG_SERIALIZE | IDE_HFLAG_MMIO,
 	.mwdma_mask		=3D ATA_MWDMA2,
 	.swdma_mask		=3D ATA_SWDMA2,
@@ -518,10 +520,12 @@ icside_register_v6(struct icside_state *state, st=
ruct expansion_card *ec)
=20
 	ecard_set_drvdata(ec, state);
=20
+#ifdef CONFIG_BLK_DEV_IDEDMA_ICS
 	if (ec->dma !=3D NO_DMA && !request_dma(ec->dma, DRV_NAME)) {
 		d.init_dma =3D icside_dma_init;
 		d.port_ops =3D &icside_v6_port_ops;
 	} else
+#endif
 		d.dma_ops =3D NULL;
=20
 	ret =3D ide_host_register(host, &d, hws);
--=20
1.7.5.4
