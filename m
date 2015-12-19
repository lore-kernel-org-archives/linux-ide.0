From: Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Sat, 19 Dec 2015 16:16:47 -0400
Message-ID: <5675BB2F.6060107@candw.ms>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
 <56732C04.9040100@candw.ms> <yw1xvb7wbowu.fsf@unicorn.mansr.com>
 <5673F277.2050607@candw.ms> <yw1xegekarp9.fsf@unicorn.mansr.com>
 <1450441395.30729.203.camel@linux.intel.com>
 <yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
 <yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
 <yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
 <yw1xlh8r9wkm.fsf@unicorn.mansr.com>
 <CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
 <567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
 <CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
 <yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
 <yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
 <yw1xio3u8dgc.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060007010301010902060905"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp754.redcondor.net ([208.80.206.54]:38824 "EHLO
	smtp754.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724AbbLSURV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2015 15:17:21 -0500
In-Reply-To: <yw1xio3u8dgc.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060007010301010902060905
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

On 12/19/2015 3:07 PM, Måns Rullgård wrote:
> Julian Margetson <runaway@candw.ms> writes:
>
>> On 12/19/2015 1:19 PM, Måns Rullgård wrote:
>>> Julian Margetson <runaway@candw.ms> writes:
>>>
>>>> On 12/19/2015 1:05 PM, Måns Rullgård wrote:
>>>>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>>>>
>>>>>> On Sat, Dec 19, 2015 at 5:40 PM, Måns Rullgård <mans@mansr.com> wrote:
>>>>>>
>>>>>>> OK, I've found something.  The dma setup errors are benign, caused by
>>>>>>> the driver calling dmaengine_prep_slave_sg() even for non-dma
>>>>>>> operations.
>>>>>> I suppose the following is a quick fix to avoid preparing descriptor
>>>>>> for non-DMA operations (not tested anyhow)
>>>>>>
>>>>>> a/drivers/ata/sata_dwc_460ex.c
>>>>>> +++ b/drivers/ata/sata_dwc_460ex.c
>>>>>> @@ -1041,6 +1041,9 @@ static void sata_dwc_qc_prep_by_tag(struct
>>>>>> ata_queued_cmd *qc, u8 tag)
>>>>>>                    __func__, ap->port_no, get_dma_dir_descript(qc->dma_dir),
>>>>>>                     qc->n_elem);
>>>>>>
>>>>>> +       if (!is_slave_direction(qc->dma_dir))
>>>>>> +               return;
>>>>>> +
>>>>>>            desc = dma_dwc_xfer_setup(qc);
>>>>>>            if (!desc) {
>>>>>>                    dev_err(ap->dev, "%s: dma_dwc_xfer_setup returns NULL\n",
>>>>> I already have a better patch sitting here.
>>>>>
>>>>>>> The real error is the lock recursion that's reported
>>>>>>> later.  I wasn't seeing it since I was running a UP non-preempt kernel.
>>>>>>> With lock debugging enabled, I get the same error.  This patch should
>>>>>>> fix it.
>>>>>>> -       spin_lock_irqsave(&ap->host->lock, flags);
>>>>>>>            hsdevp->cmd_issued[tag] = cmd_issued;
>>>>>>> -       spin_unlock_irqrestore(&ap->host->lock, flags);
>>>>>>> +
>>>>>> This will create a second empty line, though I don't care it is so minor.
>>>>> The patch leaves one blank line before the following block comment.  I
>>>>> think it looks better that way.
>>>>>
>>>> Still can't get the patch applied .
>>> Sorry, didn't realise it conflicted with an intervening patch I had in
>>> my tree.  Try this one.
>>>
>>
>> =~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2015.12.19 14:44:52 =~=~=~=~=~=~=~=~=~=~=~=
>>
>> U-Boot 2015.a (May 16 2015 - 14:20:11)
>>
>> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
>>         No Security/Kasumi support
>>         Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>>         Internal PCI arbiter enabled
>>         32 kB I-Cache 32 kB D-Cache
>> Board: Sam460ex/cr, PCIe 4x + SATA-2
>> I2C:   ready
>> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
>> PCI:   Bus Dev VenId DevId Class Int
>>          00  04  1095  3512  0104  00
>>          00  06  126f  0501  0380  00
>> PCIE1: successfully set as root-complex
>>          02  00  1002  683f  0300  ff
>> Net:   ppc_4xx_eth0
>> FPGA:  Revision 03 (2010-10-07)
>> SM502: found
>> PERMD2:not found
>> VGA:   1
>> VESA:  OK
>> [    0.000000] Using Canyonlands machine description
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 4.4.0-rc5-Sam460ex (root@julian-VirtualBox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #1 PREEMPT Sat Dec 19 14:25:55 AST 2015
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
>> [    0.000000]   Normal   empty
>> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
>> [    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
>> [    0.000000] Kernel command line: root=/dev/sda8 console=ttyS0,115200 console=tty1 dw_dmac_core.dyndbg dw_dmac.dyndbg
> Please add ignore_log_level.
>
Had to truncate the kernel command line to add it.

--------------060007010301010902060905
Content-Type: text/plain; charset=UTF-8;
 name="log5.log.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="log5.log.log"

=~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2015.12.19 15:59:55 =~=~=~=~=~=~=~=~=~=~=~=

U-Boot 2015.a (May 16 2015 - 14:20:11)

CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
       No Security/Kasumi support
       Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
       Internal PCI arbiter enabled
       32 kB I-Cache 32 kB D-Cache
Board: Sam460ex/cr, PCIe 4x + SATA-2
I2C:   ready
DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
PCI:   Bus Dev VenId DevId Class Int
        00  04  1095  3512  0104  00
        00  06  126f  0501  0380  00
PCIE1: successfully set as root-complex
        02  00  1002  683f  0300  ff
Net:   ppc_4xx_eth0
FPGA:  Revision 03 (2010-10-07)
SM502: found
PERMD2:not found
VGA:   1
VESA:  OK
[    0.000000] Using Canyonlands machine description
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 4.4.0-rc5-Sam460ex (root@julian-VirtualBox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #1 PREEMPT Sat Dec 19 14:25:55 AST 2015
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: root=/dev/sda8 console=ttyS0,115200  ignore_log_level dw_dmac_core.dyndbg dw_dmac.dyndbg
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 2068868K/2097152K available (6732K kernel code, 332K rwdata, 3232K rodata, 236K init, 368K bss, 28284K reserved, 0K cma-reserved, 1310720K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs
[    0.000000]   * 0xffa00000..0xffc00000  : consistent mem
[    0.000000]   * 0xffa00000..0xffa00000  : early ioremap
[    0.000000]   * 0xf1000000..0xffa00000  : vmalloc & ioremap
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0
[    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0
[    0.000000] UIC2 (32 IRQ sources) at DCR 0xe0
[    0.000000] UIC3 (32 IRQ sources) at DCR 0xf0
[    0.000013] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x10a60dda894, max_idle_ns: 440795207041 ns
[    0.000023] clocksource: timebase mult[dda520] shift[24] registered
[    0.000144] Console: colour dummy device 80x25
[    0.000175] pid_max: default: 32768 minimum: 301
[    0.000277] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000289] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.004032] devtmpfs: initialized
[    0.006766] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.007154] xor: measuring software checksum speed
[    0.016351]    8regs     :   856.000 MB/sec
[    0.026358]    8regs_prefetch:   784.000 MB/sec
[    0.036389]    32regs    :  1120.000 MB/sec
[    0.046422]    32regs_prefetch:   996.000 MB/sec
[    0.046429] xor: using function: 32regs (1120.000 MB/sec)
[    0.046463] prandom: seed boundary self test passed
[    0.048911] prandom: 100 self tests passed
[    0.049448] NET: Registered protocol family 16
[    0.052548] cpuidle: using governor ladder
[    0.055582] cpuidle: using governor menu
[    0.055982] 256k L2-cache enabled
[    0.056065] PCIE0: Port disabled via device-tree
[    0.056116] PCIE1: Checking link...
[    0.056122] PCIE1: Device detected, waiting for link...
[    0.056128] PCIE1: link is up !
[    0.158413] PCI host bridge /plb/pciex@d20000000 (primary) ranges:
[    0.158440]  MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000 
[    0.158455]  MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000 
[    0.158465]   IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
[    0.158488] 4xx PCI DMA offset set to 0x00000000
[    0.158494] 4xx PCI DMA window base to 0x0000000000000000
[    0.158500] DMA window size 0x0000000080000000
[    0.158524] PCIE1: successfully set as root-complex
[    0.158589] PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
[    0.158604]  MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000 
[    0.158618]  MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000 
[    0.158629]   IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
[    0.158643] 4xx PCI DMA offset set to 0x00000000
[    0.158648] 4xx PCI DMA window base to 0x0000000000000000
[    0.158654] DMA window size 0x0000000080000000
[    0.159140] PCI: Probing PCI hardware
[    0.159241] PCI host bridge to bus 0000:80
[    0.159259] pci_bus 0000:80: root bus resource [io  0xfffe0000-0xfffeffff] (bus address [0x0000-0xffff])
[    0.159272] pci_bus 0000:80: root bus resource [mem 0xe80000000-0xeffffffff] (bus address [0x80000000-0xffffffff])
[    0.159284] pci_bus 0000:80: root bus resource [mem 0xf00100000-0xf001fffff] (bus address [0x00000000-0x000fffff])
[    0.159297] pci_bus 0000:80: root bus resource [bus 80-ff]
[    0.159421] PCI: Hiding 4xx host bridge resources 0000:80:00.0
[    0.160285] pci 0000:80:00.0: PCI bridge to [bus 81-bf]
[    0.160491] PCI host bridge to bus 0001:00
[    0.160505] pci_bus 0001:00: root bus resource [io  0x0000-0xffff]
[    0.160517] pci_bus 0001:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
[    0.160529] pci_bus 0001:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
[    0.160540] pci_bus 0001:00: root bus resource [bus 00-ff]
[    0.161162] pci 0000:80:00.0: BAR 9: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.161174] pci 0000:80:00.0: BAR 8: assigned [mem 0xe90000000-0xe900fffff]
[    0.161185] pci 0000:80:00.0: BAR 7: assigned [io  0xfffe1000-0xfffe1fff]
[    0.161201] pci 0000:81:00.0: BAR 0: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.161221] pci 0000:81:00.0: BAR 2: assigned [mem 0xe90000000-0xe9003ffff 64bit]
[    0.161238] pci 0000:81:00.0: BAR 6: assigned [mem 0xe90040000-0xe9005ffff pref]
[    0.161251] pci 0000:81:00.1: BAR 0: assigned [mem 0xe90060000-0xe90063fff 64bit]
[    0.161268] pci 0000:81:00.0: BAR 4: assigned [io  0xfffe1000-0xfffe10ff]
[    0.161281] pci 0000:80:00.0: PCI bridge to [bus 81-bf]
[    0.161292] pci 0000:80:00.0:   bridge window [io  0xfffe1000-0xfffe1fff]
[    0.161303] pci 0000:80:00.0:   bridge window [mem 0xe90000000-0xe900fffff]
[    0.161314] pci 0000:80:00.0:   bridge window [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.161392] pci 0001:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]
[    0.161405] pci 0001:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]
[    0.161417] pci 0001:00:04.0: BAR 6: assigned [mem 0xd84200000-0xd8427ffff pref]
[    0.161429] pci 0001:00:04.0: BAR 5: assigned [mem 0xd84280000-0xd842801ff]
[    0.161440] pci 0001:00:04.0: BAR 4: assigned [io  0x1000-0x100f]
[    0.161452] pci 0001:00:04.0: BAR 0: assigned [io  0x1010-0x1017]
[    0.161463] pci 0001:00:04.0: BAR 2: assigned [io  0x1018-0x101f]
[    0.161475] pci 0001:00:04.0: BAR 1: assigned [io  0x1020-0x1023]
[    0.161487] pci 0001:00:04.0: BAR 3: assigned [io  0x1024-0x1027]
[    0.188265] raid6: int32x1  gen()   300 MB/s
[    0.205419] raid6: int32x1  xor()   173 MB/s
[    0.222445] raid6: int32x2  gen()   433 MB/s
[    0.239493] raid6: int32x2  xor()   240 MB/s
[    0.256585] raid6: int32x4  gen()   476 MB/s
[    0.273663] raid6: int32x4  xor()   267 MB/s
[    0.290719] raid6: int32x8  gen()   234 MB/s
[    0.307892] raid6: int32x8  xor()   218 MB/s
[    0.307898] raid6: using algorithm int32x4 gen() 476 MB/s
[    0.307904] raid6: .... xor() 267 MB/s, rmw enabled
[    0.307911] raid6: using intx1 recovery algorithm
[    0.308209] vgaarb: device added: PCI:0000:81:00.0,decodes=io+mem,owns=none,locks=none
[    0.308223] vgaarb: loaded
[    0.308228] vgaarb: bridge control possible 0000:81:00.0
[    0.308493] SCSI subsystem initialized
[    0.308867] usbcore: registered new interface driver usbfs
[    0.308911] usbcore: registered new interface driver hub
[    0.308964] usbcore: registered new device driver usb
[    0.309060] pps_core: LinuxPPS API ver. 1 registered
[    0.309068] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.309096] PTP clock support registered
[    0.309240] EDAC MC: Ver: 3.0.0
[    0.309589] Advanced Linux Sound Architecture Driver Initialized.
[    0.329521] DMA-API: preallocated 65536 debug entries
[    0.329534] DMA-API: debugging enabled by kernel config
[    0.329580] clocksource: Switched to clocksource timebase
[    0.336185] NET: Registered protocol family 2
[    0.336769] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.336863] TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
[    0.337204] TCP: Hash tables configured (established 8192 bind 8192)
[    0.337315] UDP hash table entries: 512 (order: 2, 24576 bytes)
[    0.337380] UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)
[    0.337725] NET: Registered protocol family 1
[    0.338039] RPC: Registered named UNIX socket transport module.
[    0.338048] RPC: Registered udp transport module.
[    0.338054] RPC: Registered tcp transport module.
[    0.338060] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.338817] Could not remap bcsr
[    0.341969] genirq: Setting trigger mode 3 for irq 45 failed (uic_set_irq_type+0x0/0x160)
[    0.345025] futex hash table entries: 256 (order: 0, 7168 bytes)
[    0.355166] ntfs: driver 2.1.32 [Flags: R/W].
[    0.355700] fuse init (API version 7.23)
[    0.359889] async_tx: api initialized (async)
[    0.359989] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.360006] io scheduler noop registered
[    0.360148] io scheduler cfq registered (default)
[    0.362207] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
[    0.362217] crc32: self tests passed, processed 225944 bytes in 892377 nsec
[    0.363191] crc32c: CRC_LE_BITS = 64
[    0.363200] crc32c: self tests passed, processed 225944 bytes in 446237 nsec
[    0.429593] crc32_combine: 8373 self tests passed
[    0.496188] crc32c_combine: 8373 self tests passed
[    0.496240] glob: 64 self-tests passed, 0 failed
[    0.534469] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.535260] console [ttyS0] disabled
[    0.555405] serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 22, base_baud = 691200) is a U6_16550A
[    1.487085] console [ttyS0] enabled
[    1.511191] serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 23, base_baud = 691200) is a U6_16550A
[    1.521036] console [ttyS0] disabled
[    0.000000] Using Canyonlands machine description
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 4.4.0-rc5-Sam460ex (root@julian-VirtualBox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #1 PREEMPT Sat Dec 19 14:25:55 AST 2015
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: root=/dev/sda8 console=ttyS0,115200  ignore_log_level dw_dmac_core.dyndbg dw_dmac.dyndbg
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 2068868K/2097152K available (6732K kernel code, 332K rwdata, 3232K rodata, 236K init, 368K bss, 28284K reserved, 0K cma-reserved, 1310720K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
[    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs
[    0.000000]   * 0xffa00000..0xffc00000  : consistent mem
[    0.000000]   * 0xffa00000..0xffa00000  : early ioremap
[    0.000000]   * 0xf1000000..0xffa00000  : vmalloc & ioremap
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] Build-time adjustment of leaf fanout to 32.
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0
[    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0
[    0.000000] UIC2 (32 IRQ sources) at DCR 0xe0
[    0.000000] UIC3 (32 IRQ sources) at DCR 0xf0
[    0.000013] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x10a60dda894, max_idle_ns: 440795207041 ns
[    0.000023] clocksource: timebase mult[dda520] shift[24] registered
[    0.000144] Console: colour dummy device 80x25
[    0.000175] pid_max: default: 32768 minimum: 301
[    0.000277] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000289] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.004032] devtmpfs: initialized
[    0.006766] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.007154] xor: measuring software checksum speed
[    0.016351]    8regs     :   856.000 MB/sec
[    0.026358]    8regs_prefetch:   784.000 MB/sec
[    0.036389]    32regs    :  1120.000 MB/sec
[    0.046422]    32regs_prefetch:   996.000 MB/sec
[    0.046429] xor: using function: 32regs (1120.000 MB/sec)
[    0.046463] prandom: seed boundary self test passed
[    0.048911] prandom: 100 self tests passed
[    0.049448] NET: Registered protocol family 16
[    0.052548] cpuidle: using governor ladder
[    0.055582] cpuidle: using governor menu
[    0.055982] 256k L2-cache enabled
[    0.056065] PCIE0: Port disabled via device-tree
[    0.056116] PCIE1: Checking link...
[    0.056122] PCIE1: Device detected, waiting for link...
[    0.056128] PCIE1: link is up !
[    0.158413] PCI host bridge /plb/pciex@d20000000 (primary) ranges:
[    0.158440]  MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000 
[    0.158455]  MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000 
[    0.158465]   IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
[    0.158488] 4xx PCI DMA offset set to 0x00000000
[    0.158494] 4xx PCI DMA window base to 0x0000000000000000
[    0.158500] DMA window size 0x0000000080000000
[    0.158524] PCIE1: successfully set as root-complex
[    0.158589] PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
[    0.158604]  MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000 
[    0.158618]  MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000 
[    0.158629]   IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
[    0.158643] 4xx PCI DMA offset set to 0x00000000
[    0.158648] 4xx PCI DMA window base to 0x0000000000000000
[    0.158654] DMA window size 0x0000000080000000
[    0.159140] PCI: Probing PCI hardware
[    0.159241] PCI host bridge to bus 0000:80
[    0.159259] pci_bus 0000:80: root bus resource [io  0xfffe0000-0xfffeffff] (bus address [0x0000-0xffff])
[    0.159272] pci_bus 0000:80: root bus resource [mem 0xe80000000-0xeffffffff] (bus address [0x80000000-0xffffffff])
[    0.159284] pci_bus 0000:80: root bus resource [mem 0xf00100000-0xf001fffff] (bus address [0x00000000-0x000fffff])
[    0.159297] pci_bus 0000:80: root bus resource [bus 80-ff]
[    0.159421] PCI: Hiding 4xx host bridge resources 0000:80:00.0
[    0.160285] pci 0000:80:00.0: PCI bridge to [bus 81-bf]
[    0.160491] PCI host bridge to bus 0001:00
[    0.160505] pci_bus 0001:00: root bus resource [io  0x0000-0xffff]
[    0.160517] pci_bus 0001:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
[    0.160529] pci_bus 0001:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
[    0.160540] pci_bus 0001:00: root bus resource [bus 00-ff]
[    0.161162] pci 0000:80:00.0: BAR 9: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.161174] pci 0000:80:00.0: BAR 8: assigned [mem 0xe90000000-0xe900fffff]
[    0.161185] pci 0000:80:00.0: BAR 7: assigned [io  0xfffe1000-0xfffe1fff]
[    0.161201] pci 0000:81:00.0: BAR 0: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.161221] pci 0000:81:00.0: BAR 2: assigned [mem 0xe90000000-0xe9003ffff 64bit]
[    0.161238] pci 0000:81:00.0: BAR 6: assigned [mem 0xe90040000-0xe9005ffff pref]
[    0.161251] pci 0000:81:00.1: BAR 0: assigned [mem 0xe90060000-0xe90063fff 64bit]
[    0.161268] pci 0000:81:00.0: BAR 4: assigned [io  0xfffe1000-0xfffe10ff]
[    0.161281] pci 0000:80:00.0: PCI bridge to [bus 81-bf]
[    0.161292] pci 0000:80:00.0:   bridge window [io  0xfffe1000-0xfffe1fff]
[    0.161303] pci 0000:80:00.0:   bridge window [mem 0xe90000000-0xe900fffff]
[    0.161314] pci 0000:80:00.0:   bridge window [mem 0xe80000000-0xe8fffffff 64bit pref]
[    0.161392] pci 0001:00:06.0: BAR 0: assigned [mem 0xd80000000-0xd83ffffff]
[    0.161405] pci 0001:00:06.0: BAR 1: assigned [mem 0xd84000000-0xd841fffff]
[    0.161417] pci 0001:00:04.0: BAR 6: assigned [mem 0xd84200000-0xd8427ffff pref]
[    0.161429] pci 0001:00:04.0: BAR 5: assigned [mem 0xd84280000-0xd842801ff]
[    0.161440] pci 0001:00:04.0: BAR 4: assigned [io  0x1000-0x100f]
[    0.161452] pci 0001:00:04.0: BAR 0: assigned [io  0x1010-0x1017]
[    0.161463] pci 0001:00:04.0: BAR 2: assigned [io  0x1018-0x101f]
[    0.161475] pci 0001:00:04.0: BAR 1: assigned [io  0x1020-0x1023]
[    0.161487] pci 0001:00:04.0: BAR 3: assigned [io  0x1024-0x1027]
[    0.188265] raid6: int32x1  gen()   300 MB/s
[    0.205419] raid6: int32x1  xor()   173 MB/s
[    0.222445] raid6: int32x2  gen()   433 MB/s
[    0.239493] raid6: int32x2  xor()   240 MB/s
[    0.256585] raid6: int32x4  gen()   476 MB/s
[    0.273663] raid6: int32x4  xor()   267 MB/s
[    0.290719] raid6: int32x8  gen()   234 MB/s
[    0.307892] raid6: int32x8  xor()   218 MB/s
[    0.307898] raid6: using algorithm int32x4 gen() 476 MB/s
[    0.307904] raid6: .... xor() 267 MB/s, rmw enabled
[    0.307911] raid6: using intx1 recovery algorithm
[    0.308209] vgaarb: device added: PCI:0000:81:00.0,decodes=io+mem,owns=none,locks=none
[    0.308223] vgaarb: loaded
[    0.308228] vgaarb: bridge control possible 0000:81:00.0
[    0.308493] SCSI subsystem initialized
[    0.308867] usbcore: registered new interface driver usbfs
[    0.308911] usbcore: registered new interface driver hub
[    0.308964] usbcore: registered new device driver usb
[    0.309060] pps_core: LinuxPPS API ver. 1 registered
[    0.309068] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.309096] PTP clock support registered
[    0.309240] EDAC MC: Ver: 3.0.0
[    0.309589] Advanced Linux Sound Architecture Driver Initialized.
[    0.329521] DMA-API: preallocated 65536 debug entries
[    0.329534] DMA-API: debugging enabled by kernel config
[    0.329580] clocksource: Switched to clocksource timebase
[    0.336185] NET: Registered protocol family 2
[    0.336769] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.336863] TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
[    0.337204] TCP: Hash tables configured (established 8192 bind 8192)
[    0.337315] UDP hash table entries: 512 (order: 2, 24576 bytes)
[    0.337380] UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)
[    0.337725] NET: Registered protocol family 1
[    0.338039] RPC: Registered named UNIX socket transport module.
[    0.338048] RPC: Registered udp transport module.
[    0.338054] RPC: Registered tcp transport module.
[    0.338060] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.338817] Could not remap bcsr
[    0.341969] genirq: Setting trigger mode 3 for irq 45 failed (uic_set_irq_type+0x0/0x160)
[    0.345025] futex hash table entries: 256 (order: 0, 7168 bytes)
[    0.355166] ntfs: driver 2.1.32 [Flags: R/W].
[    0.355700] fuse init (API version 7.23)
[    0.359889] async_tx: api initialized (async)
[    0.359989] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.360006] io scheduler noop registered
[    0.360148] io scheduler cfq registered (default)
[    0.362207] crc32: CRC_LE_BITS = 64, CRC_BE BITS = 64
[    0.362217] crc32: self tests passed, processed 225944 bytes in 892377 nsec
[    0.363191] crc32c: CRC_LE_BITS = 64
[    0.363200] crc32c: self tests passed, processed 225944 bytes in 446237 nsec
[    0.429593] crc32_combine: 8373 self tests passed
[    0.496188] crc32c_combine: 8373 self tests passed
[    0.496240] glob: 64 self-tests passed, 0 failed
[    0.534469] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.535260] console [ttyS0] disabled
[    0.555405] serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 22, base_baud = 691200) is a U6_16550A
[    1.487085] console [ttyS0] enabled
[    1.511191] serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 23, base_baud = 691200) is a U6_16550A
[    1.521036] console [ttyS0] disabled
[    1.524695] 4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 22, base_baud = 691200) is a 16550
[    2.481174] console [ttyS0] enabled
[    2.485294] 4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 23, base_baud = 691200) is a 16550
[    2.494676] Generic non-volatile memory driver v1.1
[    2.499834] [drm] Initialized drm 1.1.0 20060810
[    2.504522] [drm] radeon kernel modesetting enabled.
[    2.510206] [drm] initializing kernel modesetting (VERDE 0x1002:0x683F 0x1545:0x7750).
[    2.518194] [drm] register mmio base: 0xe90000000
[    2.522930] [drm] register mmio size: 262144
[    2.859029] ATOM BIOS: C44501
[    2.862259] radeon 0000:81:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.871169] radeon 0000:81:00.0: GTT: 2048M 0x0000000040000000 - 0x00000000BFFFFFFF
[    2.878834] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.883720] [drm] RAM width 128bits DDR
[    2.887755] [TTM] Zone  kernel: Available graphics memory: 379074 kiB
[    2.894229] [TTM] Zone highmem: Available graphics memory: 1034434 kiB
[    2.900760] [TTM] Initializing pool allocator
[    2.905216] [drm] radeon: 1024M of VRAM memory ready
[    2.910200] [drm] radeon: 2048M of GTT memory ready.
[    2.915234] [drm] Loading verde Microcode
[    2.919284] [drm] Internal thermal controller with fan control
[    2.925353] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[    2.978966] [drm] radeon: dpm initialized
[    2.983195] radeon 0000:81:00.0: Direct firmware load for radeon/TAHITI_vce.bin failed with error -2
[    2.992385] radeon 0000:81:00.0: radeon_vce: Can't load firmware "radeon/TAHITI_vce.bin"
[    3.000535] [drm] GART: num cpu pages 524288, num gpu pages 524288
[    3.017262] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[    3.072039] [drm] PCIE GART of 2048M enabled (table at 0x0000000000277000).
[    3.079320] radeon 0000:81:00.0: WB enabled
[    3.083555] radeon 0000:81:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xedccec00
[    3.093656] radeon 0000:81:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xedccec04
[    3.103751] radeon 0000:81:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xedccec08
[    3.113846] radeon 0000:81:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xedccec0c
[    3.123941] radeon 0000:81:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xedccec10
[    3.164520] radeon 0000:81:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0xf5135a18
[    3.174619] radeon 0000:81:00.0: VCE init error (-22).
[    3.179768] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.186384] [drm] Driver supports precise vblank timestamp query.
[    3.192490] radeon 0000:81:00.0: radeon: MSI limited to 32-bit
[    3.198403] genirq: Setting trigger mode 3 for irq 45 failed (uic_set_irq_type+0x0/0x160)
[    3.206668] radeon 0000:81:00.0: radeon: using MSI.
[    3.211618] [drm] radeon: irq initialized.
[    3.971625] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed (scratch(0x850C)=0xCAFEDEAD)
[    3.980432] radeon 0000:81:00.0: disabling GPU acceleration
[    4.189393] [drm] Radeon Display Connectors
[    4.193648] [drm] Connector 0:
[    4.196742] [drm]   HDMI-A-1
[    4.199638] [drm]   HPD4
[    4.202178] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 0x657c 0x657c
[    4.209579] [drm]   Encoders:
[    4.212556] [drm]     DFP1: INTERNAL_UNIPHY2
[    4.216836] [drm] Connector 1:
[    4.219899] [drm]   DVI-I-1
[    4.222702] [drm]   HPD2
[    4.225241] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c
[    4.232641] [drm]   Encoders:
[    4.235612] [drm]     DFP2: INTERNAL_UNIPHY
[    4.239804] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    4.358055] [drm] fb mappable at 0x80678000
[    4.362253] [drm] vram apper at 0x80000000
[    4.366358] [drm] size 8294400
[    4.369422] [drm] fb depth is 24
[    4.372660] [drm]    pitch is 7680
[    4.651943] Console: switching to colour frame buffer device 240x67
[    4.730862] radeon 0000:81:00.0: fb0: radeondrmfb frame buffer device
[    4.739645] [drm] Initialized radeon 2.43.0 20080528 for 0000:81:00.0 on minor 0
[    4.756405] brd: module loaded
[    4.763940] loop: module loaded
[    4.767432] sata_sil 0001:00:04.0: Applying R_ERR on DMA activate FIS errata fix
[    4.775448] scsi host0: sata_sil
[    4.779018] scsi host1: sata_sil
[    4.782403] ata1: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd84280080 irq 21
[    4.789730] ata2: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd842800c0 irq 21
[    4.797687] PPC 4xx OCP EMAC driver, version 3.54
[    4.802957] MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
[    4.808829] ZMII /plb/opb/emac-zmii@ef600d00 initialized
[    4.814261] RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
[    4.821419] TAH /plb/opb/emac-tah@ef601350 initialized
[    4.826620] TAH /plb/opb/emac-tah@ef601450 initialized
[    4.832028] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
[    4.839156] eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:50:c2:80:d5:c5
[    4.846052] eth0: found Generic MII PHY (0x00)
[    4.850690] /plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
[    4.857796] eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
[    4.864694] eth1: found Generic MII PHY (0x01)
[    4.869194] PPP generic driver version 2.4.2
[    4.873666] PPP BSD Compression module registered
[    4.878395] PPP Deflate Compression module registered
[    4.883457] NET: Registered protocol family 24
[    4.888087] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.894780] ppc-of-ehci 4bffd0400.ehci: OF EHCI
[    4.899489] ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
[    4.908098] ppc-of-ehci 4bffd0400.ehci: irq 31, io mem 0x4bffd0400
[    4.919596] ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
[    4.925980] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.932787] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.940016] usb usb1: Product: OF EHCI
[    4.943774] usb usb1: Manufacturer: Linux 4.4.0-rc5-Sam460ex ehci_hcd
[    4.950223] usb usb1: SerialNumber: PPC-OF USB
[    4.955077] hub 1-0:1.0: USB hub found
[    4.958893] hub 1-0:1.0: 1 port detected
[    4.963122] ehci-pci: EHCI PCI platform driver
[    4.967675] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    4.973990] ppc-of-ohci 4bffd0000.usb: OF OHCI
[    4.978647] ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 2
[    4.986447] ppc-of-ohci 4bffd0000.usb: irq 32, io mem 0x4bffd0000
[    5.111605] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    5.152366] ata1.00: ATA-8: WDC WD5000AAKS-00V1A0, 05.01D05, max UDMA/133
[    5.166582] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[    5.183854] ata1.00: configured for UDMA/100
[    5.206848] scsi 0:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 1D05 PQ: 0 ANSI: 5
[    5.220252] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.228697] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    5.239823] sd 0:0:0:0: [sda] Write Protect is off
[    5.249681] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.265591] usb 1-1: new high-speed USB device number 2 using ppc-of-ehci
[    5.284427]  sda: RDSK (512) sda1 (DOS^G)(res 2 spb 1) sda2 (SFS^@)(res 2 spb 1) sda3 (SFS^@)(res 2 spb 1) sda4 (SFS^@)(res 2 spb 1) sda5 (SFS^@)(res 2 spb 1) sda6 (SFS^@)(res 2 spb 1) sda7 (NTFS)(res 2 spb 2) sda8 (EXT^C)(res 2 spb 1)
[    5.326820] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.394945] usb 1-1: New USB device found, idVendor=0424, idProduct=2517
[    5.407584] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.423680] hub 1-1:1.0: USB hub found
[    5.430680] hub 1-1:1.0: 7 ports detected
[    5.547608] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    5.576718] ata2.00: ATAPI: ASUS    DRW-24B3ST   i, 1.00, max UDMA/100
[    5.609699] ata2.00: configured for UDMA/100
[    5.625517] scsi 1:0:0:0: CD-ROM            ASUS     DRW-24B3ST   i   1.00 PQ: 0 ANSI: 5
[    5.668878] sr 1:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    5.683583] cdrom: Uniform CD-ROM driver Revision: 3.20
[    5.695388] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    5.704861] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    5.711919] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.719186] usb 1-1.1: new high-speed USB device number 3 using ppc-of-ehci
[    5.726158] usb usb2: Product: OF OHCI
[    5.729925] usb usb2: Manufacturer: Linux 4.4.0-rc5-Sam460ex ohci_hcd
[    5.736432] usb usb2: SerialNumber: PPC-OF USB
[    5.741400] hub 2-0:1.0: USB hub found
[    5.745219] hub 2-0:1.0: 1 port detected
[    5.749482] ohci-pci: OHCI PCI platform driver
[    5.754227] usbcore: registered new interface driver usblp
[    5.759874] usbcore: registered new interface driver usb-storage
[    5.766108] usbcore: registered new interface driver usbserial
[    5.772035] usbcore: registered new interface driver usbserial_generic
[    5.778625] usbserial: USB Serial support registered for generic
[    5.784961] mousedev: PS/2 mouse device common for all mice
[    5.790655] i2c /dev entries driver
[    5.796536] rtc-m41t80 8-0068: rtc core: registered m41t80 as rtc0
[    5.803706] ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
[    5.809967] ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
[    5.816065] md: linear personality registered for level -1
[    5.821578] md: raid0 personality registered for level 0
[    5.826953] md: raid1 personality registered for level 1
[    5.832338] md: raid10 personality registered for level 10
[    5.838046] md: raid6 personality registered for level 6
[    5.843408] md: raid5 personality registered for level 5
[    5.848737] md: raid4 personality registered for level 4
[    5.854675] usb 1-1.1: New USB device found, idVendor=1a40, idProduct=0101
[    5.861749] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
[    5.870236] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    5.877610] EDAC PPC4xx MC: v1.0.0
[    5.881056] usb 1-1.1: Product: USB 2.0 Hub
[    5.885258] EDAC PPC4xx MC: Reporting type: interrupt
[    5.890901] hub 1-1.1:1.0: USB hub found
[    5.894940] hidraw: raw HID events driver (C) Jiri Kosina
[    5.900674] hub 1-1.1:1.0: 4 ports detected
[    5.905185] usbcore: registered new interface driver usbhid
[    5.910834] usbhid: USB HID core driver
[    5.915341] usbcore: registered new interface driver snd-usb-audio
[    5.921731] usbcore: registered new interface driver snd-ua101
[    5.927843] usbcore: registered new interface driver snd-usb-usx2y
[    5.934407] ipip: IPv4 over IPv4 tunneling driver
[    5.939646] Initializing XFRM netlink socket
[    5.944809] NET: Registered protocol family 10
[    5.950263] sit: IPv6 over IPv4 tunneling driver
[    5.955402] NET: Registered protocol family 17
[    5.959950] NET: Registered protocol family 15
[    5.966421] Key type encrypted registered
[    5.972009] rtc-m41t80 8-0068: setting system clock to 2015-12-19 16:06:54 UTC (1450541214)
[    5.980625] ALSA device list:
[    5.983625]   No soundcards found.
[    5.987635] md: Waiting for all devices to be available before autodetect
[    5.994463] md: If you don't use raid, use raid=noautodetect
[    6.000794] md: Autodetecting RAID arrays.
[    6.004927] md: Scanned 0 and added 0 devices.
[    6.009379] md: autorun ...
[    6.012183] md: ... autorun DONE.
[    6.015612] usb 1-1.2: new low-speed USB device number 4 using ppc-of-ehci
[    6.047473] EXT4-fs (sda8): mounting ext3 file system using the ext4 subsystem
[    6.081467] EXT4-fs (sda8): mounted filesystem with ordered data mode. Opts: (null)
[    6.089223] VFS: Mounted root (ext3 filesystem) readonly on device 8:8.
[    6.116407] usb 1-1.2: New USB device found, idVendor=04f2, idProduct=0116
[    6.123456] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.130926] usb 1-1.2: Product: USB Keyboard
[    6.135247] usb 1-1.2: Manufacturer: CHICONY
[    6.139715] devtmpfs: mounted
[    6.143527] Freeing unused kernel memory: 236K (c09be000 - c09f9000)
[    6.156461] input: CHICONY USB Keyboard as /devices/platform/plb/4bffd0400.ehci/usb1/1-1/1-1.2/1-1.2:1.0/0003:04F2:0116.0001/input/input0
[    6.220061] hid-generic 0003:04F2:0116.0001: input,hidraw0: USB HID v1.10 Keyboard [CHICONY USB Keyboard] on usb-PPC-OF USB-1.2/input0
[    6.232359] usb 1-1.1.1: new full-speed USB device number 5 using ppc-of-ehci
[    6.325782] usb 1-1.1.1: New USB device found, idVendor=0d8c, idProduct=000c
[    6.332879] usb 1-1.1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    6.340745] usb 1-1.1.1: Product: C-Media USB Audio Device   
[    6.370063] input: C-Media USB Audio Device    as /devices/platform/plb/4bffd0400.ehci/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.3/0003:0D8C:000C.0002/input/input1
[    6.397609] usb 1-1.6: new full-speed USB device number 6 using ppc-of-ehci
[    6.434891] hid-generic 0003:0D8C:000C.0002: input,hidraw1: USB HID v1.00 Device [C-Media USB Audio Device   ] on usb-PPC-OF USB-1.1.1/input3
[    6.493278] usb 1-1.6: New USB device found, idVendor=046d, idProduct=c52b
[    6.500693] usb 1-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.508405] usb 1-1.6: Product: USB Receiver
[    6.512956] usb 1-1.6: Manufacturer: Logitech
[    6.522084] input: Logitech USB Receiver as /devices/platform/plb/4bffd0400.ehci/usb1/1-1/1-1.6/1-1.6:1.0/0003:046D:C52B.0003/input/input2
[    6.585896] hid-generic 0003:046D:C52B.0003: input,hidraw2: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-PPC-OF USB-1.6/input0
[    6.598174] random: nonblocking pool is initialized
[    6.609505] input: Logitech USB Receiver as /devices/platform/plb/4bffd0400.ehci/usb1/1-1/1-1.6/1-1.6:1.1/0003:046D:C52B.0004/input/input3
[    6.672996] hid-generic 0003:046D:C52B.0004: input,hidraw3: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-PPC-OF USB-1.6/input1
[    6.690714] hid-generic 0003:046D:C52B.0005: hidraw4: USB HID v1.11 Device [Logitech USB Receiver] on usb-PPC-OF USB-1.6/input2
[    6.775607] usb 1-1.7: new high-speed USB device number 7 using ppc-of-ehci
[    6.875265] usb 1-1.7: New USB device found, idVendor=0424, idProduct=2240
[    6.882558] usb 1-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    6.890159] usb 1-1.7: Product: Ultra Fast Media 
[    6.895002] usb 1-1.7: Manufacturer: Generic
[    6.899314] usb 1-1.7: SerialNumber: 000000225001
[    6.906743] usb-storage 1-1.7:1.0: USB Mass Storage device detected
[    6.913312] scsi host2: usb-storage 1-1.7:1.0
[    7.294300] systemd[1]: Failed to insert module 'kdbus': Function not implemented
[    7.388418] systemd[1]: systemd 228 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[    7.406999] systemd[1]: Detected architecture ppc.

