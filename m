From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-eh don't waste time retrying media errors (v2)
Date: Wed, 2 May 2012 08:54:14 -0700
Message-ID: <20120502155414.GB21677@google.com>
References: <4FA043BE.2010009@teksavvy.com>
 <4FA04714.7050602@teksavvy.com>
 <20120501215854.GA21677@google.com>
 <4FA07655.6090506@teksavvy.com>
 <4FA07932.2090003@teksavvy.com>
 <4FA0A3F7.7000401@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62495 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2EBPyT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 May 2012 11:54:19 -0400
Received: by pbbrp8 with SMTP id rp8so1258673pbb.19
        for <linux-ide@vger.kernel.org>; Wed, 02 May 2012 08:54:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FA0A3F7.7000401@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, May 01, 2012 at 11:03:19PM -0400, Mark Lord wrote:
> ATA and SATA drives have had built-in retries for media errors
> for as long as they've been commonplace in computers (early 1990s).
> 
> When libata stumbles across a bad sector, it can waste minutes
> sitting there doing retry after retry before finally giving up
> and letting the higher layers deal with it.
> 
> This patch removes retries for media errors only.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> version 2; the original patch changed more than intended.
> 
> --- linux/drivers/ata/libata-eh.c.orig	2012-04-27 13:17:35.000000000 -0400
> +++ linux/drivers/ata/libata-eh.c	2012-05-01 22:40:00.182425015 -0400
> @@ -2122,7 +2122,8 @@
>  		if (qc->flags & ATA_QCFLAG_IO ||
>  		    (!(qc->err_mask & AC_ERR_INVALID) &&
>  		     qc->err_mask != AC_ERR_DEV))
> -			qc->flags |= ATA_QCFLAG_RETRY;
> +			if (!(qc->err_mask & AC_ERR_MEDIA))
> +				qc->flags |= ATA_QCFLAG_RETRY;

It can be combined like the following,

	if (!(qc->err_mask & AC_ERR_MEDIA) &&
	    (qc->flags & ATA_QCFLAG_IO ||
	     (!(qc->err_mask & AC_ERR_INVALID) &&
	      qc->err_mask != AC_ERR_DEV)))

which doesn't look any prettier.  Hmm... maybe using local vars would
make it better?

	bool emedia = qc->err_mask & AC_ERR_MEDIA;
	bool einval = qc->err_mask & AC_ERR_INVALID;
	bool edev = qc->err_mask == AC_ERR_DEV;
	bool is_io = qc->flags & ATA_QCFLAG_IO;

	if (!emedia && (is_io || (!einval && !edev)))

-- 
tejun
