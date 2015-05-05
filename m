From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/4] libata: Allow NCQ TRIM to be enabled or disabled
 with a module parameter
Date: Tue, 05 May 2015 07:51:40 +0200
Message-ID: <55485A6C.6040800@suse.de>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38556 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256AbbEEFvm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 May 2015 01:51:42 -0400
In-Reply-To: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>, tj@kernel.org
Cc: linux-ide@vger.kernel.org

On 05/05/2015 03:54 AM, Martin K. Petersen wrote:
> We have started seeing SSD firmware updates introduce support for que=
ued
> TRIM. Sadly, in most cases this support is completely untested and ca=
n
> lead to either errors or data corruption.
>=20
> Add two libata force flags that can be used to either enable or disab=
le
> queued TRIM support.
>=20
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  Documentation/kernel-parameters.txt | 2 ++
>  drivers/ata/libata-core.c           | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kern=
el-parameters.txt
> index 61ab1628a057..a2e4891a714f 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1774,6 +1774,8 @@ bytes respectively. Such letter suffixes can al=
so be entirely omitted.
> =20
>  			* [no]ncq: Turn on or off NCQ.
> =20
> +			* [no]ncqtrim: Turn off queued DSM TRIM.
> +
>  			* nohrst, nosrst, norst: suppress hard, soft
>                            and both resets.
> =20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4476fb590733..9cebd7872ac6 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6472,6 +6472,8 @@ static int __init ata_parse_force_one(char **cu=
r,
>  		{ "3.0Gbps",	.spd_limit	=3D 2 },
>  		{ "noncq",	.horkage_on	=3D ATA_HORKAGE_NONCQ },
>  		{ "ncq",	.horkage_off	=3D ATA_HORKAGE_NONCQ },
> +		{ "noncqtrim",	.horkage_on	=3D ATA_HORKAGE_NO_NCQ_TRIM },
> +		{ "ncqtrim",	.horkage_off	=3D ATA_HORKAGE_NO_NCQ_TRIM },
>  		{ "dump_id",	.horkage_on	=3D ATA_HORKAGE_DUMP_ID },
>  		{ "pio0",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 0) },
>  		{ "pio1",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 1) },
>=20
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
