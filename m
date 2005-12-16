From: Jean-Pierre Turchi <jpturchi@mageos.com>
Subject: Strange behaviour of IDE driver with bad disk.
Date: Fri, 16 Dec 2005 11:44:51 +0100
Message-ID: <000501c6022d$e0a79220$0200a8c0@laprod>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:10484 "EHLO sMtp.neuf.fr")
	by vger.kernel.org with ESMTP id S1750939AbVLPKuU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Dec 2005 05:50:20 -0500
Received: from laprod ([84.7.247.172]) by sp604002mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-4.03 (built Sep 22 2005))
 with SMTP id <0IRL00JVS79JVRY2@sp604002mt.gpm.neuf.ld> for
 linux-ide@vger.kernel.org; Fri, 16 Dec 2005 11:46:41 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, andre@linux-ide.org

Hi !

I don't know if it's a bug, so that's why I don't use a "regular" maili=
ng-list.
Anyway, it's a strange and dangerous story :

On a testing machine (2.4 GHz Celeron 256 Mb one year old, Debian based=
 kernel 2.6.14.3), a fews days ago I wanted to check an old
Samsung 3.4 Gb.
So I installed it in a removable rack connected to hdd, and powered up =
the box :
(edited "/var/log/messages" - hostname is "legris")

Dec 10 22:12:45 legris kernel: [   23.419620] Uniform Multi-Platform E-=
IDE driver Revision: 7.00alpha2
Dec 10 22:12:45 legris kernel: [   23.419733] ide: Assuming 33MHz syste=
m bus speed for PIO modes; override with idebus=3Dxx
Dec 10 22:12:45 legris kernel: [   23.419922] ICH4: IDE controller at P=
CI slot 0000:00:1f.1
Dec 10 22:12:45 legris kernel: [   23.420050] ACPI: PCI Interrupt 0000:=
00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
Dec 10 22:12:45 legris kernel: [   23.420209] ICH4: chipset revision 2
Dec 10 22:12:45 legris kernel: [   23.424896] ICH4: not 100%% native mo=
de: will probe irqs later
Dec 10 22:12:45 legris kernel: [   23.429594]     ide0: BM-DMA at 0xf00=
0-0xf007, BIOS settings: hda:DMA, hdb:DMA
Dec 10 22:12:45 legris kernel: [   23.434384]     ide1: BM-DMA at 0xf00=
8-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Dec 10 22:12:45 legris kernel: [   23.439078] Probing IDE interface ide=
0...
Dec 10 22:12:45 legris kernel: [   23.725563] hda: IC35L060AVV207-0, AT=
A DISK drive
Dec 10 22:12:45 legris kernel: [   24.009112] hdb: IC35L060AVV207-0, AT=
A DISK drive
Dec 10 22:12:45 legris kernel: [   24.069721] ide0 at 0x1f0-0x1f7,0x3f6=
 on irq 14
Dec 10 22:12:45 legris kernel: [   24.074540] Probing IDE interface ide=
1...
Dec 10 22:12:45 legris kernel: [   24.807842] hdc: DVD-RW IDE1008, ATAP=
I CD/DVD-ROM drive
Dec 10 22:12:45 legris kernel: [   25.091393] hdd: SAMSUNG VG33402A (3.=
40GB), ATA DISK drive
Dec 10 22:12:45 legris kernel: [   25.151495] ide1 at 0x170-0x177,0x376=
 on irq 15
Dec 10 22:12:45 legris kernel: [   27.125606] hda: max request size: 10=
24KiB
Dec 10 22:12:45 legris kernel: [   27.151810] hda: 78125000 sectors (40=
000 MB) w/1821KiB Cache, CHS=3D16383/255/63, UDMA(100)
Dec 10 22:12:45 legris kernel: [   27.157309] hda: cache flushes suppor=
ted
Dec 10 22:12:45 legris kernel: [   27.162343]  hda: hda1 hda2 hda3 hda4=
 < hda5 hda6 hda7 >
