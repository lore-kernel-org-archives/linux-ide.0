From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream] libata: update spurious NCQ completion blacklist
Date: Sat, 29 Sep 2007 02:23:37 -0400
Message-ID: <46FDEF69.7090506@garzik.org>
References: <46FD01B3.9030700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33958 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758053AbXI2GXj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Sep 2007 02:23:39 -0400
In-Reply-To: <46FD01B3.9030700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> * The firmware version of ST3160812AS is "3.ADJ" no "3.AD".
> * Add several entries from various sources.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index fd4563d..7f424c4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3891,9 +3891,12 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
>  	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
>  	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
> +	{ "WDC WD3200AAJS-00RYA0", "12.01B01",	ATA_HORKAGE_NONCQ, },
>  	{ "FUJITSU MHV2080BH",	"00840028",	ATA_HORKAGE_NONCQ, },
> +	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
>  	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
> -	{ "ST3160812AS",	"3.AD",		ATA_HORKAGE_NONCQ, },
> +	{ "ST3160812AS",	"3.ADJ",	ATA_HORKAGE_NONCQ, },
> +	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
>  	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },

applied


