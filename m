From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] remove <linux/hdreg.h>
Date: Thu, 24 Jul 2008 15:49:15 -0400
Message-ID: <20080724194915.GA23998@infradead.org>
References: <200807242137.58606.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:41603 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYGXTtQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 15:49:16 -0400
Content-Disposition: inline
In-Reply-To: <200807242137.58606.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 24, 2008 at 09:37:58PM +0200, Bartlomiej Zolnierkiewicz wrote:
> It has no in-kernel users now and can be removed.

But beeing an exported header it has userspace users.  Plese keep it
and just leave the ioctl defintions as need by userspace in it instead
of renaming that part to hdio_ioctls.h.

