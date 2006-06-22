From: Martin Hicks <mort@bork.org>
Subject: sata_vsc problems with libata-dev.git#upstream
Date: Thu, 22 Jun 2006 11:20:57 -0400
Message-ID: <20060622152057.GE2949@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from galileo.bork.org ([134.117.69.57]:43413 "EHLO galileo.bork.org")
	by vger.kernel.org with ESMTP id S1751448AbWFVPU7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jun 2006 11:20:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by galileo.bork.org (Postfix) with ESMTP id 0D4834175
	for <linux-ide@vger.kernel.org>; Thu, 22 Jun 2006 11:20:58 -0400 (EDT)
Received: from galileo.bork.org ([127.0.0.1])
	by localhost (galileo.bork.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10787-04 for <linux-ide@vger.kernel.org>;
	Thu, 22 Jun 2006 11:20:57 -0400 (EDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

I wanted to see if I could get device hotplug working with the
intel31244 (sata_vsc driver).  This machine boots fine with 2.6.16, but
with the #upstream branch from git I get the following crash.

This is a ppc440gx board.  Any pointing in the right direction would be
appreciated.  With 2.6.16 it seems to do the ata_pio_sector data read
just fine and detect the device.

thanks,
mh

ata_device_add: ENTER
ata_host_add: ENTER
ata_port_start: prd alloc, virt ff102000, dma 5d4000
ata1: SATA max UDMA/133 cmd 0xD106A200 ctl 0xD106A229 bmdma 0xD106A270 irq 27
__ata_port_freeze: ata1 port frozen
ata_host_add: ENTER
ata_port_start: prd alloc, virt ff104000, dma 499000
ata2: SATA max UDMA/133 cmd 0xD106A400 ctl 0xD106A429 bmdma 0xD106A470 irq 27
__ata_port_freeze: ata2 port frozen
ata_host_add: ENTER
ata_port_start: prd alloc, virt ff106000, dma 6db000
ata3: SATA max UDMA/133 cmd 0xD106A600 ctl 0xD106A629 bmdma 0xD106A670 irq 27
__ata_port_freeze: ata3 port frozen
ata_host_add: ENTER
ata_port_start: prd alloc, virt ff108000, dma 614000
ata4: SATA max UDMA/133 cmd 0xD106A800 ctl 0xD106A829 bmdma 0xD106A870 irq 27
__ata_port_freeze: ata4 port frozen
ata_device_add: probe begin
scsi0 : sata_vsc
ata_port_schedule_eh: port EH scheduled
ata_scsi_error: ENTER
ata_port_flush_task: ENTER
ata_port_flush_task: flush #1
ata_port_flush_task: flush #2
ata_port_flush_task: EXIT
ata_eh_recover: ENTER
__ata_port_freeze: ata1 port frozen
ata_std_softreset: ENTER
ata_std_softreset: about to softreset, devmask=1
ata_bus_softreset: ata1: bus reset via SRST
ata_dev_classify: found ATA device by sig
ata_std_softreset: EXIT, classes[0]=1 [1]=0
ata_std_postreset: ENTER
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata_std_postreset: EXIT
ata_eh_thaw_port: ata1 port thawed
ata_eh_revalidate_and_attach: ENTER
ata_dev_read_id: ENTER, host 1, dev 0
ata_exec_command_mmio: ata1: cmd 0xEC
ata_hsm_move: ata1: protocol 2 task_state 2 (dev_stat 0x58)
ata_pio_sector: data read
Machine check in kernel mode.
Data Read PLB Error
PLB0: BEAR=0x000000000f059200 ACR=  0x9b000000 BESR= 0x0c000000
POB0: BEAR=0x00000008a6bd7ce2 BESR0=0x00000000 BESR1=0x00000000
OPB0: BEAR=0x0000000000000000 BSTAT=0x00000000
Oops: machine check, sig: 7 [#1]
NIP: C0004010 LR: C01B17AC CTR: 00000100
REGS: c0309f50 TRAP: 0202   Not tainted  (2.6.17-g2a827025-dirty)
MSR: 00029000 <EE,ME>  CR: 44002422  XER: 00000000
TASK = c02ab740[0] 'swapper' THREAD: c02ec000
GPR00: D106A200 C02EDD90 C02AB740 CF059200 C047442E 00000000 00000000 C02ACF6C
GPR08: 00000000 00000100 00000000 C0310000 24008422 30000000 07FF5500 00000000
GPR16: 00000001 C0280000 C0260000 00000000 07FEFD1C 00000000 00000002 C0260000
GPR24: 00000058 C0310000 00000000 C047429C C0310000 C0474430 C047429C 00000200
NIP [C0004010] __ide_mm_insw+0x14/0x24
LR [C01B17AC] ata_pio_data_xfer+0x88/0xf0
Call Trace:
[C02EDD90] [C0310000] 0xc0310000 (unreliable)
[C02EDDB0] [C01B1920] ata_pio_sector+0xd8/0x154
[C02EDDE0] [C01B2318] ata_hsm_move+0x1ac/0x7ac
[C02EDE30] [C01B4364] ata_host_intr+0xb8/0x148
[C02EDE50] [C01BE00C] vsc_sata_interrupt+0x1d0/0x1ec
[C02EDE80] [C0038764] handle_IRQ_event+0x5c/0xc4
[C02EDEA0] [C00388BC] __do_IRQ+0xf0/0x17c
[C02EDEC0] [C0006EB8] do_IRQ+0x48/0x8c
[C02EDEE0] [C0002240] ret_from_except+0x0/0x18
[C02EDFA0] [C0009A54] cpu_idle+0xdc/0xe0
[C02EDFC0] [C0001048] rest_init+0x28/0x38
[C02EDFD0] [C02EE664] start_kernel+0x17c/0x1a8
[C02EDFF0] [C00001E8] skpinv+0x190/0x1cc
Instruction dump:
3884fffc 4c810020 84a40004 7ca01d2c 7c0006ac 4200fff4 4e800020 2c050000
7ca903a6 3884fffe 4c810020 a0a30000 <7c0006ac> b4a40002 4200fff4 4e800020
Kernel panic - not syncing: Attempted to kill the idle task!
 <0>Rebooting in 180 seconds..


-- 
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE
