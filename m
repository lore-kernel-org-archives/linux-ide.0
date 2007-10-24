From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add HTS542525K9SA00 to NCQ blacklist
Date: Tue, 23 Oct 2007 21:25:33 -0400
Message-ID: <471E9F0D.9020606@garzik.org>
References: <20071023100749.GD18322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38319 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbXJXBZe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Oct 2007 21:25:34 -0400
In-Reply-To: <20071023100749.GD18322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Luca Tettamanti <kronos.it@gmail.com>

Tejun Heo wrote:
> Another one doing spurious NCQ completions.  Blacklist it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Luca Tettamanti <kronos.it@gmail.com>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 908613d..be872fa 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3981,6 +3981,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "HTS541612J9SA00",	"SBDIC7JP",	ATA_HORKAGE_NONCQ, },
>  	{ "HDT722516DLA380",	"V43OA96A",	ATA_HORKAGE_NONCQ, },
>  	{ "Hitachi HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, },
> +	{ "Hitachi HTS542525K9SA00", "BBFOC31P", ATA_HORKAGE_NONCQ, },
>  	{ "WDC WD740ADFD-00NLR1", NULL,		ATA_HORKAGE_NONCQ, },
>  	{ "WDC WD3200AAJS-00RYA0", "12.01B01",	ATA_HORKAGE_NONCQ, },

applied


