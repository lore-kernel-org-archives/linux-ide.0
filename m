From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Bugme-new] [Bug 14518] New: I/O appears to get stuck on
 certain rsync backup job and system clock halts then
Date: Sat, 31 Oct 2009 11:48:04 +0000
Message-ID: <20091031114804.75ca5835@lxorguk.ukuu.org.uk>
References: <bug-14518-10286@http.bugzilla.kernel.org/>
	<20091031001711.0d3a8238.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36060 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757573AbZJaLqb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Oct 2009 07:46:31 -0400
In-Reply-To: <20091031001711.0d3a8238.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Martin@Lichtvoll.de, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>

> Yup, it looks more like an ata issue.

I see no ATA issue here


> > 25/00:08:5d:bf:8f/00:01:13:00:00/e0 tag 0 dma 135168 in
> > Oct 15 09:45:16 shambhala kernel:         res
> > ff/ff:ff:ff:ff:ff/ff:ff:ff:ff:ff/ff Emask 0x2 (HSM violation)
> > Oct 15 09:45:16 shambhala kernel: ata3.00: status: { Busy }
> > Oct 15 09:45:16 shambhala kernel: ata3.00: error: { ICRC UNC IDNF ABRT }

Looks like the drive fell off the bus entirely

> > I let the backup continue and it finished after a long time. libata reduced DMA
> > speeds several times during that backup sessions. I have never seen this before
> > when working with eSATA disks. Complete log available on request.

Desperately trying to get the drive to work reliably.

> > the machine suddenly reacted again. Later I found out that the time got stuck.
> > The clock was going several hours to late.

If the clock gets stuck for some reason then the block layer and ATA
timeouts are not going to work so the clock is probably the root cause.
Clock stopped sounds like an IRQ jam, and given removing the card fixed
it then possibly the drive jammed the IRQ on.

> > This brought some more UDMA CRC errors into the SMART LOG of my 500 GB eSATA
> > drive. Good that this is only an old age attribute. Anyway, both drives are

CRC errors are just logs of messages failing to get across uncorrupted -
its a sign of bad cables/power/adapters/ using SATA devices with eSATA
and not eSATA devices and the like. It's not really a sign of drive
problems.

I would say you had two problems

#1 Your eSATA cabling/power is flaky
#2 the Cardbus Sil3512 controller somehow got stuck asserting an
interrupt that wasn't cleared.

Needs the Sil3512 person to look at it. Even with flaky cabling it should
have either recovered cleanly or dropped the device.
