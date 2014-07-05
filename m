From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 4/5] libata: support the ata host which implements a
 queue depth less than 32
Date: Sat, 5 Jul 2014 21:21:34 +0800
Message-ID: <20140705132134.GA15232@pek-khao-d1.corp.ad.wrs.com>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
 <1404389382-27298-5-git-send-email-haokexin@gmail.com>
 <20140703134717.GA16191@htj.dyndns.org>
 <20140704064646.GA15828@pek-khao-d1.corp.ad.wrs.com>
 <20140704153022.GA764@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:51340 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927AbaGENVl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jul 2014 09:21:41 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so3119902pad.14
        for <linux-ide@vger.kernel.org>; Sat, 05 Jul 2014 06:21:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140704153022.GA764@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2014 at 11:30:22AM -0400, Tejun Heo wrote:
> Hello, Kevin.
>=20
> On Fri, Jul 04, 2014 at 02:46:46PM +0800, Kevin Hao wrote:
> > Since the fsl sata only support a 16 command queue, if we put the inter=
nal
> > command to ata_port->qcmd[16 - 1], we can easily change the above code =
to:
>=20
> Hmmm... something that I wanna do is using all 32 tags for regular
> commands and moving ATA_TAG_INTERNAL to something out-of-bounds, say
> 32 or INT_MAX and let each driver use whatever command slot (most
> likely zero) to actually execute internal commands.
>=20
> There really is no reason to permanently reserve a command tag for
> internal commands like we do now; however, it could be that using a
> tag number to distinguish an internal command isn't a very good idea
> to begin with and it could be better to use a qcflag instead.

