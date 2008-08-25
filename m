From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/9] ide-disk: set_addressing() fixes
Date: Mon, 25 Aug 2008 22:23:54 +0200
Message-ID: <200808252223.54795.bzolnier@gmail.com>
References: <20080817171454.27943.37234.sendpatchset@localhost.localdomain> <20080817171501.27943.57473.sendpatchset@localhost.localdomain> <48B0850D.4000105@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:23392 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbYHYUcL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 16:32:11 -0400
Received: by mu-out-0910.google.com with SMTP id g7so320611muf.1
        for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 13:32:11 -0700 (PDT)
In-Reply-To: <48B0850D.4000105@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 23 August 2008, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Return -EIO if arg > 0 and LBA48 is unsupported.
> >
> > * No need to reset ->addressing.
> >
> > * Make ->addressing a single bit flag.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >   
> [...]
> > Index: b/include/linux/ide.h
> > ===================================================================
> > --- a/include/linux/ide.h
> > +++ b/include/linux/ide.h
> > @@ -507,7 +507,7 @@ struct ide_drive_s {
> >  	unsigned sleeping	: 1;	/* 1=sleeping & sleep field valid */
> >  	unsigned post_reset	: 1;
> >  	unsigned udma33_warned	: 1;
> > -	unsigned addressing	: 2;	/* 0=28-bit, 1=48-bit, 2=48-bit doing 28-bit */
> > +	unsigned addressing	: 1;	/* 0=28-bit, 1=48-bit */
> >  	unsigned wcache		: 1;	/* status of write cache */
> >  	unsigned nowerr		: 1;	/* used for ignoring ATA_DF */
> >   
> 
>    Don't you want to get rid of things like:
> 
>         u8 lba48 = (drive->addressing == 1) ? 1 : 0;

This was dealt with in "[PATCH 5/9] ide: add device flags" - since patch
#5/9 was going to touch the code anyway and there were no benefits besides
aesthetics in doing it in #2/9 I optimized the development process a bit...