Dec 10 22:12:45 legris kernel: [   27.228721] hdb: max request size: 10=
24KiB
Dec 10 22:12:45 legris kernel: [   27.254864] hdb: 78125000 sectors (40=
000 MB) w/1821KiB Cache, CHS=3D16383/255/63, UDMA(100)
Dec 10 22:12:45 legris kernel: [   27.260421] hdb: cache flushes suppor=
ted
Dec 10 22:12:45 legris kernel: [   27.265537]  hdb: hdb1 hdb2 < hdb5 >
Dec 10 22:12:45 legris kernel: [   27.297464] hdd: max request size: 12=
8KiB
Dec 10 22:12:45 legris kernel: [   27.302517] hdd: 6643728 sectors (340=
1 MB) w/112KiB Cache, CHS=3D6591/16/63, UDMA(33)
Dec 10 22:12:45 legris kernel: [   27.307826] hdd: cache flushes not su=
pported
Dec 10 22:12:45 legris kernel: [   27.313118]  hdd: hdd1
Dec 10 22:12:45 legris kernel: [   27.450269] hdc: ATAPI 40X DVD-ROM DV=
D-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Dec 10 22:12:45 legris kernel: [   27.455915] Uniform CD-ROM driver Rev=
ision: 3.20


Everything was fine, so, I issued "badblocks -s -n /dev/hdd", and, near=
 the two thirds of the disk, I got, on my screen :

Dec 10 23:08:26 legris kernel: [ 3372.933122] hdd: dma_intr: status=3D0=
x51 { DriveReady SeekComplete Error }
Dec 10 23:08:26 legris kernel: [ 3372.935603] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307280
Dec 10 23:08:26 legris kernel: [ 3372.938191] ide: failed opcode was: u=
nknown
Dec 10 23:08:26 legris kernel: [ 3372.940730] end_request: I/O error, d=
ev hdd, sector 3307280
Dec 10 23:08:26 legris kernel: [ 3372.943295] Buffer I/O error on devic=
e hdd, logical block 413410
(edited: removed identical lines)
Dec 10 23:08:27 legris kernel: [ 3373.712030] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307288
Dec 10 23:08:27 legris kernel: [ 3373.720771] Buffer I/O error on devic=
e hdd, logical block 413411

Dec 10 23:08:28 legris kernel: [ 3374.488842] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307296
Dec 10 23:08:28 legris kernel: [ 3374.499124] Buffer I/O error on devic=
e hdd, logical block 413412

Dec 10 23:08:29 legris kernel: [ 3375.265639] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307304
Dec 10 23:08:29 legris kernel: [ 3375.277571] Buffer I/O error on devic=
e hdd, logical block 413413

Dec 10 23:08:29 legris kernel: [ 3376.042260] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307312
Dec 10 23:08:29 legris kernel: [ 3376.055984] Buffer I/O error on devic=
e hdd, logical block 413414

Dec 10 23:08:30 legris kernel: [ 3376.819032] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307320
Dec 10 23:08:30 legris kernel: [ 3376.833421] Buffer I/O error on devic=
e hdd, logical block 413415

Dec 10 23:08:31 legris kernel: [ 3377.595403] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307328
Dec 10 23:08:31 legris kernel: [ 3377.610164] Buffer I/O error on devic=
e hdd, logical block 413416

Dec 10 23:08:32 legris kernel: [ 3378.371920] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307336
Dec 10 23:08:32 legris kernel: [ 3378.388110] Buffer I/O error on devic=
e hdd, logical block 413417

Dec 10 23:08:33 legris kernel: [ 3379.159652] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307344
Dec 10 23:08:33 legris kernel: [ 3379.177427] Buffer I/O error on devic=
e hdd, logical block 413418

Dec 10 23:08:33 legris kernel: [ 3379.947769] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307352
Dec 10 23:08:33 legris kernel: [ 3379.967191] Buffer I/O error on devic=
e hdd, logical block 413419

Dec 10 23:08:34 legris kernel: [ 3380.735569] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307360
Dec 10 23:08:34 legris kernel: [ 3380.756616] Buffer I/O error on devic=
e hdd, logical block 413420

