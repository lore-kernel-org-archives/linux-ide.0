From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/5] ide-cd: trivial fixes
Date: Wed, 27 Feb 2008 23:48:34 +0100
Message-ID: <200802272348.35011.bzolnier@gmail.com>
References: <1204136449-9490-1-git-send-email-petkovbb@gmail.com> <200802272218.40312.bzolnier@gmail.com> <20080227221814.GC9545@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:45009 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbYB0WrM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 17:47:12 -0500
Received: by ug-out-1314.google.com with SMTP id z38so279ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 14:47:08 -0800 (PST)
In-Reply-To: <20080227221814.GC9545@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 27 February 2008, Borislav Petkov wrote:
> On Wed, Feb 27, 2008 at 10:18:40PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi,
> > 
> > On Wednesday 27 February 2008, Borislav Petkov wrote:
> > > Hi Bart,
> > > 
> > > here are the ide-cd trivial fixes split in an easier to digest format. I
> > > cannot do the md5sum check here since all of the patches change at least one
> > > char but i hope that this'll be redundant here since they're trivially easy
> > > to review :) now.
> > > 
> > >  drivers/ide/ide-cd.c |  591 +++++++++++++++++++++++++-------------------------
> > >  1 files changed, 298 insertions(+), 293 deletions(-)
> > 
> > applied everything
> > 
> > BTW patch #3/5 which accounts for 2/3 of the diffstat passes md5sum check here
> 
> huh, are you sure? The fixup-comments patch adds at least one char to the source
> file so the md5sums cannot be the same.

OTOH md5sums of the resulting _binary_ files matches... ;-) 