Welcome to Ubuntu 16.04!

[    7.444895] systemd[1]: Set hostname to <Sam460ex>.
[    7.644195] systemd-fstab-generator[116]: Mount point  is not a valid path, ignoring.
[    7.747303] systemd[110]: /lib/systemd/system-generators/systemd-fstab-generator terminated by signal ABRT.
[    7.918808] scsi 2:0:0:0: Direct-Access     Generic  Ultra HS-COMBO   1.98 PQ: 0 ANSI: 0
[    7.928760] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    7.937131] sd 2:0:0:0: [sdb] Attached SCSI removable disk
[    8.703965] systemd[1]: Listening on udev Kernel Socket.
[  OK  ] Listening on udev Kernel Socket.
[    8.716950] systemd[1]: Listening on fsck to fsckd communication Socket.
[  OK  ] Listening on fsck to fsckd communication Socket.
[    8.731931] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
[    8.746753] systemd[1]: Reached target Remote File Systems (Pre).
[  OK  ] Reached target Remote File Systems (Pre).
[    8.761026] systemd[1]: Listening on Journal Socket.
[  OK  ] Listening on Journal Socket.
[    8.773692] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[  OK  ] Set up automount Arbitrary Executab...ats File System Automount Point.
[    8.792987] systemd[1]: Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket (/dev/log).
[    8.805802] systemd[1]: Reached target Swap.
[  OK  ] Reached target Swap.
[    8.816042] systemd[1]: Created slice System Slice.
[  OK  ] Created slice System Slice.
[    8.829139] systemd[1]: Started Read required files in advance.
[  OK  ] Started Read required files in advance.
[    9.041561] systemd[1]: Starting Load Kernel Modules...
         Starting Load Kernel Modules...
