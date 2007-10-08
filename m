From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] IDE:  Remove inclusion of non-existent io_trace.h.
Date: Mon, 8 Oct 2007 22:38:08 +0200
Message-ID: <200710082238.08931.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0710070748180.1286@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:59004 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbXJHVjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:44 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370186nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710070748180.1286@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-ide@vger.kernel.org, gadio@netvision.net.il


Hi,

On Sunday 07 October 2007, Robert P. J. Day wrote:
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
>   the fact that this header file doesn't exist has apparently been
> known for quite some time:
> 
> http://osdir.com/ml/linux.tape/2005-07/msg00001.html
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 1fa5794..e5a86a9 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -621,7 +621,6 @@ typedef struct os_dat_s {
>   */
>  #define USE_IOTRACE	0
>  #if USE_IOTRACE
> -#include <linux/io_trace.h>
>  #define IO_IDETAPE_FIFO	500
>  #endif

It seems that all code covered by #if/#endif USE_IOTRACE in ide-tape.c
could be removed as well.  Care to respin the patch?

Thanks,
Bart
