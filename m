From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide_timer_expiry() - shouldn't 'wait' be int?
Date: Mon, 2 Mar 2009 16:45:21 +0100
Message-ID: <200903021645.22133.bzolnier@gmail.com>
References: <49ABEAC0.40407@gmail.com> <200903021558.20809.bzolnier@gmail.com> <49ABFDB8.9050600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:5257 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016AbZCBPuE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 10:50:04 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1530292ywh.1
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2009 07:50:00 -0800 (PST)
In-Reply-To: <49ABFDB8.9050600@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Monday 02 March 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>vi drivers/ide/ide-io.c +906 and note:
> 
> >>>void ide_timer_expiry (unsigned long data)
> >>>{
> >>>	ide_expiry_t *expiry = hwif->expiry;
> >>>	...
> >>>	unsigned long   wait = -1;
> 
> >>    Hm, haven't nothiced that this is *unsigned*.
> 
> >>>		...
> >>>		if (expiry) {
> >>>			...
> >>>			wait = expiry(drive);
> >>>			if (wait > 0) { /* continue */
> >>
> >>>also note that in include/linux/ide.h:883:
> 
> >>>typedef int (ide_expiry_t)(ide_drive_t *);
> 
> >>>doesn't this mean that expiry returns int, and wait therefore should
> >>>be int as well?
> 
> >>    It rather means that ide_expiry_t() should return unsigned.
> 
> > Seconded.  Roel, could you also handle it?
> 
>     Not worth it, IMO...
> 
> > [ However since this is 2.6.30 stuff and there has been much work in
> >   this area recently please base in top of linux-next or pata-2.6 tree. ]
> 
> >>    However, you're right as ide_dma_timeout_retry() takes *int* as a 2nd 
> >>argument.
> 
> > Though it works fine (by a luck :) we should also fix it while we're at it.
> 
>     Fix what?

ide_dma_timeout_retry's argument -- it is not the error value that we want to
pass but the timeout value.