Dec 10 23:08:35 legris kernel: [ 3381.523187] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307368
Dec 10 23:08:35 legris kernel: [ 3381.537912] end_request: I/O error, d=
ev hdd, sector 3307368

Dec 10 23:08:36 legris kernel: [ 3382.310886] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307376
Dec 10 23:08:36 legris kernel: [ 3382.325946] end_request: I/O error, d=
ev hdd, sector 3307376

Dec 10 23:08:37 legris kernel: [ 3383.098338] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307384
Dec 10 23:08:37 legris kernel: [ 3383.113113] end_request: I/O error, d=
ev hdd, sector 3307384

Dec 10 23:08:37 legris kernel: [ 3383.120504] printk: 2 messages suppre=
ssed.

Dec 10 23:08:37 legris kernel: [ 3383.127971] Buffer I/O error on devic=
e hdd, logical block 413423

Dec 10 23:08:37 legris kernel: [ 3383.896519] hdd: dma_intr: error=3D0x=
40 { UncorrectableError }, LBAsect=3D3307399, sector=3D3307392
Dec 10 23:08:37 legris kernel: [ 3383.911264] end_request: I/O error, d=
ev hdd, sector 3307392


Stopped badblocks with CTRL-C.

Coz I had experimented a similar problem near the end of an IBM 40 Gb s=
ome days ago, problem cured with "-w" (write-destroy) option
of balblocks, I then entered "badblocks -s -w /dev/hdd" and, near the t=
wo thirds of the disk, a lot of kernel ide error messages
flooded my console, at the speed of the light !
Unable to enter CTRL-C nor CTRL-S, unable to change console using Alt-F=
x, unable to change state of Numlock key, led always on...
Unable to recover the hand, unable to do anything, and the console floo=
ded, flooded...

After 12 minutes of CTRL-C and Alt-Fx, I decided to extract the drive.
So I did and hopefully badblocks ended.
I started to look at /var/log/messages but was flooded again, after 30 =
seconds of reading.
But others consoles were now alive, so I quickly entered "halt<ENTER>" =
;-) !

Below are the logs (edited for clarity) :

Dec 10 23:15:46 legris kernel: [ 3811.415184] hdd: dma_intr: status=3D0=
x51 { DriveReady SeekComplete Error }
Dec 10 23:15:46 legris kernel: [ 3811.417447] hdd: dma_intr: error=3D0x=
10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:15:46 legris kernel: [ 3811.419882] ide: failed opcode was: u=
nknown

Dec 10 23:15:46 legris kernel: [ 3811.422435] hdd: dma_intr: status=3D0=
x51 { DriveReady SeekComplete Error }
Dec 10 23:15:46 legris kernel: [ 3811.424999] hdd: dma_intr: error=3D0x=
10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:15:46 legris kernel: [ 3811.427596] ide: failed opcode was: u=
nknown

Dec 10 23:15:46 legris kernel: [ 3811.430262] hdd: recal_intr: status=3D=
0x51 { DriveReady SeekComplete Error }
Dec 10 23:15:46 legris kernel: [ 3811.432763] hdd: recal_intr: error=3D=
0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:15:46 legris kernel: [ 3811.435196] ide: failed opcode was: u=
nknown

Dec 10 23:15:46 legris kernel: [ 3811.437840] hdd: dma_intr: status=3D0=
x51 { DriveReady SeekComplete Error }
Dec 10 23:15:46 legris kernel: [ 3811.440460] hdd: dma_intr: error=3D0x=
10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:15:46 legris kernel: [ 3811.443147] ide: failed opcode was: u=
nknown

Dec 10 23:15:46 legris kernel: [ 3811.445768] hdc: DMA disabled <<< hdc=
 ???
Dec 10 23:15:46 legris kernel: [ 3811.448367] hdd: DMA disabled
Dec 10 23:15:46 legris kernel: [ 3811.490927] ide1: reset: success