[    9.056466] systemd[1]: Reached target Remote File Systems.
[  OK  ] Reached target Remote File Systems.
[    9.070204] systemd[1]: Created slice system-getty.slice.
[  OK  ] Created slice system-getty.slice.
[    9.083066] systemd[1]: Created slice User and Session Slice.
[  OK  ] Created slice User and Session Slice.
[    9.099834] systemd[1]: Starting Uncomplicated firewall...
         Starting Uncomplicated firewall...
[    9.113830] systemd[1]: Reached target Encrypted Volumes.
[  OK  ] Reached target Encrypted Volumes.
[    9.127319] systemd[1]: Created slice system-serial\x2dgetty.slice.
[  OK  ] Created slice system-serial\x2dgetty.slice.
[    9.145719] systemd[1]: Mounting Debug File System...
         Mounting Debug File System...
[    9.165781] systemd[1]: Mounting POSIX Message Queue File System...
         Mounting POSIX Message Queue File System...
[    9.191042] systemd[1]: Listening on udev Control Socket.
[  OK  ] Listening on udev Control Socket.
[    9.204064] systemd[1]: Listening on Syslog Socket.
[  OK  ] Listening on Syslog Socket.
[    9.241313] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[  OK  ] Started Forward Password Requests to Wall Directory Watch.
[    9.259212] systemd[1]: Reached target User and Group Name Lookups.
[  OK  ] Reached target User and Group Name Lookups.
[    9.276965] systemd[1]: Reached target Slices.
[  OK  ] Reached target Slices.
[    9.291925] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[    9.309897] systemd[1]: Starting Create list of required static device nodes for the current kernel...
         Starting Create list of required st... nodes for the current kernel...
