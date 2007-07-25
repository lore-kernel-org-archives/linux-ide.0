From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata problem or hard drive failure?
Date: Wed, 25 Jul 2007 20:22:03 +0100
Message-ID: <20070725202203.41d2092c@the-village.bc.nu>
References: <11718197.1185389096527.JavaMail.root@eastrmwml27.mgt.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49404 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S935476AbXGYTPI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jul 2007 15:15:08 -0400
In-Reply-To: <11718197.1185389096527.JavaMail.root@eastrmwml27.mgt.cox.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cyrix12@cox.net
Cc: linux-ide@vger.kernel.org

> ata2: port is slow to respond, please be patient (Status 0xff)
> ata2: device not ready (errno=-16), forcing hardreset
> ata2: SRST failed (errno=-19)
> ata2: reset failed (errno=-19), retrying in 10 secs

Basically "hello ?" "hello ?" , and no response

> According to smart the last time I had the drive available to the system, there is nothing wrong with the drive.  I ran bad block scans on the drive a couple days ago and come up with nothing.  It only stopped being detected today.  Prior to this, it would die at random with something like the following in my logs:
> 
> Jul 23 06:34:15 [kernel] ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> Jul 23 06:34:15 [kernel] ata4.00: (BMDMA stat 0x24)
> Jul 23 06:34:15 [kernel] ata4.00: cmd 25/00:08:9f:9a:6b/00:00:32:00:00/e0 tag 0 cdb 0x0 data 4096 in
> Jul 23 06:34:15 [kernel]          res 51/40:08:9f:9a:6b/40:00:32:00:00/e0 Emask 0x9 (media error)

Bad blocks and then fell off the bus by the look of the rest of the trace.

It was the drive which said media error not us so I would be very
suspicious of the drive as a starting point.

Alan
