From: Jens Axboe <axboe@suse.de>
Subject: Re: [patch][9/9] block: remove bio walking
Date: Thu, 9 Sep 2004 16:31:16 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040909143116.GX1737@suse.de>
References: <200409082127.04331.bzolnier@elka.pw.edu.pl> <20040909090314.A24950@flint.arm.linux.org.uk> <200409091553.13918.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:12501 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265044AbUIIOcb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Sep 2004 10:32:31 -0400
Content-Disposition: inline
In-Reply-To: <200409091553.13918.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 09 2004, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 09 September 2004 10:03, Russell King wrote:
> > On Wed, Sep 08, 2004 at 09:27:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > [patch] block: remove bio walking
> > > 
> > > IDE driver was the only user of bio walking code.
> 
> was in -bk10 :-(
> 
> > The MMC driver also uses this.  Please don't remove.
> 
> OK I'll just drop this patch but can't we also use scatterlists in MMC?
> 
> The point is that I now think bio walking was a mistake and accessing
> bios directly from low-level drivers is a layering violation (thus
> all the added complexity). Moreover with fixed IDE PIO and without
> bio walking code it should be possible to shrink struct request by
> removing all "current" entries.

I agree, it's much nicer and it allows to drop the cbio fields in struct
request which is good.

-- 
Jens Axboe

