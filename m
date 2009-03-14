From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 59/73] pdc_adma: use ata.h mode mask defines, add ATA_PIO4_ONLY
Date: Sat, 14 Mar 2009 15:34:48 -0400
Message-ID: <49BC06D8.1050007@garzik.org>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net> <alpine.BSF.1.00.0903142021290.59456@anduin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53212 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756947AbZCNTey (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Mar 2009 15:34:54 -0400
In-Reply-To: <alpine.BSF.1.00.0903142021290.59456@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RXJpayBJbmdlIEJvbHPDuA==?= <knan-lkml@anduin.net>
Cc: linux-ide@vger.kernel.org

Erik Inge Bols=C3=B8 wrote:
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index e06d4c1..3901b00 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -108,6 +108,8 @@ enum {
>  	ATA_PIO5		=3D ATA_PIO4 | (1 << 5),
>  	ATA_PIO6		=3D ATA_PIO5 | (1 << 6),
> =20
> +	ATA_PIO4_ONLY		=3D (1 << 4),
> +
>  	ATA_SWDMA0		=3D (1 << 0),
>  	ATA_SWDMA1		=3D ATA_SWDMA0 | (1 << 1),
>  	ATA_SWDMA2		=3D ATA_SWDMA1 | (1 << 2),

This needs to be added to the patch #1 mentioned in my previous email

