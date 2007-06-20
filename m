From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: more NONCQ devices
Date: Wed, 20 Jun 2007 19:56:57 -0400
Message-ID: <4679BEC9.4040901@garzik.org>
References: <20070618053841.GP29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45880 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757706AbXFTX47 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Jun 2007 19:56:59 -0400
In-Reply-To: <20070618053841.GP29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> More for the NCQ blacklist.  One hitachi and one raptor.  Other
> members of these families of drives are already on the list, so no
> surprises.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 047eabd..3562812 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3802,6 +3802,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "HTS541010G9SA00",    "MBZOC60D",     ATA_HORKAGE_NONCQ, },
>  	/* Drives which do spurious command completion */
>  	{ "HTS541680J9SA00",	"SB2IC7EP",	ATA_HORKAGE_NONCQ, },
> +	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
> +	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },

applied


