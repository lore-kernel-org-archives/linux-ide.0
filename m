From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: libata problems with 66Mhz Promise SATA150 TX4
Date: Tue, 14 Sep 2004 20:03:51 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41473287.7050101@epita.fr>
References: <m34qm13m8h.fsf@zathras.nivin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:22424 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269672AbUINSLN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Sep 2004 14:11:13 -0400
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1C7Hlo-0002bd-00
	for <linux-ide@vger.kernel.org>; Tue, 14 Sep 2004 20:11:12 +0200
Received: from 213.41.133.51 ([213.41.133.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 14 Sep 2004 20:11:11 +0200
Received: from bevand_m by 213.41.133.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 14 Sep 2004 20:11:11 +0200
In-Reply-To: <m34qm13m8h.fsf@zathras.nivin.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Paul Fisher wrote:
> We're experiencing failures on a Promise SATA150 TX4 when run at 66Mhz
> on either PCI-X bus on a Tyan S2882 (dual Opteron system).  The
> problems manifest themselves rather quickly on an SMP-enabled kernel,
> and it takes a bit longer to kill a non-SMP kernel.
> [...]
> The only way we can get a stable system is to run the SATA150 TX4 off
> the 33Mhz PCI bus.
> [...]
> We've tested 2.6.8, 2.6.9-rc1, and 2.6.9-rc1-bk16.
> [...]
> CPU 0: Machine Check Exception:                4 Bank 4: b200000000070f0f

I have *exactly* the same problem (MCE b200000000070f0f, which indicates
a watchdog timer timeout), on the same hardware (Promise SATA150 TX4).
Like you, I get the problem only when using a 66MHz PCI bus (no problem
at 33MHz). Like you, the stack trace indicate the problem comes from
the Promise hardware. And like you the watchdog timeout is much harder
to reproduce with a non-SMP kernel.

Here is a short summary of my config:
  - Dual Opteron 244
  - Tyan S2885
  - 4 x 133MHz/64-bit PCI-X slots
  - 1 x 33MHz/32-bit PCI slot
  - Promise SATA150 TX4,
    running at either 66MHz (PCI-X slot), or 33MHz (PCI slot)
  - 4 x Seagate 160Go 7200 RPM S-ATA Barracuda 7200.7

An easy way to reproduce the problem is to run 4 instances of 'dd' reading
from 4 disks at the same time. It is much harder to reproduce when reading
from 3 disks, and quasi-impossible to reproduce when reading from 2 disks.

I have tried kernels 2.6.5 and 2.6.9-rc1 (arch x86_64). I have tried the
latest BIOS for my motherboard, the latest BIOS for the Promise card, and
all the PCI-X slots of the motherboard.

It seems the Promise chip has some problems under high-load conditions:
the throughput I obtain when reading from 4 disks is 100 MB/s (at 33MHz)
and 215 MB/s (at 66MHz)...

I contacted the Promise support some months ago, but they "did not get
this issue before", and finally they told me they "do not support 64 bit
or even PCI-X slots [for this model]" :-/

Actually I would be very interested to know if *anybody* is successfully
using this card at 66MHz with 3 or 4 disks attached to it.

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.