I prefer to use a qcflag. How about the following codes? If it is acceptabl=
e,
I can rebase my patch on it.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2895254d8388..f3c876ca26e1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -749,10 +749,12 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct a=
ta_device *dev,
 		    u64 block, u32 n_block, unsigned int tf_flags,
 		    unsigned int tag)
 {
+	struct ata_queued_cmd *qc =3D __ata_qc_from_tag(dev->link->ap, tag);
+
 	tf->flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->flags |=3D tf_flags;
=20
-	if (ata_ncq_enabled(dev) && likely(!ata_tag_internal(tag))) {
+	if (ata_ncq_enabled(dev) && likely(!ata_tag_internal(qc))) {
 		/* yay, NCQ */
 		if (!lba_48_ok(block, n_block))
 			return -ERANGE;
@@ -1570,15 +1572,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
=20
 	/* initialize internal qc */
=20
-	/* XXX: Tag 0 is used for drivers with legacy EH as some
-	 * drivers choke if any other tag is given.  This breaks
-	 * ata_tag_internal() test for those drivers.  Don't use new
-	 * EH stuff without converting to it.
-	 */
-	if (ap->ops->error_handler)
-		tag =3D ATA_TAG_INTERNAL;
-	else
-		tag =3D 0;
+	/* Tag 0 is used as some drivers choke if any other tag is given. */
+	tag =3D 0;
=20
 	if (test_and_set_bit(tag, &ap->qc_allocated))
 		BUG();
@@ -1609,7 +1604,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	    dma_dir =3D=3D DMA_FROM_DEVICE)
 		qc->tf.feature |=3D ATAPI_DMADIR;
=20
-	qc->flags |=3D ATA_QCFLAG_RESULT_TF;
+	qc->flags |=3D ATA_QCFLAG_RESULT_TF | ATA_QCFLAG_INTERNAL;
 	qc->dma_dir =3D dma_dir;
 	if (dma_dir !=3D DMA_NONE) {
 		unsigned int i, buflen =3D 0;
@@ -4737,10 +4732,6 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_=
port *ap)
 	for (i =3D 0; i < ATA_MAX_QUEUE; i++) {
 		tag =3D (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
=20
-		/* the last tag is reserved for internal command. */
-		if (ata_tag_internal(tag))
-			continue;
-
 		if (!test_and_set_bit(tag, &ap->qc_allocated)) {
 			qc =3D __ata_qc_from_tag(ap, tag);
 			qc->tag =3D tag;
@@ -4906,7 +4897,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 		 * Finish internal commands without any further processing
 		 * and always with the result TF filled.
 		 */
-		if (unlikely(ata_tag_internal(qc->tag))) {
+		if (unlikely(ata_tag_internal(qc))) {
 			fill_result_tf(qc);
 			__ata_qc_complete(qc);
 			return;
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 07bc7e4dbd04..b26e15c91905 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -395,10 +395,6 @@ static inline unsigned int sata_fsl_tag(unsigned int t=
ag,
 	/* We let libATA core do actual (queue) tag allocation */
=20
 	/* all non NCQ/queued commands should have tag#0 */
-	if (ata_tag_internal(tag)) {
-		DPRINTK("mapping internal cmds to tag#0\n");
-		return 0;
-	}
=20
 	if (unlikely(tag >=3D SATA_FSL_QUEUE_DEPTH)) {
 		DPRINTK("tag %d invalid : out of range\n", tag);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 0534890f118a..755459c62641 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -458,13 +458,6 @@ static const struct ata_port_info sil24_port_info[] =
=3D {
 	},
 };
=20
-static int sil24_tag(int tag)
-{
-	if (unlikely(ata_tag_internal(tag)))
-		return 0;
-	return tag;
-}
-
 static unsigned long sil24_port_offset(struct ata_port *ap)
 {
 	return ap->port_no * PORT_REGS_SIZE;
@@ -491,7 +484,7 @@ static void sil24_read_tf(struct ata_port *ap, int tag,=
 struct ata_taskfile *tf)
 	struct sil24_prb __iomem *prb;
 	u8 fis[6 * 4];
=20
-	prb =3D port + PORT_LRAM + sil24_tag(tag) * PORT_LRAM_SLOT_SZ;
+	prb =3D port + PORT_LRAM + tag * PORT_LRAM_SLOT_SZ;
 	memcpy_fromio(fis, prb->fis, sizeof(fis));
 	ata_tf_from_fis(fis, tf);
 }
@@ -848,7 +841,7 @@ static void sil24_qc_prep(struct ata_queued_cmd *qc)
 	struct sil24_sge *sge;
 	u16 ctrl =3D 0;
=20
-	cb =3D &pp->cmd_block[sil24_tag(qc->tag)];
+	cb =3D &pp->cmd_block[qc->tag];
=20
 	if (!ata_is_atapi(qc->tf.protocol)) {
 		prb =3D &cb->ata.prb;
@@ -890,7 +883,7 @@ static unsigned int sil24_qc_issue(struct ata_queued_cm=
d *qc)
 	struct ata_port *ap =3D qc->ap;
 	struct sil24_port_priv *pp =3D ap->private_data;
 	void __iomem *port =3D sil24_port_base(ap);
-	unsigned int tag =3D sil24_tag(qc->tag);
+	unsigned int tag =3D qc->tag;
 	dma_addr_t paddr;
 	void __iomem *activate;
=20
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5ab4e3a76721..74612875b198 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -265,6 +265,7 @@ enum {
 	ATA_QCFLAG_FAILED	=3D (1 << 16), /* cmd failed and is owned by EH */
 	ATA_QCFLAG_SENSE_VALID	=3D (1 << 17), /* sense data valid */
 	ATA_QCFLAG_EH_SCHEDULED =3D (1 << 18), /* EH scheduled (obsolete) */
+	ATA_QCFLAG_INTERNAL	=3D (1 << 19), /* Internal command */
=20
 	/* host set flags */
 	ATA_HOST_SIMPLEX	=3D (1 << 0),	/* Host is simplex, one DMA channel per ho=
st only */
@@ -1479,11 +1480,6 @@ static inline unsigned int ata_tag_valid(unsigned in=
t tag)
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
 }
=20
-static inline unsigned int ata_tag_internal(unsigned int tag)
-{
-	return tag =3D=3D ATA_TAG_INTERNAL;
-}
-
 /*
  * device helpers
  */
@@ -1642,6 +1638,11 @@ static inline struct ata_queued_cmd *ata_qc_from_tag=
(struct ata_port *ap,
 	return NULL;
 }
=20
+static inline unsigned int ata_tag_internal(struct ata_queued_cmd *qc)
+{
+	return (qc->flags & ATA_QCFLAG_INTERNAL);
+}
+
 static inline unsigned int ata_qc_raw_nbytes(struct ata_queued_cmd *qc)
 {
 	return qc->nbytes - min(qc->extrabytes, qc->nbytes);
>=20
> Anyways, sata_fsl already has workaround for ATA_TAG_INTERNAL, right?

Yes, the internal command is mapped to tag 0 in sata_fsl.

> Given that the situation around internal tag handling may change, I'm
> not sure about changing the interface now.  Is it a lot of cruft on
> fsl side?

Yes, I agree.

Thanks,
Kevin

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJTt/veAAoJEJNY7TDerrFxWqgIALYwlmb+/yb6890x25zUn2in
aE/hA1nE7A910Zfw3/Py3S3B72SHuAoT51eSEdSOxov5OkSW0tEu65Yimcy0jjIX
xDYuw9bA0Ag1MtEuQ2UqwM3T0vU/CXg0ApyHlIiaQoR2tk4mr6ZJazT5engyuA1R
LHN+e+MWRxz5dcu5NYiAoKIJ9lVOBkzUU9LDNYL5s0mXRraJQOOgc9lhzBvoCwlr
m+d+aIpe9USllWa8VsOGo7QrvaHbjes8HKOHT6RmILUKMM0Mba952JVBuh+iOn4o
xhKNHaSiy43sCzTXzp4vIbiOF9Nlb+Syt6k9kf3nYPJyVdNmq5lvlJWbSV+XUMg=
=k0iZ
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
