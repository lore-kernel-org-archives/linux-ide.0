From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_it821x: (partially) fix DMA in RAID mode
Date: Mon, 11 Jun 2007 00:52:18 -0400
Message-ID: <466CD502.6010201@garzik.org>
References: <200706101843.20947.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42048 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714AbXFKEwY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jun 2007 00:52:24 -0400
In-Reply-To: <200706101843.20947.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>

Bartlomiej Zolnierkiewicz wrote:
> Code intended to check DMA status was checking DMA command register.
>=20
> Moreover firmware seems to "forget" to set DMA capable bit for the
> slave device (at least in RAID mode but without ITE RAID volumes) so
> check device ID for DMA capable bit when deciding whether to use DMA
> and remove DMA status check completely.
>=20
> Thanks to Pavol =A9imo for the bugreport and testing the initial fix.
>=20
> This change unfortunately still doesn't fix DMA in RAID mode (which
> works fine with IDE it821x) but Alan is working on the missing pieces
> (pata_it821x vs libata EH issues).
>=20
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Tejun Heo <htejun@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ---
>=20
>  drivers/ata/pata_it821x.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Patch is OK but it's mangled by your mailer:

@@ -79,7 +80,7 @@
=3D20
=3D20
  #define DRV_NAME "pata_it821x"
=3D2D#define DRV_VERSION "0.3.6"
+#define DRV_VERSION "0.3.7"
=3D20
  struct it821x_dev
  {
@@ -460,14 +461,8 @@ static unsigned int it821x_passthru_qc_i
=3D20

=3D2D     int dma_enabled =3D3D 0;
         int i;
=3D20

etc.

