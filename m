From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Handle SATA bridges better
Date: Mon, 21 May 2007 16:22:24 +0200
Message-ID: <4651AB20.7070103@gmail.com>
References: <20070521151332.4ec9ea1d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.228]:18475 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248AbXEUOXW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 10:23:22 -0400
Received: by nz-out-0506.google.com with SMTP id z3so328162nzf
        for <linux-ide@vger.kernel.org>; Mon, 21 May 2007 07:23:21 -0700 (PDT)
In-Reply-To: <20070521151332.4ec9ea1d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Alan Cox wrote:
> In some situations we find that SATA devices are attached via PATA/SATA
> bridges. When we find this we need to change a couple of bits of behaviour
> 
> -	Error changedown behaviour for SATA is different - no point
> dropping to PIO
> -	40/80 wire cable detection testing cannot be done.
> 
> Thus we need to detect this case and update the cable type accordingly.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:22:53.000000000 +0100
> +++ linux-2.6.22-rc1-mm1/drivers/ata/libata-core.c	2007-05-18 16:40:23.000000000 +0100
> @@ -2186,6 +2186,16 @@
>  	if (ap->ops->cable_detect)
>  		ap->cbl = ap->ops->cable_detect(ap);
>  
> +	/* We may have SATA bridge glue hiding here irrespective of the
> +	   reported cable types and sensed types */
> +	for (i = 0; i < ATA_MAX_DEVICES; i++) {
> +		dev = &ap->device[i];
> +		if (!ata_dev_enabled(dev))
> +			continue;
> +		if (ata_id_is_sata(dev->id))
> +			ap->cbl = ATA_CBL_SATA;
> +	}
> +

I'm not sure this is correct.  The SATA bridge can be at the far side of
PATA cable near to the drive.  ie.

PATA host <========= PATA cable ==========> P/SATA bridge : SATA drive

In this case, most of the cable is PATA and cable detection matters.
Another problem is that there are still codes which interpret ap->cbl ==
ATA_CBL_SATA as SATA host port.  They need to be fixed first before
using ap->cbl for the actual cable type.

-- 
tejun
