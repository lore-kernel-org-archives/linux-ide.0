From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/4] remove <linux/hdreg.h>
Date: Thu, 24 Jul 2008 22:11:52 +0200
Message-ID: <200807242211.53655.bzolnier@gmail.com>
References: <200807242137.58606.bzolnier@gmail.com> <20080724194915.GA23998@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:26137 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbYGXUTZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 16:19:25 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1164085nfc.21
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 13:19:23 -0700 (PDT)
In-Reply-To: <20080724194915.GA23998@infradead.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 24 July 2008, Christoph Hellwig wrote:
> On Thu, Jul 24, 2008 at 09:37:58PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > It has no in-kernel users now and can be removed.
> 
> But beeing an exported header it has userspace users.  Plese keep it
> and just leave the ioctl defintions as need by userspace in it instead
> of renaming that part to hdio_ioctls.h.

Agreed w.r.t. to keeping it (the last patch was more of rfc than intended
to be commited, sorry that I didn't mark it as such) but what's wrong with
moving ioctl definitions to hdio_ioctls.h so we have clean separation of
obsoleted userspace-only stuff & userspace/kernel stuff?

[ The hdio_ioctls.h include is also exported to userspace and included
  by hdreg.h internally (patch #1) so userspace should be unaffected. ]

Thanks,
Bart
