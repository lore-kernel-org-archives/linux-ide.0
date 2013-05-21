From: Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Tue, 21 May 2013 22:37:25 +0200
Message-ID: <201305212237.26212.plr.vincent@gmail.com>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com> <201305202243.15125.plr.vincent@gmail.com> <20130520220238.GA30556@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Gs9mRhYcRNoBXpR"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:58197 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab3EUUhc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 May 2013 16:37:32 -0400
Received: by mail-we0-f180.google.com with SMTP id u56so602323wes.11
        for <linux-ide@vger.kernel.org>; Tue, 21 May 2013 13:37:30 -0700 (PDT)
In-Reply-To: <20130520220238.GA30556@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Csaba =?utf-8?q?Hal=C3=A1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

--Boundary-00=_Gs9mRhYcRNoBXpR
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi.

Attached should be the final patches, unless someone has objections.

Changes since previous version:
- noatapi_dmadir dropped
- flag documented
- slight change to 2/2 commit message
- tested

Regards,
-- 
Vincent Pelletier

--Boundary-00=_Gs9mRhYcRNoBXpR
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-libata-make-ata_exec_internal_sg-honor-DMADIR.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-libata-make-ata_exec_internal_sg-honor-DMADIR.patch"

=46rom a2fe028e6736afa9d6b6612c713844c411ffca5c Mon Sep 17 00:00:00 2001
Message-Id: <a2fe028e6736afa9d6b6612c713844c411ffca5c.1369168262.git.plr.vi=
ncent@gmail.com>
=46rom: Vincent Pelletier <plr.vincent@gmail.com>
Date: Sat, 18 May 2013 18:44:04 +0200
Subject: [1/2] libata: make ata_exec_internal_sg honor DMADIR
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

libata honors DMADIR for regular commands, but not for internal commands
used (among other) during device initialisation.

This makes SATA-host-to-PATA-device bridges based on Silicon Image SiL3611
(such as "Abit Serillel 2") end up disabled when used with an ATAPI device
after a few tries.

Log output of the bridge being hot-plugged with an ATAPI drive:

  [ 9631.212901] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40c0000 action =
0xe frozen
  [ 9631.212913] ata1: irq_stat 0x00000040, connection status changed
  [ 9631.212923] ata1: SError: { CommWake 10B8B DevExch }
  [ 9631.212939] ata1: hard resetting link
  [ 9632.104962] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [ 9632.106393] ata1.00: ATAPI: PIONEER DVD-RW  DVR-115, 1.06, max UDMA/33
  [ 9632.106407] ata1.00: applying bridge limits
  [ 9632.108151] ata1.00: configured for UDMA/33
  [ 9637.105303] ata1.00: qc timeout (cmd 0xa0)
  [ 9637.105324] ata1.00: failed to clear UNIT ATTENTION (err_mask=3D0x5)
  [ 9637.105335] ata1: hard resetting link
  [ 9638.044599] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [ 9638.047878] ata1.00: configured for UDMA/33
  [ 9643.044933] ata1.00: qc timeout (cmd 0xa0)
  [ 9643.044953] ata1.00: failed to clear UNIT ATTENTION (err_mask=3D0x5)
  [ 9643.044963] ata1: limiting SATA link speed to 1.5 Gbps
  [ 9643.044971] ata1.00: limiting speed to UDMA/33:PIO3
  [ 9643.044979] ata1: hard resetting link
  [ 9643.984225] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [ 9643.987471] ata1.00: configured for UDMA/33
  [ 9648.984591] ata1.00: qc timeout (cmd 0xa0)
  [ 9648.984612] ata1.00: failed to clear UNIT ATTENTION (err_mask=3D0x5)
  [ 9648.984619] ata1.00: disabled
  [ 9649.000593] ata1: hard resetting link
  [ 9649.939902] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [ 9649.955864] ata1: EH complete

With this patch, the drive enumerates correctly when libata is loaded with
atapi_dmadir=3D1:

  [ 9891.810863] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40c0000 action =
0xe frozen
  [ 9891.810874] ata1: irq_stat 0x00000040, connection status changed
  [ 9891.810884] ata1: SError: { CommWake 10B8B DevExch }
  [ 9891.810900] ata1: hard resetting link
  [ 9892.762105] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [ 9892.763544] ata1.00: ATAPI: PIONEER DVD-RW  DVR-115, 1.06, max UDMA/33=
, DMADIR
  [ 9892.763558] ata1.00: applying bridge limits
  [ 9892.765393] ata1.00: configured for UDMA/33
  [ 9892.786063] ata1: EH complete
  [ 9892.792062] scsi 0:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-115  =
1.06 PQ: 0 ANSI: 5
  [ 9892.798455] sr2: scsi3-mmc drive: 12x/12x writer dvd-ram cd/rw xa/form=
2 cdda tray
  [ 9892.798837] sr 0:0:0:0: Attached scsi CD-ROM sr2
  [ 9892.799109] sr 0:0:0:0: Attached scsi generic sg6 type 5

