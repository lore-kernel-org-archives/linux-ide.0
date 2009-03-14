From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 46/73] pata_radisys: use ata.h mode mask defines, add
 ATA_UDMA24_ONLY
Date: Sat, 14 Mar 2009 15:35:23 -0400
Message-ID: <49BC06FB.1080803@garzik.org>
References: <alpine.BSF.1.00.0903141850260.53715@anduin.net> <alpine.BSF.1.00.0903142019350.59456@anduin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53216 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756145AbZCNTf1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Mar 2009 15:35:27 -0400
In-Reply-To: <alpine.BSF.1.00.0903142019350.59456@anduin.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?RXJpayBJbmdlIEJvbHPDuA==?= <knan-lkml@anduin.net>
Cc: linux-ide@vger.kernel.org

Erik Inge Bols=C3=B8 wrote:
> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index 386eeac..e06d4c1 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -133,6 +133,8 @@ enum {
>  	ATA_UDMA7		=3D ATA_UDMA6 | (1 << 7),
>  	/* ATA_UDMA7 is just for completeness... doesn't exist (yet?).  */
> =20
> +	ATA_UDMA24_ONLY		=3D (1 << 2) | (1 << 4),
> +
>  	ATA_UDMA_MASK_40C	=3D ATA_UDMA2,	/* udma0-2 */
> =20
>  	/* DMA-related */

ditto -- this bit goes into patch #1

