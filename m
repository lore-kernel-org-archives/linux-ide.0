From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.31] sata_promise: update reset code
Date: Thu, 17 Sep 2009 16:50:44 -0400
Message-ID: <4AB2A124.8010509@pobox.com>
References: <19119.37343.976763.528719@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54689 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbZIQUuq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Sep 2009 16:50:46 -0400
In-Reply-To: <19119.37343.976763.528719@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Peter Favrholdt <linux-ide@how.dk>, linux-ide@vger.kernel.org

On 09/15/2009 09:08 AM, Mikael Pettersson wrote:
> sata_promise's reset code has deviated quite a bit from
> the Promise reference driver's, and it has been observed
> to fail to recover from errors in some cases.
>
> This patch thus updates the reset code to more closely
> match the reference driver:
>
> - soft reset (pdc_reset_port):
>    * wait for ATA engine to not be in packet command mode
>      (2nd gen only)
>    * write reset bit in PDC_CTLSTAT before the first read
>      in the loop
>    * for 2nd gen SATA follow up with FPDMA reset and clearing
>      error status registers
> - hard reset (pdc_sata_hardreset):
>    * wait for ATA engine to not be in packet command mode
>      (2nd gen only)
>    * reset ATA engine via the PCI control register
>    * Tejun's change to use non-waiting hardreset + follow-up SRST
>
> I'm not changing the hotplug mask bits since they are taken care
> of by sata_promise's ->freeze() and ->thaw() operations. And I'm
> not writing the PMP port # because that's always zero (for now).
>
> Tested here on various controllers. In particular, one disk
> which used to timeout and fail to recover from certain hdparm
> and smartmonctl commands now works nicely.
>
> Signed-off-by: Mikael Pettersson<mikpe@it.uu.se>
> ---
> I should have submitted this long ago, sorry.
> This update involves a lot of details, so it should probably sit
> in a testing tree for a while before going upstream.
>
>   drivers/ata/sata_promise.c |  121 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 120 insertions(+), 1 deletion(-)

applied -- I would rather push it to upstream and see what happens, 
given that waiting would probably mean less test exposure at this point 
[unless we wait a full release cycle]

	Jeff



