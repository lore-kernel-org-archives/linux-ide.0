From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: blacklist NCQ on OCZ CORE 2 SSD (resend)
Date: Mon, 29 Dec 2008 07:41:25 -0500
Message-ID: <4958C575.5030206@pobox.com>
References: <494F6D6A.2010406@dsrg.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37333 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780AbYL2Mla (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 07:41:30 -0500
In-Reply-To: <494F6D6A.2010406@dsrg.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?THVib23DrXIgQnVsZWo=?= <lubomir.bulej@dsrg.mff.cuni.cz>
Cc: linux-ide@vger.kernel.org

Lubom=C3=ADr Bulej wrote:
>=20
> The patchlet below blacklists NCQ on OCZ CORE v2 SSD drive(s). Even=20
> though the drive advertises NCQ support with queue depth 1, it respon=
ds=20
> with all-zeroes FIS to NCQ commands which triggers ata error handling=
=20
> several times before the kernel decides to disable NCQ on the drive.
>=20
>=20
> signed-off-by: Lubomir Bulej <lubomir.bulej@dsrg.mff.cuni.cz>
>=20
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 5e2eb74..ba38eb8 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4048,6 +4048,7 @@ static const struct ata_blacklist_entry=20
> ata_device_blacklist [] =3D {
>      { "Maxtor 7V300F0",    "VA111630",    ATA_HORKAGE_NONCQ },
>      { "ST380817AS",        "3.42",        ATA_HORKAGE_NONCQ },
>      { "ST3160023AS",    "3.42",        ATA_HORKAGE_NONCQ },
> +    { "OCZ CORE_SSD",    "02.10104",    ATA_HORKAGE_NONCQ },

applied (manually)


