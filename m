From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: libata depends on HAS_DMA
Date: Tue, 12 May 2009 14:40:08 +0200
Message-ID: <200905121440.09315.arnd@arndb.de>
References: <20090511222702.352192505@arndb.de> <200905112238.55404.arnd@arndb.de> <4A08C9C0.6040202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:52063 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbZELMkN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2009 08:40:13 -0400
In-Reply-To: <4A08C9C0.6040202@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 12 May 2009, Jeff Garzik wrote:
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -4,7 +4,7 @@
> > =A0
> > =A0menuconfig ATA
> > =A0=A0=A0=A0=A0=A0tristate "Serial ATA (prod) and Parallel ATA (exp=
erimental) drivers"
> > -=A0=A0=A0=A0=A0depends on HAS_IOMEM
> > +=A0=A0=A0=A0=A0depends on HAS_IOMEM && HAS_DMA
> > =A0=A0=A0=A0=A0=A0depends on BLOCK
> > =A0=A0=A0=A0=A0=A0depends on !(M32R || M68K) || BROKEN
>=20
> What specifically is breaking?
>=20
> Ideally we should be able to work with PIO-only...

CONFIG_HAS_DMA is not set on architectures that are missing
asm/dma-mapping.h or fall back to asm-generic/dma-mapping-broken.h.

In the latter case, you get a link error:
drivers/built-in.o: In function `sas_issue_ata_cmd':
/home/arnd/linux/linux-2.6/drivers/scsi/libsas/sas_ata.c(.text+0x33c50)=
: undefined reference to `dma_map_sg'
/home/arnd/linux/linux-2.6/drivers/scsi/libsas/sas_ata.c(.text+0x33ef0)=
: undefined reference to `dma_unmap_sg'
drivers/built-in.o: In function `ata_sg_clean':
/home/arnd/linux/linux-2.6/drivers/ata/libata-core.c(.text+0x37d18): un=
defined reference to `dma_unmap_sg'
drivers/built-in.o: In function `ata_qc_issue':
/home/arnd/linux/linux-2.6/drivers/ata/libata-core.c(.text+0x38774): un=
defined reference to `dma_map_sg'
drivers/built-in.o: In function `ata_port_start':
/home/arnd/linux/linux-2.6/drivers/ata/libata-core.c(.text+0x3bf0c): un=
defined reference to `dmam_alloc_coherent'

A slightly less naive (but still suboptimal) fix would be the patch bel=
ow.
I could not find an easy way to force all devices to use PIO, this
patch would simply fail if someone tried to set a DMA mode.

	Arnd <><

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4629,6 +4629,7 @@ static unsigned int ata_dev_init_params(struct at=
a_device *dev,
  */
 void ata_sg_clean(struct ata_queued_cmd *qc)
 {
+#ifdef CONFIG_HAS_DMA
 	struct ata_port *ap =3D qc->ap;
 	struct scatterlist *sg =3D qc->sg;
 	int dir =3D qc->dma_dir;
@@ -4642,6 +4643,7 @@ void ata_sg_clean(struct ata_queued_cmd *qc)
=20
 	qc->flags &=3D ~ATA_QCFLAG_DMAMAP;
 	qc->sg =3D NULL;
+#endif /* CONFIG_HAS_DMA */
 }
=20
 /**
@@ -4743,6 +4745,7 @@ void ata_sg_init(struct ata_queued_cmd *qc, struc=
t scatterlist *sg,
  */
 static int ata_sg_setup(struct ata_queued_cmd *qc)
 {
+#ifdef CONFIG_HAS_DMA
 	struct ata_port *ap =3D qc->ap;
 	unsigned int n_elem;
=20
@@ -4758,6 +4761,10 @@ static int ata_sg_setup(struct ata_queued_cmd *q=
c)
 	qc->flags |=3D ATA_QCFLAG_DMAMAP;
=20
 	return 0;
+#else
+	DPRINTK("attempted to use DMA on incompatible architecture\n");
+	return -EINVAL;
+#endif /* CONFIG_HAS_DMA */
 }
=20
 /**
@@ -5450,8 +5457,12 @@ int ata_port_start(struct ata_port *ap)
 {
 	struct device *dev =3D ap->dev;
=20
+#ifdef CONFIG_HAS_DMA
 	ap->prd =3D dmam_alloc_coherent(dev, ATA_PRD_TBL_SZ, &ap->prd_dma,
 				      GFP_KERNEL);
+#else
+	ap->prd =3D devres_alloc(dev, ATA_PRD_TBL_SZ, GFP_KERNEL);
+#endif /* CONFIG_HAS_DMA */
 	if (!ap->prd)
 		return -ENOMEM;
=20
diff --git a/drivers/scsi/libsas/Kconfig b/drivers/scsi/libsas/Kconfig
index 59e00fa..e00271f 100644
--- a/drivers/scsi/libsas/Kconfig
+++ b/drivers/scsi/libsas/Kconfig
@@ -34,6 +34,7 @@ config SCSI_SAS_ATA
 	bool "ATA support for libsas (requires libata)"
 	depends on SCSI_SAS_LIBSAS
 	depends on ATA =3D y || ATA =3D SCSI_SAS_LIBSAS
+	depends on HAS_DMA
 	help
 		Builds in ATA support into libsas.  Will necessitate
 		the loading of libata along with libsas.
