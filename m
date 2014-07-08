From: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH v2 1/2] libata: introduce ata_host_set_queue_depth()
Date: Tue, 8 Jul 2014 10:58:20 +0800
Message-ID: <20140708025820.GB29746@pek-khao-d1.corp.ad.wrs.com>
References: <1404628121-8158-1-git-send-email-haokexin@gmail.com>
 <1404628121-8158-2-git-send-email-haokexin@gmail.com>
 <20140707134945.GA18550@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:55812 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbaGHC61 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2014 22:58:27 -0400
Received: by mail-pa0-f53.google.com with SMTP id ey11so6508355pad.12
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2014 19:58:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140707134945.GA18550@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2014 at 09:49:45AM -0400, Tejun Heo wrote:
> Hello,
>=20
> On Sun, Jul 06, 2014 at 02:28:40PM +0800, Kevin Hao wrote:
> > +int ata_host_set_queue_depth(struct ata_host *host, unsigned int queue=
_depth)
>=20
> Hmmm... is there a reason we're doing this separately when the same
> information is available from scsi_host_template->can_queue from
> ata_host_register()?

This was my first thought. But given that scsi_host_template are the parame=
ters
passed to the scsi layer, it seems a bit weird to set the ata_host based a
value in that. Anyway if we decide to use can_queue, how about directly use
it in ata_qc_new(), just like the following codes?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8f3043165048..4792fea79acf 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4728,14 +4728,17 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc =3D NULL;
-	unsigned int i, tag;
+	unsigned int i, tag, max_queue;
+
+	max_queue =3D ap->scsi_host->can_queue;
+	WARN_ON_ONCE(max_queue > ATA_MAX_QUEUE);
=20
 	/* no command while frozen */
 	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
 		return NULL;
=20
-	for (i =3D 0; i < ATA_MAX_QUEUE; i++) {
-		tag =3D (i + ap->last_tag + 1) % ATA_MAX_QUEUE;
+	for (i =3D 0, tag =3D ap->last_tag + 1; i < max_queue; i++, tag++) {
+		tag =3D tag < max_queue ? tag : 0;
=20
 		/* the last tag is reserved for internal command. */
 		if (tag =3D=3D ATA_TAG_INTERNAL)

Thanks,
Kevin

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJTu15MAAoJEJNY7TDerrFx1JgH/RNMBbPmDVE8ayW0PiWR8u05
u1LRebSQc2BhxKwEYOjzihyNvU6J9SY5ChBmxY0x3J0sVEe9y5FFSRzngptiV/Yl
dF/JM8p55w+Clh92O31mSBTTxeQqWBHbkXrzkGaMEiABYhVcU65wSv8ugqJs+7g2
NUCt5aK39NPcGnMgrLCD8axQCnDIej2sX2rviaSrmeF2OMuRwbIKliCHApueAXtp
NhSoUtsjs7snxAn/qNDMprd+LE3LSUXGvEIHLjytp7XTPOXVG3xoUMZu8L+8/zSQ
VpoeGV/ZEoKGZbx3DXM9eEgj3d6am7kyvB4eRYPvvD59oxJgQDPCFyO5//zNm5g=
=fjnR
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
