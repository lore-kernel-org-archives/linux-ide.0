From: Dark Sylinc <dark_sylinc@yahoo.com.ar>
Subject: Re: SATA Shutdown issue confuses (sda)
Date: Thu, 29 Nov 2007 00:49:19 -0300 (ART)
Message-ID: <930126.21016.qm@web56308.mail.re3.yahoo.com>
References: <474E22B6.2020304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web56308.mail.re3.yahoo.com ([216.252.110.232]:39177 "HELO
	web56308.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751441AbXK2DtV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 22:49:21 -0500
In-Reply-To: <474E22B6.2020304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, hmh@debian.org


>  I'm attaching a patch that fixes it. It basically
> follows
>  http://linux-ata.org/shutdown.html and *SKIPS* the
> drive shutdown when
>  the respective
> /sys/block/sdX/device/scsi_disk:*/manage_start_stop
>  exists (leaving it for the kernel to do).
>=20

eeeehhh, I'm ashamed :$ . Now everything makes sense.
Thanks

> >> So, the patch isn't in the package yet?
> >=20
> > I checked yesterday both Debian's unstable and
> > testing, and the patch wasn't there.
>=20
> Eeeeekk....

Dark Sylinc


      Los referentes m=E1s importantes en compra/ venta de autos se jun=
taron:
Demotores y Yahoo!
Ahora comprar o vender tu auto es m=E1s f=E1cil. Vist=E1 ar.autos.yahoo=
=2Ecom/