Dec 10 23:15:48 legris kernel: [ 3813.430160] hdd: set_geometry_intr: s=
tatus=3D0x51 { DriveReady SeekComplete Error }
Dec 10 23:15:48 legris kernel: [ 3813.432894] hdd: set_geometry_intr: e=
rror=3D0x10 { SectorIdNotFound }, LBAsect=3D5003631,
sector=3D5003776
Dec 10 23:15:48 legris kernel: [ 3813.435894] ide: failed opcode was: u=
nknown

Dec 10 23:15:48 legris kernel: [ 3813.438984] hdd: recal_intr: status=3D=
0x51 { DriveReady SeekComplete Error }
Dec 10 23:15:48 legris kernel: [ 3813.442249] hdd: recal_intr: error=3D=
0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:15:48 legris kernel: [ 3813.445676] ide: failed opcode was: u=
nknown

Dec 10 23:15:48 legris kernel: [ 3813.449135] hdd: recal_intr: status=3D=
0x51 { DriveReady SeekComplete Error }
Dec 10 23:15:48 legris kernel: [ 3813.452778] hdd: recal_intr: error=3D=
0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:15:48 legris kernel: [ 3813.456543] ide: failed opcode was: u=
nknown

Dec 10 23:15:48 legris kernel: [ 3813.460668] hdd: task_out_intr: statu=
s=3D0x51 { DriveReady SeekComplete Error }
Dec 10 23:15:48 legris kernel: [ 3813.464565] hdd: task_out_intr: error=
=3D0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:15:48 legris kernel: [ 3813.468735] ide: failed opcode was: u=
nknown
Dec 10 23:15:48 legris kernel: [ 3813.473143] hdd: task_out_intr: statu=
s=3D0x51 { DriveReady SeekComplete Error }

Note : *nothing* between 23:15:38 and 23:27:39, extraction time of hdd =
:

Dec 10 23:27:39 legris kernel: [ 3813.477518] hdd: task_out_intr: error=
=3D0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:27:39 legris kernel: [ 3813.481909] ide: failed opcode was: u=
nknown
Dec 10 23:27:39 legris kernel: [ 3813.486697] hdd: task_out_intr: statu=
s=3D0x51 { DriveReady SeekComplete Error }

Dec 10 23:27:39 legris kernel: [ 3813.491443] hdd: task_out_intr: error=
=3D0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:27:39 legris kernel: [ 3813.496371] ide: failed opcode was: u=
nknown
Dec 10 23:27:39 legris kernel: [ 3813.501485] hdd: task_out_intr: statu=
s=3D0x51 { DriveReady SeekComplete Error }

Dec 10 23:27:39 legris kernel: [ 3813.506587] hdd: task_out_intr: error=
=3D0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:27:39 legris kernel: [ 3813.511806] ide: failed opcode was: u=
nknown
Dec 10 23:27:39 legris kernel: [ 3813.517196] hdd: task_out_intr: statu=
s=3D0x51 { DriveReady SeekComplete Error }

Dec 10 23:27:39 legris kernel: [ 3813.517204] hdd: task_out_intr: error=
=3D0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:27:39 legris kernel: [ 3813.517215] ide: failed opcode was: u=
nknown
Dec 10 23:27:39 legris kernel: de: failed opcode was: unknown
Dec 10 23:27:39 legris kernel: [ 4519.924336] hdd: task_out_intr: statu=
s=3D0x51 { DriveReady SeekComplete Error }

Dec 10 23:27:39 legris kernel: [ 4519.924341] hdd: task_out_intr: error=
=3D0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:27:39 legris kernel: [ 4519.924351] ide: failed opcode was: u=
nknown
Dec 10 23:27:39 legris kernel: [ 4519.924643] hdd: task_out_intr: statu=
s=3D0x51 { DriveReady SeekComplete Error }

duplicate message 67 times

Dec 10 23:27:39 legris kernel: [ 4519.945285] hdd: task_out_intr: error=
=3D0x10 { SectorIdNotFound }, LBAsect=3D5003631, sector=3D5003776
Dec 10 23:27:39 legris kernel: [ 4519.945295] ide: failed opcode was: u=
nknown


What happened during my short read of /var/log/messages (notice the tim=
e hole)
Notice also some badly formated lines (klogd also flooded ?) :

