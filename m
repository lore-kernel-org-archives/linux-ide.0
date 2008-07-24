From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] remove <linux/hdreg.h>
Date: Thu, 24 Jul 2008 16:22:09 -0400
Message-ID: <20080724202209.GA30634@infradead.org>
References: <200807242137.58606.bzolnier@gmail.com> <20080724194915.GA23998@infradead.org> <200807242211.53655.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:42635 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYGXUWK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 16:22:10 -0400
Content-Disposition: inline
In-Reply-To: <200807242211.53655.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 24, 2008 at 10:11:52PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 24 July 2008, Christoph Hellwig wrote:
> > On Thu, Jul 24, 2008 at 09:37:58PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > It has no in-kernel users now and can be removed.
> > 
> > But beeing an exported header it has userspace users.  Plese keep it
> > and just leave the ioctl defintions as need by userspace in it instead
> > of renaming that part to hdio_ioctls.h.
> 
> Agreed w.r.t. to keeping it (the last patch was more of rfc than intended
> to be commited, sorry that I didn't mark it as such) but what's wrong with
> moving ioctl definitions to hdio_ioctls.h so we have clean separation of
> obsoleted userspace-only stuff & userspace/kernel stuff?

Well, if there was anything kernel-related left in hdreg.h I would
agree to split it, although I'd prefer to move the kernel part out.

But given that you kill all the kernel only bits anyway, just leave
the user interface in hdreg.h even if it's slightly misnamed.

