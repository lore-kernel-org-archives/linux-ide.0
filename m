From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: Don't trust current capacity values in identify
 words 57-58
Date: Mon, 16 Feb 2009 18:01:06 -0500
Message-ID: <4999F032.6060107@rtr.ca>
References: <4999CA54.1060306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:37762 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbZBPXBH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Feb 2009 18:01:07 -0500
In-Reply-To: <4999CA54.1060306@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, =?UTF-8?B?SGFubm8gQsO2Y2s=?= <hanno@hboeck.de>

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
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>
=2E.
>  	} else {
>  		if (ata_id_current_chs_valid(id))
> -			return ata_id_u32(id, 57);
> +			return id[54] * id[55] * id[56];
>  		else
>  			return id[1] * id[3] * id[6];
=2E.

NAK.  That's not quite correct, either.

The LBA capacity can be larger than the CHS capacity,
so we have to use the reported LBA values if at all possible.

That's why ata_id_is_lba_capacity_ok() exists,
and why it looks so peculiar.

Some of those early drives really did require that kind of logic.

Cheers

