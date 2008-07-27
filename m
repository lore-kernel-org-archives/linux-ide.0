From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/4] remove <linux/hdreg.h>
Date: Sun, 27 Jul 2008 17:28:05 +0200
Message-ID: <200807271728.05518.bzolnier@gmail.com>
References: <200807242137.58606.bzolnier@gmail.com> <200807242211.53655.bzolnier@gmail.com> <20080724202209.GA30634@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:10604 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbYG0PfD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jul 2008 11:35:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1928048fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jul 2008 08:35:01 -0700 (PDT)
In-Reply-To: <20080724202209.GA30634@infradead.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 24 July 2008, Christoph Hellwig wrote:
> On Thu, Jul 24, 2008 at 10:11:52PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 24 July 2008, Christoph Hellwig wrote:
> > > On Thu, Jul 24, 2008 at 09:37:58PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > It has no in-kernel users now and can be removed.
> > > 
> > > But beeing an exported header it has userspace users.  Plese keep it
> > > and just leave the ioctl defintions as need by userspace in it instead
> > > of renaming that part to hdio_ioctls.h.
> > 
> > Agreed w.r.t. to keeping it (the last patch was more of rfc than intended
> > to be commited, sorry that I didn't mark it as such) but what's wrong with
> > moving ioctl definitions to hdio_ioctls.h so we have clean separation of
> > obsoleted userspace-only stuff & userspace/kernel stuff?
> 
> Well, if there was anything kernel-related left in hdreg.h I would
> agree to split it, although I'd prefer to move the kernel part out.
> 
> But given that you kill all the kernel only bits anyway, just leave
> the user interface in hdreg.h even if it's slightly misnamed.

Yep, no need to move it around.  I reworked patchset accordingly.

Thanks,
Bart
