From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2 pata-2.6] ide: make void and rename ide_dma_lostirq() method
Date: Sat, 5 May 2007 20:51:00 +0200
Message-ID: <200705052051.01056.bzolnier@gmail.com>
References: <200704250004.09951.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:23637 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933228AbXEEUHx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 16:07:53 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1128719muf
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 13:07:51 -0700 (PDT)
In-Reply-To: <200704250004.09951.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


On Tuesday 24 April 2007, Sergei Shtylyov wrote:
> Since ide_dma_lostirq() method's result is discarded, make it return 'void'.
> While at it, rename the method to dma_lost_irq(), drop the '__' prefix from the
> default method's name, and do some cleanups in this method driver-wise:
> 
> - in aec62xx.c, rename the method in accordance with other drivers, and get rid
>   of unnecessary variables there;
> 
> - in pdc202xx_old.c, define/use 'hwif' variable;
> 
> - in sgiioc4.c, rearrange the code to call the resetproc() method directly.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
