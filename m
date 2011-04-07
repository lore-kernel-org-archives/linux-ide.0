From: Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH] support for PMP used in TT BlackX Duet drive dock
Date: Thu, 7 Apr 2011 18:54:10 +0200
Message-ID: <201104071854.10911.morpheus.ibis@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ywenNd3j2828Vj8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60961 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab1DGQyP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2011 12:54:15 -0400
Received: by fxm17 with SMTP id 17so1801734fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 07 Apr 2011 09:54:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_ywenNd3j2828Vj8
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Current linux kernel failes to communicate with PMP chip used in Thermaltake 
BlackX Duet (ST0015E) external drive, adding same quirks (some of them may not 
be necessary) as other chips have fixes it (tested on AHCI driver, on JMB363 
and ICH10R)

Please note that this patch is purposefully not in state includable in 
mainline, it is meant as a base for someone with more understanding of libata 
to make a proper fix

Thanks
Pavel Herrmann

--Boundary-00=_ywenNd3j2828Vj8
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-libata-pmp-add-support-for-Thermaltake-BlackX-Duet-e.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-libata-pmp-add-support-for-Thermaltake-BlackX-Duet-e.patch"

=46rom f1c2e6ec61c978846d6d3dadacc7c1b2997140a6 Mon Sep 17 00:00:00 2001
=46rom: Pavel Herrmann <morpheus.ibis@gmail.com>
Date: Thu, 7 Apr 2011 18:15:26 +0200
Subject: [PATCH] libata-pmp: add support for Thermaltake BlackX Duet esata =
drive dock

some errors still show up, but the dock works, both drives can be
accessed at the same time

the chip maker and designation is unknown - possibly jmicron JMB350?

Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
=2D--
 drivers/ata/libata-pmp.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 3120596..9ceef00 100644
=2D-- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -449,6 +449,14 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |=3D ATA_LFLAG_NO_RETRY;
+		}
+	} else if (vendor =3D=3D 0x1095 && devid =3D=3D 0x4726) {
+		/* chip found in Thermaltake BlackX Duet */
+		ata_for_each_link(link, ap, EDGE) {
+			/* Use same quirks as sil chips	to make it work */
+			link->flags |=3D ATA_LFLAG_NO_LPM |
+				       ATA_LFLAG_NO_SRST |
+				       ATA_LFLAG_ASSUME_ATA;
 	}
 }
=20
=2D-=20
1.7.4.1


--Boundary-00=_ywenNd3j2828Vj8--
