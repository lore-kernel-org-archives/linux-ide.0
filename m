From: Borislav Petkov <bp@alien8.de>
Subject: Re: [3.1-rc6] kmalloc(64) leak from IDE
Date: Fri, 30 Sep 2011 08:40:19 +0200
Message-ID: <20110930064019.GA8092@liondog.tnic>
References: <20110922072643.GA27232@hostway.ca>
 <20110922084811.GC17640@liondog.tnic>
 <20110922202337.GB32661@hostway.ca>
 <20110923072118.GA13293@liondog.tnic>
 <20110923173808.GB26481@hostway.ca>
 <20110925085818.GA10947@liondog.tnic>
 <20110926080549.GA14697@hostway.ca>
 <20110927170755.GA31384@gere.osrc.amd.com>
 <20110929092705.GA809@liondog.tnic>
 <20110929224505.GC7959@hostway.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:40058 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899Ab1I3GkY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Sep 2011 02:40:24 -0400
Content-Disposition: inline
In-Reply-To: <20110929224505.GC7959@hostway.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Kirby <sim@hostway.ca>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Sep 29, 2011 at 03:45:05PM -0700, Simon Kirby wrote:
> Tested against on 2.6.39 with and without this patch, and it
> definitely leaks without it and does not leak with it. 3.0 and 3.1-rc8
> also seems good with the patch.

Good job, thanks!

> I tested on another IDE box (with an old Quantum Fireball 6.4GB!) and

:-)

> even with software RAID, I could not see the leak, so I had to use the
> original box, of course. The only difference I could see is the test
> box has piix and the production box has via82cxxx, but anyway...

It might be because the production box drive is reporting of being
capable of doing write cache flushes, i.e. it should say something like

ideXX: cache flushes supported

in dmesg. idedisk_prep_fn() is contingent on that and is used only then
AFAICT.

Thanks again for testing.

-- 
Regards/Gruss,
    Boris.
