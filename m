From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
Subject: RE: [PATCH][v2] sata_fsl: Add asynchronous notification support
Date: Wed, 1 Jul 2009 17:56:45 +0530
Message-ID: <16444A0F3094A24C83EAB7836A12C63B24FB60@zin33exm20.fsl.freescale.net>
References: <Pine.WNT.4.64.0906292044150.5480@B00888-02.fsl.freescale.net> <4A4B1D8F.9090609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:64049 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbZGAM1A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jul 2009 08:27:00 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id n61CQns1020622
	for <linux-ide@vger.kernel.org>; Wed, 1 Jul 2009 05:26:52 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net [10.232.192.5])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n61CQm2x002680
	for <linux-ide@vger.kernel.org>; Wed, 1 Jul 2009 07:26:49 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <4A4B1D8F.9090609@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Hello Sergei,

It looks like that the email client has added these whitespaces and
alignment mess-up,
as the original patch file has none of these issues. 

I will try using another email client and re-post the patch.

Thanks,
Ashish

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com] 
Sent: Wednesday, July 01, 2009 1:56 PM
To: Kalra Ashish-B00888
Cc: linux-ide@vger.kernel.org; linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][v2] sata_fsl: Add asynchronous notification support

Hello.

ashish kalra wrote:

> Enable device hot-plug support on Port multiplier fan-out ports
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
[...]
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index 
> 94eaa43..5751145 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -34,7 +34,7 @@ enum {
>
>      SATA_FSL_HOST_FLAGS    = (ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
>                  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
> -                ATA_FLAG_PMP | ATA_FLAG_NCQ),
> +                 ATA_FLAG_PMP | ATA_FLAG_NCQ | ATA_FLAG_AN),

   Why are you breaking the alignment? There's alos trailing whitespace
here...

> @@ -132,7 +132,7 @@ enum {
>      INT_ON_SINGL_DEVICE_ERR = (1 << 1),
>      INT_ON_CMD_COMPLETE = 1,
>
> -    INT_ON_ERROR = INT_ON_FATAL_ERR |
> +    INT_ON_ERROR = INT_ON_FATAL_ERR | INT_ON_SNOTIFY_UPDATE |

   Trailing whitespace.

> @@ -154,6 +154,7 @@ enum {
>
>      DEFAULT_PORT_IRQ_ENABLE_MASK = IE_ON_FATAL_ERR | IE_ON_PHYRDY_CHG
|
>          IE_ON_SIGNATURE_UPDATE |
> +        IE_ON_SNOTIFY_UPDATE |

   Again.

>          IE_ON_SINGL_DEVICE_ERR | IE_ON_CMD_COMPLETE,
>
>      EXT_INDIRECT_SEG_PRD_FLAG = (1 << 31), @@ -1003,6 +1004,11 @@ 
> static void sata_fsl_error_intr(struct ata_port
> *ap)
>          freeze = 1;
>      }
>
> +    /* Handle SDB FIS receive & notify update */
> +    if (hstatus & INT_ON_SNOTIFY_UPDATE) {
> +        sata_async_notification(ap);
> +    }

   And again -- on every line.

MBR, Sergei


