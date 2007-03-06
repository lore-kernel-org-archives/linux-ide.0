From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 07/30] libata: add NCQ blacklist entries from Silicon
 Image Windows driver
Date: Tue, 06 Mar 2007 06:45:35 -0500
Message-ID: <45ED545F.2070402@garzik.org>
References: <200703061037.l26AbtT4019472@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53609 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945AbXCFLph (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 06:45:37 -0500
In-Reply-To: <200703061037.l26AbtT4019472@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, hancockr@shaw.ca

akpm@linux-foundation.org wrote:
> From: Robert Hancock <hancockr@shaw.ca>
> 
> This patch adds in some NCQ blacklist entries taken from the Silicon Image
> Windows drivers' .inf files for the 3124 and 3132 controllers.  These
> entries were marked as ""DisableSataQueueing".  Assume these are in their
> blacklist for a reason and disable NCQ on these drives.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/libata-core.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff -puN drivers/ata/libata-core.c~libata-add-ncq-blacklist-entries-from-silicon-image-windows drivers/ata/libata-core.c
> --- a/drivers/ata/libata-core.c~libata-add-ncq-blacklist-entries-from-silicon-image-windows
> +++ a/drivers/ata/libata-core.c
> @@ -3368,6 +3368,13 @@ static const struct ata_blacklist_entry 
>  
>  	/* Devices with NCQ limits */
>  
> +	/* The following blacklist entries are taken from the Windows
> +	   driver .inf files for the Silicon Image 3124 and 3132. */
> +	{ "Maxtor 7B250S0",	"BANC1B70",	ATA_HORKAGE_NONCQ, },
> +	{ "HTS541060G9SA00",	"MB3OC60D",	ATA_HORKAGE_NONCQ, },
> +	{ "HTS541080G9SA00",	"MB4OC60D",	ATA_HORKAGE_NONCQ, },
> +	{ "HTS541010G9SA00",	"MBZOC60D",	ATA_HORKAGE_NONCQ, },

Already discussed:  drop the HTS* entries, leaving only the Maxtor, and 
I'll apply it