[    9.339866] systemd[1]: Started Uncomplicated firewall.
[  OK  ] Started Uncomplicated firewall.
[    9.523413] systemd[1]: systemd-modules-load.service: Main process exited, code=exited, status=1/FAILURE
[    9.540458] systemd[1]: Failed to start Load Kernel Modules.
[FAILED] Failed to start Load Kernel Modules.
See 'systemctl status systemd-modules-load.service' for details.
[    9.561751] systemd[1]: systemd-modules-load.service: Unit entered failed state.
[    9.569450] systemd[1]: systemd-modules-load.service: Failed with result 'exit-code'.
[    9.592917] systemd[1]: Started Create list of required static device nodes for the current kernel.
[  OK  ] Started Create list of required sta...ce nodes for the current kernel.
[    9.624225] systemd[1]: Mounted Debug File System.
[  OK  ] Mounted Debug File System.
[    9.645485] systemd[1]: Mounted POSIX Message Queue File System.
[  OK  ] Mounted POSIX Message Queue File System.
[    9.681739] systemd[1]: ureadahead.service: Main process exited, code=exited, status=5/NOTINSTALLED
[    9.693091] systemd[1]: ureadahead.service: Unit entered failed state.
[    9.699745] systemd[1]: ureadahead.service: Failed with result 'exit-code'.
[    9.753528] systemd[1]: Starting Create Static Device Nodes in /dev...
         Starting Create Static Device Nodes in /dev...
