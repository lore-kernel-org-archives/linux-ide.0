From: Daniel J Blueman <daniel@quora.org>
Subject: Re: [PATCH] Prevent interface errors with Seagate FreeAgent GoFlex
Date: Tue, 15 May 2012 00:11:37 +0800
Message-ID: <CAMVG2stUaPMOoxhYABuCu5YF=8riHxzAv+Op-KpqrkP8OkCsbQ@mail.gmail.com>
References: <1336058460-19924-1-git-send-email-daniel@quora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50551 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756443Ab2ENQLj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2012 12:11:39 -0400
Received: by bkcji2 with SMTP id ji2so3985982bkc.19
        for <linux-ide@vger.kernel.org>; Mon, 14 May 2012 09:11:37 -0700 (PDT)
In-Reply-To: <1336058460-19924-1-git-send-email-daniel@quora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>

Jeff,

On 3 May 2012 23:21, Daniel J Blueman <daniel@quora.org> wrote:
> When connected by the optional eSATAp cable, various interface errors
> occur with my new external Seagate FreeAgent GoFlex (firmware 0110) u=
ntil
> the interface is forced to 1.5Gbps mode. Blacklist 3.0Gbps mode with =
it
> to avoid the error messages, delays and dataloss potential.
>
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> ---
> =A0drivers/ata/libata-core.c | =A0 =A01 +
> =A01 file changed, 1 insertion(+)
>
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 28db50b..0781510 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4119,6 +4119,7 @@ static const struct ata_blacklist_entry ata_dev=
ice_blacklist [] =3D {
>
> =A0 =A0 =A0 =A0/* Devices which aren't very happy with higher link sp=
eeds */
> =A0 =A0 =A0 =A0{ "WD My Book", =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, =
=A0 ATA_HORKAGE_1_5_GBPS, },
> + =A0 =A0 =A0 { "Seagate FreeAgent GoFlex", =A0 NULL, =A0 ATA_HORKAGE=
_1_5_GBPS, },
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Devices which choke on SETXFER. =A0Applies only if =
both the

I addressed concerns Martin raised; any further objections to taking
this patch? I still see issues and potential data loss after a short
while until the link has negotiated down to 1.5Gb/s [1] without it,
and no issues with the patch applied.

Thanks,
  Daniel

--- [1]

ata5.00: exception Emask 0x52 SAct 0x0 SErr 0x1400c01 action 0x6 frozen
ata5.00: irq_stat 0x0c000000, interface fatal error
ata5: SError: { RecovData Proto HostInt Handshk TrStaTrns }
ata5.00: failed command: READ DMA
ata5.00: cmd c8/00:01:00:00:00/00:00:00:00:00/e0 tag 0 dma 512 in
        res 50/00:00:00:4f:c2/00:00:00:00:00/40 Emask 0x52 (ATA bus err=
or)
ata5.00: status: { DRDY }
ata5: hard resetting link
ata5: SATA link down (SStatus 1 SControl 300)
ata5: hard resetting link
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: configured for UDMA/133
ata5: EH complete
--=20
Daniel J Blueman
