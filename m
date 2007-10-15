From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add ST9160821AS / 3.CCD to NCQ blacklist
Date: Mon, 15 Oct 2007 15:41:33 -0400
Message-ID: <4713C26D.5010006@garzik.org>
References: <20071011014926.GP12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35107 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759332AbXJOTlf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 Oct 2007 15:41:35 -0400
In-Reply-To: <20071011014926.GP12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> ST9160821AS / 3.CCD does spurious completions too.  Blacklist it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index ce8ccb4..5402755 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3984,6 +3984,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	{ "ST9120822AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
>  	{ "ST9160821AS",	"3.CLF",	ATA_HORKAGE_NONCQ, },
>  	{ "ST9160821AS",	"3.ALD",	ATA_HORKAGE_NONCQ, },
> +	{ "ST9160821AS",	"3.CCD",	ATA_HORKAGE_NONCQ, },
>  	{ "ST3160812AS",	"3.ADJ",	ATA_HORKAGE_NONCQ, },
>  	{ "ST980813AS",		"3.ADB",	ATA_HORKAGE_NONCQ, },
>  	{ "SAMSUNG HD401LJ",	"ZZ100-15",	ATA_HORKAGE_NONCQ, },

applied


