From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patches] IDE updates/fixes
Date: Wed, 16 May 2007 12:07:57 +0200
Message-ID: <200705161207.57716.bzolnier@gmail.com>
References: <200705160127.55430.bzolnier@gmail.com> <alpine.LFD.0.98.0705151847160.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:14165 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634AbXEPJzx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 May 2007 05:55:53 -0400
Received: by nz-out-0506.google.com with SMTP id r28so494794nza
        for <linux-ide@vger.kernel.org>; Wed, 16 May 2007 02:55:52 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0705151847160.3890@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wednesday 16 May 2007, Linus Torvalds wrote:
> 
> On Wed, 16 May 2007, Bartlomiej Zolnierkiewicz wrote:
> > 
> > * host driver fixes:
> >   - pdc202xx_old: mode programming rewrite (a lot of bugs fixed)
> >   - serverworks/sis5513: PIO mode setup fixes
> >   - sl82c105: MWDMA0/1 support by Sergei
> >   - cs5530/sc1200/sl82c105: ->speedproc support ("hdparm -X")
> 
> > * 2nd part of cleanups basing on DMA tuning rework (which was merged
> >   in the previous IDE update) - quite straightforward code re-factoring
> >   (no functionality changes) and removal of no longer needed functions.
> > 
> >   This results in simpler, more generic code and in ~300 LOCs gone.
> > 
> > * some misc fixes/updates
> 
> Bartlomiej, this really was too late for the 2.6.22 merge window. I'm 
> going to pull it, since it seems borderline mostly fixes and the 

Thanks.

> refactoring should hopefully not change any functionality, but I really 

Moreover most of these patches have been in IDE tree and -mm for
over 2 months so they really should be fine.

> don't enjoy it. Please don't do this again.

OK and sorry for that.

Bart