[    9.777165] systemd[1]: Mounting FUSE Control File System...
         Mounting FUSE Control File System...
[    9.797560] systemd[1]: Starting Apply Kernel Variables...
         Starting Apply Kernel Variables...
[    9.822354] systemd[1]: Mounting Configuration File System...
         Mounting Configuration File System...
[    9.850252] systemd[1]: Mounted FUSE Control File System.
[  OK  ] Mounted FUSE Control File System.
[    9.864937] systemd[1]: Mounted Configuration File System.
[  OK  ] Mounted Configuration File System.
[  OK  ] Started Apply Kernel Variables.
[  OK  ] Started Journal Service.
[  OK  ] Started Create Static Device Nodes in /dev.
         Starting udev Kernel Device Manager...
[  OK  ] Started udev Kernel Device Manager.
         Starting File System Check on Root Device...
[  OK  ] Started File System Check Daemon to report status.
[  OK  ] Started File System Check on Root Device.
         Starting Remount Root and Kernel File Systems...
[FAILED] Failed to start Remount Root and Kernel File Systems.
See 'systemctl status systemd-remount-fs.service' for details.
         Starting Flush Journal to Persistent Storage...
         Starting udev Coldplug all Devices...
[  OK  ] Reached target Local File Systems (Pre).
         Starting Load/Save Random Seed...