Dec 10 23:28:05 legris kernel: [ 4549.942362] hdd: lost interrupt
Dec 10 23:28:05 legris kernel: [ 4549.945620] hdd: task_out_intr: statu=
s=3D0x7f { DriveReady DeviceFault SeekComplete DataRequest
CorrectedError Index Error }
Dec 10 23:28:05 legris kernel: [ 4549.949259] hdd: task_out_intr: error=
=3D0x7f { DriveStatusError UncorrectableError SectorIdNotFound
TrackZeroNotFound AddrMarkNotFound }, LBAsect=3D260013951, sector=3D500=
3777
Dec 10 23:28:05 legris kernel: [ 4549.956788] ide: failed opcode was: u=
nknown
Dec 10 23:28:35 legris kernel: [ 4579.910781] ide1: reset timed-out, st=
atus=3D0x90
Dec 10 23:28:35 legris kernel: [ 4579.910918] hdd: status error: status=
=3D0x7f { DriveReady DeviceFault SeekComplete DataRequest
CorrectedError Index Error }
Dec 10 23:28:35 legris kernel: [ 4579.919652] hdd: status error: error=3D=
0x7f { DriveStatusError UncorrectableError SectorIdNotFound
TrackZeroNotFound AddrMarkNotFound }, LBAsect=3D260013951, sector=3D500=
3777
Dec 10 23:28:35 legris kernel: [ 4579.936857] ide: failed opcode was: u=
nknown
Dec 10 23:28:35 legris kernel: [ 4579.945382] hdd: drive not ready for =
command
Dec 10 23:29:11 legris kernel: d, logical block 629544
Dec 10 23:29:11 legris kernel: [ 4614.891052] lost page write due to I/=
O error on hdd
Dec 10 23:29:11 legris kernel: [ 4614.892384] end_request: I/O error, d=
ev hdd, sector 5036360
Dec 10 23:29:11 legris kernel: [ 4614.893874] end_request: I/O error, d=
ev hdd, sector 5036368
Sectors increment by 8 steps.
804 removed lines.
Dec 10 23:29:12 legris kernel: [ 4616.169846] end_request: I/O error, d=
ev hdd, sector 5042808
Dec 10 23:29:12 legris kernel:  sector 5044240
Dec 10 23:29:12 legris kernel: [ 4616.375814] end_request: I/O error, d=
ev hdd, sector 5044248
59 removed lines.
Dec 10 23:29:13 legris kernel: [ 4616.445718] end_request: I/O error, d=
ev hdd, sector 5044728
Dec 10 23:29:13 legris kernel: [ 4616.446864] end_request: I/O error, d=
ev hdd, se sector 5048160
Dec 10 23:29:13 legris kernel: [ 4616.938325] end_request: I/O error, d=
ev hdd, sector 5048168
2040 removed lines.
Dec 10 23:29:16 legris kernel: [ 4619.925638] end_request: I/O error, d=
ev hdd, sector 5064496
Dec 10 23:29:16 legris kernel: [ 4619.933788] printk: 3517 messages sup=
pressed.
Dec 10 23:29:16 legris kernel: [ 4619.941939] Buffer I/O error on devic=
e hdd, logical block 633062
Dec 10 23:29:16 legris kernel: [ 4619.950012] lost page write due to I/=
O error on hdd
Dec 10 23:29:16 legris kernel: [ 4619.958182] end_request: I/O error, d=
ev hdd, sector 5064504
2596 removed lines.
Dec 10 23:29:20 legris kernel: [ 4624.871833] end_request: I/O error, d=
ev hdd, sector 5085280
Dec 10 23:29:20 legris kernel: [ 4624.872960] printk: 2597 messages sup=
pressed.
Dec 10 23:29:20 legris kernel: [ 4624.874129] Buffer I/O error on devic=
e hdd, logical block 635660
Dec 10 23:29:20 legris kernel: [ 4624.875377] lost page write due to I/=
O error on hdd
Dec 10 23:29:20 legris kernel: [ 4624.876652] end_request: I/O error, d=
ev hdd, sector 5085288
499 removed lines.
Dec 10 23:29:22 legris kernel: [ 4625.816255] end_request: I/O error, d=
ev hdd, sector 5089288
Dec 10 23:29:22 legris kernel:  sector 5089944
Dec 10 23:29:22 legris kernel: [ 4625.913185] end_request: I/O error, d=
ev hdd, sector 5089952
59 removed lines.
Dec 10 23:29:22 legris kernel: [ 4625.980807] end_request: I/O error, d=
ev hdd, sector 5090432
Dec 10 23:29:22 legris kernel: [ 4625.981944] end_request: I/O error, d=
ev hdd, se sector 5093080
Dec 10 23:29:22 legris kernel: [ 4626.356583] end_request: I/O error, d=
ev hdd, sector 5093088
59 removed lines.
Dec 10 23:29:22 legris kernel: [ 4626.425779] end_request: I/O error, d=
ev hdd, sector 5093568
Dec 10 23:29:22 legris kernel: [ 4626.426917] end_request: I/O error, d=
ev hdd, se sector 5095432
Dec 10 23:29:22 legris kernel: [ 4626.690184] end_request: I/O error, d=
ev hdd, sector 5095440
602 removed lines.
Dec 10 23:29:24 legris kernel: [ 4627.734818] end_request: I/O error, d=
ev hdd, sector 5100264
Dec 10 23:29:24 legris kernel:  sector 5104032
Dec 10 23:29:24 legris kernel: [ 4628.283665] end_request: I/O error, d=
ev hdd, sector 5104040
59 removed lines
Dec 10 23:29:24 legris kernel: [ 4628.352351] end_request: I/O error, d=
ev hdd, sector 5104520
Dec 10 23:29:24 legris kernel: [ 4628.353475] end_request: I/O error, d=
ev hdd, se sector 5105624
Dec 10 23:29:24 legris kernel: [ 4628.509544] end_request: I/O error, d=
ev hdd, sector 5105632
1052 removed lines
Dec 10 23:29:25 legris kernel: [ 4629.864434] end_request: I/O error, d=
ev hdd, sector 5114056
Dec 10 23:29:25 legris kernel: [ 4629.865559] printk: 3596 messages sup=
pressed.
Dec 10 23:29:25 legris kernel: [ 4629.866728] Buffer I/O error on devic=
e hdd, logical block 639257
Dec 10 23:29:25 legris kernel: [ 4629.867969] lost page write due to I/=
O error on hdd
Dec 10 23:29:25 legris kernel: [ 4629.869294] end_request: I/O error, d=
ev hdd, sector 5114064
2194 removed lines.
Dec 10 23:29:30 legris kernel: [ 4634.010797] end_request: I/O error, d=
ev hdd, sector 5131624
Dec 10 23:29:30 legris kernel:  sector 5133848
Dec 10 23:29:30 legris kernel: [ 4634.363647] end_request: I/O error, d=
ev hdd, sector 5133856
59 removed lines.
Dec 10 23:29:31 legris kernel: [ 4634.441981] end_request: I/O error, d=
ev hdd, sector 5134336
Dec 10 23:29:31 legris kernel: [ 4634.443494] end_request: I/O error, d=
ev hdd, seO error, dev hdd, sector 5136224
Dec 10 23:29:31 legris kernel: [ 4634.776991] end_request: I/O error, d=
ev hdd, sector 5136232
60 removed lines.
Dec 10 23:29:31 legris kernel: [ 4634.856874] end_request: I/O error, d=
ev hdd, sector 5136720
Dec 10 23:29:31 legris kernel: [ 4634.858306] printk: 2832 messages sup=
pressed.
Dec 10 23:29:31 legris kernel: [ 4634.859782] Buffer I/O error on devic=
e hdd, logical block 642090
Dec 10 23:29:31 legris kernel: [ 4634.861311] lost page write due to I/=
O error on hdd
Dec 10 23:29:31 legris kernel: [ 4634.862939] end_request: I/O error, d=
ev hdd, sector 5136728
613 removed lines.
Dec 10 23:29:32 legris kernel: [ 4635.903357] end_request: I/O error, d=
ev hdd, sector 5141640
Dec 10 23:29:32 legris kernel: [ 4 sector 5141800
Dec 10 23:29:32 legris kernel: [ 4635.927062] end_request: I/O error, d=
ev hdd, sector 5141808
59 removed lines.
Dec 10 23:29:32 legris kernel: [ 4636.010003] end_request: I/O error, d=
ev hdd, sector 5142288
Dec 10 23:29:32 legris kernel: [ 4636.011534] end_request: I/O error, d=
ev hdd, se sector 5143368
Dec 10 23:29:32 legris kernel: [ 4636.203551] end_request: I/O error, d=
ev hdd, sector 5143376
59 removed lines.
Dec 10 23:29:32 legris kernel: [ 4636.285029] end_request: I/O error, d=
ev hdd, sector 5143856
Dec 10 23:29:32 legris kernel: [ 4636.286473] end_request: I/O error, d=
ev hdd, se sector 5146616
Dec 10 23:29:32 legris kernel: [ 4636.561716] end_request: I/O error, d=
ev hdd, sector 5146624
121 removed lines.
Dec 10 23:29:33 legris kernel: [ 4636.562407] end_request: I/O error, d=
ev hdd, sector 5147600
Dec 10 23:29:33 legris kernel: [ 4636.562411] end_request: I/O error, d=
ev hdd, secto sector 5148968
Dec 10 23:29:33 legris kernel: [ 4636.900116] end_request: I/O error, d=
ev hdd, sector 5148976
59 removed lines.
Dec 10 23:29:33 legris kernel: [ 4636.973040] end_request: I/O error, d=
ev hdd, sector 5149456
Dec 10 23:29:33 legris kernel: [ 4636.974174] end_request: I/O error, d=
ev hdd, se sector 5149752
Dec 10 23:29:33 legris kernel: [ 4637.015749] end_request: I/O error, d=
ev hdd, sector 5149760
59 removed lines.
Dec 10 23:29:33 legris kernel: [ 4637.090468] end_request: I/O error, d=
ev hdd, sector 5150240
Dec 10 23:29:33 legris kernel: [ 4637.091909] end_request: I/O error, d=
ev hdd, se sector 5154680
Dec 10 23:29:33 legris kernel: [ 4637.361710] end_request: I/O error, d=
ev hdd, sector 5154688
1093 removed lines.
Dec 10 23:29:35 legris kernel: [ 4639.848604] end_request: I/O error, d=
ev hdd, sector 5163440
Dec 10 23:29:35 legris kernel: [ 4639.849893] printk: 3339 messages sup=
pressed.
Dec 10 23:29:35 legris kernel: [ 4639.851140] Buffer I/O error on devic=
e hdd, logical block 645430
Dec 10 23:29:35 legris kernel: [ 4639.852421] lost page write due to I/=
O error on hdd
Dec 10 23:29:35 legris kernel: [ 4639.853792] end_request: I/O error, d=
ev hdd, sector 5163448
1797 removed lines.
Dec 10 23:29:40 legris kernel: [ 4644.036981] end_request: I/O error, d=
ev hdd, sector 5177832
Dec 10 23:29:40 legris kernel:  sector 5204008
Dec 10 23:29:40 legris kernel: [ 4644.176455] end_request: I/O error, d=
ev hdd, sector 5204016
246 removed lines.
Dec 10 23:29:40 legris kernel: [ 4644.177896] end_request: I/O error, d=
ev hdd, sector 5205992

Dec 10 23:29:43 legris shutdown[8303]: shutting down for system halt


End of story.
Conclusions :
- interrupt mechanism fooled ?
- bad error management ?
My knowledge and my skills stop here, but I will be happy to test any k=
ind of patch.
I keep the disk, waiting for a solution.

Coz, in fine, what about a production machine where a disk starts to cr=
eate bad blocks as bad as those found in my disk ?
What would have happened if my disk was not removable ?
100 % /var/log full ?
Other processes hanged up ?

Best regards,
--=20
Jean-Pierre Turchi
=AB From South of France =BB
jpturchi at mageos dot com

