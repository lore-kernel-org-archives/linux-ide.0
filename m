From: idurdanovic@comcast.net (Igor Durdanovic)
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 4 Oct 2007 03:29:23 -0400
Message-ID: <18180.38483.139258.690293@kitty1.shrimp.net>
References: <18180.26625.216781.626572@kitty1.shrimp.net>
	<470468EE.909@gmail.com>
	<18180.30643.554165.292012@kitty1.shrimp.net>
	<4704790C.7060901@gmail.com>
	<18180.31651.305092.579581@kitty1.shrimp.net>
	<470480C9.9030309@gmail.com>
	<18180.34107.704754.565573@kitty1.shrimp.net>
	<47048C2B.1060202@gmail.com>
	<47049344.6010603@gmail.com>
Reply-To: idurdanovic@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([204.127.200.85]:40725 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427AbXJDHev (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 03:34:51 -0400
In-Reply-To: <47049344.6010603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: idurdanovic@comcast.net, linux-ide@vger.kernel.org

Tejun Heo writes:
> > Can you try to update the firmware as explained in the SIMG support page
> > and see whether that fixes the problem?

I am actually trying to put all the sw on the array, will try to
update firmware later.

Have some weird problems .. the whole thing just froze, sigh.
Also, why can't I enable write-caching on each drive behind PM?


> Hmmm... Before doing that, do your drives spin up one-by-one as the
> above probing progresses?

Yes, the probing starts with the bottom drive and progresses to the
top. But it seems for each drive it resets (from the bottom) all
already probed drives.

Igor
