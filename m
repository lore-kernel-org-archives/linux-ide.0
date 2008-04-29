From: Mark Lord <liml@rtr.ca>
Subject: Re: ata_std_qc_defer not good enough for FIS-based switching ?
Date: Tue, 29 Apr 2008 13:17:06 -0400
Message-ID: <48175812.7000106@rtr.ca>
References: <48163C5D.9050605@rtr.ca> <48164AE8.4070106@rtr.ca> <481659B5.7090703@gmail.com> <48175664.5030702@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3798 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbYD2RRH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 13:17:07 -0400
In-Reply-To: <48175664.5030702@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
..
> For the first time ever, I can now *heavily* mix PIO commands
> with NCQ/non-NCQ DMA commands, to drives on an attached PM
> (well, two attached PMs even), and the thing doesn't croak.
> Woo-hoo!
..

Here is the simple torture test I'm using for this.
It might be fun for others to try something similar on the other LLDs
which have PMP support:

1. QuadCore CPU, with 4GB of RAM (lots of simultaneous threads).

2. In one window, do this (lots of overlapping PIO commands):
    while ( true ) ; do for d in /dev/sd? ; do bash -c "hdparm -C $d &" ; done  ;  sleep 0.1 ; done

3. In a second window, do this (lots of overlapping DMA/NCQ reads):
    while (true) ; do  for d in /dev/sd? ; do bash -c "hdparm -t $d &" ; done ; sleep 6 ; done

Or something like that.

Cheers
