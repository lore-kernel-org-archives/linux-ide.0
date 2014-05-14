From: Janet Estabridis <jpe1313@mchsi.com>
Subject: uClinux booting with 64GByte Swiss Bit Compact Flash irq 7: nobody
 cared (try booting with the "irqpoll" option)
Date: Wed, 14 May 2014 14:01:28 -0500 (CDT)
Message-ID: <181387481.4053491400094087936.JavaMail.root@dsmdc-mail-mbs11>
References: <1934070794.4053461400094082049.JavaMail.root@dsmdc-mail-mbs11>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_134999_1136913880.1400094087931"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-smtp02.mcomdc.com ([97.64.187.18]:5336 "EHLO
	dsmdc-mail-smtp.mcomdc.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752597AbaENTHN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 15:07:13 -0400
In-Reply-To: <1934070794.4053461400094082049.JavaMail.root@dsmdc-mail-mbs11>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

------=_Part_134999_1136913880.1400094087931
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I've been using compact flashes for years and they always boot nicely with uClinux. 

I've got a new compact flash that doesn't handle the interrupt on boot when given the ID Command.  I have found that with other cards, right after the EC command is sent the interrupts are enabled and everything is great.  But with this card, the interrupts never get turned on.  Is it a problem with the Compact Flash being out of spec? 

I'm enclosing the boot for the cards.

Thank you for your time.

Janet Estabridis


------=_Part_134999_1136913880.1400094087931
Content-Type: text/plain; name=DATA-FOR-libata-sff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=DATA-FOR-libata-sff

32 GBYTE SWISS BIT

