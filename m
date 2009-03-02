From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide_timer_expiry() - shouldn't 'wait' be int?
Date: Mon, 2 Mar 2009 16:29:13 +0100
Message-ID: <200903021629.13651.bzolnier@gmail.com>
References: <49ABEAC0.40407@gmail.com> <200903021558.20809.bzolnier@gmail.com> <49ABF892.1060300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:23859 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbZCBP1r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2009 10:27:47 -0500
Received: by fk-out-0910.google.com with SMTP id f33so978079fkf.5
        for <linux-ide@vger.kernel.org>; Mon, 02 Mar 2009 07:27:43 -0800 (PST)
In-Reply-To: <49ABF892.1060300@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Monday 02 March 2009, Roel Kluin wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Monday 02 March 2009, Sergei Shtylyov wrote:
> >> Roel Kluin wrote:
> >>
> >>> vi drivers/ide/ide-io.c +906 and note:
> >>> void ide_timer_expiry (unsigned long data)
> >>> {
> >>> 	ide_expiry_t *expiry = hwif->expiry;
> >>> 	...
> >>> 	unsigned long   wait = -1;
> >>     Hm, haven't nothiced that this is *unsigned*.
> >>
> >>> 		...
> >>> 		if (expiry) {
> >>> 			...
> >>> 			wait = expiry(drive);
> >>> 			if (wait > 0) { /* continue */
> >>> also note that in include/linux/ide.h:883:
> >>> typedef int (ide_expiry_t)(ide_drive_t *);
> >>> doesn't this mean that expiry returns int, and wait therefore should
> >>> be int as well?
> >>     It rather means that ide_expiry_t() should return unsigned.
> > 
> > Seconded.  Roel, could you also handle it?
> > 
> > [ However since this is 2.6.30 stuff and there has been much work in
> >   this area recently please base in top of linux-next or pata-2.6 tree. ]
> > 
> >>     However, you're right as ide_dma_timeout_retry() takes *int* as a 2nd 
> >> argument.
> > 
> > Though it works fine (by a luck :) we should also fix it while we're at it.
> > 
> > Thanks,
> > Bart
> 
> I'm a little confused, do you want wait to be int, as my patch does below,
> or do you want the typedef to be:
> 
> typedef unsigned long (ide_expiry_t)(ide_drive_t *);

Both. ;)

> If the latter, I think the functions that expiry points to have to be adapted as
> well, right?
> 
> this is against tip-latest, feel free to modify the changelog.

Thanks!  This is exactly what I meant for 2.6.29 (one-line bugfix),
for 2.6.30 we should also do s/int/unsigned long/ cleanup (on top of
the current linux-next/pata-2.6 tree).

> ------------------------------>8-------------8<---------------------------------
> expiry() returns int, negative expiry() return values won't be noticed.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index cc35d6d..0715692 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -1190,7 +1190,7 @@ void ide_timer_expiry (unsigned long data)
>  	ide_handler_t	*handler;
>  	ide_expiry_t	*expiry;
>  	unsigned long	flags;
> -	unsigned long	wait = -1;
> +	int		wait = -1;
>  
>  	spin_lock_irqsave(&ide_lock, flags);
