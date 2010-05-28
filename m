From: Tim Small <tim@seoss.co.uk>
Subject: Forcing a an Intel ICH8 into AHCI mode after boot - success
Date: Fri, 28 May 2010 16:58:11 +0100
Message-ID: <4BFFE813.5030000@seoss.co.uk>
References: <4BBAE866.4060903@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4BBAE866.4060903@seoss.co.uk>
Sender: linux-pci-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

I tried to get a Dell PE R300 (ICH9R) working in AHCI mode a few weeks 
ago - there is no AHCI mode option in the BIOS.

In case anyone is trying the same thing - I just tried the same method 
on an Abit IB9 (Intel ICH8 - also lacking AHCI BIOS support), and it 
worked (see below).  I'll try coding this up as a PCI quirk (defaulting 
to off)...

> setpci -s 00:1f.2 0x90.w=0x0060
> modprobe fakephp
> echo 1>  /sys/bus/pci/slots/0000\:00\:1f.0/power
> echo 1>  /sys/bus/pci/slots/0000\:00\:1f.2/power
> echo 1>  /sys/bus/pci/slots/0000\:00\:1f.5/power
> echo 0>  /sys/bus/pci/slots/0000\:00\:1f.2/power
> echo 1>  /sys/bus/pci/slots/0000\:00\:1f.2/power
> echo 1>  /sys/bus/pci/slots/0000\:00\:1f.0/power
> echo 1>  /sys/bus/pci/slots/0000\:00\:1f.5/power
> modprobe ahci
>    


This time I got.

[  244.592159] pci 0000:00:1f.2: reg 10 io port: [0xfa00-0xfa07]
[  244.592165] pci 0000:00:1f.2: reg 14 io port: [0xf900-0xf903]
[  244.592169] pci 0000:00:1f.2: reg 18 io port: [0xf800-0xf807]
[  244.592174] pci 0000:00:1f.2: reg 1c io port: [0xf700-0xf703]
[  244.592179] pci 0000:00:1f.2: reg 20 io port: [0xf600-0xf61f]
[  244.592184] pci 0000:00:1f.2: reg 24 32bit mmio: [0x00f000-0x00f7ff]
[  244.592208] pci 0000:00:1f.2: PME# supported from D3hot
[  244.592244] pci 0000:00:1f.2: PME# disabled
[  244.640044] ahci 0000:00:1f.2: version 3.0
[  244.640061] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[  244.640145]   alloc irq_desc for 26 on node -1
[  244.640147]   alloc kstat_irqs on node -1
[  244.640156] ahci 0000:00:1f.2: irq 26 for MSI/MSI-X
[  244.640164] ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
[  244.640214] ahci: SSS flag set, parallel bus scan disabled
[  244.640267] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 
0xf impl SATA mode
[  244.640304] ahci 0000:00:1f.2: flags: 64bit ncq sntf ilck stag pm led 
clo pmp pio slum part ccc ems
[  244.640343] ahci 0000:00:1f.2: setting latency timer to 64
[  244.656102] scsi6 : ahci
[  244.656193] scsi7 : ahci
[  244.656269] scsi8 : ahci
[  244.656347] scsi9 : ahci
[  244.656488] ata7: SATA max UDMA/133 abar m2048@0xf0000000 port 
0xf0000100 irq 26
[  244.656525] ata8: SATA max UDMA/133 abar m2048@0xf0000000 port 
0xf0000180 irq 26
[  244.656561] ata9: SATA max UDMA/133 abar m2048@0xf0000000 port 
0xf0000200 irq 26
[  244.656598] ata10: SATA max UDMA/133 abar m2048@0xf0000000 port 
0xf0000280 irq 26
[  244.976013] ata7: SATA link down (SStatus 0 SControl 300)
[  245.312012] ata8: SATA link down (SStatus 0 SControl 300)
[  246.356006] ata9: failed to resume link (SControl 0)
[  246.356046] ata9: SATA link down (SStatus 0 SControl 0)
[  247.400006] ata10: failed to resume link (SControl 0)
[  247.400046] ata10: SATA link down (SStatus 0 SControl 0)
[  434.987580] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4000000 action 
0xe frozen
[  434.987629] ata7: irq_stat 0x00000040, connection status changed
[  434.987662] ata7: SError: { DevExch }
[  434.987697] ata7: hard resetting link
[  445.000006] ata7: softreset failed (device not ready)
[  445.000040] ata7: hard resetting link
[  445.888011] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  445.919259] ata7.00: ATA-7: ST3500641AS, 3.AAD, max UDMA/133
[  445.919294] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  445.985918] ata7.00: configured for UDMA/133
[  445.985959] ata7: EH complete
[  446.804096] scsi 6:0:0:0: Direct-Access     ATA      ST3500641AS      
3.AA PQ: 0 ANSI: 5
[  446.890857] sd 6:0:0:0: [sda] 976773168 512-byte logical blocks: (500 
GB/465 GiB)
[  446.890941] sd 6:0:0:0: [sda] Write Protect is off
[  446.890975] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  446.890994] sd 6:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[  446.891149]  sda: sda1 sda2
[  446.909372] sd 6:0:0:0: [sda] Attached SCSI disk


(sid-netboot)root@netboot:~# hdparm -t /dev/sda

/dev/sda:
  Timing buffered disk reads:  182 MB in  3.03 seconds =  60.00 MB/sec

(sid-netboot)root@netboot:~# uname -a
Linux netboot 2.6.32-5-amd64 #1 SMP Mon May 17 17:51:57 UTC 2010 x86_64 
GNU/Linux



-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309