scsi0 : pata_altera_cf
ata1: PATA max PIO4 mmio cmd 0x8000000 ctl 0x8000038 irq 7
ata1.00: CFA: SFCF32GBH1BO4TO-I-NC-543-SMA, 110301a, max UDMA/66
ata1.00: 64028160 sectors, multi 0: LBA 
scsi 0:0:0:0: Direct-Access     ATA      SFCF32GBH1BO4TO- 1103 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 64028160 512-byte hardware sectors: (32.7 GB/30.5 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk


64 GBYTE SWISS BIT

/> Uncompressing Linux... Ok, booting the kernel.
Linux version 2.6.30 (janet@localhost.localdomain) (gcc version 3.4.6) #4699 PREEMPT Fri May 2 09:55:59 PDT 2014


uClinux/Nios II
Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 32512
Kernel command line: 
NR_IRQS:32
PID hash table entries: 512 (order: 9, 2048 bytes)
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory available: 128012k/1920k RAM, 0k/0k ROM (1177k kernel code, 743k data)
Calibrating delay loop... 49.45 BogoMIPS (lpj=247296)
Mount-cache hash table entries: 512
init_BSP(): registering device resources
bio: create slab <bio-0> at 0
SCSI subsystem initialized
io scheduler noop registered
io scheduler deadline registered (default)
ttyS0 at MMIO 0x8000060 (irq = 9) is a Altera UART
console [ttyS0] enabled
Driver 'sd' needs updating - please use bus_type methods
Freeing unused kernel memory: 504k freed (0x162000 - 0x1df000)
Shell invoked to run file: /etc/rc
Command: hostname uClinux
hostname: applet not found
Command: mount -t proc proc /proc -o noexec,nosuid,nodev
Command: mount -t sysfs sysfs /sys -o noexec,nosuid,nodev
Command: mount -t devpts devpts /dev/pts -o noexec,nosuid
Command: cd /dev
Command: mknod aim9x0 c 241 0
Command: sleep 1
scsi0 : pata_altera_cf
ata1: PATA max PIO4 mmio cmd 0x8000000 ctl 0x8000038 irq 7
irq 7: nobody cared (try booting with the "irqpoll" option)
Stack from 00343db0:<0>
       <0> 00000000<0> 00040084<0> 0015bb04<0> 0004028c<0> 0003e840<0> 00153284<0> 0000000a<0> 00000007<0>
       <0> 003408e0<0> ffffe000<0> 0015bb04<0> 00041154<0> 000000ff<0> 00343ea8<0> 0015d640<0> 00000007<0>
       <0> 000014fc<0> 00000000<0> 0015d640<0> 00000002<0> 00000a24<0> 00000001<0> 00326510<0> 00000000<0>
       <0> 3b9356f8<0> 00000000<0> 0015a540<0> 0000004c<0> 41b69800<0> 00000001<0> ffffe000<0> 00000101<0>
       <0> 00342000<0> 00342000<0> 00000001<0> 00000000<0> ffffffff<0> 00017274<0> deadbeef<0> 00343e60<0>
       <0> deadbeef<0> 00000001<0> 00000001<0> 000170f8<0> 0015a228<0> 0003e840<0> 08001854<0> 00332568<0>
Call Trace:<0>
       <0> [<000000ff>]<0> [<00000000>]<0> [<00000000>]<0> [<00017274>]<0>
       <0> [<00000001>]<0> [<000175dc>]<0> [<00001500>]<0> [<00004a38>]<0>
       <0> [<00000005>]<0> [<00000a24>]<0> [<00000001>]<0> [<00000000>]<0>
       <0> [<00000000>]<0> [<00000000>]<0> [<00000000>]<0> [<000000f7>]<0>
       <0> [<00000000>]<0> [<00024ec0>]<0> [<00000001>]<0> [<00000001>]<0>
       <0> [<0011fe00>]<0> [<0011fdb0>]<0> [<00024ec0>]<0> [<00000000>]<0>
       <0> [<0002a538>]<0> [<00000000>]<0> [<0002a538>]<0> [<00000001>]<0>
       <0> [<00024d04>]<0> [<00029b00>]<0> [<00001e18>]<0> [<000096cc>]<0>
       <0> [<00000b64>]<0> [<00000001>]<0> [<00029a68>]<0> [<00000000>]<0>
       <0> [<00000000>]<0> [<00000000>]<0> [<00000001>]<0> [<00000711>]<0>
       <0> [<00000711>]<0> [<00000000>]<0> [<00000000>]<0> [<00029f4c>]<0>
       <0> [<00000001>]<0> [<00000001>]<0> [<00001e08>]<0>
handlers:
[<001204c4>]
Disabling IRQ #7
Command: cat /etc/motd
Welcome to
          ____ _  _
         /  __| ||_|                 
    _   _| |  | | _ ____  _   _  _  _ 
   | | | | |  | || |  _ \| | | |\ \/ /
   | |_| | |__| || | | | | |_| |/    \
   |  ___\____|_||_|_| |_|\____|\_/\_/
   | |
   |_|

For further information check:
http://www.uclinux.org/

Execution Finished, Exiting

Sash command shell (version 1.1.1)
/> ata1.00: CFA: SFCF64GBH2BU4TO-I-NU-517-L28, 120504, max UDMA/133
ata1.00: 125313024 sectors, multi 0: LBA 
scsi 0:0:0:0: Direct-Access     ATA      SFCF64GBH2BU4TO- 1205 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 125313024 512-byte hardware sectors: (64.1 GB/59.7 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda:<4>ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: limiting speed to UDMA7:PIO5
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: limiting speed to PIO0
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00 
sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: EH complete
INFO: task ata_aux:10 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
ata_aux       D 00001e08     0    10      2
Stack from 00345c28:<0>
       <0> 00326040<0> ffffe000<0> 0015a514<0> 003261d0<0> 00000000<0> 00345cb8<0> 00000000<0> 00000000<0>
       <0> 00345c54<0> deadbeef<0> 00122ee4<0> 00000002<0> 00345d04<0> 7fffffff<0> ffffe000<0> 00345c6c<0>
       <0> 00122bf8<0> 7fffffff<0> 00345cac<0> 00123c4c<0> 00000000<0> 0040f6a8<0> 001bba80<0> 001bb988<0>
       <0> 00000001<0> ffffe000<0> 00198ebc<0> 00000000<0> 00000002<0> 00345d04<0> 7fffffff<0> ffffe000<0>
       <0> 00123308<0> 00000001<0> 00326040<0> 0000b33c<0> 00345d08<0> 00345d08<0> 00000000<0> 00326040<0>
       <0> 0000b33c<0> 00000000<0> 00000000<0> 00345d10<0> 00000000<0> 00345d04<0> 001bb988<0> 00000000<0>
Call Trace:<0>
       <0> [<00000001>]<0> [<00123430>]<0> [<00000020>]<0> [<000c7240>]<0>
       <0> [<000c703c>]<0> [<00000000>]<0> [<00000001>]<0> [<00000000>]<0>
       <0> [<00000000>]<0> [<00000020>]<0> [<00000010>]<0> [<00000020>]<0>
       <0> [<00000010>]<0> [<00000000>]<0> [<00000000>]<0> [<0008e390>]<0>
       <0> [<000c3868>]<0> [<00000020>]<0> [<00000010>]<0> [<000feaa0>]<0>
       <0> [<00000010>]<0> [<00000005>]<0> [<00000000>]<0> [<00000002>]<0>
       <0> [<000febb0>]<0> [<00000020>]<0> [<00000bb8>]<0> [<00000005>]<0>
       <0> [<00000000>]<0> [<00000000>]<0> [<000c286c>]<0> [<00000000>]<0>
       <0> [<00000003>]<0> [<00109790>]<0> [<00000020>]<0> [<00000bb8>]<0>
       <0> [<00000005>]<0> [<00000000>]<0> [<0000109e>]<0> [<00000000>]<0>
       <0> [<00000000>]<0> [<00002000>]<0> [<00000000>]<0> [<00000000>]<0>
       <0> [<00000000>]<0> [<00000000>]<0> [<00000000>]<0> [<00000000>]<0>
       <0> [<00109c1c>]<0> [<00000000>]<0> [<00000bb8>]<0> [<00000005>]<0>
       <0> [<00000000>]<0> [<00000000>]<0> [<00000000>]<0> [<00000000>]<0>
       <0> [<00000000>]<0> [<00000001>]<0> [<00000001>]<0> [<00000000>]<0>
       <0> [<00000001>]<0> [<000922ac>]<0> [<00000001>]<0> [<00107fc8>]<0>
       <0> [<00103834>]<0> [<00117f1c>]<0> [<00117dac>]<0> [<00024ec0>]<0>
       <0> [<00000000>]<0> [<0002a538>]<0> [<00000000>]<0> [<0002a538>]<0>
       <0> [<00000001>]<0> [<00024d04>]<0> [<00029b00>]<0> [<00001e18>]<0>
       <0> [<000096cc>]<0> [<00000b64>]<0> [<00000001>]<0> [<00029a68>]<0>
       <0> [<00000000>]<0> [<00000000>]<0> [<00000000>]<0> [<00000001>]<0>
       <0> [<00000711>]<0> [<00000711>]<0> [<00000000>]<0> [<00000000>]<0>
       <0> [<00029f4c>]<0> [<00000001>]<0> [<00000001>]<0> [<00001e08>]<0>
INFO: task async/0:23 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
async/0       D 00001e08     0    23      2
Stack from 0016dd28:<0>
       <0> 00418680<0> ffffe000<0> 0015a514<0> 00418810<0> 00000002<0> 00042c88<0> 0015ce78<0> 00167020<0>
       <0> 0016dd54<0> deadbeef<0> 00122ee4<0> 002e52c8<0> 0016ddb0<0> 00000001<0> ffffe000<0> 0016dd6c<0>
       <0> 00122bf8<0> 0015a8fc<0> 0016dd78<0> 0012394c<0> 00000000<0> 0016dda8<0> 0015ce78<0> 00042cd0<0>
       <0> 00123dd4<0> 00000000<0> 00167000<0> 00167000<0> 00310c60<0> 0016ddfc<0> 001e87c0<0> 000432e4<0>
       <0> 001e87c0<0> 00000000<0> 00000000<0> 00418680<0> 0002a57c<0> 002e52c8<0> 002e52c8<0> 001e87c0<0>
       <0> 00000000<0> 00000000<0> 00418680<0> 0002a57c<0> 0016ddbc<0> 0016ddbc<0> 0004521c<0> 00000000<0>
Call Trace:<0>
       <0> [<000aaf30>]<0> [<00000000>]<0> [<000ab0fc>]<0> [<00000001>]<0>
       <0> [<00000024>]<0> [<00000000>]<0> [<00000001>]<0> [<00000000>]<0>
       <0> [<00000001>]<0> [<00000000>]<0> [<00000000>]<0> [<00000000>]<0>
       <0> [<000aad44>]<0> [<00000000>]<0> [<00000001>]<0> [<00000002>]<0>
       <0> [<000ce098>]<0> [<00000000>]<0> [<00000000>]<0> [<00000001>]<0>
       <0> [<00000001>]<0> [<00000000>]<0> [<00091a60>]<0> [<00000000>]<0>
       <0> [<00000001>]<0> [<00000000>]<0> [<00000001>]<0> [<00091ae8>]<0>
       <0> [<000aab14>]<0> [<000c9900>]<0> [<000ca608>]<0> [<0010ae90>]<0>
       <0> [<00000000>]<0> [<00000000>]<0> [<00031ecc>]<0> [<00000000>]<0>
       <0> [<0000b33c>]<0> [<00000000>]<0> [<0000b33c>]<0> [<00000000>]<0>
       <0> [<00000000>]<0> [<00000000>]<0> [<00031d10>]<0> [<00029b00>]<0>
       <0> [<00001e18>]<0> [<000096cc>]<0> [<00000b64>]<0> [<00000001>]<0>
       <0> [<00029a68>]<0> [<00000000>]<0> [<00000000>]<0> [<00000000>]<0>
       <0> [<00000001>]<0> [<00000711>]<0> [<00000711>]<0> [<00000000>]<0>
       <0> [<00000000>]<0> [<00029f4c>]<0> [<00000001>]<0> [<00000001>]<0>
       <0> [<00001e08>]<0>
ata1: lost interrupt (Status 0x58)
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.00: cmd 20/00:08:00:00:00/00:00:00:00:00/e0 tag 0 pio 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
sd 0:0:0:0: [sda] Result: hostbyte=0x00 driverbyte=0x08
sd 0:0:0:0: [sda] Sense Key : 0xb [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00 
sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x0
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
 unable to read partition table
sd 0:0:0:0: [sda] Attached SCSI disk
ata1: EH complete
sda: detected capacity change from 0 to 64160268288
sda: detected capacity change from 0 to 64160268288
/> 

------=_Part_134999_1136913880.1400094087931--
