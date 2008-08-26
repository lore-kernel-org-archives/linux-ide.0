From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 11:38:00 +0100
Message-ID: <20080826113800.4a212f53@lxorguk.ukuu.org.uk>
References: <20080826072841.GS20055@kernel.dk>
	<20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>
	<20080826101713.GW20055@kernel.dk>
	<48B3DE5B.1020607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35478 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752937AbYHZK5F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2008 06:57:05 -0400
In-Reply-To: <48B3DE5B.1020607@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, jeff@garzik.org, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Kay Sievers <kay.sievers@vrfy.org>, Gwendal Grignou <gwendal@google.com>

> * The current IO timeouts are too long.  It's not like reducing this is
> difficult.  The only reason why we haven't reduced it yet is because we

They are too short.

> haven't been able to agree on what's the proper timeout value.
> According to Mark, 8 secs should be fine (Windows uses it) for
> read/writes but there seem to be some corner cases.

The worst case I've seen on bad blocks is up over sixty seconds and as a
result of our underlength timeouts we get continuous retries and mode
changedowns in response to this not a proper error and raid failover. The
worst case on cache flush is even longer!

We have the same problem with CD devices.

Now we should probably have a shorter timeout where we then check the
status bits for BUSY so we can quickly catch lost interrupts or commands
but that is quite different.

> * Some rare controllers fail miserably after a timeout but this is
> pretty rare and getting rarer.  I don't think we need to consider this
> the main deciding factor.

Several require resets, the driver should be doing this work. Again the
poll on timeout to check if we just lost the IRQ would improve this also
but is only done by old IDE right now.

> * Currently, the transfer speed setting reached by EH actions is not
> persistent.  On the next boot, the device would have to go through the
> same thing all over again, which isn't too pleasant.  It would be great
> if we can make this setting persistent.  Maybe this can be done libata
> sysfs and udev?

How ? you've no idea what device combination will appear next boot ?

Alan
