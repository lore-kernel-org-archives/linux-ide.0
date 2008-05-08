From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: sata_sx4 vs. Promise SX4060
Date: Thu, 08 May 2008 21:30:02 +0200
Message-ID: <fvvkbr$h60$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:37924 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbYEHTfF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 May 2008 15:35:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JuBtO-0004rW-UE
	for linux-ide@vger.kernel.org; Thu, 08 May 2008 19:35:02 +0000
Received: from d83-183-214-201.cust.tele2.se ([83.183.214.201])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 19:35:02 +0000
Received: from lasse.makholm by d83-183-214-201.cust.tele2.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 08 May 2008 19:35:02 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hi,

I know it's been brought up here before, at least a few years ago
(http://search.gmane.org/?query=sx4060&group=gmane.linux.ide) but here
goes anyway...

I'm one of those semi-happy owners of a Promise SX4060 PATA RAID
controller which is apparently only supported for some 2.4-something
kernels...

Obviously I would a lot more happy with a 2.6 driver... :-)

So I've been googling high and low without much result, except finding
out that the SX4060 is based on the same chip (the PDC20621) as the SATA
150 SX4, leading me to believe that the sata_sx4 driver is probably the
best bet for getting the SX4060 working under 2.6 kernels...

Also, this comment in sata_sx4.c seems to support this suspicion:

	The SX4 behaves like a PATA chip, with no SATA controls or
	knowledge whatsoever, leading to the presumption that
	PATA<->SATA bridges exist on SX4 boards, external to the
	PDC20621 chip itself.

All documentation I've been able to find on the devices indicate that 
they are very similar...

I tried hacking the driver to recognize the SX4060 board number,
essentially the same thing as described here:
http://article.gmane.org/gmane.linux.ide/5435

...with similar results. The controller is recognized and it also
recognizes the attached drives, but it seems to have trouble 
initializing the DIMM and with the ATA_SET_FEATURES command...

With ATA_DEBUG and ATA_DEBUG_VERBOSE, I get something like this (I have 
the full log if someone wants to see it):

[  271.122187] pdc20621_dimm_init: Time Counter Register (0x44): 0xf0a6fb86
[  271.122250] pdc20621_dimm_init: Num counters 0xf590479 (257492089)
[  271.122309] pdc20621_dimm_init: 10 * Internal clk = 0x35a (858)
[  271.122369] pdc20621_dimm_init: 10 * Internal clk * 33 = 0x6e9a (28314)
[  271.122428] pdc20621_dimm_init: PLL F Param: 0x2f (47)
[  271.122486] pdc20621_dimm_init: pci_status: 0x8a2f1824
[  271.122721] pdc20621_dimm_init: Local DIMM Speed = 100
[  271.124883] pdc20621_dimm_init: Local DIMM Size = 64MB
[  271.125118] Local DIMM ECC Enabled
[  271.226153] 0, 0,
[  271.226220] 55, aa, Promise Not Yet Defined 1.1098
[  271.226291] 55, aa, Promise Not Yet Defined 1.1098
[  271.226524] pdc20621_dimm_init: Start ECC initialization
[  281.972847] BUG: soft lockup - CPU#0 stuck for 11s! [modprobe:6153]
Register and stack dump here...
[  293.775043] BUG: soft lockup - CPU#0 stuck for 11s! [modprobe:6153]
Register and stack dump here...
[  305.581239] BUG: soft lockup - CPU#0 stuck for 11s! [modprobe:6153]
Register and stack dump here...
[  312.567607] pdc20621_dimm_init: Finish ECC initialization
Lots of noise follows...
[  312.768567] ata5: PATA max UDMA/44 mmio m1048576@0xfe900000 dimm 
m32768@0xfe800000 port 0xfe900200 irq 17
[  312.768571] ata6: PATA max UDMA/44 mmio m1048576@0xfe900000 dimm 
m32768@0xfe800000 port 0xfe900280 irq 17
[  312.768574] ata7: PATA max UDMA/44 mmio m1048576@0xfe900000 dimm 
m32768@0xfe800000 port 0xfe900300 irq 17
[  312.768577] ata8: PATA max UDMA/44 mmio m1048576@0xfe900000 dimm 
m32768@0xfe800000 port 0xfe900380 irq 17
More noise follows...
[  342.918886] ata_port_flush_task: ENTER
[  342.918947] ata5: ata_port_flush_task: EXIT
[  342.918959] ata5.00: qc timeout (cmd 0xef)
[  342.918962] ata_dev_set_xfermode: EXIT, err_mask=4
[  342.919021] ata5.00: failed to set xfermode (err_mask=0x4)

