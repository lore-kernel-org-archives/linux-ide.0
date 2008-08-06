From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch] cdrom: Handle TOC
Date: Thu, 07 Aug 2008 08:11:45 +0900
Message-ID: <489A2FB1.1060603@kernel.org>
References: <20080806210358.GA7386@shurick.s2s.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51022 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbYHFXNM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Aug 2008 19:13:12 -0400
In-Reply-To: <20080806210358.GA7386@shurick.s2s.msu.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Inyukhin <shurick@sectorb.msk.ru>
Cc: linux-ide@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>, Borislav Petkov <petkovbb@googlemail.com>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Alexander Inyukhin wrote:
> index d9d1b65..efc3aa0 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -394,6 +394,8 @@ int register_cdrom(struct cdrom_device_info *cdi)
>  
>  	if (cdo->open == NULL || cdo->release == NULL)
>  		return -EINVAL;
> +	if (cdo->audio_ioctl == NULL)
> +		return -EINVAL;

Maybe sticking a BUG_ON() is a good idea just in case?

-- 
tejun
