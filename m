From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Port Multiplier access with Sil 3124
Date: Mon, 09 Feb 2009 22:48:45 -0500
Message-ID: <4990F91D.4020503@garzik.org>
References: <498F42B6.8030607@tlinx.org>	 <87f94c370902090635h2fc3e604n990bdd70be9c48cd@mail.gmail.com>	 <4990AC91.8010104@tlinx.org> <87f94c370902091501h96ecb8dp7acac1fa80a82d8a@mail.gmail.com> <4990C70E.1010707@garzik.org> <4990D349.4050408@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55619 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888AbZBJDsu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Feb 2009 22:48:50 -0500
In-Reply-To: <4990D349.4050408@tlinx.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linda Walsh <lkml@tlinx.org>
Cc: linux-ide@vger.kernel.org

Linda Walsh wrote:
> Jeff Garzik wrote:
>> Greg Freemyer wrote:
>>
>>> I'm hearing of people saying a 2 disk mirror (raid-1) is not safe
>>> enough.  Go with either a 3 disk mirror or to raid-6.  Even with
>>> raid-6 I personally would not let it have too many spindles. (Whatever
>>> too many means?)
>>
>> IMO, RAID-1 was never safe.  With RAID-1, one must rely solely on 
>> "knowing" which RAID component is bad.  With a completely dead drive, 
>> this is obvious; with slowly creeping bad sectors, far less obvious.
> ---
>     I had a similar thought -- how would I know if the
> 2-disks are actually "in sync"?
> 
>     I'm  guessing I could physically remove each and try to access
> them as single-drives and they should be the same, but I don't know that
> the RAID-1 format will store the data on each drive to exactly look
> like a single mounted disk.  I can't think of how else they might
> do it, or why, but I just haven't physically verified that I an
> pull either HD and access it as a solo-hard disk.  (I'd hope so...but
> until I've actually tried it with the hardware in question...)
> 
>     But all of this is really depressing me.  Just throw up my hands
> and give up on computer storage?

Find a solution that has both replication and checksumming :)

Trust no component!  :)

	Jeff




