From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2 pata-2.6] ide: make void and rename ide_dma_timeout() method
Date: Sat, 5 May 2007 20:51:21 +0200
Message-ID: <200705052051.21906.bzolnier@gmail.com>
References: <200704250005.16183.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:16330 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933253AbXEEUHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 16:07:55 -0400
Received: by ug-out-1314.google.com with SMTP id 44so854329uga
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 13:07:53 -0700 (PDT)
In-Reply-To: <200704250005.16183.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Tuesday 24 April 2007, Sergei Shtylyov wrote:
> Since ide_dma_timeout() method's result is discarded, make it return 'void'.
> While at it, drop 'ide_' from the method's name, drop the '__' prefix from
> the default method's name, and do some cleanups in this method driver-wise:
> 
> - in ide-dma.c, au1xxx-ide.c, and pdc202xx_old.c, define/use 'hwif' variable;
> 
> - in au1xxx-ide.c, get rid of commented out printk();
> 
> - in sl82c105.c, get rid of unnecessary variables.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
