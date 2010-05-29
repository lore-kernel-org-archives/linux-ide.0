From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-sff: trivial corrections to Kconfig help text
Date: Sat, 29 May 2010 14:38:00 +0200
Message-ID: <4C010AA8.8070004@kernel.org>
References: <tkrat.67c3608aed9d86ad@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48520 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341Ab0E2MiS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 May 2010 08:38:18 -0400
In-Reply-To: <tkrat.67c3608aed9d86ad@s5r6.in-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On 05/29/2010 12:47 PM, Stefan Richter wrote:
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Acked-by: Tejun Heo <tj@kernel.org>

> ---
>  drivers/ata/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 73f8833..aa85a98 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -168,10 +168,10 @@ config ATA_BMDMA
>  	default y
>  	help
>  	  This option adds support for SFF ATA controllers with BMDMA
> -	  capability.  BMDMA stands for bus-master DMA and the
> -	  de-facto DMA interface for SFF controllers.
> +	  capability.  BMDMA stands for bus-master DMA and is the
> +	  de facto DMA interface for SFF controllers.
>  
> -	  If unuser, say Y.
> +	  If unsure, say Y.
>  
>  if ATA_BMDMA
>  
> 
> By the way, is there something that could be said in a few words in the
> help text when to enable that option and when not?

Hmmmm... maybe we can emphasize the 'if unsure, say Y' part?

> Or could that option even be hidden and 'select'ed by bus master DMA
> capable ATA SFF drivers?

I wanted to make the distinction clear so made the option explicit.
Opinions on whether that is actually a good idea would differ but at
the same time, I don't think this would cause any problem, would it?

Thanks.

-- 
tejun
