From: linux@horizon.com
Subject: Anything more recent than 2.6.13-rc7-netdev1.patch.bz2?
Date: 28 Sep 2005 21:32:12 -0400
Message-ID: <20050929013212.1792.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:15676 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751297AbVI2BcX
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Sep 2005 21:32:23 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a new AMD64 server running 2.6.13.2 + 2.6.13-rc7-netdev1.patch.bz2
on some Sil3132 controllers, and I just got an assert fail in libata.
(Unfortunately, it didn't get written down; I'm trying to reproduce it.
I think the zcav I was runing on a 6-way RAID 0 might have caused it.)

Since I know libata development is rapid, it's quite possible that
it's been fixed in the month since that patch was released.  Also, I'd
like to try a 2.6.14-rc kernel, but I need a libata patch for the sim24
sriver, and trying to apply  2.6.13-rc7-netdev1.patch results in a mess
of conflicts; it looks like some of it has already been merged upstream.

Is there a more recent libata patch available somewhere?

Thanks!