Based on a patch by Csaba Hal=C3=A1sz <csaba.halasz@gmail.com> on linux-ide:
http://marc.info/?l=3Dlinux-ide&m=3D136121147832295&w=3D2

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
=2D--
 drivers/ata/libata-core.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 63c743b..16c3345 100644
=2D-- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1602,6 +1602,10 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	qc->tf =3D *tf;
 	if (cdb)
 		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
+	if (tf->protocol =3D=3D ATAPI_PROT_DMA && dev->flags & ATA_DFLAG_DMADIR &&
+	    dma_dir =3D=3D DMA_FROM_DEVICE)
+		/* some SATA bridges need us to indicate data xfer direction */
+		qc->tf.feature |=3D ATAPI_DMADIR;
 	qc->flags |=3D ATA_QCFLAG_RESULT_TF;
 	qc->dma_dir =3D dma_dir;
 	if (dma_dir !=3D DMA_NONE) {
=2D-=20
1.7.10.4


--Boundary-00=_Gs9mRhYcRNoBXpR
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0002-libata-Add-atapi_dmadir-force-flag.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0002-libata-Add-atapi_dmadir-force-flag.patch"

=46rom 0fbfe1b12661030142a91cbae4d452d97440b2f6 Mon Sep 17 00:00:00 2001
Message-Id: <0fbfe1b12661030142a91cbae4d452d97440b2f6.1369168262.git.plr.vi=
ncent@gmail.com>
In-Reply-To: <a2fe028e6736afa9d6b6612c713844c411ffca5c.1369168262.git.plr.v=
incent@gmail.com>
References: <a2fe028e6736afa9d6b6612c713844c411ffca5c.1369168262.git.plr.vi=
ncent@gmail.com>
=46rom: Vincent Pelletier <plr.vincent@gmail.com>
Date: Tue, 21 May 2013 22:30:58 +0200
Subject: [2/2] libata: Add atapi_dmadir force flag

Some device require DMADIR to be enabled, but are not detected as such by
atapi_id_dmadir.
One such example is "Asus Serillel 2" SATA-host-to-PATA-device bridge: the
bridge itself requires DMADIR, even if the bridged device does not.

As atapi_dmadir module parameter can cause problems with some devices
(as per Tejun Heo's memory), enabling it globally may not be possible
depending on the hardware.

This patch adds atapi_dmadir in the form of a "force" horkage value,
allowing global, per-bus and per-device control.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
=2D--
 Documentation/kernel-parameters.txt |    2 ++
 drivers/ata/libata-core.c           |    3 ++-
 include/linux/libata.h              |    1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-par=
ameters.txt
index 8ccbf27..c679714 100644
=2D-- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1414,6 +1414,8 @@ bytes respectively. Such letter suffixes can also be =
entirely omitted.
=20
 			* dump_id: dump IDENTIFY data.
=20
+			* atapi_dmadir: Enable ATAPI DMADIR bridge support
+
 			If there are multiple matching configurations changing
 			the same attribute, the last one is used.
=20
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 16c3345..7db6375 100644
=2D-- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2399,7 +2399,7 @@ int ata_dev_configure(struct ata_device *dev)
 			cdb_intr_string =3D ", CDB intr";
 		}
=20
=2D		if (atapi_dmadir || atapi_id_dmadir(dev->id)) {
+		if (atapi_dmadir || (dev->horkage & ATA_HORKAGE_ATAPI_DMADIR) || atapi_i=
d_dmadir(dev->id)) {
 			dev->flags |=3D ATA_DFLAG_DMADIR;
 			dma_dir_string =3D ", DMADIR";
 		}
@@ -6498,6 +6498,7 @@ static int __init ata_parse_force_one(char **cur,
 		{ "nosrst",	.lflags		=3D ATA_LFLAG_NO_SRST },
 		{ "norst",	.lflags		=3D ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST },
 		{ "rstonce",	.lflags		=3D ATA_LFLAG_RST_ONCE },
+		{ "atapi_dmadir", .horkage_on	=3D ATA_HORKAGE_ATAPI_DMADIR },
 	};
 	char *start =3D *cur, *p =3D *cur;
 	char *id, *val, *endp;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index eae7a05..9a4c194 100644
=2D-- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -399,6 +399,7 @@ enum {
 	ATA_HORKAGE_BROKEN_FPDMA_AA	=3D (1 << 15),	/* skip AA */
 	ATA_HORKAGE_DUMP_ID	=3D (1 << 16),	/* dump IDENTIFY data */
 	ATA_HORKAGE_MAX_SEC_LBA48 =3D (1 << 17),	/* Set max sects to 65535 */
+	ATA_HORKAGE_ATAPI_DMADIR =3D (1 << 18),	/* device requires dmadir */
=20
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
=2D-=20
1.7.10.4


--Boundary-00=_Gs9mRhYcRNoBXpR--
