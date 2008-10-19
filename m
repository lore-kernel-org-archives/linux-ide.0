From: Mark Lord <liml@rtr.ca>
Subject: Re: A USB enclosure that supports SCSI-ATA-Passthru (cheap!)
Date: Sun, 19 Oct 2008 12:38:05 -0400
Message-ID: <48FB626D.4070205@rtr.ca>
References: <48FB60CC.5000008@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:37928 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbYJSQhe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Oct 2008 12:37:34 -0400
In-Reply-To: <48FB60CC.5000008@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Bruce Allen <ballen@gravity.phys.uwm.edu>

Mark Lord wrote:
> I believe this is of possible interest to others here:
> 
> Most newer USB enclosures now support SCSI STOP/START commands.
> 
> But.. the Western Digital 2.5" mobile USB2 enclosures (SATA inside)
> appear to also support the SCSI-ATA-Command-Passthru protocol.
> These are the first ones I have seen here that do this.
> 
> So, things like "hdparm -I /dev/sdb" work without fuss on an
> external USB drive when used with these enclosures.
> As does setting automatic spin-down with "hdparm -S".
..
> Model:  WD-250XMS-00 (with 250GB drive inside, removeable).
> USB info:  1058:0702 Western Digital Technologies, Inc.
> Bridge chip by InitIO:  INIC-1606L
..

Mmm.. I also have two NexStar-3 2.5" USB/eSata enclosures here,
but they are not identical on the inside.

The one with an InitIO INIC-1610L chip does *not* support SAT,
but the second one with an InitIO INIC-1611L chip *does* work with SAT!

Good to see these chips getting out there now,
as it allows external storage to be spun-down much
of the time when only rarely needed -- keeps the drives
from cooking the rest of the time.

Cheers
