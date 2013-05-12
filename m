From: Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Sun, 12 May 2013 12:13:46 +0200
Message-ID: <201305121213.47294.plr.vincent@gmail.com>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bt2jR/qY7C3rmPn"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:44542 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab3ELKNv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 May 2013 06:13:51 -0400
Received: by mail-we0-f176.google.com with SMTP id p60so5170406wes.21
        for <linux-ide@vger.kernel.org>; Sun, 12 May 2013 03:13:50 -0700 (PDT)
In-Reply-To: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Csaba =?utf-8?q?Hal=C3=A1sz?= <csaba.halasz@gmail.com>

--Boundary-00=_bt2jR/qY7C3rmPn
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Le lundi 18 f=E9vrier 2013 19:17:54, Csaba Hal=E1sz a =E9crit :
> kernel: ata5.00: qc timeout (cmd 0xa0)
> kernel: ata5.00: failed to clear UNIT ATTENTION (err_mask=3D0x5)
> kernel: ata5.00: disabled
>=20
> At least for the bridge I have (an Abit Serillel 2) setting DMADIR
> option and making sure even the internal commands use it seems to fix
> the issue.

I confirm this issue, as of 3.8.12 (current debian sid) with the same bridg=
e:
"Abit Serillel" marked on the outside, PCB marked with "serillel2".
The most relevant IC has these markings:
  Silicon Image
  SataLink
  SiL3611CT80
  Q31844.1
  Q329
  1.4

> I have copied the code from atapi_xlat. Maybe some refactoring would
> be in order, because apparently some other things might have to be
> done too (such as setting lbam/lbah).
> Also I am not sure whether we need to check that it's in fact an ATAPI
> command (maybe by putting this in the if (cdb) block).

In my understanding, it should indeed go in the "if (cdb)" block, as it sho=
uld=20
only be needed for ATAPI commands. I don't think lbam/lbah need to be set (=
or=20
if they do, it's a different issue), because they are set independently fro=
m=20
DMADIR in atapi_xlat (so ata_exec_internal_sg would have to set them=20
independently too, probably in the "if (cdb)" block).

I've modified original patch to the attached one, and tested it: drive is=20
correctly recognised and data can be read from it.

What would be needed to integrate this patch into the kernel ?
Also, why does atapi_dmadir default to disabled ? I'm very unfamiliar with=
=20
ata[pi], if there any drawback from enabling it by default to fix such
devices ?

Regards,
=2D-=20
Vincent Pelletier

--Boundary-00=_bt2jR/qY7C3rmPn
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-libata-make-ata_exec_internal_sg-honor-DMADIR.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-libata-make-ata_exec_internal_sg-honor-DMADIR.patch"

=46rom 7de32c38eb2633fc324852c0a239d067c1b4f9ea Mon Sep 17 00:00:00 2001
Message-Id: <7de32c38eb2633fc324852c0a239d067c1b4f9ea.1368353364.git.plr.vi=
ncent@gmail.com>
=46rom: Vincent Pelletier <plr.vincent@gmail.com>
Date: Sun, 12 May 2013 12:09:18 +0200
Subject: libata: make ata_exec_internal_sg honor DMADIR
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Based on a patch by Csaba Hal=C3=A1sz <csaba.halasz@gmail.com>

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
=2D--
 drivers/ata/libata-core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 63c743b..d121db7 100644
=2D-- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1600,8 +1600,13 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
=20
 	/* prepare & issue qc */
 	qc->tf =3D *tf;
=2D	if (cdb)
+	if (cdb) {
 		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
+		if ((dev->flags & ATA_DFLAG_DMADIR) &&
+		    (dma_dir =3D=3D DMA_FROM_DEVICE))
+			/* some SATA bridges need us to indicate data xfer direction */
+			qc->tf.feature |=3D ATAPI_DMADIR;
+	}
 	qc->flags |=3D ATA_QCFLAG_RESULT_TF;
 	qc->dma_dir =3D dma_dir;
 	if (dma_dir !=3D DMA_NONE) {
=2D-=20
1.7.10.4


--Boundary-00=_bt2jR/qY7C3rmPn--
