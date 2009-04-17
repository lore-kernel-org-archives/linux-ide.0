From: Zhenwen Xu <helight.xu@gmail.com>
Subject: [PATCH]v2 fix error on drivers/ata/pata_legacy.c
Date: Fri, 17 Apr 2009 14:20:04 +0800
Message-ID: <20090417062004.GA6201@helight>
Reply-To: Zhenwen Xu <helight.xu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:16110 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbZDQGVe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Apr 2009 02:21:34 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

fix those errors:

drivers/ata/pata_legacy.c: In function =E2=80=98pdc_data_xfer_vlb=E2=80=
=99:
drivers/ata/pata_legacy.c:289: error: =E2=80=98ap=E2=80=99 undeclared (=
first use in this function)
drivers/ata/pata_legacy.c:289: error: (Each undeclared identifier is re=
ported only once
drivers/ata/pata_legacy.c:289: error: for each function it appears in.)
drivers/ata/pata_legacy.c: At top level:
drivers/ata/pata_legacy.c:869: error: =E2=80=98ATA_PFLAG_PIO32_CHANGE=E2=
=80=99 undeclared here (not in a
+function)
make[2]: *** [drivers/ata/pata_legacy.o] Error 1
make[1]: *** [drivers/ata] Error 2


=46rom 80584279bc9dbc2d5dbb7c9dcfd4dcc6b39ad70c Mon Sep 17 00:00:00 200=
1
=46rom: Zhenwen Xu <Helight.Xu@gmail.com>
Date: Fri, 17 Apr 2009 14:18:18 +0800
Subject: [PATCH] fix error on drivers/ata/pata_legacy.c

Signed-off-by: Zhenwen Xu <helight.xu@gmail.com>
---
 drivers/ata/pata_legacy.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 6f985be..bb30589 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -285,10 +285,11 @@ static unsigned int pdc_data_xfer_vlb(struct ata_=
device *dev,
 			unsigned char *buf, unsigned int buflen, int rw)
 {
 	int slop =3D buflen & 3;
+	struct ata_port *ap =3D dev->link->ap;
+
 	/* 32bit I/O capable *and* we need to write a whole number of dwords =
*/
 	if (ata_id_has_dword_io(dev->id) && (slop =3D=3D 0 || slop =3D=3D 3)
 					&& (ap->pflags & ATA_PFLAG_PIO32)) {
-		struct ata_port *ap =3D dev->link->ap;
 		unsigned long flags;
=20
 		local_irq_save(flags);
@@ -866,7 +867,7 @@ static struct legacy_controller controllers[] =3D {
 			0,			0,			NULL },
 	{"PDC20230",	&pdc20230_port_ops,	0x7,
 			ATA_FLAG_NO_IORDY,
-			ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32_CHANGE,	NULL },
+			ATA_PFLAG_PIO32 | ATA_PFLAG_PIO32CHANGE,	NULL },
 	{"HT6560A",	&ht6560a_port_ops,	0x07,
 			ATA_FLAG_NO_IORDY,	0,			NULL },
 	{"HT6560B",	&ht6560b_port_ops,	0x1F,
--=20
1.5.6.5

--=20
---------------------------------
Zhenwen Xu - Open and Free
Home Page:	http://zhwen.org
My Studio:	http://dim4.cn
