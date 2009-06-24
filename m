From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [patch 2/6] ide: fix ide_kill_rq() for special
	ide-{floppy,tape} driver requests
Date: Wed, 24 Jun 2009 09:08:13 +0200
Message-ID: <20090624070813.GA21999@liondog.tnic>
References: <200906232326.06830.bzolnier@gmail.com> <20090623.161611.139291300.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:64897 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324AbZFXHIO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 03:08:14 -0400
Content-Disposition: inline
In-Reply-To: <20090623.161611.139291300.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

On Tue, Jun 23, 2009 at 04:16:11PM -0700, David Miller wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Tue, 23 Jun 2009 23:26:06 +0200
> 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: fix ide_kill_rq() for special ide-{floppy,tape} driver requests
> > 
> > Such requests should be failed with -EIO (like all other requests
> > in this function) instead of being completed successfully.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> > Untested, you may try pinging Borislav and/or Tejun about possible
> > testing if you would like to verify the patch before applying.
> 
> This must be tested in some way.  I can see this potentially
> breaking something.
> 
> Especially this is true because ide_complete_rq() does it's
> "complete whole request right now" logic for error <= 0.
> 
> Borislov/Tejun, can either of you test this code path with this
> change applied?  I'd very much appreciate it.

Yep, I'll give the whole series a whirl in a while.

-- 
Regards/Gruss,
    Boris.
