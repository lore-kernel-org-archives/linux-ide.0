From: Jim Paris <jim@jtan.com>
Subject: Re: timeout errors on sata_sil24 with port multiplier & PCI-X
Date: Thu, 15 Mar 2007 15:36:13 -0400
Message-ID: <20070315193612.GA24099@jim.sh>
References: <20070309221628.GA12330@jim.sh> <20070309233151.GD14319@curie-int.orbis-terrarum.net> <20070309221628.GA12330@jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:45566 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932985AbXCOTg0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Mar 2007 15:36:26 -0400
Content-Disposition: inline
In-Reply-To: <20070309233151.GD14319@curie-int.orbis-terrarum.net> <20070309221628.GA12330@jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-ide@vger.kernel.org

I wrote:
> I have a SiI3124 PCI-X controller
..
> I have been using this configuration with a DS-1220 external
> enclosure + port multiplier:
..
> Occasionally, I get an error like this:
> 
> Mar  9 12:53:18 localhost kernel: ata8.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
> Mar  9 12:53:18 localhost kernel: ata8.00: tag 0 cmd 0x61 Emask 0x4 stat 0x40 err 0x0 (timeout)
> Mar  9 12:53:18 localhost kernel: ata8.15: hard resetting port

After moving the port multiplier from the PCI-X SiI3124 to a PCIe
SiI3132, the timeouts are gone.  No errors at all while moving 1T back
and forth and resyncing the RAID.  I wonder if it's a bad card
(Norco 4618, came with the enclosure) or a driver issue.


Robin H. Johnson wrote:
> Also, afaik there has been no resolution of the performance issue - while the
> controller shows 3Gb, the actual combined speeds I get are only at the 1.5Gb
> level.

I agree, on a single port combined speeds are right around 150MB/sec.
On two ports it hits 180MB/sec.  I guess that's approaching the PCIe x1
limit.

One interesting note is that the original SiI3124 controller always
reported the host->PMP link as 1.5Gb.  The SiI3132 reports it as
3.0Gb.

-jim
