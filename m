From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 09/14] ide-atapi: use local sense buffer
Date: Tue, 12 May 2009 09:17:39 +0200
Message-ID: <20090512071739.GA24565@liondog.tnic>
References: <1241855134-4984-1-git-send-email-petkovbb@gmail.com> <1241855134-4984-10-git-send-email-petkovbb@gmail.com> <200905102332.39043.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:33348 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758066AbZELHRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 May 2009 03:17:43 -0400
Content-Disposition: inline
In-Reply-To: <200905102332.39043.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Sun, May 10, 2009 at 11:32:38PM +0200, Bartlomiej Zolnierkiewicz wrote:

[..]

all done, testing...

> > -	pc->req_xfer = blk_rq_bytes(sense_rq);
> 
> I think that we can remove ->req_xfer now completely, patch #13.5? :)

Well, the trivial thing would be to replace the pc->req_xfer with the
naked number representing the cmd length, which is ugly. I'll think of
something more elegant when merging all those ide_create.*cmd into their
users. As always, I'm open to suggestions, of course :).

-- 
Regards/Gruss,
    Boris.
