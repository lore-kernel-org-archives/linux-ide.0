From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] [241/2many] MAINTAINERS - IDE/ATAPI CDROM DRIVER
Date: Mon, 13 Aug 2007 12:06:26 +0100
Message-ID: <20070813120626.1f0447d9@the-village.bc.nu>
References: <46bffa41.8uNto66i1R9GDZK6%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47654 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S943502AbXHMK7T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Aug 2007 06:59:19 -0400
In-Reply-To: <46bffa41.8uNto66i1R9GDZK6%joe@perches.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: joe@perches.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On Sun, 12 Aug 2007 23:29:21 -0700
joe@perches.com wrote:

> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d22e45a..b77decd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2285,6 +2285,8 @@ P:	Alan Cox
>  M:	alan@lxorguk.ukuu.org.uk
>  L:	linux-ide@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/cdrom/ide-cd
> +F:	drivers/ide/ide-cd.*

Acked-by: Alan Cox <alan@redhat.com>
