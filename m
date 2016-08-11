From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] ahci: disable correct irq for dymmy ports
Date: Thu, 11 Aug 2016 12:36:37 -0400
Message-ID: <20160811163637.GD2695@mtj.duckdns.org>
References: <1470925562-28914-1-git-send-email-hch@lst.de>
 <1470925562-28914-2-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33045 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932586AbcHKQgk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2016 12:36:40 -0400
Received: by mail-yw0-f194.google.com with SMTP id z8so41836ywa.0
        for <linux-ide@vger.kernel.org>; Thu, 11 Aug 2016 09:36:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1470925562-28914-2-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

Hello, Christoph.

On Thu, Aug 11, 2016 at 07:26:01AM -0700, Christoph Hellwig wrote:
> irq already contains the interrupt number for the port, don't add the port
> index to it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/ata/libahci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 7461a58..dcf2c72 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -2524,7 +2524,7 @@ static int ahci_host_activate_multi_irqs(struct ata_host *host,
>  
>  		/* Do not receive interrupts sent by dummy ports */
>  		if (!pp) {
> -			disable_irq(irq + i);
> +			disable_irq(irq);
>  			continue;
>  		}

I'm not following.  The driver at that point has irqs in the range
[@irq, @irq + @host->n_ports - 1] and is trying to activate them and
the above code block disables irq for a port which should be skipped.
Why wouldn't it need to be indexed?

Thanks.

-- 
tejun
