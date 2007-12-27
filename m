From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] trm290: do hook dma_host_{on,off} methods (take 2)
Date: Thu, 27 Dec 2007 17:05:32 +0100
Message-ID: <200712271705.32867.bzolnier@gmail.com>
References: <200712271355.36105.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:1112 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbXL0R2V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Dec 2007 12:28:21 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1677055ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 09:28:20 -0800 (PST)
In-Reply-To: <200712271355.36105.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 27 December 2007, Sergei Shtylyov wrote:
> Using default methods caused the chip's DMA PRD count registers, inadvertently
> starting DMA!  While fixing it, also do:

nasty, this could possibly explain the following trm290.c hack:

...
#if 0 /* play it safe for now */
			  IDE_HFLAG_TRUST_BIOS_FOR_DMA |
#endif
...

> - get rid of the 'ide_' prefixes in several functions for which the prefix in
>   the method's name has been 'ide_' ectomized already;
> 
> - align the code hooking the IDE DMA methods in init_hwif_trm290()...
> 
> ---
> Fixed the header, added 'static' to the new method definitions.
> The patch is against Linus' kernel tree...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
