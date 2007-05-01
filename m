From: Craig Metz <cmetz@inner.net>
Subject: Re: Problems with Linux SATA driver and ARC-770 IDE Bridge chip
Date: Tue, 01 May 2007 10:27:06 -0400
Message-ID: <20070501142706.31A38582C@rmail.inner.net>
References: <5760903.1177441381244.JavaMail.root@wombat.diezmil.com> <4636D7CE.9070702@gmail.com> <4637379F.7070805@rtr.ca>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rmail.inner.net ([199.33.248.12]:4133 "EHLO rmail.inner.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423568AbXEAOPw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 10:15:52 -0400
In-reply-to: <4637379F.7070805@rtr.ca> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, sjackerman@comcast.net, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, albertcc@tw.ibm.com

In message <4637379F.7070805@rtr.ca>, you write:
>It would be useful to see the full tf on those errors.
>My experience with PATA drives and CF cards, it that they
>default to PIO4 (assuming they report supporting PIO4).
>So we don't actually need to do a set xfer mode on them.
>
>Is the full IDENTIFY data available (hex, please)?
>Perhaps we can recognize this beast and just handle it
>differently when detected.
>
>Is it the CF card, or the CF adaptor, that's the problem?
>
>Many questions, not many answers (yet).

  The CF card I'm using is a modern SanDisk, which supports up to MDMA2. I'd
like to be able to use their new Extreme IV, which supports up to UDMA6. The
flash parts themselves are now getting fast enough that DMA really makes a
difference vs. PIO.

  The same card in a CF<->PATA adapter chained to a PATA<->SATA adapter based
on a different bridge chip works fine. So I don't think it's the card, or the
CF technology inherently. My personal estimation is that the ACard bridge
chip is buggy and in need of a work-around.

  What do I need to run in order to extract the full IDENTIFY data for you?
Keep in mind that I can't get a kernel booted that will fully see this device.
(i.e., no SCSI disk is ever allocated)

  Thanks,

									-Craig
