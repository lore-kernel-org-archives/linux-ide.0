From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
Date: Thu, 28 Apr 2005 23:26:27 +0100
Message-ID: <1114727182.24687.235.camel@localhost.localdomain>
References: <Pine.LNX.3.96.1050428140509.29292A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:28113 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262298AbVD1W1m
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Apr 2005 18:27:42 -0400
In-Reply-To: <Pine.LNX.3.96.1050428140509.29292A-100000@gatekeeper.tmr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Iau, 2005-04-28 at 19:13, Bill Davidsen wrote:
> On Thu, 28 Apr 2005, Alan Cox wrote:

> But isn't that the stuff we use for swapping drives? Down the drive, down
> the interface, swap, and restart? Are these the functions called by hdparm
> (-bRU) which are all of a sudden not going to work? Or am I being
> alarmist?

True but the only kernels supporting that are 2.4.x-ac. There are
reasons I noticed this and looking at getting 2.6 IDE back to 2.4
standards in this area was one of them.

> I missed the discussion of why it was felt that the users would no longer
> want to be able to do these things, or the new way to do it.

I'm assuming it may be accidental rather than detailed planning. Also
its taken this long to notice so its clearly not that critical to
everyone. Seems to be reasonably sane to fix too.

Alan

