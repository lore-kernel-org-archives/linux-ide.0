From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH] ATA: pata_at91.c bugfixes
Date: Sun, 1 May 2011 23:17:16 +0200
Message-ID: <20110501211716.GA5217@localhost.localdomain>
References: <1303299877-12088-1-git-send-email-plyatov@gmail.com>
 <20110423093623.GA3410@localhost.localdomain>
 <4DB6684C.7050505@gmail.com>
 <20110427183819.GA2285@localhost.localdomain>
 <4DBA9E2F.3070100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx4.wp.pl ([212.77.101.8]:23296 "EHLO mx4.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783Ab1EAVRD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 1 May 2011 17:17:03 -0400
Content-Disposition: inline
In-Reply-To: <4DBA9E2F.3070100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Igor Plyatov <plyatov@gmail.com>
Cc: linux-ide@vger.kernel.org

(Cc again linux-ide)

> >>This is not clear for me. Maybe we talk about different things or I
> >>have wrong
> >>understanding of ATA timings.
> >>Can you please look at "Standard Read Cycle" for AT91SAM9 MCU
> >>http://www.kicad.ru/files/AT91SAM9G20%20bus%20timing.pdf
> >>, CompactFlash connection schematic
> >>http://www.kicad.ru/files/CF%20for%20AT91SAM9%20(True%20IDE%20mode).pdf
> >>and comment my thoughts?
> >Full "External Bus Interface" section from AT91 spec is important,
> >because is describe how SMC works internally in CF True IDE mode.
> 
> You can look at it here:
> http://www.atmel.com/dyn/resources/prod_documents/doc6384.pdf
> 12 MB, Pages 159-200.

I know where AT91 documentation can be downloaded from.

> >>* The NCS signal is not the same as CS1, CS2 ATA signals! It used only to
> >>   enable data bus transceiver U2.
> >Well, they are different signals but connected together. All of these are
> >controlled by NCS: CFCE1 (CS1), CFCE2 (CS2), CFRNW (DIR), CFCS0 (OE)
> >if SMC is configured in True IDE mode.
> 
> I must repeat again - NCS ("CFCS1" from schematic) are completely
> different signal for different purpose, then A0, A1, A2, CS0, CS1.
> It used only to enable data bus transceiver U2.

So, how in your opinion CS0 and CS1 are controlled? IMO there
are delivered from CFCE1 and CFCE2, which itself are delivered
from NCS. Here is corresponding quote from atmel documentation
you cited above:

"The CFCE1 and CFCE2 waveforms are identical to the corresponding NCSx waveform"

> I think it is much better do not simply keep
> 
> cs_setup = 0;
> cs_pulse = cycle; /* cs_hold = 0 */
> 
> as you propose, but better to keep good balance and assume:
> 
> cs_setup = setup / 2;

Again. If you do this, real t1 time - ADDR "A02, A01, A00, -CS0, -CS1"
valid to "-IORD / -IOWR" edge, on ATA bus will be equal "setup / 2" not
"setup" as it should. Actually only time between -CS0, -CS1 and
-IORD/-IOWR will not be correct, address lines are established at the
beginning of SMC cycle, as you pointed.
 
> This is because at high master clock frequency, "cs_pulse" value
> physically can not be as large as "cycle" (SMC HW limitations).

There is no point to consider times of rising and falling edges
of electric signal in discussion here, they are small enough and
can be ignored. AFAIK NCS pulse time equal to cycle time is pretty
valid SMC setting, there is no reason to not utilize that.

> So, I still don't understand why you think that my equations is not right.
> If you think another way, then please explain your idea better then
> a few words.

I'm sorry, I'm not able to explain things different than I did in this
and my previous emails.

Stanislaw
