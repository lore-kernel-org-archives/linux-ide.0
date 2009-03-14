From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 10/73] pata_at32: use ata.h mode mask defines
Date: Sat, 14 Mar 2009 15:21:41 -0400
Message-ID: <49BC03C5.3010401@garzik.org>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net> <alpine.BSF.1.00.0903142012030.59456@anduin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43066 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756089AbZCNTVq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Mar 2009 15:21:46 -0400
In-Reply-To: <alpine.BSF.1.00.0903142012030.59456@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RXJpayBJbmdlIEJvbHPDuA==?= <knan-lkml@anduin.net>
Cc: linux-ide@vger.kernel.org

Erik Inge Bols=C3=B8 wrote:
> No functional changes in this patch.
>=20
> Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
> ---
>  drivers/ata/pata_at32.c |   16 +++++++++-------
>  1 files changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
> index ab61095..131b20c 100644
> --- a/drivers/ata/pata_at32.c
> +++ b/drivers/ata/pata_at32.c
> @@ -58,16 +58,18 @@
>   * ATA PIO modes
>   *
>   *	Name	| Mb/s	| Min cycle time | Mask
> - *	--------+-------+----------------+--------
> - *	Mode 0	| 3.3	| 600 ns	 | 0x01
> - *	Mode 1	| 5.2	| 383 ns	 | 0x03
> - *	Mode 2	| 8.3	| 240 ns	 | 0x07
> - *	Mode 3	| 11.1	| 180 ns	 | 0x0f
> - *	Mode 4	| 16.7	| 120 ns	 | 0x1f
> + *	--------+-------+----------------+----------
> + *	Mode 0	| 3.3	| 600 ns	 | ATA_PIO0
> + *	Mode 1	| 5.2	| 383 ns	 | ATA_PIO1
> + *	Mode 2	| 8.3	| 240 ns	 | ATA_PIO2
> + *	Mode 3	| 11.1	| 180 ns	 | ATA_PIO3
> + *	Mode 4	| 16.7	| 120 ns	 | ATA_PIO4

NAK, don't mess with the ASCII chart in the code comment


