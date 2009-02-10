From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Port Multiplier access with Sil 3124
Date: Mon, 09 Feb 2009 19:15:10 -0500
Message-ID: <4990C70E.1010707@garzik.org>
References: <498F42B6.8030607@tlinx.org>	 <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>	 <4990AC91.8010104@tlinx.org> <87f94c370902091501h96ecb8dp7acac1fa80a82d8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52105 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990AbZBJAPP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Feb 2009 19:15:15 -0500
In-Reply-To: <87f94c370902091501h96ecb8dp7acac1fa80a82d8a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Linda Walsh <suse@tlinx.org>, linux-ide@vger.kernel.org

Greg Freemyer wrote:

> I'm hearing of people saying a 2 disk mirror (raid-1) is not safe
> enough.  Go with either a 3 disk mirror or to raid-6.  Even with
> raid-6 I personally would not let it have too many spindles. (Whatever
> too many means?)

IMO, RAID-1 was never safe.  With RAID-1, one must rely solely on 
"knowing" which RAID component is bad.  With a completely dead drive, 
this is obvious; with slowly creeping bad sectors, far less obvious.

Plus, the biggest crime, in my opinion, is the lack of checksumming or 
any other method of actually verifying your data.

I've been waiting for years for someone to write RAID-1f...  RAID-1 with 
a hash function that writes checksums in a special metadata area (just 
like the other pre-existing RAID metadata...  a RAID partition is really 
a just simple filesystem anyway).

That way you _know_ with 100% certainty that your data is OK (or not), 
even if you only have a single drive.

	Jeff