[  OK  ] Started Load/Save Random Seed.
[  OK  ] Started Flush Journal to Persistent Storage.
[  OK  ] Started udev Coldplug all Devices.
[  OK  ] Started Dispatch Password Requests to Console Directory Watch.
[  OK  ] Found device /dev/ttyS0.
[   13.798794] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[   13.821775] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[   13.852881] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[  OK  ] Reached target Sound Card.
[  OK  ] Created slice system-ifup.slice.
[  OK  ] Found device /sys/subsystem/net/devices/eth0.
[  OK  ] Found device WDC_WD5000AAKS-00V1A0 NTFS.
         Mounting /media/NTFS...
[  OK  ] Mounted /media/NTFS.
[  OK  ] Reached target Local File Systems.
         Starting LSB: AppArmor initialization...
         Starting Create Volatile Files and Directories...
         Starting Tell Plymouth To Write Out Runtime Data...
         Starting Wait for all "auto" /etc/n... up for network-online.target...
         Starting Clean up any mess left by 0dns-up...
[  OK  ] Started Tell Plymouth To Write Out Runtime Data.
[  OK  ] Started Create Volatile Files and Directories.
[  OK  ] Reached target System Time Synchronized.
         Starting Update UTMP about System Boot/Shutdown...
[  OK  ] Started Update UTMP about System Boot/Shutdown.
[  OK  ] Started Clean up any mess left by 0dns-up.
[  OK  ] Started LSB: AppArmor initialization.
[  OK  ] Started ifup for eth0.
         Starting Nameserver information manager...
