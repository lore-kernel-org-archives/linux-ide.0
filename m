From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-core: blacklist HITACHI HDS drives using wildcard
 blacklist matching
Date: Sat, 29 Sep 2007 02:23:43 -0400
Message-ID: <46FDEF6F.8000000@garzik.org>
References: <20070928192906.GA28375@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33966 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758093AbXI2GXo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Sep 2007 02:23:44 -0400
In-Reply-To: <20070928192906.GA28375@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

David Milburn wrote:
> Blacklist HITACHI HDS7250SASUN500G and HITACHI HDS7225SBSUN250G
> drives using wildcard matching.
> 
> Signed-off-by David Milburn <dmilburn@redhat.com>
> ---
> 
>  libata-core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index fd4563d..d6319ec 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -3878,8 +3878,8 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	/* NCQ is broken */
>  	{ "Maxtor *",		"BANC*",	ATA_HORKAGE_NONCQ },
>  	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
> -	{ "HITACHI HDS7250SASUN500G 0621KTAWSD", "K2AOAJ0AHITACHI",
> -	  ATA_HORKAGE_NONCQ },
> +	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
> +	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },

applied


