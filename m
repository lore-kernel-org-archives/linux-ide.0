From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/21] ide-floppy redux v2
Date: Sat, 12 Jan 2008 21:14:39 +0100
Message-ID: <200801122114.40047.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <200801121446.00276.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:20776 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757168AbYALUUB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:20:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so640513ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 12:19:59 -0800 (PST)
In-Reply-To: <200801121446.00276.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Saturday 12 January 2008, Bartlomiej Zolnierkiewicz wrote:
> On Friday 11 January 2008, Borislav Petkov wrote:
> > 
> > Hi Bart,
> > 
> >    here's the second version of the ide-floppy refactoring trail. All the
> > patches are based on the version of your quilt tree from the 05.01. Also, you've
> > already applied patch 5 in this series but i'm submitting it still for the sake
> > of completeness.
> > 
> > 
> >  drivers/ide/ide-cd.c     |    2 -
> >  drivers/ide/ide-floppy.c | 1403 ++++++++++++++++++----------------------------
> >  include/linux/cdrom.h    |    1 +
> >  include/linux/ide.h      |    3 +
> >  4 files changed, 558 insertions(+), 851 deletions(-)
> 
> applied patches #1-4, #8
> (#4 with some changes)
> 
> #5 was already applied so I just re-ordered it into the right spot
> 
> I have some comments for #6-7

applied #9, #15 and #17

some comments for #11-12, #14 and #18-21 in separate mails

#10 and #16 are fine but because they depend on unmerged patches
I'm unable to apply them currently

Overall: good job!  300 LOC removed from the driver, code size savings
and a lot of preparations for the future ATAPI handling unification. :)

Thanks,
Bart

PS1 Please rebase the patches still needing polishing on top of updated
IDE quilt tree, recast them and respin the patch series (no need to post
already merged patches).

PS2 what happend to "fix DMA error reporting" patch? (#13 is missing, hmm?)
