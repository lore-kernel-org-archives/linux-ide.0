From: Tejun Heo <tj@kernel.org>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 13:23:36 +0200
Message-ID: <48B3E7B8.5060307@kernel.org>
References: <20080826072841.GS20055@kernel.dk>	<20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>	<20080826101713.GW20055@kernel.dk>	<48B3DE5B.1020607@kernel.org> <20080826113800.4a212f53@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49673 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbYHZL0y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 07:26:54 -0400
In-Reply-To: <20080826113800.4a212f53@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <jens.axboe@oracle.com>, jeff@garzik.org, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Kay Sievers <kay.sievers@vrfy.org>, Gwendal Grignou <gwendal@google.com>

Alan Cox wrote:
>> * The current IO timeouts are too long.  It's not like reducing this is
>> difficult.  The only reason why we haven't reduced it yet is because we
> 
> They are too short.
> 
>> haven't been able to agree on what's the proper timeout value.
>> According to Mark, 8 secs should be fine (Windows uses it) for
>> read/writes but there seem to be some corner cases.
> 
> The worst case I've seen on bad blocks is up over sixty seconds and as a
> result of our underlength timeouts we get continuous retries and mode
> changedowns in response to this not a proper error and raid failover. The
> worst case on cache flush is even longer!

We probably needs to extend timeout for flush or at least when retrying
flushes.  As for reads and writes, I really think we should move more
towards shorter timeout as timeouts are not too rare in SATA at least
(and undistinguishible using BSY or other methods).  Those long delays
are very rare and maybe having control knobs is the best way to deal
with them.

> We have the same problem with CD devices.
> 
> Now we should probably have a shorter timeout where we then check the
> status bits for BUSY so we can quickly catch lost interrupts or commands
> but that is quite different.

Yeah, we need to check for lost interrupts and dead IRQ due to screaming
IRQ.  Maybe we can do some of that in interrupt core.

>> * Some rare controllers fail miserably after a timeout but this is
>> pretty rare and getting rarer.  I don't think we need to consider this
>> the main deciding factor.
> 
> Several require resets, the driver should be doing this work. Again the
> poll on timeout to check if we just lost the IRQ would improve this also
> but is only done by old IDE right now.

The few I was talking about just freezes the whole machine after a
timeout.  Dunno whether the lowlevel driver needs to do EH differently
or the controller is just built that way tho.

>> * Currently, the transfer speed setting reached by EH actions is not
>> persistent.  On the next boot, the device would have to go through the
>> same thing all over again, which isn't too pleasant.  It would be great
>> if we can make this setting persistent.  Maybe this can be done libata
>> sysfs and udev?
> 
> How ? you've no idea what device combination will appear next boot ?

udev and hal know a lot about the system configuration including
connection topology and many ways to id each device.  Saving limit
configuration using combination of topology and device ID should be
pretty safe.  I think more difficult problem is how to notify the user
that such persistent auto-configuration happened and provide a
convenient way to undo.

Thanks.

-- 
tejun
