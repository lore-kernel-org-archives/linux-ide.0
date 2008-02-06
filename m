From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-core: unblacklist HITACHI drives
Date: Wed, 06 Feb 2008 07:04:20 -0500
Message-ID: <47A9A244.2050607@garzik.org>
References: <20080204182421.GA22434@dhcp-210.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40548 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762283AbYBFMEX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 07:04:23 -0500
In-Reply-To: <20080204182421.GA22434@dhcp-210.hsv.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Milburn <dmilburn@redhat.com>
Cc: linux-ide@vger.kernel.org

David Milburn wrote:
> The HITACHI HDS7250SASUN500G and HITACHI HDS7225SBSUN250 drives
> do not need to be blacklisted, the NCQ problem has been resolved
> with the "sata_nv: fix for completion handling" patch.
> 
> Signed-off-by David Milburn <dmilburn@redhat.com>
> ---
> 
>  libata-core.c |    2 --
>  1 files changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index bdbd55a..ba5406e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4154,8 +4154,6 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  	/* NCQ is broken */
>  	{ "Maxtor *",		"BANC*",	ATA_HORKAGE_NONCQ },
>  	{ "Maxtor 7V300F0",	"VA111630",	ATA_HORKAGE_NONCQ },
> -	{ "HITACHI HDS7250SASUN500G*", NULL,    ATA_HORKAGE_NONCQ },
> -	{ "HITACHI HDS7225SBSUN250G*", NULL,    ATA_HORKAGE_NONCQ },
>  	{ "ST380817AS",		"3.42",		ATA_HORKAGE_NONCQ },
>  	{ "ST3160023AS",	"3.42",		ATA_HORKAGE_NONCQ },

applied


