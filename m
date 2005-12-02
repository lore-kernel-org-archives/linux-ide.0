From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise SATA oops
Date: Fri, 02 Dec 2005 00:29:01 -0500
Message-ID: <438FDB9D.2030201@pobox.com>
References: <20051202045853.GD3677@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8415 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751315AbVLBF3K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2005 00:29:10 -0500
In-Reply-To: <20051202045853.GD3677@vitelus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Aaron Lehmann wrote:
> I'm running 2.6.14.2 on an x86_64 (Athlon X2, i.e. SMP) with a Promise
> TX4 SATAII 150 controller. The night I set up the machine, I got a
> Promise-related oops (null pointer dereference IIRC), but was foolish
> enough not to write it down.  Since then, the machine has been
> unstable, and I've suspected the same thing is recurring, but since I
> use X it's very difficult to actually get at the oops. I ended up
> setting up a ramdisk with a static busybox that I could use to poke
> around if anything interesting happened. Just now everything using the
> filesystem went into D-state, so I checked dmesg and saw uncorrectable
> errors being reported on /dev/sdd. The system froze completely within
> a minute. When I rebooted, I got the oops at the end of this message.
> I was only able to copy the portion that fit on the screen. A second
> reboot was sucessful. My RAID5 arrays are resyncing now, and I expect
> that to complete normally because I've had to go through a lot of
> resyncs since I set this system up and they were all sucessful. Once
> that's done, I guess I'll run badblocks on sdd and see if anything
> turns up. It would be a shame if that drive is bad, considering that
> my 4 hard drives are brand new ones to replace a failed array I had
> lots of problems with.

This should be fixed in 2.6.15-rcX...

	Jeff



