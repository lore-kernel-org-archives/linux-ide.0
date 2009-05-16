From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: Re: [PATCH] sata_sx4: speed up ECC initialization
Date: Sat, 16 May 2009 17:29:12 +0400
Message-ID: <20090516132912.GA23272@orion>
References: <1239675982-32584-1-git-send-email-a.beregalov@gmail.com> <49E47A45.60902@garzik.org> <20090414200054.GB17134@orion> <49E4F047.3030500@garzik.org> <a4423d670904141351o72c4c0acka87a00360f1a53eb@mail.gmail.com> <4A0E5D5F.1080708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:43978 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847AbZEPN3T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 May 2009 09:29:19 -0400
Received: by bwz22 with SMTP id 22so2376966bwz.37
        for <linux-ide@vger.kernel.org>; Sat, 16 May 2009 06:29:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A0E5D5F.1080708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Sat, May 16, 2009 at 02:29:51AM -0400, Jeff Garzik wrote:
> Check out 2.6.30-rc6, sata_sx4 received several major bug fixes...

Thanks, but it still does not work.


bus: 'pci': add driver sata_sx4
bus: 'pci': driver_probe_device: matched device 0000:02:04.0 with driver sata_sx4
bus: 'pci': really_probe: probing driver sata_sx4 with device 0000:02:04.0
sata_sx4 0000:02:04.0: version 0.12
PCI: Enabling device: (0000:02:04.0), cmd 3
pdc20621_dimm_init: Time Period Register (0x40): 0xffffffff
pdc20621_dimm_init: Time Counter Register (0x44): 0xf71a3f65
pdc20621_dimm_init: Num counters 0x8e5c09a (149274778)
pdc20621_dimm_init: 10 * Internal clk = 0x1f1 (497)
pdc20621_dimm_init: 10 * Internal clk * 33 = 0x4011 (16401)
pdc20621_dimm_init: PLL F Param: 0x53 (83)
pdc20621_dimm_init: pci_status: 0x8a531824
pdc20621_dimm_init: Local DIMM Speed = 100
pdc20621_dimm_init: Local DIMM Size = 512MB
Local DIMM ECC Enabled
ff, 0, 
ff, 0, 
ff, 0, 
pdc20621_dimm_init: Start ECC initialization
pdc20621_dimm_init: Finish ECC initialization
sata_sx4 0000:02:04.0: enabling bus mastering
pdc20621_interrupt: ENTER
pdc20621_interrupt: mask == 0x0
pdc20621_interrupt: QUICK EXIT 3
scsi2 : sata_sx4
device: 'host2': device_add
bus: 'scsi': add device host2
device: 'host2': device_add
scsi3 : sata_sx4
device: 'host3': device_add
bus: 'scsi': add device host3
device: 'host3': device_add
scsi4 : sata_sx4
device: 'host4': device_add
bus: 'scsi': add device host4
device: 'host4': device_add
scsi5 : sata_sx4
device: 'host5': device_add
bus: 'scsi': add device host5
device: 'host5': device_add
ata3: PATA max UDMA/133 mmio m1048576@0x1ff00300000 dimm m32768@0x1ff00400000 port 0x1ff00300200 irq 16
ata4: PATA max UDMA/133 mmio m1048576@0x1ff00300000 dimm m32768@0x1ff00400000 port 0x1ff00300280 irq 16
ata5: PATA max UDMA/133 mmio m1048576@0x1ff00300000 dimm m32768@0x1ff00400000 port 0x1ff00300300 irq 16
ata6: PATA max UDMA/133 mmio m1048576@0x1ff00300000 dimm m32768@0x1ff00400000 port 0x1ff00300380 irq 16
driver: '0000:02:04.0': driver_bound: bound to device 'sata_sx4'
bus: 'pci': really_probe: bound device 0000:02:04.0 to driver sata_sx4
ata3.00: ATA-5: ST320414A, 3.28, max UDMA/100
ata3.00: 39851760 sectors, multi 0: LBA 
pdc20621_nodata_prep: ata3: ENTER
pdc20621_ata_pkt: ENTER, dimm_sg == 0x200180, 2097536
pdc20621_nodata_prep: ata pkt buf ofs 282, mmio copied
ata3.00: configured for UDMA/100
scsi 2:0:0:0: Direct-Access     ATA      ST320414A        3.28 PQ: 0 ANSI: 5
device: 'target2:0:0': device_add
bus: 'scsi': add device target2:0:0
device: '2:0:0:0': device_add
bus: 'scsi': add device 2:0:0:0
bus: 'scsi': driver_probe_device: matched device 2:0:0:0 with driver sd
bus: 'scsi': really_probe: probing driver sd with device 2:0:0:0
driver: '2:0:0:0': driver_bound: bound to device 'sd'
bus: 'scsi': really_probe: bound device 2:0:0:0 to driver sd
device: '2:0:0:0': device_add
device: 'sg1': device_add
sd 2:0:0:0: Attached scsi generic sg1 type 0
device: '2:0:0:0': device_add
sd 2:0:0:0: [sdb] 39851760 512-byte hardware sectors: (20.4 GB/19.0 GiB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
device: 'sdb': device_add
 sdb:<3>pdc20621_dma_prep: ata3: ENTER
pdc20621_host_sg: HOST PSG @ 200080 == (0x2100, 0x200080)
pdc20621_host_pkt: ENTER, dimm_sg == 0x200080, 2097280
pdc20621_host_pkt: host_sg == 0x201800, 2103296
pdc20621_host_pkt: HOST PKT @ 200000 == (0x40005ff 0x182000 0x80002000 0x0)
pdc20621_ata_sg: ATA sg addr 0x210000, 2162688
pdc20621_ata_sg: ATA PSG @ 200180 == (0x2100, 0x200080)
pdc20621_ata_pkt: ENTER, dimm_sg == 0x200180, 2097536
pdc20621_dma_prep: ata pkt buf ofs 282, prd size 8, mmio copied
pdc20621_packet_start: ata3: ENTER
pdc20621_packet_start: submitted ofs 0x200100 (2097408), seq 1
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata3.00: cmd c8/00:10:00:00:00/00:00:00:00:00/e0 tag 0 dma 8192 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.00: status: { DRDY }
ata3: soft resetting link
pdc20621_nodata_prep: ata3: ENTER
pdc20621_ata_pkt: ENTER, dimm_sg == 0x200180, 2097536
pdc20621_nodata_prep: ata pkt buf ofs 282, mmio copied
ata3.00: configured for UDMA/100
ata3: EH complete
pdc20621_dma_prep: ata3: ENTER
pdc20621_host_sg: HOST PSG @ 200080 == (0x2100, 0x200080)
pdc20621_host_pkt: ENTER, dimm_sg == 0x200080, 2097280
pdc20621_host_pkt: host_sg == 0x201800, 2103296
pdc20621_host_pkt: HOST PKT @ 200000 == (0x40005ff 0x182000 0x80002000 0x0)
pdc20621_ata_sg: ATA sg addr 0x210000, 2162688
pdc20621_ata_sg: ATA PSG @ 200180 == (0x2100, 0x200080)
pdc20621_ata_pkt: ENTER, dimm_sg == 0x200180, 2097536
pdc20621_dma_prep: ata pkt buf ofs 282, prd size 8, mmio copied
pdc20621_packet_start: ata3: ENTER
pdc20621_packet_start: submitted ofs 0x200100 (2097408), seq 1
ata3.00: limiting speed to UDMA/66:PIO4
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata3.00: cmd c8/00:10:00:00:00/00:00:00:00:00/e0 tag 0 dma 8192 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.00: status: { DRDY }
ata3: soft resetting link
