From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Linux v2.6.22-rc3
Date: Mon, 28 May 2007 17:50:14 -0400
Message-ID: <465B4E96.30108@tmr.com>
References: <alpine.LFD.0.98.0705252008210.26602@woody.linux-foundation.org> <9d2cd630705270801m2826be60p3f802c502b26c531@mail.gmail.com> <46599E6B.1000209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:32823 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbXE1Vu3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 May 2007 17:50:29 -0400
In-Reply-To: <46599E6B.1000209@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:

> Several people have reported LITE-ON LTR-48246S detection failed
> because SETXFER fails.  It seems the device raises IRQ too early after
> SETXFER.  This is controller independent.  The same problem has been
> reported for different controllers.
> 
> So, now we have pata_via where the controller raises IRQ before it's
> ready after SETXFER and a device which does similar thing.  This patch
> makes libata always execute SETXFER via polling.  As this only happens
> during EH, performance impact is nil.  Setting ATA_TFLAG_POLLING is
> also moved from issue hot path to ata_dev_set_xfermode() - the only
> place where SETXFER can be issued.
> 
> Note that ATA_TFLAG_POLLING applies only to drivers which implement
> SFF TF interface and use libata HSM.  More advanced controllers ignore
> the flag.  This doesn't matter for this fix as SFF TF controllers are
> the problematic ones.
> 
Not only kills two birds with a single store, but will avoid having to 
re-solve the problem at sometime in the future. That's good software!

-- 
Bill Davidsen <davidsen@tmr.com>
   "We have more to fear from the bungling of the incompetent than from
the machinations of the wicked."  - from Slashdot
