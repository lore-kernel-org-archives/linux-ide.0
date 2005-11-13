From: linux@horizon.com
Subject: Re: sata_sil24 corruption details
Date: 13 Nov 2005 01:11:42 -0500
Message-ID: <20051113061142.19627.qmail@science.horizon.com>
References: <20051111021616.28929.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:35889 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750997AbVKMGLz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Nov 2005 01:11:55 -0500
In-Reply-To: <20051111021616.28929.qmail@science.horizon.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com, linux@horizon.com

> There will now follow a period of drive, cable, and controller swapping
> while I figure out WTF is going on here.

In case anyone's following this saga...
The motherboard has 6 slots, starting from the CPU:

PCIe x1		(/dev/sde and /dev/sdf)
PCIe x16
PCIe x1		(/dev/sda and /dev/sdb)
PCIe x1		(/dev/sdc and /dev/sdd)	<=== THE CULPRIT
PCI
PCI

I've tried all three controller cards in the "culprit" slot, and
all read data from the disk unreliably.

Interestingly, I can still *write* data to the disk reliably.  I copied
350 GB to /dev/sdc4, swapped it to the sdf slot, and verified it was all
correct.  Then I swapped the sde+sdf controller card (and the attached
cables and drives) into the sdc+sdd slot and got tons of verify errors.

So right now, I'm blaming the motherboard.  (Albatron K8NF4U, if anyone cares)

The fact it's the slot furthest from the bridge seems suggestive, but
PCIe is packetized with link-level CRCs and retransmission, so
transmission problems shouldn't be capable of causing corruption.
Might I have a bad bridge chip?

I'm currently reading the PCIe spec looking for link error logging
registers.


This isn't hugely IDE software related, but I figured it was worth
sharing some progress, as I've been talking about it rather a lot.
