From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide: ide-cd.c fix sparse endianness warnings
Date: Sun, 6 Jul 2008 09:25:40 +0200
Message-ID: <20080706072540.GA31524@gollum.tnic>
References: <1215128085.16647.40.camel@brick>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:14477 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbYGFHZv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 03:25:51 -0400
Received: by ik-out-1112.google.com with SMTP id c28so816538ika.5
        for <linux-ide@vger.kernel.org>; Sun, 06 Jul 2008 00:25:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1215128085.16647.40.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Jul 03, 2008 at 04:34:45PM -0700, Harvey Harrison wrote:
> drivers/ide/ide-cd.c:1276:46: warning: Using plain integer as NULL po=
inter
> drivers/ide/ide-cd.c:1298:19: warning: cast to restricted __be32
> drivers/ide/ide-cd.c:1300:4: warning: cast to restricted __be32
> drivers/ide/ide-cd.c:1522:14: warning: cast to restricted __le16
> drivers/ide/ide-cd.c:1523:14: warning: cast to restricted __le16
> drivers/ide/ide-cd.c:1525:14: warning: cast to restricted __be16
> drivers/ide/ide-cd.c:1526:14: warning: cast to restricted __be16
> drivers/ide/ide-cd.c:1667:37: warning: cast to restricted __be16
>=20
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>

Acked-off-by: Borislav Petkov <petkovbb@gmail.com>

> ---
>  drivers/ide/ide-cd.c |   19 ++++++++-----------
>  1 files changed, 8 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 9b4acbe..47c58a8 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -1273,7 +1273,7 @@ int cdrom_check_status(ide_drive_t *drive, stru=
ct request_sense *sense)
>  	 */
>  	cmd[7] =3D cdi->sanyo_slot % 3;
> =20
> -	return ide_cd_queue_pc(drive, cmd, 0, NULL, 0, sense, 0, REQ_QUIET)=
;
> +	return ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, sense, 0, REQ_QUI=
ET);
>  }
> =20
>  static int cdrom_read_capacity(ide_drive_t *drive, unsigned long *ca=
pacity,
> @@ -1281,8 +1281,8 @@ static int cdrom_read_capacity(ide_drive_t *dri=
ve, unsigned long *capacity,
>  			       struct request_sense *sense)
>  {
>  	struct {
> -		__u32 lba;
> -		__u32 blocklen;
> +		__be32 lba;
> +		__be32 blocklen;
>  	} capbuf;
> =20
>  	int stat;
> @@ -1515,15 +1515,12 @@ void ide_cdrom_update_speed(ide_drive_t *driv=
e, u8 *buf)
>  	struct cdrom_info *cd =3D drive->driver_data;
>  	u16 curspeed, maxspeed;
> =20
> -	curspeed =3D *(u16 *)&buf[8 + 14];
> -	maxspeed =3D *(u16 *)&buf[8 +  8];
> -
>  	if (drive->dev_flags & IDE_DFLAG_LE_SPEED_FIELDS) {
> -		curspeed =3D le16_to_cpu(curspeed);
> -		maxspeed =3D le16_to_cpu(maxspeed);
> +		curspeed =3D le16_to_cpup((__le16 *)&buf[8 + 14]);
> +		maxspeed =3D le16_to_cpup((__le16 *)&buf[8 + 8]);
>  	} else {
> -		curspeed =3D be16_to_cpu(curspeed);
> -		maxspeed =3D be16_to_cpu(maxspeed);
> +		curspeed =3D be16_to_cpup((__be16 *)&buf[8 + 14]);
> +		maxspeed =3D be16_to_cpup((__be16 *)&buf[8 + 8]);
>  	}
> =20
>  	cd->current_speed =3D (curspeed + (176/2)) / 176;
> @@ -1664,7 +1661,7 @@ static int ide_cdrom_probe_capabilities(ide_dri=
ve_t *drive)
>  	else
>  		printk(KERN_CONT " drive");
> =20
> -	printk(KERN_CONT ", %dkB Cache\n", be16_to_cpu(*(u16 *)&buf[8 + 12]=
));
> +	printk(KERN_CONT ", %dkB Cache\n", be16_to_cpup((__be16 *)&buf[8 + =
12]));
> =20
>  	return nslots;
>  }
> --=20
> 1.5.6.1.281.g1087e
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Regards/Gru=DF,
    Boris.
