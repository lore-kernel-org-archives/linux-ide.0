From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH 2.6.29] ide-tape: remove back-to-back
	REQUEST_SENSE detection
Date: Tue, 9 Jun 2009 01:26:54 -0700
Message-ID: <20090609082654.GC8347@kroah.com>
References: <20090527072004.GA8127@liondog.tnic> <200905270940.40610.bzolnier@gmail.com> <20090527080345.GA9162@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:36860 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754109AbZFIImr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Jun 2009 04:42:47 -0400
Content-Disposition: inline
In-Reply-To: <20090527080345.GA9162@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, tj@kernel.org, linux-ide@vger.kernel.org, stable@kernel.org

On Wed, May 27, 2009 at 10:03:45AM +0200, Borislav Petkov wrote:
> On Wed, May 27, 2009 at 09:40:40AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 27 May 2009 09:20:04 Borislav Petkov wrote:
> > > Hi,
> > > 
> > > please include, commit id upstream:
> > > 
> > > 1e75540ec5202cae63cd238c86bd880e3d496546
> > 
> > This is for-next branch..
> > 
> > The right commit is 36999a5af1b6c5379e59f0ddf434db08d03c19e4 (because it
> > was later cherry picked into for-linus) and has my S-o-B line.
> 
> Thanks, had the wrong commit id noted here.

Now queued up, thanks.

greg k-h
