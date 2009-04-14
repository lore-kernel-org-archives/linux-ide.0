From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_sx4: speed up ECC initialization
Date: Tue, 14 Apr 2009 07:57:57 -0400
Message-ID: <49E47A45.60902@garzik.org>
References: <1239675982-32584-1-git-send-email-a.beregalov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43667 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbZDNL6B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 07:58:01 -0400
In-Reply-To: <1239675982-32584-1-git-send-email-a.beregalov@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: linux-ide@vger.kernel.org

Alexander Beregalov wrote:
> ECC initialization takes too long. It writes zeroes by portions of 4
> byte, it takes more than 6 minutes to initialize 512Mb DIMM module.
> Change portion to 1Mb.
> 
> before:
> [10857.207576] pdc20621_dimm_init: Start ECC initialization
> [11235.333118] pdc20621_dimm_init: Finish ECC initialization
> 
> after:
> [ 1005.126437] pdc20621_dimm_init: Local DIMM Speed = 100
> [ 1005.128111] pdc20621_dimm_init: Local DIMM Size = 512MB
> [ 1005.133508] Local DIMM ECC Enabled
> [ 1005.236482] pdc20621_dimm_init: Start ECC initialization
> [ 1031.278098] pdc20621_dimm_init: Finish ECC initialization
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
> ---
>  drivers/ata/sata_sx4.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
> index dce3dcc..d329501 100644
> --- a/drivers/ata/sata_sx4.c
> +++ b/drivers/ata/sata_sx4.c
> @@ -1208,7 +1208,6 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
>  {
>  	int speed, size, length;
>  	u32 addr, spd0, pci_status;
> -	u32 tmp = 0;
>  	u32 time_period = 0;
>  	u32 tcount = 0;
>  	u32 ticks = 0;
> @@ -1323,14 +1322,17 @@ static unsigned int pdc20621_dimm_init(struct ata_host *host)
>  	pdc20621_i2c_read(host, PDC_DIMM0_SPD_DEV_ADDRESS,
>  			  PDC_DIMM_SPD_TYPE, &spd0);
>  	if (spd0 == 0x02) {
> +		void *buf;
>  		VPRINTK("Start ECC initialization\n");
>  		addr = 0;
>  		length = size * 1024 * 1024;
> +		buf = kzalloc(PDC_20621_PAGE_SIZE * 32, GFP_KERNEL);
>  		while (addr < length) {
> -			pdc20621_put_to_dimm(host, (void *) &tmp, addr,
> -					     sizeof(u32));
> -			addr += sizeof(u32);
> +			pdc20621_put_to_dimm(host, buf, addr,
> +					     PDC_20621_PAGE_SIZE * 32);
> +			addr += PDC_20621_PAGE_SIZE * 32;
>  		}
> +		kfree(buf);

Comments:

1) on an older machine, where these things might be found, 1MB might be 
a lot -- particularly if there is a lot of VM fragmentation.  Please 
reduce the size a bit -- I suppose 128k is not unbearably slow?

2) Rather than repeating 'page size * 32' calculation multiple times, 
put it into a named constant somewhere.

Other than that, looks ok!

	Jeff





