From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2] libata: Don't trust current capacity values in identify
 words 57-58
Date: Tue, 17 Feb 2009 14:32:23 +0300
Message-ID: <499AA047.70502@ru.mvista.com>
References: <4999CA54.1060306@gmail.com> <4999CFEB.3030204@ru.mvista.com> <499A1DAC.6090200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:20686 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751123AbZBQLcb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Feb 2009 06:32:31 -0500
In-Reply-To: <499A1DAC.6090200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, =?UTF-8?B?SGFubm8=?= =?UTF-8?B?IELDtmNr?= <hanno@hboeck.de>

Hello.

Robert Hancock wrote:

> Hanno B=C3=B6ck reported a problem where an old Conner CP30254 240MB =
hard drive
> was reported as 1.1TB in capacity by libata:
>
> http://lkml.org/lkml/2009/2/13/134
>
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
>
> While we're at it, clean up this function to use named constants for =
the
> identify word values.
>
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>
>  =20

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

   ... though I'm not sure that the rename should be a part of this pat=
ch.

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
>  =20

   It won't hurt to comment on why the capacity is ignored.=20
Unfortunately, the IDE code lacks such comment.

MBR, Sergei