Even more noise follows...

[  373.068199] ata5.00: failed to set xfermode (err_mask=0x4)
[  373.068260] ata5.00: limiting speed to UDMA/44:PIO3
[  373.068263] pdc_20621_phy_reset: ENTER
[  373.068320] ata_bus_reset: ENTER, host 5, port 0
[  373.068388] ata_bus_softreset: ata5: bus reset via SRST
[  373.224003] ata_dev_classify: found ATA device by sig
[  373.224068] ata_bus_reset: EXIT
[  373.224125] ata5.00: ata_dev_read_id: ENTER
[  373.224127] ata5: ata_dev_select: ENTER, device 0, wait 1
[  373.224157] ata5: ata_dev_select: ENTER, device 0, wait 1
[  373.224195] ata_tf_load: feat 0x0 nsect 0x0 lba 0x0 0x0 0x0
[  373.224253] ata_tf_load: device 0xA0
[  373.224321] ata_exec_command: ata5: cmd 0xEC
[  373.231994] ata_hsm_move: ata5: protocol 2 task_state 2 (dev_stat 0x58)
[  373.232057] ata_pio_sector: data read
[  373.232419] ata_hsm_move: ata5: protocol 2 task_state 3 (dev_stat 0x50)
[  373.232479] ata_hsm_move: ata5: dev 0 command complete, drv_stat 0x50
[  373.232562] ata_port_flush_task: ENTER
[  373.232618] ata5: ata_port_flush_task: EXIT
[  373.232622] ata5.00: ata_dev_configure: ENTER
[  373.232634] pdc20621_nodata_prep: ata5: ENTER
[  373.232692] pdc20621_ata_pkt: ENTER, dimm_sg == 0x200180, 2097536
[  373.232760] pdc20621_nodata_prep: ata pkt buf ofs 282, mmio copied
[  373.232819] pdc20621_packet_start: ata5: ENTER
[  373.232879] pdc20621_packet_start: submitted ofs 0x200100 (2097408), 
seq 1
[  373.232987] pdc20621_interrupt: ENTER
[  373.233045] pdc20621_interrupt: mask == 0x2
[  373.233103] pdc20621_interrupt: seq 1, port_no 0, ap de81c000, tmp 2
[  373.233162] pdc20621_host_intr: ENTER
[  373.233230] pdc20621_host_intr: BUS_NODATA (drv_stat 0x50)
[  373.233297] pdc20621_interrupt: seq 2, port_no 1, ap de820000, tmp 0
[  373.233357] pdc20621_interrupt: seq 3, port_no 2, ap de824000, tmp 0
[  373.233416] pdc20621_interrupt: seq 4, port_no 3, ap de828000, tmp 0
[  373.233475] pdc20621_interrupt: seq 5, port_no 0, ap de81c000, tmp 0
[  373.233535] pdc20621_interrupt: seq 6, port_no 1, ap de820000, tmp 0
[  373.233594] pdc20621_interrupt: seq 7, port_no 2, ap de824000, tmp 0
[  373.233654] pdc20621_interrupt: seq 8, port_no 3, ap de828000, tmp 0
[  373.233713] pdc20621_interrupt: mask == 0x2
[  373.233769] pdc20621_interrupt: EXIT
[  373.233828] ata_port_flush_task: ENTER
[  373.233886] ata5: ata_port_flush_task: EXIT
[  373.233890] ata5.00: ata_dev_configure: cfg 49:2f00 82:7c6b 83:7b09 
84:4003 85:7c69 86:3a01 87:4003 88:087f
[  373.233894] ata_dump_id: 49==0x2f00  53==0x0007  63==0x0007 
64==0x0003  75==0x0000
[  373.233964] ata_dump_id: 80==0x00fe  81==0x001e  82==0x7c6b 
83==0x7b09  84==0x4003
[  373.234033] ata_dump_id: 88==0x087f  93==0x600b
[  373.234092] ata5.00: ATA-7: Maxtor 6Y080P0, YAR41BW0, max UDMA/133
[  373.234095] ata5.00: 160086528 sectors, multi 0: LBA
[  373.234105] ata5.00: ata_dev_configure: EXIT, drv_stat = 0x50
[  373.234110] ata_dev_set_xfermode: set features - xfer mode
[  373.234168] pdc20621_nodata_prep: ata5: ENTER
[  373.234226] pdc20621_ata_pkt: ENTER, dimm_sg == 0x200180, 2097536
[  373.234292] pdc20621_nodata_prep: ata pkt buf ofs 282, mmio copied
[  373.234351] pdc20621_packet_start: ata5: ENTER
[  373.234411] pdc20621_packet_start: submitted ofs 0x200100 (2097408), 
seq 1
[  373.234520] pdc20621_interrupt: ENTER
[  373.234577] pdc20621_interrupt: mask == 0x2
[  373.234634] pdc20621_interrupt: seq 1, port_no 0, ap de81c000, tmp 2
[  373.234694] pdc20621_interrupt: seq 2, port_no 1, ap de820000, tmp 0
[  373.234754] pdc20621_interrupt: seq 3, port_no 2, ap de824000, tmp 0
[  373.234813] pdc20621_interrupt: seq 4, port_no 3, ap de828000, tmp 0
[  373.234872] pdc20621_interrupt: seq 5, port_no 0, ap de81c000, tmp 0
[  373.234932] pdc20621_interrupt: seq 6, port_no 1, ap de820000, tmp 0
[  373.234991] pdc20621_interrupt: seq 7, port_no 2, ap de824000, tmp 0
[  373.235051] pdc20621_interrupt: seq 8, port_no 3, ap de828000, tmp 0
[  373.235110] pdc20621_interrupt: mask == 0x2
[  373.235166] pdc20621_interrupt: EXIT
Above stuff seems to happen a couple of times...
[  403.217240] ata_port_flush_task: ENTER
[  403.217301] ata5: ata_port_flush_task: EXIT
[  403.217313] ata5.00: qc timeout (cmd 0xef)
[  403.217316] ata_dev_set_xfermode: EXIT, err_mask=4
[  403.217375] ata5.00: failed to set xfermode (err_mask=0x4)
[  403.217434] ata5.00: disabled
It finally bombs... Same thing happens for all 4 ports...

