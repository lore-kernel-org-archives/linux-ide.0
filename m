From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ata_piix and combined mode
Date: Mon, 22 Mar 2004 13:15:40 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <405F2D4C.9010506@pobox.com>
References: <20040322132336.GA12460@cistron.nl> <405F2B2E.6080001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44261 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262165AbUCVSPx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Mar 2004 13:15:53 -0500
In-Reply-To: <405F2B2E.6080001@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Jeff Garzik wrote:
>     c) hardware pretends that SATA0/1 are master/slave.
>     This last introduces nastiness into most drivers, since sata
>     is _really_ point-to-point.  Faking non-PTP this way leads
>     to a disconnect, because you must now map master to
>     port 0 or 1, and slave to the other port (yes ordering
>     is dynamic too).

Just to be more clear, the assignment (routing) of PATA and SATA ports 
on the ICH5 too dynamic for its own good.  You must deal with

* PATA and SATA on separate PCI devices (as it should be)
* PATA and SATA on the same PCI device, where
	c0 == pata0 master (master), pata1 master (slave)
	c1 == sata0 (master), sata1 (master)
     or
	c0 == pata0 master (master), pata1 master (slave)
	c1 == sata1 (master), sata0 (master)

the ICH6 follows the horror of combined mode, where c0 or c1 might be 
sata ports 0/2 or 1/3 (it has 4 sata ports rather than ICH5's 2).  and 
PATA might be c0 or c1.

(c0 == ata channel zero, c1 == ata channel one)

Sigh.

Although not with libata, with other drivers I belive that combined mode 
is fundamentally flawed.  Pretending a SATA device is a PATA device 
eliminates SATA-specific knowledge, such as avoiding soft-reset (SRST) 
on certain SATA devices, since they will lock up on probe.

I always recommend that users avoid combined mode when their 
configuration permits.

	Jeff



