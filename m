From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc5] libata: kill non-sense warning message
Date: Wed, 27 Jun 2007 02:45:16 -0400
Message-ID: <4682077C.8060702@garzik.org>
References: <467FB0E1.206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37959 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760535AbXF0GpS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Jun 2007 02:45:18 -0400
In-Reply-To: <467FB0E1.206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> prereset() is now allowed to set flag for unsupported reset method.
> EH layer is responsible for selecting the fallback.  Remove non-sense
> warning message.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index d807098..376f004 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1665,8 +1665,6 @@ static int ata_eh_reset(struct ata_port *ap, int classify,
>  
>  	/* did prereset() screw up?  if so, fix up to avoid oopsing */
>  	if (!reset) {
> -		ata_port_printk(ap, KERN_ERR, "BUG: prereset() requested "
> -				"invalid reset type\n");
>  		if (softreset)
>  			reset = softreset;

applied


