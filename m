From: Sander <sander@humilis.net>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Tue, 21 Mar 2006 20:15:47 +0100
Message-ID: <20060321191547.GC20426@favonius>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca> <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca> <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ookhoi.xs4all.nl ([213.84.114.66]:7611 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S965067AbWCUTPv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 14:15:51 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sander <sander@humilis.net>, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Linus Torvalds wrote (ao):
> On Tue, 21 Mar 2006, Sander wrote:
> > The system just freezes. Rock solid. No sysrq, no ctrl-alt-del, nothing.
> 
> Can you enable the NMI watchdog? It could be a PCI bus lockup (in which 
> case nothing will help), but if it's some interrupts-off busy loop 
> (whether due to a spinlock deadlock or due to the driver just spinning) 
> then nmi-watchdog should help.
> 
> Of course, that requires that you have support for local/io-APIC (ie if 
> UP, please select CONFIG_X86_UP_.*APIC)

The kernel is compiled for x86-64 and SMP (dual core opteron), so if I
understand the NMI watchdog documentation correctly, it is automagically
enabled.

# dmesg | grep -i nmi
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[   75.280604] testing NMI watchdog ... OK.

# grep -i nmi /proc/interrupts 
NMI:         52         43 

(seems to increment _very_ slowly).

Is there anything else I can do to see some crash info?

Btw, it always seems to crash during the md5sum of this test:

for i in `seq 4`
do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
dd if=bigfile.$i of=/dev/null bs=1024k count=10000
done
time md5sum bigfile.*
time rm bigfile.*

One time during many tests I needed to run this twice before it went
bellyup.

I was not able to let 2.6.16-rc6-mm2 crash yet.

I'll test 2.6.16-rc6-mm1 now.

-- 
Humilis IT Services and Solutions
http://www.humilis.net