[  OK  ] Started Nameserver information manager.
         Starting LSB: Raise network interfaces....
         Starting LSB: start Samba SMB/CIFS daemon (smbd)...
[  OK  ] Started LSB: start Samba SMB/CIFS daemon (smbd).
[  OK  ] Started Wait for all "auto" /etc/ne...be up for network-online.target.

[   44.789143] ata3.00: failed command: READ FPDMA QUEUED
[   44.794376] ata3.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
[   44.794376]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   44.809351] ata3.00: status: { DRDY }

[   45.137778] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[   45.158850] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
r LSB: Rai...ork interfaces. (44s / no limit)
[   75.765297] ata3.00: failed command: READ FPDMA QUEUED
[   75.770531] ata3.00: cmd 60/08:00:00:00:00/00:00:00:00:00/40 tag 0 ncq 4096 in
[   75.770531]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[   75.785501] ata3.00: status: { DRDY }
[   76.098849] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
    *] A start job is running for LSB: Rai...interfa[   76.115178] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
ces. (1min 7s / no limit)[   76.136847] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
n 31s / no limit)
[  106.742527] ata3.00: failed command: READ DMA
[  106.746991] ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[  106.746991]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  106.762046] ata3.00: status: { DRDY }
[  107.076848] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[  107.091773] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL

