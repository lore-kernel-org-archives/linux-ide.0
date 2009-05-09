From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: 2.9.29.2: ide-tape: panic when probing device at boot
Date: Sat, 9 May 2009 18:18:01 +0200
Message-ID: <20090509161801.GB5749@liondog.tnic>
References: <200905080700.n48704BR031273@turbo.physics.adelaide.edu.au> <200905091757.49697.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:60171 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZEIQSF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 May 2009 12:18:05 -0400
Content-Disposition: inline
In-Reply-To: <200905091757.49697.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

Hi,

On Sat, May 09, 2009 at 05:57:49PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> [ cc:ing linux-ide and knowledgeable people ]
> 
> Borislav/Tejun:
> 
> Is the 2.6.29 problem the same thing that was fixed recently?

I'll let Tejun answer that one since I don't get an oops. However, now
that I have an ide-tape hardware here, I do get something DMA-related
failing during boot:

[    1.677012] hdb: Seagate STT8000A, ATAPI TAPE drive

..

[    1.701097] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    1.708289] hdb: bad DMA info in identify block
[    1.712872] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4

..

[    3.450381] Uniform CD-ROM driver Revision: 3.20
[    5.467347] ide-tape: hdb <-> ht0: Seagate STT8000A rev 5.44
[    5.484852] ide-tape: hdb <-> ht0: 88KBps, 14*26kB buffer, 400ms tDS

and more specifically the bad DMA info in identify block thing above. I
haven't looked into it yet but its next on my TODO.

> Should I just push commit 1e75540ec5202cae63cd238c86bd880e3d496546
> ("ide-tape: remove back-to-back REQUEST_SENSE detection") to Linus
> or there is more needed to bring ide-tape to the world of living?

... and I'm afraid we'll have to do some serious bugfixing since this
driver is behaving really funny :). Stay tuned, I'm on it.

-- 
Regards/Gruss,
    Boris.
