From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: turn selectproc() method into dev_select() method
Date: Fri, 20 Mar 2009 20:02:53 +0100
Message-ID: <200903202002.55510.bzolnier@gmail.com>
References: <200903191831.43621.sshtylyov@ru.mvista.com> <49C2688A.3070808@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:48187 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbZCTTHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Mar 2009 15:07:01 -0400
Received: by bwz17 with SMTP id 17so1009786bwz.37
        for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2009 12:06:58 -0700 (PDT)
In-Reply-To: <49C2688A.3070808@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org

On Thursday 19 March 2009, Sergei Shtylyov wrote:
> Hello, I wrote:
>=20
> > Turn selectproc() method into dev_select() method by teaching it to=
 write to the
> > device register and moving it from 'struct ide_port_ops' to 'struct=
 ide_tp_ops'.
>=20
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>=20
> [...]
>=20
> > Index: linux-2.6/drivers/ide/trm290.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.orig/drivers/ide/trm290.c
> > +++ linux-2.6/drivers/ide/trm290.c
> > @@ -171,10 +171,11 @@ static void trm290_prepare_drive (ide_dr
> >  	local_irq_restore(flags);
> >  }
> > =20
> > -static void trm290_selectproc (ide_drive_t *drive)
> > +static void trm290_dev_select(ide_drive_t *drive)
> >  {
> >  	trm290_prepare_drive(drive, !!(drive->dev_flags & IDE_DFLAG_USING=
_DMA));
> > -}
> > +
> > +	outb(drive->select | ATA_DEVICE_OBS, drive->hwif->io_ports.device=
_addr);}
>=20
>     Oops, I keep forgetting about running checkpatch.pl first. :-<
>     Bart, do I need to repost, or you can fix it while applying?

fixed while applying

ditto for:

drivers/ide/ns87415.c:314: error: =E2=80=98ns87415_tp_ops=E2=80=99 unde=
clared here (not in a function)
make[1]: *** [drivers/ide/ns87415.o] Error 1
make: *** [drivers/ide/ns87415.o] Error 2
