From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 02/73] [ide/ata]: add ATA_MWDMA3 and ATA_MWDMA4 masks
Date: Sat, 14 Mar 2009 15:23:07 -0400
Message-ID: <49BC041B.4040700@garzik.org>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net> <alpine.BSF.1.00.0903142010100.59456@anduin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43090 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755937AbZCNTXM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Mar 2009 15:23:12 -0400
In-Reply-To: <alpine.BSF.1.00.0903142010100.59456@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RXJpayBJbmdlIEJvbHPDuA==?= <knan-lkml@anduin.net>
Cc: linux-ide@vger.kernel.org

Erik Inge Bols=C3=B8 wrote:
> Will be used by next patch for pata_octeon_cf.
>=20
> Signed-off-by: Erik Inge Bols=C3=B8 <knan-lkml@anduin.net>
> ---
>  include/linux/ata.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index 9a061ac..386eeac 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -117,6 +117,8 @@ enum {
>  	ATA_MWDMA0		=3D (1 << 0),
>  	ATA_MWDMA1		=3D ATA_MWDMA0 | (1 << 1),
>  	ATA_MWDMA2		=3D ATA_MWDMA1 | (1 << 2),
> +	ATA_MWDMA3		=3D ATA_MWDMA2 | (1 << 3),
> +	ATA_MWDMA4		=3D ATA_MWDMA3 | (1 << 4),

This patch should be patch #1, and all the driver changes should be=20
rolled up into patch #2.

It is the same logical change, and therefore should not be broken up=20
into 73 tiny patches.

	Jeff




