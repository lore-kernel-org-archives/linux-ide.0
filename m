From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 2.6.31] sata_promise: update reset code
Date: Fri, 18 Sep 2009 03:05:03 +0200
Message-ID: <19122.56511.241470.984707@pilspetsen.it.uu.se>
References: <19119.37343.976763.528719@pilspetsen.it.uu.se>
	<4AB2A124.8010509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fanny.its.uu.se ([130.238.4.241]:41600 "EHLO fanny.its.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232AbZIRBFJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 21:05:09 -0400
In-Reply-To: <4AB2A124.8010509@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Peter Favrholdt <linux-ide@how.dk>, linux-ide@vger.kernel.org

Jeff Garzik writes:
 > On 09/15/2009 09:08 AM, Mikael Pettersson wrote:
 > > sata_promise's reset code has deviated quite a bit from
 > > the Promise reference driver's, and it has been observed
 > > to fail to recover from errors in some cases.
 > >
 > > This patch thus updates the reset code to more closely
 > > match the reference driver:
 > >
 > > - soft reset (pdc_reset_port):
 > >    * wait for ATA engine to not be in packet command mode
 > >      (2nd gen only)
 > >    * write reset bit in PDC_CTLSTAT before the first read
 > >      in the loop
 > >    * for 2nd gen SATA follow up with FPDMA reset and clearing
 > >      error status registers
 > > - hard reset (pdc_sata_hardreset):
 > >    * wait for ATA engine to not be in packet command mode
 > >      (2nd gen only)
 > >    * reset ATA engine via the PCI control register
 > >    * Tejun's change to use non-waiting hardreset + follow-up SRST
 > >
 > > I'm not changing the hotplug mask bits since they are taken care
 > > of by sata_promise's ->freeze() and ->thaw() operations. And I'm
 > > not writing the PMP port # because that's always zero (for now).
 > >
 > > Tested here on various controllers. In particular, one disk
 > > which used to timeout and fail to recover from certain hdparm
 > > and smartmonctl commands now works nicely.
 > >
 > > Signed-off-by: Mikael Pettersson<mikpe@it.uu.se>
 > > ---
 > > I should have submitted this long ago, sorry.
 > > This update involves a lot of details, so it should probably sit
 > > in a testing tree for a while before going upstream.
 > >
 > >   drivers/ata/sata_promise.c |  121 ++++++++++++++++++++++++++++++++++++++++++++-
 > >   1 file changed, 120 insertions(+), 1 deletion(-)
 > 
 > applied -- I would rather push it to upstream and see what happens, 
 > given that waiting would probably mean less test exposure at this point 
 > [unless we wait a full release cycle]

Agreed, using 2.6.32-rc as the testing grounds for this makes sense.

/Mikael
