From: Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Fri, 17 May 2013 19:20:10 +0200
Message-ID: <201305171920.11127.plr.vincent@gmail.com>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com> <201305121213.47294.plr.vincent@gmail.com> <20130514190616.GU6795@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LbmlReVIpXPkzw9"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:51176 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349Ab3EQRUP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 May 2013 13:20:15 -0400
Received: by mail-ee0-f47.google.com with SMTP id t10so2656047eei.6
        for <linux-ide@vger.kernel.org>; Fri, 17 May 2013 10:20:14 -0700 (PDT)
In-Reply-To: <20130514190616.GU6795@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Csaba =?utf-8?q?Hal=C3=A1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

--Boundary-00=_LbmlReVIpXPkzw9
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Le mardi 14 mai 2013 21:06:16, Tejun Heo a =E9crit :
> Patch looks correct to me but can you please put more detail into the
> description preferably with a link to this thread?

Updated & attached. I write one (trivial) kernel commit message every 3 yea=
rs,=20
so please correct me if there is a more consistent way to present it.

> As for why atapi_dmadir isn't enabled by default, my memory is extremely
> fuzzy now but ISTR it to be deprecated and cause issues with some devices.

As atapi_id_dmadir() doesn't detect the bridge needs DMADIR, for now I need=
 to=20
enable it globally.
This means it doesn't work out of the box, and needs a reboot to work as=20
atapi_dmadir is read-only in sysfs. Also, if it causes regression with othe=
r=20
drives, maybe one would gain a drive by enabling DMADIR but loose another.

=46rom my (very limited) understanding, the bridge just passes the drive's =
"id"=20
(as in "atapi_id_dmadir(dev->id)") through. Is there another way to detect=
=20
such bridge ? Other things atapi_id_dmadir() should look for in "id" ?

If not, would it be possible to have a rw sysfs pseudofile per-device (...p=
er=20
port ?) to enable DMADIR ?

If not, what about making atapi_dmadir sysfs pseudofile rw, to save a reboo=
t ?

Would you have more ideas on how it could be solved ?

I'm willing to give a try to any of these options if they have a chance to =
get=20
somewhere.

Regards,
=2D-=20
Vincent Pelletier

--Boundary-00=_LbmlReVIpXPkzw9
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-libata-make-ata_exec_internal_sg-honor-DMADIR.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-libata-make-ata_exec_internal_sg-honor-DMADIR.patch"

=46rom beca064485e3c86e4abe08b9ce5c89b33ed8c780 Mon Sep 17 00:00:00 2001
Message-Id: <beca064485e3c86e4abe08b9ce5c89b33ed8c780.1368810901.git.plr.vi=
ncent@gmail.com>
=46rom: Vincent Pelletier <plr.vincent@gmail.com>
Date: Fri, 17 May 2013 19:09:05 +0200
Subject: libata: make ata_exec_internal_sg honor DMADIR
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

=46ixes SATA-to-PATA bridge "Abit Serillel 2" when used on an ATAPI device,
which otherwise fails several tries with a timeout until it gets disabled:

  kernel: ata5.00: qc timeout (cmd 0xa0)
  kernel: ata5.00: failed to clear UNIT ATTENTION (err_mask=3D0x5)
  kernel: ata5.00: disabled

Based on a patch by Csaba Hal=C3=A1sz <csaba.halasz@gmail.com> on linux-ide:
http://marc.info/?l=3Dlinux-ide&m=3D136121147832295&w=3D2

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


--Boundary-00=_LbmlReVIpXPkzw9--
