From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: can't use SSD/non-rotational queue flag for all
 CFA devices
Date: Tue, 06 Jan 2009 00:20:54 +0300
Message-ID: <496279B6.5080802@ru.mvista.com>
References: <200901051951.29692.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:64610 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751871AbZAEVVA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2009 16:21:00 -0500
In-Reply-To: <200901051951.29692.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Some rotating disks also present themselves as CFA devices.
>
> Reported-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>  =20

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-disk.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -633,7 +633,7 @@ static void ide_disk_setup(ide_drive_t *
>  	printk(KERN_INFO "%s: max request size: %dKiB\n", drive->name,
>  		q->max_sectors / 2);
> =20
> -	if (ata_id_is_ssd(id) || ata_id_is_cfa(id))
> +	if (ata_id_is_ssd(id))
>  		queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
> =20
>  	/* calculate drive capacity, and select LBA if possible */
> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=96)=DE=BA{=
=2En=C7+=89=B7=A5=8A{=B1=89=D7=A2=9E=D8^n=87r=A1=F6=A6z=CB=1A=81=EBh=99=
=A8=E8=AD=DA&=A2=F8=1E=AEG=AB=9D=E9h=AE=03(=AD=E9=9A=8E=8A=DD=A2j"=9D=FA=
=1A=B6=1Bm=A7=FF=EF=81=EA=E4z=B9=DE=96=8A=E0=FEf=A3=A2=B7h=9A=88=A7~=88=
mml=3D=3D

Hm, why your Kmail base64-encodes plain English messages and adds this=20
kind of binary crap?

MBR, Sergei


