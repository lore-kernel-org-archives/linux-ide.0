From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 4/4] pata_platform: Use 16-bit wide data transfer
Date: Sat, 23 Aug 2014 12:53:26 -0400
Message-ID: <20140823165326.GA13540@mtj.dyndns.org>
References: <1408790772-5305-1-git-send-email-shc_work@mail.ru>
 <1408790772-5305-3-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:46155 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaHWQxa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2014 12:53:30 -0400
Received: by mail-qc0-f178.google.com with SMTP id x3so11957083qcv.23
        for <linux-ide@vger.kernel.org>; Sat, 23 Aug 2014 09:53:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408790772-5305-3-git-send-email-shc_work@mail.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-ide@vger.kernel.org

Hello,

On Sat, Aug 23, 2014 at 02:46:12PM +0400, Alexander Shiyan wrote:
> In some cases, system bus can be configured for 16-bit mode, in this
> case using of read/write functions for the 32 bit values causes two
> cycles of 16 bits, which is incorrect.

Shouldn't we distinguish them instead of forcing 16bit transfer on
all?

> The patch provides its own function to use the proper 16-bit mode.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/ata/pata_platform.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> index ecbc3bf..79dd223 100644
> --- a/drivers/ata/pata_platform.c
> +++ b/drivers/ata/pata_platform.c
> @@ -43,13 +43,28 @@ static int pata_platform_set_mode(struct ata_link *link, struct ata_device **unu
>  	return 0;
>  }
>  
> +static unsigned int pata_platform_xfer_noirq(struct ata_device *dev,
> +					     unsigned char *buf,
> +					     unsigned int buflen, int rw)
> +{
> +	unsigned long flags;
> +	unsigned int consumed;
> +
> +	local_irq_save(flags);
> +	/* Use 16-bit transfer */
> +	consumed = ata_sff_data_xfer(dev, buf, buflen, rw);
> +	local_irq_restore(flags);
> +
> +	return consumed;
> +}

This doesn't seem like a good location for this function.  Please
rename the existing noirq function to xfer32_noriq and add generic
xfer_noirq for 16bit xfers.

Thanks.

-- 
tejun
