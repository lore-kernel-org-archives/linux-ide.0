From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 05/07] sil24: use longer delay function
 and less iteration in reset_controller
Date: Thu, 11 Aug 2005 15:20:36 -0400
Message-ID: <42FBA504.4060101@pobox.com>
References: <20050730101344.1C985988@htj.dyndns.org> <20050730101344.241DEAE1@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:55975 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932391AbVHKTUk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 15:20:40 -0400
In-Reply-To: <20050730101344.241DEAE1@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org, Edward Falk <efalk@google.com>

Tejun Heo wrote:
> 05_sil24_mdelay-instead-of-udelay.patch
> 
> 	loop 100 times with mdelay(1) instead of 1000 times with
> 	udelay(100) in sil24_reset_controller.
> 
> 	Jeff, is this what you wanted?  If not, just ignore this
> 	patch.  The following patches will apply without this one.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
>  sata_sil24.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> Index: work/drivers/scsi/sata_sil24.c
> ===================================================================
> --- work.orig/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
> +++ work/drivers/scsi/sata_sil24.c	2005-07-30 19:13:40.000000000 +0900
> @@ -445,9 +445,13 @@ static void sil24_reset_controller(struc
>  	writel(PORT_CS_DEV_RST, port + PORT_CTRL_STAT);
>  	readl(port + PORT_CTRL_STAT);	/* sync */
>  
> -	/* Max ~100ms */
> -	for (cnt = 0; cnt < 1000; cnt++) {
> -		udelay(100);
> +	/*
> +	 * Max ~100ms.
> +	 * FIXME: 100ms is an arbitrary value, get spec and use
> +	 *        accurate value.
> +	 */
> +	for (cnt = 0; cnt < 100; cnt++) {
> +		mdelay(1);
>  		tmp = readl(port + PORT_CTRL_STAT);

I forget what the discussion resulted in, for this change.

For error handling, we typically want to move to process context (if not 
there already), and then use msleep() and friends.

	Jeff


