From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sx4: speed up ECC initialization
Date: Tue, 14 Apr 2009 16:21:27 -0400
Message-ID: <49E4F047.3030500@garzik.org>
References: <1239675982-32584-1-git-send-email-a.beregalov@gmail.com> <49E47A45.60902@garzik.org> <20090414200054.GB17134@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57656 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbZDNUVb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 16:21:31 -0400
In-Reply-To: <20090414200054.GB17134@orion>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: linux-ide@vger.kernel.org

Alexander Beregalov wrote:
> On Tue, Apr 14, 2009 at 07:57:57AM -0400, Jeff Garzik wrote:
>> Alexander Beregalov wrote:
>>> ECC initialization takes too long. It writes zeroes by portions of 4
>>> byte, it takes more than 6 minutes to initialize 512Mb DIMM module.
>>> Change portion to 1Mb.
>>>
>>> before:
>>> [10857.207576] pdc20621_dimm_init: Start ECC initialization
>>> [11235.333118] pdc20621_dimm_init: Finish ECC initialization
>>>
>>> after:
>>> [ 1005.126437] pdc20621_dimm_init: Local DIMM Speed = 100
>>> [ 1005.128111] pdc20621_dimm_init: Local DIMM Size = 512MB
>>> [ 1005.133508] Local DIMM ECC Enabled
>>> [ 1005.236482] pdc20621_dimm_init: Start ECC initialization
>>> [ 1031.278098] pdc20621_dimm_init: Finish ECC initialization
>>>
>> Comments:
>>
>> 1) on an older machine, where these things might be found, 1MB might be 
>> a lot -- particularly if there is a lot of VM fragmentation.  Please 
>> reduce the size a bit -- I suppose 128k is not unbearably slow?
>>
>> 2) Rather than repeating 'page size * 32' calculation multiple times, 
>> put it into a named constant somewhere.
>>
>> Other than that, looks ok!
> 
> 
>>From 00e980a4651ef12811fbe9a893a7e72510b955d1 Mon Sep 17 00:00:00 2001
> From: Alexander Beregalov <a.beregalov@gmail.com>
> Date: Tue, 14 Apr 2009 23:55:52 +0400
> Subject: [PATCH v2] sata_sx4: speed up ECC initialization
> 
> ECC initialization takes too long. It writes zeroes by portions
> of 4 byte, it takes more than 6 minutes on my machine to initialize
> 512Mb ECC DIMM module. Change portion to 128Kb - it significantly
> reduces initialization time.
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
> ---
>  drivers/ata/sata_sx4.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)


Applied, to libata-dev.git#upstream

Thanks!

So...   the $64,000 question:  does sata_sx4 work for you?


> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index dce3dcc..197a4d7 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -193,6 +193,7 @@ enum {
>  					  PDC_TIMER_MASK_INT,
>  };
>  
> +#define ECC_ERASE_BUF_SZ (128 * 1024)

I made two minor edits:

1) Macros should always be guarded by parens

2) Added "_SZ" suffix to make purpose even more obvious


