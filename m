From: Mikael Pettersson <mikpelinux@gmail.com>
Subject: Re: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
Date: Sun, 16 Feb 2014 17:48:03 +0100
Message-ID: <21248.60355.895333.625080@gargle.gargle.HOWL>
References: <21248.39509.418884.931848@gargle.gargle.HOWL>
	<20140216143735.GA8680@localhost>
	<21248.54474.414445.790516@gargle.gargle.HOWL>
	<20140216152802.GA3637@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:53434 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbaBPQsI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Feb 2014 11:48:08 -0500
Received: by mail-la0-f43.google.com with SMTP id pv20so10779880lab.30
        for <linux-ide@vger.kernel.org>; Sun, 16 Feb 2014 08:48:07 -0800 (PST)
In-Reply-To: <20140216152802.GA3637@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Mikael Pettersson <mikpelinux@gmail.com>, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org

Ezequiel Garcia writes:
 > On Sun, Feb 16, 2014 at 04:10:02PM +0100, Mikael Pettersson wrote:
 > > Ezequiel Garcia writes:
 > >  > Hi Mikael,
 > >  > 
 > >  > On Sun, Feb 16, 2014 at 12:00:37PM +0100, Mikael Pettersson wrote:
 > >  > > My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-rc2
 > >  > > boot always fails due to a kernel NULL dereference in __clk_put.
 > >  > > 
 > >  > > This is a non-DT kernel, with:
 > >  > > 
 > >  > > CONFIG_ARCH_KIRKWOOD=y
 > >  > > CONFIG_KIRKWOOD_LEGACY=y
 > >  > > CONFIG_MACH_TS219=y
 > >  > > # CONFIG_ARCH_KIRKWOOD_DT is not set
 > >  > > 
 > >  > 
 > >  > Thanks for the report. I thought this issue was already fixed, but I
 > >  > cannot find it on either the mailing lists or linux-next.
 > >  > 
 > >  > So, in case it hasn't been fixed here's an untested fix for you to test.
 > >  > Please try this patch and let us know.
 > >  > 
 > >  > Your SATA won't work but if the patch is OK the kernel wont't blow away.
 > > 
 > > Thanks, this fixes the oops but does leave sata_mv non-functional,
 > > which is still a major regression from 3.13.
 > > 
 > 
 > Please, try linux-next to get the most recent fixes and make sure you have
 > CONFIG_PHY_MVEBU_SATA enabled.

If I backport

"drivers: phy: Make NULL a valid phy reference" (04c2facad8fee66c981a51852806d8923336f362)
"drivers: phy: Add support for optional phys" (788a4d56ff378bff0b8e685d03a962b36903a149)
"ata: sata_mv: Fix probe failures with optional phys" (90aa2997029fa623fe9e3ec3a469a00a34130237)

from linux-next, and fix up your sata_mv cleanup fixes for a context reject in
hunk #2, and enable CONFIG_OF and CONFIG_GENERIC_PHY, then I get a 3.14-rc2-ish
kernel that boots and mounts its root fileystem.

Still,

@@ -123,6 +124,8 @@
 loop: module loaded
 sata_mv sata_mv.0: version 1.28
 sata_mv sata_mv.0: cannot get optional clkdev
+sata_mv sata_mv.0: unable to find phy
+sata_mv sata_mv.0: unable to find phy
 sata_mv sata_mv.0: slots 32 ports 2
 scsi0 : sata_mv
 scsi1 : sata_mv

tells me that the PHY dependency is artificial.

I hope this all can be resolved in a clean way before 3.14 final.

/Mikael
