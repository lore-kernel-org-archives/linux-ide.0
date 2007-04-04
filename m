From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH pata-2.6] sl82c105: rework PIO support (take 2)
Date: Wed, 4 Apr 2007 21:33:26 +0200
Message-ID: <200704042133.26985.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200703282147.41696.sshtylyov@ru.mvista.com> <460AAEA5.40008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:15783 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993040AbXDDTgv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Apr 2007 15:36:51 -0400
Received: by ug-out-1314.google.com with SMTP id 44so782469uga
        for <linux-ide@vger.kernel.org>; Wed, 04 Apr 2007 12:36:37 -0700 (PDT)
In-Reply-To: <460AAEA5.40008@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org


On Wednesday 28 March 2007, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> > Index: linux-2.6/include/linux/ide.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/ide.h
> > +++ linux-2.6/include/linux/ide.h
> > @@ -613,7 +613,6 @@ typedef struct ide_drive_s {
> >  
> >          u8	quirk_list;	/* considered quirky, set for a specific host */
> >          u8	init_speed;	/* transfer rate set at boot */
> > -        u8	pio_speed;      /* unused by core, used by some drivers for fallback from DMA */
> >          u8	current_speed;	/* current transfer rate set */
> >          u8	dn;		/* now wide spread use */
> >          u8	wcache;		/* status of write cache */
> 
>     Oops, forgot to pull the recent kernel before sending out, so this part 
> won't apply bacause of the desired_speed nuisance. Do I need to resend?

I was mentally prepared to fix it manually to save time on both sides but...

Hunk #1 succeeded at 613 with fuzz 2.

;)
