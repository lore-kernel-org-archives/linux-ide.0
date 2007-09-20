From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ST340823A, HPA and libata
Date: Thu, 20 Sep 2007 17:37:41 -0400
Message-ID: <46F2E825.3000606@garzik.org>
References: <20070801092903.GA1199@nalle>	<200708030034.13193.bzolnier@gmail.com>	<20070802231100.GA1861@nalle>	<200708030135.16910.bzolnier@gmail.com>	<20070805190616.GA1932@nalle> <20070808142505.3213a1a6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38294 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbXITVhp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 17:37:45 -0400
In-Reply-To: <20070808142505.3213a1a6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> Ok this is a different approach to handling it - knowing it is an off by
> one so we can handle the drive if clipped
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c linux-2.6.23rc1-mm1/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-07-26 15:02:57.000000000 +0100
> +++ linux-2.6.23rc1-mm1/drivers/ata/libata-core.c	2007-08-08 13:38:39.257549616 +0100
> @@ -988,6 +992,10 @@
>  	else
>  		hpa_sectors = ata_read_native_max_address(dev);
>  
> +	/* Reports one sector too many */
> +	if (hpa_sectors && (dev->horkage & ATA_HORKAGE_HPA_SIZE))
> +		hpa_sectors--;
> +
>  	if (hpa_sectors > sectors) {
>  		ata_dev_printk(dev, KERN_INFO,
>  			"Host Protected Area detected:\n"
> @@ -3858,6 +3926,9 @@
>  
>  	/* Devices with NCQ limits */
>  
> +	/* Devices which report 1 sector over size HPA */
> +	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
> +
>  	/* End Marker */
>  	{ }
>  };
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc1-mm1/include/linux/libata.h linux-2.6.23rc1-mm1/include/linux/libata.h
> --- linux.vanilla-2.6.23rc1-mm1/include/linux/libata.h	2007-07-26 15:02:58.000000000 +0100
> +++ linux-2.6.23rc1-mm1/include/linux/libata.h	2007-08-08 13:38:09.000000000 +0100
> @@ -314,6 +314,7 @@
>  	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
>  	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
>  	ATA_HORKAGE_ALPM	= (1 << 4), 	/* ALPM problems */
> +	ATA_HORKAGE_HPA_SIZE	= (1 << 5), 	/* Reports native size off by one */

the horkage patch I sent upstream to Linus just now for 2.6.23-rc 
included some of the HPA size blacklist entries, so I dropped that 
not-for-2.6.23 patch chunk.

If this issue has settled, let's roll everything into a single patch, 
and I'll apply that.


