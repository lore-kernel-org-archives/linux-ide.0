From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: Introduce ata_platform_shutdown_one()
Date: Wed, 5 Jul 2017 10:50:27 -0400
Message-ID: <20170705145027.GB19330@htj.duckdns.org>
References: <1499104962-17498-1-git-send-email-nwatters@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36780 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbdGEOuc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jul 2017 10:50:32 -0400
Content-Disposition: inline
In-Reply-To: <1499104962-17498-1-git-send-email-nwatters@codeaurora.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nate Watterson <nwatters@codeaurora.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jul 03, 2017 at 02:02:41PM -0400, Nate Watterson wrote:
> In similar fashion to how ata_platform_remove_one() is used, this
> newly introduced method can be used by platform ata drivers to get
> basic shutdown functionality (stopping host DMA and interrupts).
> 
> Signed-off-by: Nate Watterson <nwatters@codeaurora.org>
> ---
>  drivers/ata/libata-core.c | 20 ++++++++++++++++++++
>  include/linux/libata.h    |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index e157a0e..537932e 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6702,6 +6702,25 @@ int ata_platform_remove_one(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/**
> + *	ata_platform_shutdown_one - Platform layer callback for device shutdown
> + *	@pdev: Platform device being shutdown
> + *
> + *	Platform layer indicates to libata via this hook that shutdown is
> + *	in progress and the input device should be quiesced. Functionally this
                            ^^^^^
> + *	is equivalent to ata_platform_remove_one(), however devres_release_all()
> + *	is not called on the shutdown path as it is for remove so releasing the
> + *	resources associated with the device must instead be initiated directly.

I can't easily understand the above comment.  Can you please try to
rephrase it so that it's clear why and when it's used?

Thanks.

-- 
tejun
