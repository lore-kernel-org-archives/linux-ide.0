From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide: ide-cd_ioctl.c fix sparse integer as NULL pointer
	warnings
Date: Sun, 6 Jul 2008 09:26:19 +0200
Message-ID: <20080706072619.GB31524@gollum.tnic>
References: <1215215213.27271.2.camel@brick>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:14679 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYGFH0Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 03:26:24 -0400
Received: by ik-out-1112.google.com with SMTP id c28so816583ika.5
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 00:26:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1215215213.27271.2.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>, bzolnier@gmail.com
Cc: linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Fri, Jul 04, 2008 at 04:46:53PM -0700, Harvey Harrison wrote:
> The function ide_cd_queue_pc should be checked as the bufflen arg is
> dereferenced and lots of callers are passing in NULL.
>=20
> drivers/ide/ide-cd_ioctl.c:124:46: warning: Using plain integer as NU=
LL pointer
> drivers/ide/ide-cd_ioctl.c:149:47: warning: Using plain integer as NU=
LL pointer
> drivers/ide/ide-cd_ioctl.c:231:46: warning: Using plain integer as NU=
LL pointer
> drivers/ide/ide-cd_ioctl.c:374:46: warning: Using plain integer as NU=
LL pointer
>=20
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>

Acked-by: Borislav Petkov <petkovbb@gmail.com>

> ---
>  drivers/ide/ide-cd_ioctl.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
> index fbacb7c..3a2ffd0 100644
> --- a/drivers/ide/ide-cd_ioctl.c
> +++ b/drivers/ide/ide-cd_ioctl.c
> @@ -121,7 +121,7 @@ int cdrom_eject(ide_drive_t *drive, int ejectflag=
,
>  	cmd[0] =3D GPCMD_START_STOP_UNIT;
>  	cmd[4] =3D loej | (ejectflag !=3D 0);
> =20
> -	return ide_cd_queue_pc(drive, cmd, 0, NULL, 0, sense, 0, 0);
> +	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sense, 0, 0);
>  }
> =20
>  /* Lock the door if LOCKFLAG is nonzero; unlock it otherwise. */
> @@ -146,7 +146,7 @@ int ide_cd_lockdoor(ide_drive_t *drive, int lockf=
lag,
>  		cmd[0] =3D GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL;
>  		cmd[4] =3D lockflag ? 1 : 0;
> =20
> -		stat =3D ide_cd_queue_pc(drive, cmd, 0, NULL, 0,
> +		stat =3D ide_cd_queue_pc(drive, cmd, 0, NULL, NULL,
>  				       sense, 0, 0);
>  	}
> =20
> @@ -228,7 +228,7 @@ int ide_cdrom_select_speed(struct cdrom_device_in=
fo *cdi, int speed)
>  		cmd[5] =3D speed & 0xff;
>  	}
> =20
> -	stat =3D ide_cd_queue_pc(drive, cmd, 0, NULL, 0, &sense, 0, 0);
> +	stat =3D ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, &sense, 0, 0);
> =20
>  	if (!ide_cdrom_get_capabilities(drive, buf)) {
>  		ide_cdrom_update_speed(drive, buf);
> @@ -371,7 +371,7 @@ static int ide_cd_fake_play_trkind(ide_drive_t *d=
rive, void *arg)
>  	lba_to_msf(lba_start,   &cmd[3], &cmd[4], &cmd[5]);
>  	lba_to_msf(lba_end - 1, &cmd[6], &cmd[7], &cmd[8]);
> =20
> -	return ide_cd_queue_pc(drive, cmd, 0, NULL, 0, &sense, 0, 0);
> +	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, &sense, 0, 0);
>  }
> =20
>  static int ide_cd_read_tochdr(ide_drive_t *drive, void *arg)
> --=20
> 1.5.6.1.322.ge904b
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Regards/Gru=DF,
    Boris.
