From: Jeremy Kerr <jk@ozlabs.org>
Subject: siimage breakage: no MMIO
Date: Thu, 1 May 2008 18:32:16 +1000
Message-ID: <200805011832.17580.jk@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:41008 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbYEAIcX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 May 2008 04:32:23 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Ben Herrenschmidt <benh@kernel.crashing.org>, cbe-oss-dev@ozlabs.org

Hi all,

On QS20 Cell machines, Linus' current git tree explodes on boot:

SiI680: IDE controller (0x1095:0x0680 rev 0x02) at  PCI slot 
0000:00:0a.0
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 51
    ide0: MMIO-DMA
    ide1: MMIO-DMA
Unable to handle kernel paging request for data at address 
0xa000100081220080
Faulting instruction address: 0xc000000000024748
cpu 0x2: Vector: 300 (Data Access) at [c00000001e143420]
    pc: c000000000024748: ._insw_ns+0x10/0x30
    lr: c000000000037fc4: .spiderpci_readsw+0x24/0x6c
    sp: c00000001e1436a0
   msr: 9000000000001032
   dar: a000100081220080
 dsisr: 40000000
  current = 0xc00000003d060000
  paca    = 0xc000000000623880
    pid   = 1, comm = swapper
enter ? for help
[link register   ] c000000000037fc4 .spiderpci_readsw+0x24/0x6c
[c00000001e1436a0] c00000000062ce63 (unreliable)
[c00000001e143730] c0000000000379d4 .iowa_readsw+0x78/0xa8
[c00000001e1437c0] c000000000037a98 .iowa_insw+0x94/0xd4
[c00000001e143850] c00000000022a190 .ata_input_data+0x298/0x2ec
[c00000001e143910] c00000000022b600 .try_to_identify+0x2c0/0x6d4
[c00000001e1439d0] c00000000022bb54 .do_probe+0x140/0x35c
[c00000001e143a80] c00000000022bfbc .ide_probe_port+0x24c/0x670
[c00000001e143b50] c00000000022d09c .ide_device_add_all+0x2ec/0x690
[c00000001e143c00] c00000000022d4a4 .ide_device_add+0x64/0x74
[c00000001e143c90] c00000000022f834 .ide_setup_pci_device+0x58/0x7c
[c00000001e143d30] c00000000038bdf8
[c00000001e143e10] c000000000486fb0 .ide_scan_pcibus+0x8c/0x178
[c00000001e143ea0] c000000000460c00 .kernel_init+0x1c4/0x344
[c00000001e143f90] c000000000024a1c .kernel_thread+0x4c/0x68

It looks like we're trying to do PIO accesses (which appear to be 
broken, but that's another issue) to this MMIO device. In 
ata_input_data, we see that:

	u8 mmio = (hwif->host_flags & IDE_HFLAG_MMIO) ? 1 : 0;

Gives mmio == 0.

(what's the difference between hwif->mmio and ID_HFLAG_MMIO?)

In the siimage driver, hwif->host flags is initially set up correctly 
(host_flags includes IDE_HFLAG_MMIO), but we then *clear* this bit in 
ide_init_port: 

	hwif->host_flags = d->host_flags;

where d is the struct ide_port_info for this chipset. In my case, 
d->host_flags is 0x0. It looks like this will be the same for all of 
the siimage chipsets.

I'm having a little trouble figuring out the correct solution for this, 
as the device probe is too early to do the pci_get_drvdata() test. Any 
ideas?

Cheers,


Jeremy
