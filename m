From: Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: Re: [PATCH] support for PMP used in TT BlackX Duet drive dock
Date: Thu, 7 Apr 2011 19:08:10 +0200
Message-ID: <201104071908.10852.morpheus.ibis@gmail.com>
References: <201104071854.10911.morpheus.ibis@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_69enNsE7TXK5A8p"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59117 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756237Ab1DGRIO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2011 13:08:14 -0400
Received: by fxm17 with SMTP id 17so1810639fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 07 Apr 2011 10:08:13 -0700 (PDT)
In-Reply-To: <201104071854.10911.morpheus.ibis@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_69enNsE7TXK5A8p
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Thursday 07 of April 2011 18:54:10 I wrote:
> Hi,
> 
> Current linux kernel failes to communicate with PMP chip used in
> Thermaltake BlackX Duet (ST0015E) external drive, adding same quirks (some
> of them may not be necessary) as other chips have fixes it (tested on AHCI
> driver, on JMB363 and ICH10R)
> 
> Please note that this patch is purposefully not in state includable in
> mainline, it is meant as a base for someone with more understanding of
> libata to make a proper fix
> 
> Thanks
> Pavel Herrmann

the patch included in the last mail had a copy/paste error, this one is fixed

Pavel Herrmann

--Boundary-00=_69enNsE7TXK5A8p
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-libata-pmp-add-support-for-Thermaltake-BlackX-Duet-e.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-libata-pmp-add-support-for-Thermaltake-BlackX-Duet-e.patch"

=46rom 55617331f5d1ef24f7fb60f9640a2363e3649cdf Mon Sep 17 00:00:00 2001
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
index 3120596..abc8474 100644
=2D-- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -449,6 +449,14 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |=3D ATA_LFLAG_NO_RETRY;
+	} else if (vendor =3D=3D 0x1095 && devid =3D=3D 0x4726) {
+		/* chip found in Thermaltake BlackX Duet */
+		ata_for_each_link(link, ap, EDGE) {
+			/* Use same quirks as sil chips	to make it work */
+			link->flags |=3D ATA_LFLAG_NO_LPM |
+				       ATA_LFLAG_NO_SRST |
+				       ATA_LFLAG_ASSUME_ATA;
+		}
 	}
 }
=20
=2D-=20
1.7.4.1


--Boundary-00=_69enNsE7TXK5A8p--