While I do know my way around Linux, C and a debugger, I'm still pretty 
blank when it comes ATA stuff... So any tips on where to go from here 
would highly appreciated...

Some questions:

* I guess the soft lockups during DIMM init are suspicious... Is it
   possible that the driver got the memory map wrong? The detected
   64 MB is correct... The SX4060 BIOS lists this information:

	Installed Memory Address: FE800000 Size: 64M
	Controller IRQ: 11
	ATA IO Address: E000
	XOR and HDMA IO Address: ED00
	Sequence Control IO Address: EC00
	Flash and SRAM Memory Address: FE900000

    But I don't know how to relate this to what's in the driver
    source...

*  Is it a reasonable assumption that SX4060 support could be achieved
    with fairly small changes to the sata_sx4 driver? (I realize that
    knowing exactly /what/ changes are needed is an entirely different
    matter...)

  * Is there any point in contacting Promise about information on this
    device? Or would I just be wasting my time?

  * Is it a correct assumption that the sata_sx4 driver knows nothing the
    various array configurations and that it will always just see 4
    independent drives, regardless of what arrays have been configured in
    the BIOS?

  * Also, is there any (easy) way to choke debug output from some ATA
    devices, while keeping it for others? Apart from grep... :-)

  * Would there be any useful information to gather from running the card
    with the Promise drivers under Windows or a 2.4 kernel?

I'd be happy to put in some time and effort in moving this forward but I 
probably won't make much progress need some pointers from some ATA-gurus...

/Lasse



