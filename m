From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 3/5] ide: add a driver-wide debugging macro
Date: Sun, 17 Aug 2008 20:24:33 +0200
Message-ID: <20080817182433.GA6849@gollum.tnic>
References: <1218993826-4571-1-git-send-email-petkovbb@gmail.com> <1218993826-4571-4-git-send-email-petkovbb@gmail.com> <1218996786.24527.115.camel@localhost>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:52448 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbYHQSYg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 14:24:36 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1466332fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 11:24:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1218996786.24527.115.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: bzolnier@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sun, Aug 17, 2008 at 11:13:06AM -0700, Joe Perches wrote:
> On Sun, 2008-08-17 at 19:23 +0200, Borislav Petkov wrote:
> > diff --git a/include/linux/ide.h b/include/linux/ide.h
> > index c161840..b6d714d 100644
> > --- a/include/linux/ide.h
> > +++ b/include/linux/ide.h
> > []
> > +/* DRV_NAME has to be defined in the driver before using the macro below */
> > +#define __ide_debug_log(lvl, fmt, args...)			\
> > +{								\
> > +	if (unlikely(drive->debug_mask & lvl))			\
> > +		printk(KERN_INFO DRV_NAME ": " fmt, ## args);	\
> > +}
> 
> Shouldn't a debug printk use KERN_DEBUG?

Yes, it should. However, i'm going to have to change the default console
loglevel to see those, aka boot with loglevel=7 and there's the possibility of
other debug messages getting in the way too. Instead, the debugging messages
here are enabled only when you do a debug build of the driver _and_ when enable
them through the debug_mask so you get to see debug messages only you're
interested in without changing anything else in the kernel boot.

-- 
Regards/Gruss,
    Boris.
