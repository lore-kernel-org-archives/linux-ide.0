From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] libata: make ata_exec_internal_sg honor DMADIR
Date: Wed, 22 May 2013 08:32:58 +0900
Message-ID: <20130521233258.GB6985@mtj.dyndns.org>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com>
 <201305202243.15125.plr.vincent@gmail.com>
 <20130520220238.GA30556@mtj.dyndns.org>
 <201305212237.26212.plr.vincent@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:55942 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3EUXdD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 May 2013 19:33:03 -0400
Received: by mail-pb0-f53.google.com with SMTP id un4so1108040pbc.12
        for <linux-ide@vger.kernel.org>; Tue, 21 May 2013 16:33:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201305212237.26212.plr.vincent@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Pelletier <plr.vincent@gmail.com>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?Q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to libata/for-3.10-fixes w/ stable cc'd.

Thanks a lot!

=46rom e771451c0a831d96a7c14b0ca8a8ec671d98567b Mon Sep 17 00:00:00 200=
1
=46rom: Vincent Pelletier <plr.vincent@gmail.com>
Date: Sat, 18 May 2013 18:44:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

libata honors DMADIR for regular commands, but not for internal command=
s
used (among other) during device initialisation.

This makes SATA-host-to-PATA-device bridges based on Silicon Image SiL3=
611
(such as "Abit Serillel 2") end up disabled when used with an ATAPI dev=
ice
after a few tries.

Log output of the bridge being hot-plugged with an ATAPI drive:

  [ 9631.212901] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40c0000 act=
ion 0xe frozen
  [ 9631.212913] ata1: irq_stat 0x00000040, connection status changed
  [ 9631.212923] ata1: SError: { CommWake 10B8B DevExch }
  [ 9631.212939] ata1: hard resetting link
  [ 9632.104962] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [ 9632.106393] ata1.00: ATAPI: PIONEER DVD-RW  DVR-115, 1.06, max UDM=
A/33
  [ 9632.106407] ata1.00: applying bridge limits
  [ 9632.108151] ata1.00: configured for UDMA/33
  [ 9637.105303] ata1.00: qc timeout (cmd 0xa0)
  [ 9637.105324] ata1.00: failed to clear UNIT ATTENTION (err_mask=3D0x=
5)
  [ 9637.105335] ata1: hard resetting link
  [ 9638.044599] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [ 9638.047878] ata1.00: configured for UDMA/33
  [ 9643.044933] ata1.00: qc timeout (cmd 0xa0)
  [ 9643.044953] ata1.00: failed to clear UNIT ATTENTION (err_mask=3D0x=
5)
  [ 9643.044963] ata1: limiting SATA link speed to 1.5 Gbps
  [ 9643.044971] ata1.00: limiting speed to UDMA/33:PIO3
  [ 9643.044979] ata1: hard resetting link
  [ 9643.984225] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [ 9643.987471] ata1.00: configured for UDMA/33
  [ 9648.984591] ata1.00: qc timeout (cmd 0xa0)
  [ 9648.984612] ata1.00: failed to clear UNIT ATTENTION (err_mask=3D0x=
5)
  [ 9648.984619] ata1.00: disabled
  [ 9649.000593] ata1: hard resetting link
  [ 9649.939902] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
  [ 9649.955864] ata1: EH complete

With this patch, the drive enumerates correctly when libata is loaded w=
ith
atapi_dmadir=3D1:

  [ 9891.810863] ata1: exception Emask 0x10 SAct 0x0 SErr 0x40c0000 act=
ion 0xe frozen
  [ 9891.810874] ata1: irq_stat 0x00000040, connection status changed
  [ 9891.810884] ata1: SError: { CommWake 10B8B DevExch }
  [ 9891.810900] ata1: hard resetting link
  [ 9892.762105] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  [ 9892.763544] ata1.00: ATAPI: PIONEER DVD-RW  DVR-115, 1.06, max UDM=
A/33, DMADIR
  [ 9892.763558] ata1.00: applying bridge limits
  [ 9892.765393] ata1.00: configured for UDMA/33
  [ 9892.786063] ata1: EH complete
  [ 9892.792062] scsi 0:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-1=
15  1.06 PQ: 0 ANSI: 5
  [ 9892.798455] sr2: scsi3-mmc drive: 12x/12x writer dvd-ram cd/rw xa/=
form2 cdda tray
  [ 9892.798837] sr 0:0:0:0: Attached scsi CD-ROM sr2
  [ 9892.799109] sr 0:0:0:0: Attached scsi generic sg6 type 5

Based on a patch by Csaba Hal=E1sz <csaba.halasz@gmail.com> on linux-id=
e:
http://marc.info/?l=3Dlinux-ide&m=3D136121147832295&w=3D2

tj: minor formatting changes.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d35524c..f218427 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1602,6 +1602,12 @@ unsigned ata_exec_internal_sg(struct ata_device =
*dev,
 	qc->tf =3D *tf;
 	if (cdb)
 		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
+
+	/* some SATA bridges need us to indicate data xfer direction */
+	if (tf->protocol =3D=3D ATAPI_PROT_DMA && (dev->flags & ATA_DFLAG_DMA=
DIR) &&
+	    dma_dir =3D=3D DMA_FROM_DEVICE)
+		qc->tf.feature |=3D ATAPI_DMADIR;
+
 	qc->flags |=3D ATA_QCFLAG_RESULT_TF;
 	qc->dma_dir =3D dma_dir;
 	if (dma_dir !=3D DMA_NONE) {
--=20
1.8.1.4

