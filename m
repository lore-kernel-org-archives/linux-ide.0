From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/n] libata-core.c conversion to new debugging scheme,
 part 1 (25% done)
Date: Sun, 11 Jun 2006 23:11:47 -0400
Message-ID: <448CDB73.4080305@garzik.org>
References: <20060531054633.GA4875@zmei.tnic> <20060531063957.GD14179@havoc.gtf.org> <20060601053849.GB8523@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7040 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751231AbWFLDLu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2006 23:11:50 -0400
In-Reply-To: <20060601053849.GB8523@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide@vger.kernel.org

Borislav Petkov wrote:
> On Wed, May 31, 2006 at 02:39:57AM -0400, Jeff Garzik wrote:
>> On Wed, May 31, 2006 at 07:46:33AM +0200, Borislav Petkov wrote:
>>> This patch converts the first 25% of libata-core.c to the new debugging scheme.
>>>
>>> Signed-off-by: <petkov@uni-muenster.de>
>> Looks good at first glance, though I'll hold off on apply until I return
>> from the Red Hat Summit in Nashville.
>>
>> It made me remember another point, though:  in order to avoid
>> regressions, after applying your patch, I would think that you would
>> want to create a patch which did something like
>>
>> #ifndef ATA_VERBOSE_DEBUG
>> 	ap->msg_enable = xxx
>> #else ATA_DEBUG
>> 	ap->msg_enable = yyy
>> #else
>> 	ap->msg_enable = ...
>> #endif
> 
> Ok, i was thinking something along the lines of the following; for better
> granularity we might add more ATA_XXX defines or let the user subsequently
> adjust dbg level through sysfs...? (The patch applies on top of the one i sent you
> before.)
> 
> Adjust initial debugging levels through preprocessor defines.
> 
> Signed-off-by: <petkov@uni-muenster.de>
> 
>  
> --- libata-dev/drivers/scsi/libata-core.c.orig1	2006-06-01 07:02:42.000000000 +0200
> +++ libata-dev/drivers/scsi/libata-core.c	2006-06-01 07:32:44.000000000 +0200
> @@ -5200,7 +5200,15 @@ static void ata_host_init(struct ata_por
>  	ap->sata_spd_limit = UINT_MAX;
>  	ap->active_tag = ATA_TAG_POISON;
>  	ap->last_ctl = 0xFF;
> -	ap->msg_enable = ATA_MSG_DRV;
> +
> +#if defined(ATA_VERBOSE_DEBUG)
> +	/* turn on all debugging levels */
> +	ap->msg_enable = 0x00FF;
> +#elif defined(ATA_DEBUG)
> +	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
> +#else 
> +	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR;
> +#endif

applied


