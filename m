From: Jens Axboe <axboe@suse.de>
Subject: Re: ide-cd in 2.6.10/11: BIG problem with burning audio CDs
Date: Thu, 3 Feb 2005 12:05:48 +0100
Message-ID: <20050203110547.GU5710@suse.de>
References: <20050203085452.GA22995@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ns.virtualhost.dk ([195.184.98.160]:44444 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262632AbVBCLF6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 06:05:58 -0500
Content-Disposition: inline
In-Reply-To: <20050203085452.GA22995@tangens.sinus.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>
Cc: linux-ide@vger.kernel.org

On Thu, Feb 03 2005, Pavel Troller wrote:
>   The problem is that on 2.6.10 and 2.6.11-rc[1-3], burning audio CDs
>   consumes so much CPU cycles, that my dual Athlon 1800+ system cannot
>   serve the process and cd burner dies of repeated buffer underruns or
>   totally crashes, requiring physical reset to revive (no ide bus
>   reset is enough).

Try this patch.

===== drivers/ide/ide-cd.c 1.105 vs edited =====
--- 1.105/drivers/ide/ide-cd.c	2005-01-08 06:43:53 +01:00
+++ edited/drivers/ide/ide-cd.c	2005-01-09 16:31:53 +01:00
@@ -1915,7 +1915,7 @@
 		/*
 		 * check if dma is safe
 		 */
-		if ((rq->data_len & mask) || (addr & mask))
+		if ((rq->data_len & 3) || (addr & mask))
 			info->dma = 0;
 	}
 

-- 
Jens Axboe

