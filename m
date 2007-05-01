From: Mark Lord <liml@rtr.ca>
Subject: Re: Problems with Linux SATA driver and ARC-770 IDE Bridge chip
Date: Tue, 01 May 2007 08:50:39 -0400
Message-ID: <4637379F.7070805@rtr.ca>
References: <5760903.1177441381244.JavaMail.root@wombat.diezmil.com> <4636D7CE.9070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4951 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030761AbXEAMun (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 May 2007 08:50:43 -0400
In-Reply-To: <4636D7CE.9070702@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: sjackerman@comcast.net, linux-ide@vger.kernel.org, cmetz@inner.net, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, albertcc@tw.ibm.com

Tejun Heo wrote:
> [cc'ing ATA gurus]
> Hello, again.
> 
> Okay, there are two different problems here, so I was confused a bit,
> but now I see what's going on.
> 
> sjackerman@comcast.net wrote:
>> ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10
>> scsi2 : ata_piix
>> ata1.00: CFA, max PIO4, 8005536 sectors: LBA
>> ata1.00: ata1: dev 0 multi count 0
>> ata1.00: qc timeout (cmd 0xef)
>> ata1.00: failed to set xfermode (err_mask=0x4)
..
> Jeff, Alan, Mark and Albert, do you have ideas how we should support
> this one?  This thing locks up if nIEN is set in command FIS.

It would be useful to see the full tf on those errors.
My experience with PATA drives and CF cards, it that they
default to PIO4 (assuming they report supporting PIO4).
So we don't actually need to do a set xfer mode on them.

Is the full IDENTIFY data available (hex, please)?
Perhaps we can recognize this beast and just handle it
differently when detected.

Is it the CF card, or the CF adaptor, that's the problem?

Many questions, not many answers (yet).
