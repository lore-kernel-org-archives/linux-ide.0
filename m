From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Tue, 12 May 2009 18:41:32 +0200
Message-ID: <200905121841.32576.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <200905082055.29993.bzolnier@gmail.com> <4A082621.7030008@inov.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50489 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbZELRTq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2009 13:19:46 -0400
Received: by fxm2 with SMTP id 2so109036fxm.37
        for <linux-ide@vger.kernel.org>; Tue, 12 May 2009 10:19:45 -0700 (PDT)
In-Reply-To: <4A082621.7030008@inov.pt>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-15?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

On Monday 11 May 2009 15:20:33 Jo=E3o Ramos wrote:
>=20
> >>>>    =20
> >>>>        =20
> >>> Well, yes.  Though I hoped that you would at least give a try to =
fixing
> >>> IDE core to program PIO0 initially for all host drivers that impl=
ement
> >>> ->set_pio_mode method...
> >>>  =20
> >>>      =20
> >> Sorry, I didn't noticed your hint... Sure, I can give it a try ;-)
> >> Maybe with a little help, but I can try. You mean, when the host d=
river=20
> >> is registered (ide_host_register, or ide_host_add that later calls=
=20
> >> ide_host_register), maybe in the 'ide_init_port' method (sorry, I =
need=20
> >> some guidance here...) check if the 'set_pio_mode' method is=20
> >> implemented, and after initializing each port (d->init_hwif(hwif))=
=20
> >> default it to PIO Mode 0, calling set_pio_mode method.
> >>    =20
> >
> > ide_init_port() seems OK but I think that ide_port_init_devices()
> > [it is called after ide_init_port()] would be a bit safer and more
> > flexible (some host drivers may also require special ->init_dev
> > setup first) and the check for ->set_pio_mode method presence can
> > be done just before actually using the method, i.e.
> >
> > 	const struct ide_port_ops *port_ops =3D hwif->port_ops;
> >
> > 	if (port_ops && port_ops->set_pio_mode)
> > 		port_ops->set_pio_mode(...)
> >
> >  =20
>=20
> Ok, so the patch for this is attached in this e-mail.
>=20
> Please confirm and make your comments.

--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1031,6 +1031,13 @@ static void ide_port_init_devices(ide_hwif_t *hw=
if)
=20
 		if (port_ops && port_ops->init_dev)
 			port_ops->init_dev(drive);
+
+		/*
+		 * if driver uses PIO mode, default to PIO Mode 0 before we
+		 * figure out the most suited mode for the attached device
+		 */
+		if (port_ops && port_ops->set_pio_mode)
+			port_ops->set_pio_mode(drive, 0);
 	}
 }
=20
Looks good but please move this into a separate ide_port_for_each_dev()
loop (some host drivers require full initial setup of both devices on
the port before ->set_pio_mode can be called).
