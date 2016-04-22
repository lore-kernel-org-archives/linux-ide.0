From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v1 03/23] ata: sata_dwc_460ex: set dma_boundary to 0x1fff
Date: Fri, 22 Apr 2016 16:13:00 +0300
Message-ID: <571A235C.5070007@cogentembedded.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1461262544-115408-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33136 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbcDVNNF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Apr 2016 09:13:05 -0400
Received: by mail-lf0-f52.google.com with SMTP id e190so79080845lfe.0
        for <linux-ide@vger.kernel.org>; Fri, 22 Apr 2016 06:13:05 -0700 (PDT)
In-Reply-To: <1461262544-115408-4-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Christian Lamparter <chunkeey@googlemail.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Julian Margetson <runaway@candw.ms>

Hello.

On 04/21/2016 09:15 PM, Andy Shevchenko wrote:

> The original code states:
>
> 	Make sure a LLI block is not created that will span 8K max FIS
> 	boundary. If the block spans such a FIS boundary, there is a chance
> 	that a DMA burst will cross that boundary -- this results in an error
> 	in the host controller.
>
> Since we have switched to generic DMAengine API we satisfy above by setting
> dma_boundary value to 0x1fff.
>
> Suggested-by: Mans Rullgard <mans@mansr.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ata/sata_dwc_460ex.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 7f95389..aee8873 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1151,7 +1151,13 @@ static struct scsi_host_template sata_dwc_sht = {
>   	 */
>   	.sg_tablesize		= LIBATA_MAX_PRD,
>   	/* .can_queue		= ATA_MAX_QUEUE, */
> -	.dma_boundary		= ATA_DMA_BOUNDARY,
> +	/*
> +	 * Make sure a LLI block is not created that will span 8K max FIS
> +	 * boundary. If the block spans such a FIS boundary, there is a chance
> +	 * that a DMA burst will cross that boundary -- this results in an
> +	 * error in the host controller.
> +	 */
> +	.dma_boundary		= 0x1fff /* ATA_DMA_BOUNDARY */,

    Not ~0x1fff?

[...]

MBR, Sergei

