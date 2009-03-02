From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide_timer_expiry() - shouldn't 'wait' be int?
Date: Mon, 2 Mar 2009 15:58:20 +0100
Message-ID: <200903021558.20809.bzolnier@gmail.com>
References: <49ABEAC0.40407@gmail.com> <49ABEF7B.9080005@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:48606 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbZCBO4t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 09:56:49 -0500
Received: by fxm24 with SMTP id 24so2013143fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2009 06:56:46 -0800 (PST)
In-Reply-To: <49ABEF7B.9080005@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Monday 02 March 2009, Sergei Shtylyov wrote:
> Roel Kluin wrote:
> 
> > vi drivers/ide/ide-io.c +906 and note:
> 
> > void ide_timer_expiry (unsigned long data)
> > {
> > 	ide_expiry_t *expiry = hwif->expiry;
> > 	...
> > 	unsigned long   wait = -1;
> 
>     Hm, haven't nothiced that this is *unsigned*.
> 
> > 		...
> > 		if (expiry) {
> > 			...
> > 			wait = expiry(drive);
> > 			if (wait > 0) { /* continue */
> 
> > also note that in include/linux/ide.h:883:
> 
> > typedef int (ide_expiry_t)(ide_drive_t *);
> 
> > doesn't this mean that expiry returns int, and wait therefore should
> > be int as well?
> 
>     It rather means that ide_expiry_t() should return unsigned.

Seconded.  Roel, could you also handle it?

[ However since this is 2.6.30 stuff and there has been much work in
  this area recently please base in top of linux-next or pata-2.6 tree. ]

>     However, you're right as ide_dma_timeout_retry() takes *int* as a 2nd 
> argument.

Though it works fine (by a luck :) we should also fix it while we're at it.

Thanks,
Bart
