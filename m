From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC] libata-dev: make the returned err_mask more accurate
Date: Thu, 6 Apr 2006 16:14:42 +0900
Message-ID: <20060406071442.GF31998@htj.dyndns.org>
References: <4434BD0C.9080302@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:36475 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932103AbWDFHOs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 03:14:48 -0400
Received: by zproxy.gmail.com with SMTP id o37so79568nzf
        for <linux-ide@vger.kernel.org>; Thu, 06 Apr 2006 00:14:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4434BD0C.9080302@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Hello, Albert.

On Thu, Apr 06, 2006 at 03:02:36PM +0800, Albert Lee wrote:
[-- snip --]
> --- irq-pio0/include/linux/libata.h	2006-04-06 10:08:48.000000000 +0800
> +++ irq-pio1/include/linux/libata.h	2006-04-06 13:44:25.000000000 +0800
> @@ -942,6 +942,46 @@ static inline int ata_try_flush_cache(co
>  	       ata_id_has_flush_ext(dev->id);
>  }
>  
> +static inline unsigned int ac_err_drq(u8 status)
> +{
> +	/* BSY = 1*/
> +	if (status & ATA_BUSY)
> +		return AC_ERR_HSM;
> +
> +	/* BSY = 0, DRQ = 1 */
> +	if (status & ATA_DRQ)
> +		return 0;
> +
> +	/* BSY = 0, DRQ = 0, device err */
> +	if (status & (ATA_ERR | ATA_DF))
> +		return AC_ERR_DEV;
> +
> +	/* BSY = 0, DRQ = 0, no device err
> +	 * when we are expecting data transfer.
> +	 */
> +	return AC_ERR_HSM;
> +}
> +
> +static inline unsigned int ac_err_idle(u8 status)
> +{
> +	/* BSY = 1 or DRQ = 1 */
> +	if (status & (ATA_BUSY | ATA_DRQ))
> +		return AC_ERR_HSM;
> +
> +	/* BSY = 0, DRQ = 0, device err */
> +	if (status & (ATA_ERR | ATA_DF))
> +		return AC_ERR_DEV;
> +
> +	/* BSY = 0, DRQ = 0, no device err. DRDY = 1 */
> +	if (status & ATA_DRDY)
> +		return 0;
> +
> +	/* thing looks good.
> +	 * don't know why DRDY not set.
> +	 */
> +	return AC_ERR_OTHER
> +}
> +

I don't think putting these two functions into libata.h as inlines is
a good idea.  As currently there are no users, it would be better to
put them where they are used as static functions and export it later
as necessary.

-- 
tejun
