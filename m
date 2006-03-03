From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata-dev: recognize WRITE_MULTI_FUA_EXT for r/w multiple
Date: Fri, 03 Mar 2006 12:22:35 -0500
Message-ID: <44087B5B.9030909@pobox.com>
References: <4407AB1D.2080506@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:23693 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751019AbWCCRWi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 12:22:38 -0500
In-Reply-To: <4407AB1D.2080506@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Jeff,
> 
> Changes:
> Recognize ATA_CMD_WRITE_MULTI_FUA_EXT as r/w multiple commands.
> 
> Patch against the irq-pio branch
> (1ed82ae3df3882bfcb5bfe5e9f97e4e8e23af299).
> 
> For your review, thanks.
> 
> Albert
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

I would request that you adjust your patch submission slightly.  Stuff 
like "Jeff," "Changes:", "Patch against...", "For your review", "Albert" 
all must be hand-edited out before applying the patch.  Everything 
before the "---" terminator is copied directly into the kernel changelog.

Take a look at Tejun's recent patches for an example.  The message body 
of his emailed submissions look like:

	[change description]
	[signed-off-by]
	---
	[notes, comments, insults, etc.  :)]


> --- irq-pio/include/linux/ata.h	2006-03-02 15:22:58.000000000 +0800
> +++ irq-pio-catchup/include/linux/ata.h	2006-03-02 17:05:17.000000000 +0800
> @@ -314,7 +314,8 @@ static inline int is_multi_taskfile(stru
>  	return (tf->command == ATA_CMD_READ_MULTI) ||
>  	       (tf->command == ATA_CMD_WRITE_MULTI) ||
>  	       (tf->command == ATA_CMD_READ_MULTI_EXT) ||
> -	       (tf->command == ATA_CMD_WRITE_MULTI_EXT);
> +	       (tf->command == ATA_CMD_WRITE_MULTI_EXT) ||
> +	       (tf->command == ATA_CMD_WRITE_MULTI_FUA_EXT);

Applied to irq-pio branch, though Mark Lord makes a correct point.  We 
may have to create a whitelist for PATA devices that support FUA, rather 
than a blacklist.  Something to think about...

Thanks,

	Jeff



