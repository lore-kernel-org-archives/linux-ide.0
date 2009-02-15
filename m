From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 01/10] ide: add flags query macros
Date: Sun, 15 Feb 2009 19:01:41 +0100
Message-ID: <20090215180141.GB5156@gollum.tnic>
References: <1234699692-9452-1-git-send-email-petkovbb@gmail.com> <1234699692-9452-2-git-send-email-petkovbb@gmail.com> <20090215133512.GA32621@uranus.ravnborg.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:61274 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbZBOSBm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 13:01:42 -0500
Content-Disposition: inline
In-Reply-To: <20090215133512.GA32621@uranus.ravnborg.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 15, 2009 at 02:35:12PM +0100, Sam Ravnborg wrote:
> On Sun, Feb 15, 2009 at 01:08:03PM +0100, Borislav Petkov wrote:
> > There should be no functionality change resulting from this patch.
> > 
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > ---
> >  include/linux/ide.h |  166 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 166 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/linux/ide.h b/include/linux/ide.h
> > index c75631c..f133062 100644
> > --- a/include/linux/ide.h
> > +++ b/include/linux/ide.h
> > @@ -497,6 +497,82 @@ enum {
> >  	IDE_AFLAG_NO_AUTOCLOSE		= (1 << 24),
> >  };
> >  
> > +#define ide_drv_drq_int(drive) \
> > +	((drive)->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT)
> 
> Why not use a static inline here so we get proper typecheck.
> And then convert the return result to a bool (0/1) so you
> do not have to do this at the call site.
> 
> I counted at least three places in ide-cd that does a local
> transformation to a bool and I saw nowhere the actual bit value
> was used.

I'm assuming you're talking about those places (and similar):

drive->dma = !!(drive->dev_flags & IDE_DFLAG_USING_DMA);

Well, actually we almost never use the 0/1 bool value and this one
case is more of an exception. If you take a closer look, we don't have
setters/getters ..., well let's call them methods as it is in the
OO-world, and we simply access the bare flags. So the macros as such are
simply to save some stack and improve readability and since the whole
thing keeps changing we might just as well turn them into static inlines
one fine day :).

Bart, what do you think?

-- 
Regards/Gruss,
    Boris.
