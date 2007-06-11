From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: force PIO on IOMEGA
 ZIP 250 ATAPI
Date: Mon, 11 Jun 2007 01:00:02 -0400
Message-ID: <466CD6D2.403@garzik.org>
References: <20070610055236.GI29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42106 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbXFKFAF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jun 2007 01:00:05 -0400
In-Reply-To: <20070610055236.GI29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, calvin.walton@gmail.com, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
> IOMEGA ZIP 250 ATAPI claims MWDMA0 support but fails SETXFERMODE if
> asked to configure itself to MWDMA0.  Force PIO.
> 
> This fixes bugzilla bug#8497.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Calvin Walton <calvin.walton@gmail.com>
> ---
> There was another proposed patch which lowers transfer mode if device
> rejects transfer mode but I'm not sure whether that's the right thing
> to do.  Such behavior change might affect other devices, so I'm opting
> for blacklisting for now.
> 
> Thanks.
> 
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4733f00..6312a21 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3769,6 +3769,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
>  	{ "SAMSUNG CD-ROM SN-124","N001",	ATA_HORKAGE_NODMA },
>  	{ "Seagate STT20000A", NULL,		ATA_HORKAGE_NODMA },
> +	{ "IOMEGA  ZIP 250       ATAPI", NULL,	ATA_HORKAGE_NODMA }, /* temporary fix */

applied, after adding the "temporary fix" comment based on Alan's comments


