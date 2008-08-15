From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Driver for Promise PDC42819 SATA/SAS controller
Date: Fri, 15 Aug 2008 13:10:34 +0200
Message-ID: <18597.25642.934859.944853@harpo.it.uu.se>
References: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:47796 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbYHOLKp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Aug 2008 07:10:45 -0400
In-Reply-To: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Nelson <mdnelson8@gmail.com>
Cc: linux-ide@vger.kernel.org

Mark Nelson writes:
 > Hi All,
 > 
 > I recently bought an MSI K9A2 Platinum motherboard and it has a Promise
 > PDC42819 SATA/SAS controller onboard. I haven't been able to get the
 > controller to work with any of the libata sata drivers in mainline
 > (although I did only try sata_promise, sata_sx4 or ahci; last two I was
 > doubtful about but I figured it was worth a try).
 > 
 > Has anyone played with this controller under Linux before and can it be
 > made to work with any of the open source drivers - I would realy like
 > to use the eSATA and internal SATA ports attached to this controller
 > (and I don't want to trust my data to the promise binary blob)? Maybe
 > it's as simple as adding the right PCI ID to sata_promise, but I wasn't
 > sure what kind of board it should be: 2037x, 2057x, 20319, 40518, 20619,
 > or maybe some new one...
 > 
 > I'm not sure how important this is but I gathered the following info
 > about the controller:
 > 
 > References to the controller in the motherboard manual and the
 > motherboard manufacturer's website: Promise T3 [1]
 > 
 > Written on the actual chip on the motherboard: Promise PDC42819 [2]
 > 
 > This chip is also used on Promise's own FastTrak TX2650 & TX4650
 > adapters [3] which have "partial open source" drivers [4], [5]. This
 > driver looks like an open source wrapper around a binary blob (some
 > fasttrak library for software fake raid, I think).
 > 
 > Having a quick look through the source of Promise's driver, it looks
 > like the driver has been hacked up out of a driver that was originally
 > used for fakeraid on ATI and intel southbridges as well as Promise's
 > SX4 adapter (and some Promise adapter called the OCTOPUSII).
 > 
 > Promise has an open source commitment written on its werbsite [6] but
 > it just relates to their SuperTrak products (not their FastTrak ones)
 > and the stex driver.
 > 
 > The following is the hunk of lspci output that refers to the controller:
 > 
 > 02:00.0 RAID bus controller [0104]: Promise Technology, Inc. Unknown
 > device [105a:3f20]

This is pure speculation, but _if_ it is similar to the chips
driven by sata_promise then it should be close to the 40518 family
(all the other ones are older). So adding that PCI id as a
board_40518 in pdc_ata_pci_tbl[] just might do the trick.
