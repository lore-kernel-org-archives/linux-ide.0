From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Sat, 12 Jan 2008 00:06:37 +0000
Message-ID: <20080112000637.6cc07bfc@lxorguk.ukuu.org.uk>
References: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>
	<20080111193036.787a9fdc@lxorguk.ukuu.org.uk>
	<7f68de3e0801111149x15afd429sf48ed7db5fff8fa1@mail.gmail.com>
	<20080111195521.7e771e45@lxorguk.ukuu.org.uk>
	<7f68de3e0801111227x50c9ff31n1435d005e6b6b1f3@mail.gmail.com>
	<20080111210557.390271a0@lxorguk.ukuu.org.uk>
	<7f68de3e0801111327m1363b681ree81fbc5f7f43848@mail.gmail.com>
	<20080111213415.56d90f0d@lxorguk.ukuu.org.uk>
	<87f94c370801111351g132674fam295ba82a78f17842@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32928 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762059AbYALAJB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 19:09:01 -0500
In-Reply-To: <87f94c370801111351g132674fam295ba82a78f17842@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Kristin Vadas Marsicano <kristin.marsicano@gmail.com>, linux-ide@vger.kernel.org

> I was talking to Kristin this morning about doing that.  I was
> concerned that there is not anybody certifying that each individual
> disk drive model / firmware release is properly implementing the
> Security Erase function.
> 
> Are you aware of testing body, etc. that publishes a white-list of
> drives that are known to have a proper implementation of Security
> Erase?  Lacking something like that and realizing how rarely it is
> used, I'm not sure it should be trusted.

That would be a question to ask some of the security bodies - or possible
T13 (the standards people). Given there are only about 4 major drive
vendors left it sohuldn't take long to ask them however.

> Performing both a Security Erase and calling shred on the drive might
> be the ultimate one-two punch.

Can't do any harm - and in theory drives can reject (not ignore!)
security erase. Some mini ones seem to.

