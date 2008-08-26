From: Jens Axboe <jens.axboe@oracle.com>
Subject: libata bridge limits
Date: Tue, 26 Aug 2008 09:28:41 +0200
Message-ID: <20080826072841.GS20055@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [93.163.65.50] ([93.163.65.50]:5883 "EHLO kernel.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbYHZH2n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 03:28:43 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Hi,

Jeff, a long time ago we talked about the bridge limits in libata core.
Back then it was my T43 notebook, but now I'm running into the same
problem. The Mtron 70xx series SSD drives sit behind a PATA-SATA bridge
and thus runs into the bridging limits in libata. To put things into
perspective, the difference between UDMA5 and UDMA6 modes on this drive
is 85 vs 115Mb/sec or 77 vs 106Mb/sec (depends on the host controller I
tested), so it's quite a lot.

There are several ways to solve this:

a) Why was this limit put in there? It limits both transfer speed and
   request size. If it's due to some dodgy drive/bridge, perhaps we
   should just check for that and only apply the transfer limits when
   detected (or blacklisted). On the bridge setups I've seen, I've never
   had problems with killing the limit.

b) Put in a whitelist, easy to do for these Mtron drives.

c) Add a parameter to turn it on (or off, depending on the default) for
   a specific drive.

I'm in favor of a) personally, but I'd like to hear why the check was
added originally first. Dropping 20-30% of the throughput performance on
the floor without option seems like a really bad choice.

-- 
Jens Axboe

