From: linux@horizon.com
Subject: Best PCI-X SATA controller?
Date: 22 Aug 2004 21:42:44 -0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040822214244.11863.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:46134 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S266214AbUHVVmt
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Aug 2004 17:42:49 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux@horizon.com

I'm setting up a new file server, and trying to get a reasonably
future-proof system without getting too spendy.

I'm willing to buy hardware that has capabilities that the software
can't curerntly support as long as I can expect that the support
will appear in the forseeable future.

It looks like SATA drives have basically achieved price parity,
and I'm setting up a mirrored RAID system, so getting SATA for
hot-swap is very attractive.

On the list of features I'd like to explot, native command queuing
(NCQ) is very attractive, as it should help multithreaded loads a great
deal.  Fortuitously, some of Seagate's SATA drives, which I already like
because of the longer warranty, support NCQ.

(For the Seagate 7200.7 series, the ST3160827AS and ST3200822AS, and
in general the ST3xxx8xxAS drives, support NCQ.  The ST3xxx0xxAS drives
do not.)

So, now I need an SATA controller that supports NCQ.  My chosen (Opteron)
motherboard has PCI-X, and a number of PCI-X SATA controllers are showing
up.  But which ones can do NCQ and have good Linux support?

Intel's 4-port PCI-X 31244 controller is the only one with openly
published specifications, and I'm willing to pay extra to support that.
But I can't find it on an add-in card anywhere.  Does it exist in that
form?  The SRCS16 looks like something entirely different that does
not do full PCI-X nor does it support AHCI.

Are there any other AHCI controllers floating around?

The Marvell 88SX60xx chips support NCQ, and their 88SX50xx chips (which
do not) are the basis of a number of cheap 8-port PCI-X SATa controllers,
such as trhe RocketRAID 1820A.  But I can't find a card that has the
88SX60xx on board.  (Confusingly, Promise brags about "Command Queueing
(CQ) support", but that's PATA-style TCQ, not NCQ, even on the 1820A.)

They aren't publishing specs, but apparently are being helpful on the
driver development front.

The Promise SATAII150 SX8 card is another possibility, a cheap PCI-X
8-port SATA controller, but I can't find it for sale anywhere!
I also can't find published specs, but they appear to be helping jgarzik...


Any suggestions?  Thanks!
