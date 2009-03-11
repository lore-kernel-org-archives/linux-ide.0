From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch 1/3] libata: change drive ready wait after hard reset
 to 5s
Date: Wed, 11 Mar 2009 16:39:21 +0900
Message-ID: <49B76AA9.2030707@kernel.org>
References: <200903041959.n24Jxl2X028532@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60952 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbZCKHkK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Mar 2009 03:40:10 -0400
In-Reply-To: <200903041959.n24Jxl2X028532@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, stuart_hayes@dell.com

Hello,

akpm@linux-foundation.org wrote:
> From: Stuart Hayes <stuart_hayes@dell.com>
> 
> This fixes problems during resume with drives that take longer than 1s to
> be ready.  The ATA-6 spec appears to allow 5 seconds for a drive to be
> ready.
> 
> On one affected system, this patch changes "PM: resume devices took..."
> message from 17 seconds to 4 seconds, and gets rid of a lot of ugly
> timeout/error messages.

Can you please attach log for this?  Which controller was it?

> Without this patch, the libata code moves on after 1s, tries to send a
> soft reset (which the drive doesn't see because it isn't ready) which also
> times out, then an IDENTIFY command is sent to the drive which times out,
> and finally the error handler will try to send another hard reset which
> will finally get things working.

This adds 5s delays to common detection paths.  That said, 1s could be
too short.

> diff -puN include/linux/libata.h~libata-change-drive-ready-wait-after-hard-reset-to-5s include/linux/libata.h
> --- a/include/linux/libata.h~libata-change-drive-ready-wait-after-hard-reset-to-5s
> +++ a/include/linux/libata.h
> @@ -275,7 +275,7 @@ enum {
>  	 * advised to wait only for the following duration before
>  	 * doing SRST.
>  	 */
> -	ATA_TMOUT_PMP_SRST_WAIT	= 1000,
> +	ATA_TMOUT_PMP_SRST_WAIT	= 5000,

Okay, it's already merged but this will add a lot of delay to device
probing.  I think we better be a bit smarter here.

Thanks.

-- 
tejun
