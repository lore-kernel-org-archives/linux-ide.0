From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-sff: trivial corrections to Kconfig help text
Date: Wed, 02 Jun 2010 13:50:57 -0400
Message-ID: <4C069A01.40704@garzik.org>
References: <tkrat.67c3608aed9d86ad@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51701 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725Ab0FBRvB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2010 13:51:01 -0400
Received: by mail-gw0-f46.google.com with SMTP id a12so4812714gwa.19
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2010 10:51:01 -0700 (PDT)
In-Reply-To: <tkrat.67c3608aed9d86ad@s5r6.in-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 05/29/2010 06:47 AM, Stefan Richter wrote:
> Signed-off-by: Stefan Richter<stefanr@s5r6.in-berlin.de>
> ---
>   drivers/ata/Kconfig |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 73f8833..aa85a98 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -168,10 +168,10 @@ config ATA_BMDMA
>   	default y
>   	help
>   	  This option adds support for SFF ATA controllers with BMDMA
> -	  capability.  BMDMA stands for bus-master DMA and the
> -	  de-facto DMA interface for SFF controllers.
> +	  capability.  BMDMA stands for bus-master DMA and is the
> +	  de facto DMA interface for SFF controllers.
>
> -	  If unuser, say Y.
> +	  If unsure, say Y.
>
>   if ATA_BMDMA

applied


