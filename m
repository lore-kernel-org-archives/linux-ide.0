From: Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2] support for PMP used in TT BlackX Duet drive dock
Date: Thu, 28 Apr 2011 22:32:54 +0200
Message-ID: <201104282232.54770.morpheus.ibis@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_27cuNXFwaELdVNA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60725 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab1D1UdE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Apr 2011 16:33:04 -0400
Received: by fxm17 with SMTP id 17so2079162fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 28 Apr 2011 13:33:03 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

--Boundary-00=_27cuNXFwaELdVNA
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Please note the comments have been changed to better explain the PMP behaviour

--Boundary-00=_27cuNXFwaELdVNA
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-libata-pmp-add-support-for-Thermaltake-BlackX-Duet-e.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-libata-pmp-add-support-for-Thermaltake-BlackX-Duet-e.patch"

=46rom 558ac1479ef159dddad7ee2842f629ed2095ada9 Mon Sep 17 00:00:00 2001
=46rom: Pavel Herrmann <morpheus.ibis@gmail.com>
Date: Thu, 7 Apr 2011 18:15:26 +0200
Subject: [PATCH] libata-pmp: add support for Thermaltake BlackX Duet esata
 drive dock

some errors still show up, but the dock works, both drives can be
accessed at the same time

the chip maker and designation is unknown - possibly jmicron JMB350?

Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
=2D--
 drivers/ata/libata-pmp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 3120596..f06b7ea 100644
=2D-- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -449,6 +449,16 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |=3D ATA_LFLAG_NO_RETRY;
+	} else if (vendor =3D=3D 0x197b && devid =3D=3D 0x2352) {
+		/* chip found in Thermaltake BlackX Duet, jmicron JMB350? */
+		ata_for_each_link(link, ap, EDGE) {
+			/* SRST breaks detection and disks get misclassified
+			 * LPM disabled to avoid potential problems
+			 */
+			link->flags |=3D ATA_LFLAG_NO_LPM |
+				       ATA_LFLAG_NO_SRST |
+				       ATA_LFLAG_ASSUME_ATA;
+		}
 	}
 }
=20
=2D-=20
1.7.5.rc1


--Boundary-00=_27cuNXFwaELdVNA--
