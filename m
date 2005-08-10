From: linux@horizon.com
Subject: Re: NCQ support NVidia NForce4 (CK804) SATAII
Date: 10 Aug 2005 15:17:03 -0400
Message-ID: <20050810191703.4647.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:6188 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030191AbVHJTRP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Aug 2005 15:17:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: iogl64nx@gmail.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

To save Jeff the trouble of replying....

> If NVidia followed the SATA-IO spec than should be possible to make them 
> work with NCQ, or do I think wrong of that?
> Or isn't it possible?

The SATA spec defines the interface between the SATA controller and the
hard drive.  It does not define in any way the interface between
the host processor and the SATA controller.  There is no mention of
controller registers and what the bits in them mean.

Given that a good controller involves not only the registers themselves,
but also a number of data structures pointed to by those registers,
there's quite a bit of complexity there.

Jeff has, quite sensibly, decided to focus his efforts on hardware whose
manufacturers haven't made special effort to keep useful documentation
away from him.  (By declaring them "trade secrets" and threatening to
punish any employees who might othrwise send him a copy.)

> I found a Product Brief/Specification and a Blockdiagramm.

That sort of thing is quite devoid of programming detail.  It's like
trying to navigate the New Jersey Turnpike using an early Dutch map of
New Amsterdam.

In fact, it was probably created before the programming interface was
even designed.  Somebody said "we want these features", drew up the spec,
and handed that wishlist to the silicon hackers to fill in the details
and implement.

> Could it be possible to make reverse engeneering?

Yes, but it's far more time-consuming.  In particular, early silicon
always has bugs, and finding the bugs and developing workarounds
is a PITA when you have the specs; without them, it can be a nightmare.

Jeff has plenty to do without making his life more difficult.
Reverse-engineering NVIDIA is at the bottom of the list.  He
may never get to it in person.

Of course, if you'd like to make an attempt...
