From: Olof Johansson <olof@lixom.net>
Subject: [regression] 2.6.23 sata_mv EH updates broke my 7042 controller
Date: Mon, 1 Oct 2007 17:04:39 -0500
Message-ID: <20071001220439.GA15332@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757440AbXJAWAz@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

I just pulled out my Marvell 7042 SATA controller here to give it a spin
and noticed that it no longer worked (i.e. init segvs when loading from
it), etc. 2.6.22 is fine.

Bisecting (just the file drivers/ata/sata_mv.c) resulted in
bdd4dddee325a7dce3e84cf48201a06aa8508aa4 popping out as the culprit
(file version 4537deb5e90b717a725b3d74b58b4bb1d28443d0 is fine).

Just for sanity checking: Has anyone else used 7042/6042 with the current
mainline driver?

Hardware config in my case:
Highpoint 2310 controller
PPC (big endian)
WD Raptor disk

Works fine with the other controller I've been using (SIL24), and works
fine if I revert the driver.

It also works fine if I disable the IOMMU. This would point towards
either a stale dma mapping, or a missing setup of one.

Not being much at home in the SATA drivers I could keep digging but I
figured I'd bring it up first in case it rings a bell for someone.


-Olof
