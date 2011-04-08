From: Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: Re: [PATCH] support for PMP used in TT BlackX Duet drive dock
Date: Fri, 8 Apr 2011 10:05:37 +0200
Message-ID: <201104081005.37191.morpheus.ibis@gmail.com>
References: <201104071854.10911.morpheus.ibis@gmail.com> <201104072140.59548.morpheus.ibis@gmail.com> <4D9E9605.7030304@garzik.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RHsnNdJ9G94azeB"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58213 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089Ab1DHIFl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Apr 2011 04:05:41 -0400
Received: by fxm17 with SMTP id 17so2173247fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 08 Apr 2011 01:05:40 -0700 (PDT)
In-Reply-To: <4D9E9605.7030304@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

--Boundary-00=_RHsnNdJ9G94azeB
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 08 of April 2011 06:58:45 Jeff Garzik wrote:
> So you're gonna resend this as a real patch, right?  :)

right :)

this is the tested version (call it V2 if you wish), against 29-rc2 and 28-
gentoo-r1 (no difference in this file), works in both

I still have no idea what those quirks really do, so test before including

thanks
Pavel Herrmann

--Boundary-00=_RHsnNdJ9G94azeB
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-libata-pmp-add-support-for-Thermaltake-BlackX-Duet-e.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-libata-pmp-add-support-for-Thermaltake-BlackX-Duet-e.patch"

=46rom a7b09f275faca338805fd697ab41fd13d7f21d41 Mon Sep 17 00:00:00 2001
=46rom: Pavel Herrmann <morpheus.ibis@gmail.com>
Date: Thu, 7 Apr 2011 18:15:26 +0200
Subject: [PATCH] libata-pmp: add support for Thermaltake BlackX Duet esata =
drive dock

some errors still show up, but the dock works, both drives can be
accessed at the same time

the chip maker and designation is unknown - possibly jmicron JMB350?

Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
=2D--
 drivers/ata/libata-pmp.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 3120596..e6e409d 100644
=2D-- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -449,6 +449,16 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |=3D ATA_LFLAG_NO_RETRY;
+	} else if (vendor =3D=3D 0x197b && devid =3D=3D 0x2352) {
+		/* chip found in Thermaltake BlackX Duet, jmicron JMB350? */
+		ata_for_each_link(link, ap, EDGE) {
+			/* Use same quirks as sil chips	to make it work,
+			 * not everything might be necessary though
+			 */
+			link->flags |=3D ATA_LFLAG_NO_LPM |
+				       ATA_LFLAG_NO_SRST |
+				       ATA_LFLAG_ASSUME_ATA;
+		}
 	}
 }
=20
=2D-=20
1.7.4.1


--Boundary-00=_RHsnNdJ9G94azeB--
