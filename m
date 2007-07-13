From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: 40-wire/80-wire detection
Date: Fri, 13 Jul 2007 01:26:45 +0100
Message-ID: <4696C6C5.3070703@genesi-usa.com>
References: <527770.57572.qm@web58107.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:3402 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358AbXGMAZ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 20:25:56 -0400
In-Reply-To: <527770.57572.qm@web58107.mail.re3.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Craig Block <chblock3@yahoo.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org


Craig Block wrote:
> Linux kernel: version 2.6.22.1
> Chipset: VIA VT8363 + VT82C686A
> Hard drives: Quantum Fireball LCT10 (UDMA66)
> 
> I'm having a problem with the 80-wire/40-wire cable detection in the
> ata driver.  Even when I configure the kernel with IDEDMA_IVB set, I
> still get the 40-wire speed downgrade on hda.
> 
> Why did you guys put that 80-wire/40-wire cable detection in the ata
> driver anyway?  Since when is it your job to police me in making sure
> I'm using the correct cable on my drives.  

Since it's required by the ATA standard for anything above UDMA/33
unless the cable is ludicrously short?

> This is a pefect example of why I feel Linux isn't worth the trouble. 
> If it weren't free of cost, I wouldn't go near it.  But then again, I
> guess you get what you pay for so I shouldn't complain.

I think you'll find most modern BIOS implementations will nag you
incessantly if you have a UDMA/66 and beyond device with a 40-core
cable. As will most well-written Windows device drivers knock it down
but they just don't have a big, noticable warning about it (I would
never have known Intel Application Accelerator was doing it until I
looked in it's diagnostics GUI and it told me so. Turns out I had
broken my cable).

Most IDE chipsets have a register for this explicit purpose. Not
checking it would be rather negligent on the part of the driver,
not to mention if it enabled high speed operation on an unsuitable
cable you would be waving bye-bye to all your data. That's exactly
why there is no way to force it on most drivers, too.

You trade off l33t speed boosting for data integrity, you will
only lose your data faster, in the end.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