nning for LSB: Rai...nterfaces. (1min 38s / no limit)    ] A start job is running for LSB: Rai...nterfaces. (1min 53s / no limit)
[  137.782048] ata3.00: failed command: READ DMA
[  137.786491] ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[  137.786491]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  137.801484] ata3.00: status: { DRDY }

 for LSB: Rai...interfaces. (2min 9s / no limit)[  138.130785] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[  138.151845] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL

[  OK  ] Reached target System Initialization.
[  OK  ] Started Trigger resolvconf update for networkd DNS.
[  OK  ] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Reached target Timers.
         Starting Console System Startup Logging...
[  OK  ] Listening on CUPS Scheduler.
         Starting Restore Sound Card State...
[  OK  ] Started CUPS Scheduler.
[  OK  ] Reached target Paths.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Listening on UUID daemon activation socket.
[  OK  ] Reached target Sockets.
[  OK  ] Reached target Basic System.
         Starting Modem Manager...
         Starting Restore /etc/resolv.conf i...e the ppp link was shut down....
         Starting LSB: start and stop timidity...
[  OK  ] Started Regular background program processing daemon.
         Starting Accounts Service...
         Starting LSB: handle special hotkeys of Apple computers...
[  OK  ] Started CUPS Scheduler.
         Starting LSB: daemon to balance interrupts for SMP systems...
         Starting Login Service...
[  OK  ] Started crash report submission daemon.
         Starting Network Manager...
         Starting Initialize hardware monitoring sensors...
         Starting System Logging Service...
         Starting LSB: Set the CPU Frequency Scaling governor to "ondemand"...
         Starting Avahi mDNS/DNS-SD Stack...
[  OK  ] Started Cgroup management daemon.
         Starting LSB: automatic crash report generation...
         Starting Permit User Sessions...
[  OK  ] Started Run anacron jobs.
[  OK  ] Started D-Bus System Message Bus.
[  OK  ] Started Avahi mDNS/DNS-SD Stack.
[  OK  ] Started Network Manager.
[  OK  ] Reached target Network.
[  OK  ] Reached target Network is Online.
         Starting LSB: start Samba daemons for the AD DC...
         Starting LSB: disk temperature monitoring daemon...
         Starting LSB: start Samba NetBIOS nameserver (nmbd)...
         Starting LSB: Start NTP daemon...
         Starting /etc/rc.local Compatibility...
[  OK  ] Started Make remote CUPS printers available locally.
         Starting LSB: Load kernel modules needed to enable cpufreq scaling...
         Starting LSB: Start xrdp and sesman daemons...
         Starting LSB: Tool to automatically...ubmit kernel crash signatures...
[  OK  ] Started System Logging Service.
[  OK  ] Started Console System Startup Logging.
[  OK  ] Started Restore Sound Card State.
[  OK  ] Started Restore /etc/resolv.conf if...ore the ppp link was shut down..
[  OK  ] Started LSB: start and stop timidity.
[  OK  ] Started LSB: handle special hotkeys of Apple computers.
[  OK  ] Started LSB: daemon to balance interrupts for SMP systems.
[  OK  ] Started LSB: Set the CPU Frequency Scaling governor to "ondemand".
[  OK  ] Started LSB: automatic crash report generation.
[  OK  ] Started Permit User Sessions.
[  OK  ] Started LSB: disk temperature monitoring daemon.
[  OK  ] Started /etc/rc.local Compatibility.
[  OK  ] Started LSB: Load kernel modules needed to enable cpufreq scaling.
[  OK  ] Started Initialize hardware monitoring sensors.
[  OK  ] Started LSB: Tool to automatically ... submit kernel crash signatures.
[  OK  ] Started LSB: Start NTP daemon.
[  OK  ] Started LSB: Start xrdp and sesman daemons.
[  OK  ] Started Login Service.
         Starting Authenticate and Authorize Users to Run Privileged Tasks...
         Starting Manage, Install and Generate Color Profiles...
         Starting LSB: set CPUFreq kernel parameters...
         Starting Light Display Manager...
         Starting Hold until boot process finishes up...
[  OK  ] Started Hold until boot process finishes up.
[  OK  ] Started LSB: set CPUFreq kernel parameters.
[  OK  ] Started Authenticate and Authorize Users to Run Privileged Tasks.
[  OK  ] Started Accounts Service.
         Starting WPA supplicant...
[  OK  ] Started Serial Getty on ttyS0.
[  OK  ] Started Getty on tty1.
[  OK  ] Reached target Login Prompts.
[  OK  ] Started Manage, Install and Generate Color Profiles.
[  OK  ] Started Modem Manager.
[  OK  ] Started Light Display Manager.
[  OK  ] Started WPA supplicant.
         Starting Network Manager Script Dispatcher Service...
[  OK  ] Started Network Manager Script Dispatcher Service.

Ubuntu Xenial Xerus (development branch) Sam460ex ttyS0

Sam460ex login: [  168.812924] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  168.830521] ata3.00: failed command: READ DMA
[  168.841530] ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[  168.841530]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  168.870535] ata3.00: status: { DRDY }
[  169.190057] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[  169.215664] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[  169.246746] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[  199.788475] ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  199.803744] ata3.00: failed command: READ DMA
[  199.814375] ata3.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
[  199.814375]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
[  199.845340] ata3.00: status: { DRDY }
[  200.165795] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[  200.194458] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[  200.224548] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_dwc_xfer_setup returns NULL
[  200.251506] blk_update_request: I/O error, dev sdc, sector 0
[  200.272350] Buffer I/O error on dev sdc, logical block 0, async page read

--------------060007010301010902060905--

