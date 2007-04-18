From: Mark Lord <liml@rtr.ca>
Subject: Re: libata/SATA noprobe
Date: Wed, 18 Apr 2007 12:23:18 -0400
Message-ID: <462645F6.50702@rtr.ca>
References: <6.1.1.1.2.20070418164107.02c87a30@192.168.6.12>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1188 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130AbXDRQXS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Apr 2007 12:23:18 -0400
In-Reply-To: <6.1.1.1.2.20070418164107.02c87a30@192.168.6.12>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roger While <simrw@sim-basis.de>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>

Roger While wrote:
> Is there any knob/option to prevent libata
> probing non-existent channels ?
> Specifically how can I stop the kernel probing
> the second SATA? -
..
> <6>ata1.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth 0/1)
> <6>ata1.00: ata1: dev 0 multi count 8
> <6>ata1.00: configured for UDMA/133
> <6>scsi1 : ata_piix
> <4>ata2: port is slow to respond, please be patient (Status 0xff)
> <3>ata2: port failed to respond (30 secs, Status 0xff)
> <3>ata2: SRST failed (status 0xFF)
> <3>ata2: SRST failed (err_mask=0x100)
> <4>ata2: softreset failed, retrying in 5 secs
> <3>ata2: SRST failed (status 0xFF)
> <3>ata2: SRST failed (err_mask=0x100)
> <4>ata2: softreset failed, retrying in 5 secs
> <3>ata2: SRST failed (status 0xFF)
> <3>ata2: SRST failed (err_mask=0x100)
> <3>ata2: reset failed, giving up
..

Ugh.  That could really slow down system startup.

There is no parameter to avoid it,
just one to reduce the delay while it probes.  Not ideal.

But it really could be more clever here, and notice the 0xff patterns,
and have an early exit if there's obviously nothing attached.

Or perhaps there's some register it could read to see if the
port was disabled in the BIOS (I'm betting it is still "enabled",
but it could be good to check if we don't already).

Maybe just do it in the ata_piix subdriver.  Tejun, Alan?

-ml
