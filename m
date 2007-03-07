From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: iq81340mc: oops with SATA VIA
Date: Tue, 6 Mar 2007 17:07:18 -0700
Message-ID: <0C7297FA1D2D244A9C7F6959C0BF1E52017D0497@azsmsx413.amr.corp.intel.com>
References: <20070212114114.GG6457@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15107 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030755AbXCGAHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Mar 2007 19:07:20 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20070212114114.GG6457@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: buytenh@wantstofly.org, linux-ide@vger.kernel.org

> From: Martin Michlmayr [mailto:tbm@cyrius.com]
> Sent: Monday, February 12, 2007 4:41 AM
> 
> * Williams, Dan J <dan.j.williams@intel.com> [2007-02-07 17:43]:
> > The access to 0xfffb04a7 should be remapped to 0xfec604a7.
> >
> > It looks like __io is not being called in your case.
> 
> It seems it's called, but it still fails:
> 
> sata_via 0000:00:01.0: routed to hard irq line 9
> ata1: SATA max UDMA/133 cmd 0xFFFB04A0 ctl 0xFFFB04AA bmdma 0xFFFB0480
irq 25
> __iop13xx_io: io_addr: 0xfffb04aa io_virt: fec604aa
> __iop13xx_io: io_addr: 0xfffb04a7 io_virt: fec604a7
> Unhandled fault: imprecise external abort (0x406) at 0x005db000
> Internal error: : 406 [#1]
> Modules linked in:
> CPU: 0
> PC is at ata_check_status+0x34/0x3c
> LR is at 0x60000093
> pc : [<401e44e0>]    lr : [<60000093>]    Not tainted
> sp : 40641da8  ip : 60000093  fp : 40641db4
> r10: 4fc97be4  r9 : 00000019  r8 : 00000001
> r7 : 4fcca400  r6 : 407142a4  r5 : 00000053  r4 : 407142a4
> r3 : 403acfe0  r2 : 00000000  r1 : 60000093  r0 : fec604a7
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
> Control: 400397F
> Table: 00004018  DAC: 00000035
> Process swapper (pid: 1, stack limit = 0x40640250)
> Stack: (0x40641da8 to 0x40642000)
> 1da0:                   40641dc8 40641db8 401e540c 401e44b8 407142a4
40641ddc
> 1dc0: 40641dcc 401e5674 401e53cc 20000013 40641df0 40641de0 401e56cc
401e5638
> 1de0: 00000001 40641e38 40641df4 401e01d0 401e56ac fffb04a0 fffb04aa
fffb0480
> 1e00: 00000019 4fc97be0 4062e848 4062e800 00000000 4062e8ec 4062e800
40641e5a
> 1e20: 4fcca400 4062e838 00000002 40641e84 40641e3c 401e82e8 401dffe0
4062e8b0
> 1e40: 40641e60 40641e50 401721bc 4062e848 4062e800 40641e70 40f11e64
403bf1d8
> 1e60: 4062e800 00000000 00000000 403e2784 40023444 4062e8ec 40641ea4
40641e88
> 1e80: 4018403c 401e7f60 4062e848 4062e848 4fc253e0 403bf20c 40641ecc
40641ea8
> 1ea0: 401a8c40 40183fe0 403bf20c 4062e848 4fc253e0 401a8e9c 40023444
40022f64
> 1ec0: 40641ee8 40641ed0 401a8dac 401a8be4 4062e91c 4062e848 403bf20c
40641f00
> 1ee0: 40641eec 401a8f80 401a8d20 00000000 40641f04 40641f2c 40641f04
401a80a4
> 1f00: 401a8ea8 403b7140 403b7140 4062e890 403bf20c 403bf220 403b7040
00000000
> 1f20: 40641f3c 40641f30 401a8af0 401a805c 40641f60 40641f40 401a8438
401a8adc
> 1f40: 403bf20c 00000000 403bf20c 00000000 40023444 40641f74 40641f64
401a91a8
> 1f60: 401a83d4 403bf1d8 40641f90 40641f78 40184218 401a9154 40022ed4
00000000
> 1f80: 40640000 40641fa0 40641f94 4001db60 401841a8 40641ff4 40641fa4
400280a8
> 1fa0: 4001db54 40641fb0 40028e04 4003b81c 00000000 00000000 4002802c
40041a54
> 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
> 1fe0: 00000000 00000000 00000000 40641ff8 40041a54 40028038 00000000
00000000
> Backtrace:
> [<401e44ac>] (ata_check_status+0x0/0x3c) from [<401e540c>]
> (ata_bmdma_freeze+0x4c/0x74)
> [<401e53c0>] (ata_bmdma_freeze+0x0/0x74) from [<401e5674>]
> (__ata_port_freeze+0x48/0x74)
>  r4 = 407142A4
> [<401e562c>] (__ata_port_freeze+0x0/0x74) from [<401e56cc>]
> (ata_eh_freeze_port+0x2c/0x44)
>  r4 = 20000013
> [<401e56a0>] (ata_eh_freeze_port+0x0/0x44) from [<401e01d0>]
> (ata_device_add+0x1fc/0x520)
>  r4 = 00000001
> [<401dffd4>] (ata_device_add+0x0/0x520) from [<401e82e8>]
> (svia_init_one+0x394/0x4e4)
> [<401e7f54>] (svia_init_one+0x0/0x4e4) from [<4018403c>]
> (pci_device_probe+0x68/0x8c)
> [<40183fd4>] (pci_device_probe+0x0/0x8c) from [<401a8c40>]
> (really_probe+0x68/0x13c)
>  r7 = 403BF20C  r6 = 4FC253E0  r5 = 4062E848  r4 = 4062E848
> [<401a8bd8>] (really_probe+0x0/0x13c) from [<401a8dac>]
> (driver_probe_device+0x98/0xc4)
> [<401a8d14>] (driver_probe_device+0x0/0xc4) from [<401a8f80>]
> (__driver_attach+0xe4/0xe8)
>  r6 = 403BF20C  r5 = 4062E848  r4 = 4062E91C
> [<401a8e9c>] (__driver_attach+0x0/0xe8) from [<401a80a4>]
> (bus_for_each_dev+0x54/0x80)
>  r5 = 40641F04  r4 = 00000000
> [<401a8050>] (bus_for_each_dev+0x0/0x80) from [<401a8af0>]
> (driver_attach+0x20/0x28)
>  r7 = 00000000  r6 = 403B7040  r5 = 403BF220  r4 = 403BF20C
> [<401a8ad0>] (driver_attach+0x0/0x28) from [<401a8438>]
> (bus_add_driver+0x70/0x194)
> [<401a83c8>] (bus_add_driver+0x0/0x194) from [<401a91a8>]
> (driver_register+0x60/0x9c)
>  r8 = 40023444  r7 = 00000000  r6 = 403BF20C  r5 = 00000000
>  r4 = 403BF20C
> [<401a9148>] (driver_register+0x0/0x9c) from [<40184218>]
> (__pci_register_driver+0x7c/0xc4)
>  r4 = 403BF1D8
> [<4018419c>] (__pci_register_driver+0x0/0xc4) from [<4001db60>]
> (svia_init+0x18/0x20)
>  r6 = 40640000  r5 = 00000000  r4 = 40022ED4
> [<4001db48>] (svia_init+0x0/0x20) from [<400280a8>] (init+0x7c/0x29c)
> [<4002802c>] (init+0x0/0x29c) from [<40041a54>] (do_exit+0x0/0x888)
> Code: e89da800 e5900050 ebf93cc8 e5d03000 (e20300ff)
>  <0>Kernel panic - not syncing: Attempted to kill init!
> 

Martin I am copying linux-ide because I am wondering if this issue is
due to a case where the fact that iop13xx posts i/o writes is causing
issues.  On IA the driver would be stalled until an i/o write completed.
On iop13xx the driver is free to continue running.  Perhaps someone with
more knowledge about the sata_via hardware can answer if this would be
an issue, because everything thus far looks correct in the iop13xx code.

> --
> Martin Michlmayr
> http://www.cyrius.com/

--
Dan
