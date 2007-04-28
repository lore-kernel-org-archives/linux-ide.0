From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 21:30:26 +0100
Message-ID: <20070428213026.51855392@the-village.bc.nu>
References: <4633AB75.7070107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45385 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750962AbXD1U0x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2007 16:26:53 -0400
In-Reply-To: <4633AB75.7070107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> In the IDE driver, we had code to try and cope with stuck DRQ,
> by just looping and reading from the data port a few times.
> That could have been done better, but it worked a lot of the time,
> back in those simpler days.

It works very well. The current "old" IDE has some changes in the area
but those are basically to handle one or two controllers whose internal
state machine flushes the data queue so we don't hang the box solid
trying to flush it ourselves.

