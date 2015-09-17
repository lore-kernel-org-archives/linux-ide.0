From: Luis de Bethencourt <luis@debethencourt.com>
Subject: Re: [PATCH v3] ata: pata_macio: Fix module autoload for OF platform
 driver
Date: Thu, 17 Sep 2015 14:29:20 +0200
Message-ID: <20150917122920.GA14933@goodgumbo.baconseed.org>
References: <20150917111945.GA11761@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34906 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbIQM3W (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Sep 2015 08:29:22 -0400
Content-Disposition: inline
In-Reply-To: <20150917111945.GA11761@goodgumbo.baconseed.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>

On Thu, Sep 17, 2015 at 01:19:45PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
> that information so modules have the correct aliases built-in and
> autoloading works correctly.
> 
> Link: https://lkml.org/lkml/2015/7/30/519
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
> ---
> 
> This fixes the typo error of version 2 reported by Stephen Rothwell
> https://lkml.org/lkml/2015/9/17/1
> 
>  drivers/ata/pata_macio.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
> index b002858..e3d4b05 100644
> --- a/drivers/ata/pata_macio.c
> +++ b/drivers/ata/pata_macio.c
> @@ -1344,6 +1344,7 @@ static struct of_device_id pata_macio_match[] =
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, pata_macio_match);
>  
>  static struct macio_driver pata_macio_driver =
>  {
> -- 
> 2.4.6
> 

Hi Tejun,

I sent this patch thinking that you would like to git revert the applied one
and git apply a correct one. To keep git bisect-ability.

You might want to apply a delta patch though. I could send that one, as you
prefer.

Thanks,
Luis
