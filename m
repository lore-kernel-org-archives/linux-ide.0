From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Thu, 20 Nov 2008 12:10:31 +0100
Message-ID: <18725.17831.755158.999770@harpo.it.uu.se>
References: <491C9A4F.1020801@tlinx.org>
	<491FB7E2.2030105@kernel.org>
	<18719.65298.689618.835202@harpo.it.uu.se>
	<492059B1.4030708@how.dk>
	<49205AD7.3080009@how.dk>
	<4920D093.2030508@kernel.org>
	<492159E0.1050804@how.dk>
	<4922165E.9070203@kernel.org>
	<49230361.2010001@how.dk>
	<492371F4.7020400@kernel.org>
	<49253A6D.1040202@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:38663 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753993AbYKTLKo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Nov 2008 06:10:44 -0500
In-Reply-To: <49253A6D.1040202@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

Peter Favrholdt writes:
 > Hi Tejun and list,
 > 
 > Tejun Heo wrote:
 > > COMRESETs are failing with EBUSY while ata_sff_check_ready() is
 > > returning ENODEV.  Hmmm... Does the attached patch change anything?
 > 
 > patching file drivers/ata/sata_promise.c
 > Hunk #1 succeeded at 707 (offset -2 lines).
 > 
 > Yes, it actually helped. Tested it twice and both times the following 
 > happened:
 > 
 > 1. started the dd's from all four drives
 > 
 > 2. /dev/sda fails after a while as usual
 > 
 > 3. two hardresets happen on sda - the second limits the link to 1.5Gbps
 > 
 > 4. dd continues without hickups (and when completed normally I started 
 > yet another dd test which ran to completion without any errors).
 > 
 > So at first error the hardreset kicks in and saves the day (and 
 > downgrades to 1.5Gbps which prevents the problem from happening in my 
 > setup).
 > 
 > Thanks a lot!

Interesting.

Tejun, what's the functional difference between the original
sata reset method and the one you changed it to?

 > [  649.991712] ata1: hard resetting link
 > [  650.500230] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
 > [  650.641824] ata1.00: configured for UDMA/133
 > [  650.642194] ata1: limiting SATA link speed to 1.5 Gbps
 > [  650.642200] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
 > [  650.642202] ata1: hotplug_status 0x80
 > [  650.642252] ata1: hard resetting link
 > [  651.550344] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
 > [  651.700416] ata1.00: configured for UDMA/133
 > [  651.700678] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t3
 > [  651.700681] ata1: hotplug_status 0x80

These hotplug_status things worry me. Hard resets trigger
hotplug events, but all recent kernels should disable them
in ->freeze. This used to be the case.

Either libata isn't freezing the port before the reset,
or ->freeze isn't marking the port properly causing the
interrupt handler to interpret (silent) hotplug status bits
when it shouldn't, or (horrors) ->freeze isn't working any more.

Stray hotplug events prolong EH handling sequences and can
even cause port disabling due to EH failures.

/Mikael
