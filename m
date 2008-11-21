From: Tejun Heo <tj@kernel.org>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Fri, 21 Nov 2008 13:42:15 +0900
Message-ID: <49263C27.9030505@kernel.org>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk> <18725.17831.755158.999770@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37463 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695AbYKUEmE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Nov 2008 23:42:04 -0500
In-Reply-To: <18725.17831.755158.999770@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Peter Favrholdt <linux-ide@how.dk>, linux-ide@vger.kernel.org

Hello, Mikael.

Mikael Pettersson wrote:
> Tejun, what's the functional difference between the original
> sata reset method and the one you changed it to?

It means that the controller is having trouble updating the TF
registers from the first D2H Reg FIS after hardreset and thus requires
a follow-up SRST to get the device signature and initial DRDY status
right.  This is actually quite common among SATA controllers.  Some
ahci's and sata_sil24 can't do it either.  sata_sil is one of the best
behaving ones in this regard.  It looks like sata_promise needs
follow-up SRST after all.  I'll put the header and send this patch to
Jeff.

>  > [  649.991712] ata1: hard resetting link
>  > [  650.500230] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>  > [  650.641824] ata1.00: configured for UDMA/133
>  > [  650.642194] ata1: limiting SATA link speed to 1.5 Gbps
>  > [  650.642200] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
>  > [  650.642202] ata1: hotplug_status 0x80
>  > [  650.642252] ata1: hard resetting link
>  > [  651.550344] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
>  > [  651.700416] ata1.00: configured for UDMA/133
>  > [  651.700678] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9 t3
>  > [  651.700681] ata1: hotplug_status 0x80
> 
> These hotplug_status things worry me. Hard resets trigger
> hotplug events, but all recent kernels should disable them
> in ->freeze. This used to be the case.
> 
> Either libata isn't freezing the port before the reset,
> or ->freeze isn't marking the port properly causing the
> interrupt handler to interpret (silent) hotplug status bits
> when it shouldn't, or (horrors) ->freeze isn't working any more.

libata definitely is calling ->freeze but some controllers seem to
ignore IRQ masking during hardreset.  Maybe promise falls in this
category too?  For those controllers, irq handler should be ready for
spurious interrupts during reset.  If anything needs to be done
differently, it can use ATA_PFLAG_RESETTING to tell whether reset is
in progress (see ahci.c for example).

> Stray hotplug events prolong EH handling sequences and can even
> cause port disabling due to EH failures.

libata EH should be smart enough to handle this if the PHY event
happens during reset and scheduled reset.  EH will clear those actions
on successful completion of reset but before verifying the connected
devices (spurious events are ignored w/o losing actual device
presence).

Thanks.

-- 
tejun
