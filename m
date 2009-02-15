From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/10] ide: add flags query macros
Date: Sun, 15 Feb 2009 14:35:12 +0100
Message-ID: <20090215133512.GA32621@uranus.ravnborg.org>
References: <1234699692-9452-1-git-send-email-petkovbb@gmail.com> <1234699692-9452-2-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepa.post.tele.dk ([195.41.46.235]:51516 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbZBONdV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 08:33:21 -0500
Content-Disposition: inline
In-Reply-To: <1234699692-9452-2-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sun, Feb 15, 2009 at 01:08:03PM +0100, Borislav Petkov wrote:
> There should be no functionality change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  include/linux/ide.h |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 166 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index c75631c..f133062 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
> @@ -497,6 +497,82 @@ enum {
>  	IDE_AFLAG_NO_AUTOCLOSE		= (1 << 24),
>  };
>  
> +#define ide_drv_drq_int(drive) \
> +	((drive)->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT)

Why not use a static inline here so we get proper typecheck.
And then convert the return result to a bool (0/1) so you
do not have to do this at the call site.

I counted at least three places in ide-cd that does a local
transformation to a bool and I saw nowhere the actual bit value
was used.

	Sam
