From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Polling (was Re: [PATCHSET 2/2] implement PMP support, take 6)
Date: Fri, 28 Sep 2007 22:25:36 +0200
Message-ID: <200709282225.36913.bzolnier@gmail.com>
References: <1190521193410-git-send-email-htejun@gmail.com> <46FD306C.3050205@gmail.com> <46FD5DE1.8000206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:46260 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837AbXI1UW1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Sep 2007 16:22:27 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1544472ugc
        for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 13:22:26 -0700 (PDT)
In-Reply-To: <46FD5DE1.8000206@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org


On Friday 28 September 2007, Mark Lord wrote:
> Tejun Heo wrote:
> > Jeff Garzik wrote:
> >>> Aieee... Another merge delay.  I wish the review process proceeded a bit
> >>> swifter.   The patchset has been around literally for years now and
> >>> submitted for review six times if I have the take number right.  :-(
> >> Well the vast majority of the patches are in, what five out of six
> >> original patchsets?
> > 
> > Yeah, I'm frustrated mainly because I've been telling people that
> > mainline will probably have PMP support when 2.6.24 comes out and it
> > seems we'll miss the merge window again.  Oh, well...
> > 
> >> Sorry I didn't catch the polling requirement beforehand, it was not
> >> really clear from a quick read.
> > 
> > ->pmp_read/write stuff is something which I've been meaning to change
> > anyway.  When developing the PMP code, PMP register access while frozen
> > seemed necessary but now I think we can be just as safe without it.  I
> > was thinking about changing it after merge because the current code
> > received a lot of testing and I didn't want to destabilize it right
> > before merging.

This is an excellent point for merging the PMP code as it is currently
and doing revamp later.  PMP patchset in the current form has got quite
a lot of testing in -mm and "last minute" changes have a tendency to
bring up some nasty surprises.

> > I'll be back home mid next week.  I'll try to re-test and re-submit the
> > changes ASAP.
> 
> Jeff, seeing as Tejun's commitment is never in doubt here,
> I really believe we should go with the existing PMP patchset
> for 2.6.24 (unless the respin happens quickly enough).
> 
> This functionality is way overdue, and we shouldn't be impeding it
> as long as we have been.

It is way, way overdue...

> Tejun will definitely continue to rework the changes you've asked for
> in time for the next release, but let's not hold things up unreasonably here.

Seconded.

Bart
