From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide_timer_expiry() - shouldn't 'wait' be int?
Date: Mon, 2 Mar 2009 16:51:01 +0100
Message-ID: <200903021651.01867.bzolnier@gmail.com>
References: <49ABEAC0.40407@gmail.com> <49ABEF7B.9080005@ru.mvista.com> <49ABFF0D.2070600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:47689 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbZCBPuA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 10:50:00 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1532576yxm.1
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2009 07:49:57 -0800 (PST)
In-Reply-To: <49ABFF0D.2070600@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Monday 02 March 2009, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >> vi drivers/ide/ide-io.c +906 and note:
> 
> >> void ide_timer_expiry (unsigned long data)
> >> {
> >>     ide_expiry_t *expiry = hwif->expiry;
> >>     ...
> >>     unsigned long   wait = -1;
> 
> >    Hm, haven't nothiced that this is *unsigned*.
> 
> >>         ...
> >>         if (expiry) {
> >>             ...
> >>             wait = expiry(drive);
> >>             if (wait > 0) { /* continue */
> 
> >> also note that in include/linux/ide.h:883:
> 
> >> typedef int (ide_expiry_t)(ide_drive_t *);
> 
> >> doesn't this mean that expiry returns int, and wait therefore should
> >> be int as well?
> 
> >    It rather means that ide_expiry_t() should return unsigned.
> 
>     Er, not really, as it can return -1 too.

It can just return 0 instead.
