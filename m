From: Tejun Heo <tj@kernel.org>
Subject: Re: libata bridge limits
Date: Tue, 26 Aug 2008 14:45:29 +0200
Message-ID: <48B3FAE9.3040505@kernel.org>
References: <20080826072841.GS20055@kernel.dk>	<20080826104237.4b1cd7f6@lxorguk.ukuu.org.uk>	<20080826101713.GW20055@kernel.dk>	<48B3DE5B.1020607@kernel.org>	<20080826113800.4a212f53@lxorguk.ukuu.org.uk>	<48B3E7B8.5060307@kernel.org> <20080826132547.10955c01@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59545 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577AbYHZMtL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Aug 2008 08:49:11 -0400
In-Reply-To: <20080826132547.10955c01@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <jens.axboe@oracle.com>, jeff@garzik.org, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Kay Sievers <kay.sievers@vrfy.org>, Gwendal Grignou <gwendal@google.com>

Alan Cox wrote:
>>> Now we should probably have a shorter timeout where we then check the
>>> status bits for BUSY so we can quickly catch lost interrupts or commands
>>> but that is quite different.
>> Yeah, we need to check for lost interrupts and dead IRQ due to screaming
>> IRQ.  Maybe we can do some of that in interrupt core.
> 
> For SFF at least we can read altstatus and check for BUSY. If BUSY is not
> set then something is up, either we have an error we didn't get an IRQ
> for or the status is successful.
> 
>> The few I was talking about just freezes the whole machine after a
>> timeout.  Dunno whether the lowlevel driver needs to do EH differently
>> or the controller is just built that way tho.
> 
> Some lock the box solid if you don't reset the controller before you
> touch any registers on a timeout. I thought we had them all covered - do
> you know which controllers are still showing this ?

IIRC some very early via SATAs lock up the machine solid no matter what
you do unless a command is completed by the device side.  Maybe it
requires special sequence to abort in-flight commands but simple SRST
wasn't enough.  :-(

-- 
tejun
