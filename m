From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide: Add ide_get_paired_drive() helper
Date: Thu, 18 Oct 2007 23:10:13 +0200
Message-ID: <200710182310.13272.bzolnier@gmail.com>
References: <20071018005621.8F637DDEB8@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:5764 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbXJRWuZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 18:50:25 -0400
Received: by nf-out-0910.google.com with SMTP id g13so285712nfb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 15:50:23 -0700 (PDT)
In-Reply-To: <20071018005621.8F637DDEB8@ozlabs.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, stable@kernel.org

On Thursday 18 October 2007, Benjamin Herrenschmidt wrote:
> This adds a helper to get to the "other" drive on a pair connected
> to a given hwif.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

applied

-stable team: please include this patch series in 2.6.23.2

> ---
> 
> Note: You may want to use the 1 - select.b.unit construct instead,
> as you prefer, I just used what was there and fixed it.
> 
>  include/linux/ide.h |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> Index: linux-work/include/linux/ide.h
> ===================================================================
> --- linux-work.orig/include/linux/ide.h	2007-10-18 10:41:42.000000000 +1000
> +++ linux-work/include/linux/ide.h	2007-10-18 10:42:40.000000000 +1000
> @@ -1454,4 +1454,11 @@ static inline int hwif_to_node(ide_hwif_
>  	return dev ? pcibus_to_node(dev->bus) : -1;
>  }
>  
> +static inline ide_drive_t *ide_get_paired_drive(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif	= HWIF(drive);
> +
> +	return &hwif->drives[(drive->dn ^ 1) & 1];
> +}
> +
>  #endif /* _IDE_H */
