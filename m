From: linux@horizon.com
Subject: Re: Who is working on the Marvell SATA Chipset?
Date: 18 Oct 2004 05:06:57 -0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041018050657.27810.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([192.35.100.1]:63032 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S265477AbUJRFG6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Oct 2004 01:06:58 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> I would love to be buying the 8 port pci-x marvells for nas boxes where 
> we're doing JBOD or software raid.

Me too, but I'm really trying to get hardware with NCQ support.  Some of
the Seagate 7200.7 series (the ST3xxx8xxAS drives, to be precise; look
for the 8 in the part number) support NCQ, are reasonably priced, and
have 5-year warranties.  So that part's easy.

My problem is finding an *88SX6040*-based adapter card.
All the ones I can find (the SuperMicro DAC-SATA-MV8 and the
Highpoint RocketRaid 1820A) are non-NCQ 88SX5040 designs.

Even if the software support isn't there now, it's nice to buy
future-proof hardware, and NCQ should help a file or database server
a lot.

So at the moment I'm waiting for the Promise SATAII150 SX8 to come
available, but I'm open to other suggestions.

(Note that the Marvell binary driver poperly designed as a Marvell-
supplied chipset access library and and source-supplied device driver
wrapper.  So it shouldn't be too brittle in the face of kernel changes.)

Anyway, does anyone have any suggestions for a PCI-X 8-port SATA controller
with NCQ support?

Thanks!
