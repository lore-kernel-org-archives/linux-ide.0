From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH v2] libata: Don't trust current capacity values in identify
   words 57-58
Date: Mon, 02 Mar 2009 18:53:14 -0600
Message-ID: <49AC7F7A.9020101@gmail.com>
References: <4999CA54.1060306@gmail.com> <4999CFEB.3030204@ru.mvista.com> <499A1DAC.6090200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:53153 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbZCCAxZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 19:53:25 -0500
In-Reply-To: <499A1DAC.6090200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, =?UTF-8?B?SGFubm8gQsO2Y2s=?= <hanno@hboeck.de>

Robert Hancock wrote:
> Hanno B=C3=B6ck reported a problem where an old Conner CP30254 240MB =
hard drive
> was reported as 1.1TB in capacity by libata:
>=20
> http://lkml.org/lkml/2009/2/13/134
>=20
> This was caused by libata trusting the drive's reported current capac=
ity in=20
> sectors in identify words 57 and 58 if the drive does not support LBA=
 and the
> current CHS translation values appear valid. Unfortunately it seems o=
lder
> ATA specs were vague about what this field should contain and a numbe=
r of drives
> used values with wrong byte order or that were totally bogus. There's=
 no
> unique information that it conveys and so we can just calculate the n=
umber
> of sectors from the reported current CHS values.
>=20
> While we're at it, clean up this function to use named constants for =
the
> identify word values.
>=20
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>

Jeff, any thoughts on this one? I would suggest it's -upstream material=
=20
(for .30)..

>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 9fbf059..33b5549 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1322,14 +1322,16 @@ static u64 ata_id_n_sectors(const u16 *id)
>  {
>  	if (ata_id_has_lba(id)) {
>  		if (ata_id_has_lba48(id))
> -			return ata_id_u64(id, 100);
> +			return ata_id_u64(id, ATA_ID_LBA_CAPACITY_2);
>  		else
> -			return ata_id_u32(id, 60);
> +			return ata_id_u32(id, ATA_ID_LBA_CAPACITY);
>  	} else {
>  		if (ata_id_current_chs_valid(id))
> -			return ata_id_u32(id, 57);
> +			return id[ATA_ID_CUR_CYLS] * id[ATA_ID_CUR_HEADS] *
> +			       id[ATA_ID_CUR_SECTORS];
>  		else
> -			return id[1] * id[3] * id[6];
> +			return id[ATA_ID_CYLS] * id[ATA_ID_HEADS] *
> +			       id[ATA_ID_SECTORS];
>  	}
>  }
> =20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

