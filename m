From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: READ LOG DMA EXT failed, trying unqueued
Date: Tue, 19 May 2015 21:10:51 +0900
Message-ID: <20150519121051.GA352@swordfish>
References: <20150519113320.GA498@swordfish>
 <yq1wq04kcso.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35934 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbbESMLP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2015 08:11:15 -0400
Content-Disposition: inline
In-Reply-To: <yq1wq04kcso.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Hannes Reinecke <hare@suse.de>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

On (05/19/15 07:49), Martin K. Petersen wrote:
> Sergey> Hello, my laptop doesn't boot anymore, spinning in "READ LOG DMA
> Sergey> EXT failed, trying unqueued".  any reason it loops forever?
> 
> Does the patch below help?
> 

it does.

Reported-and-tested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss

> Also, please let us know which drive you have and send us the output of:
> 
> # smartctl -l gplog,0x13 /dev/sdN
> 
> Thanks!
> 
> -- 
> Martin K. Petersen	Oracle Linux Engineering
> 
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 2893563d0537..2b370ee0ae86 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1521,6 +1521,7 @@ retry:
>  	} else {
>  		tf.command = ATA_CMD_READ_LOG_EXT;
>  		tf.protocol = ATA_PROT_PIO;
> +		dma = false;
>  	}
>  	tf.lbal = log;
>  	tf.lbam = page;
> 
> 
