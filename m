From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: blacklist NCQ on OCZ CORE 2 SSD (resend)
Date: Mon, 29 Dec 2008 17:39:27 +0900
Message-ID: <49588CBF.80002@kernel.org>
References: <494F6D6A.2010406@dsrg.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44831 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbYL2Ijo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Dec 2008 03:39:44 -0500
In-Reply-To: <494F6D6A.2010406@dsrg.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?THVib23DrXIgQnVsZWo=?= <lubomir.bulej@dsrg.mff.cuni.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Lubom=C3=ADr Bulej wrote:
> The patchlet below blacklists NCQ on OCZ CORE v2 SSD drive(s). Even
> though the drive advertises NCQ support with queue depth 1, it respon=
ds
> with all-zeroes FIS to NCQ commands which triggers ata error handling
> several times before the kernel decides to disable NCQ on the drive.
>=20
> signed-off-by: Lubomir Bulej <lubomir.bulej@dsrg.mff.cuni.cz>

Please capitalize the leading s and add --- separator between
description and the patch body.

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 5e2eb74..ba38eb8 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4048,6 +4048,7 @@ static const struct ata_blacklist_entry
> ata_device_blacklist [] =3D {
>      { "Maxtor 7V300F0",    "VA111630",    ATA_HORKAGE_NONCQ },
>      { "ST380817AS",        "3.42",        ATA_HORKAGE_NONCQ },
>      { "ST3160023AS",    "3.42",        ATA_HORKAGE_NONCQ },
> +    { "OCZ CORE_SSD",    "02.10104",    ATA_HORKAGE_NONCQ },
>=20
>      /* Seagate NCQ + FLUSH CACHE firmware bug */
>      { "ST31500341AS",    "9JU138",    ATA_HORKAGE_NONCQ |

Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

--=20
tejun
