From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Linux IDE with Intel chipset: no simultaneous access
Date: Wed, 27 Aug 2003 13:16:08 +0300 (EEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.55.0308271223020.11389@stekt37>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ee.oulu.fi ([130.231.61.23]:19612 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263262AbTH0KQU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Aug 2003 06:16:20 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: andre@linux-ide.org, B.Zolnierkiewicz@elka.pw.edu.pl

* Summary of the problem:
I can not access two harddisks in different IDE busses simultaneously. If I
try to do that, the performance of both will halve. This makes
software RAID-0 completely useless. Evidence suggests that this might be a
general problem with Intel chipsets.

[That said, please keep me on the CC, I'm not subscribed... also, please
forward this mail to correct address if this is a wrong one.]

* Full description:
Easiest to give an example. I set hard disks in /dev/hda and /dev/hdc into
multiword mode 2 (theoretical maximum 16 MB/s IIRC). Then I run
	# hdparm -t /dev/hda ; hdparm -t /dev/hdc
/dev/hda:
 Timing buffered disk reads:  64 MB in  4.86 seconds = 13.17 MB/sec
/dev/hdc:
 Timing buffered disk reads:  64 MB in  4.83 seconds = 13.24 MB/sec
	# hdparm -t /dev/hda & hdparm -t /dev/hdc
 Timing buffered disk reads:   Timing buffered disk reads:
64 MB in  8.61 seconds =  7.43 MB/sec
64 MB in  8.63 seconds =  7.42 MB/sec

As can be seen, performance of both disks halves when using both
simultaneously. I made an extensive testing and noticed that nothing
changes this as long as using disks on the Intel IDE controller (but
accessing SCSI disk and IDE simultaneously works fine). Some things I
tried:
- Writing instead of reading to both disks: no effect
- Using PIO mode instead of DMA: no effect
- Using different UltraDMA modes: no effect
- Using dual/single CPU: no effect
- Leaving out Triton chipset support from kernel: no effect
- Upgrading computer BIOS: no effect
- Using different disks in /dev/hdb and /dev/hdc: no effect
- Using identical disks in /dev/hda and /dev/hdc: no effect
- Disabling SCSI/floppy/kernel debugging... from kernel config: no effect
- Setting drives in /dev/hda and /dev/hdc into very different
  speeds: the speed of simultaneous reads will be about the average
  of both disks, and _halved_.
- Using either kernel 2.4.21 or 2.6.0-test3: no effect
- Trying hdparm -u1 and/or -m16: no effect
- And of course, accessing the drives through RAID-0 or directly: no effect

I actually might assume that this is a feature of Intel chipsets, but I did
look at the documentation which says:

<<clip>>
5.14.2       Bus Master Function
The ICH can act as a PCI Bus master on behalf of an IDE slave device. Two
PCI Bus master channels are provided, one channel for each IDE connector
(primary and secondary). By performing the IDE data transfer as a PCI Bus
master, the ICH off-loads the processor and improves system performance in
multitasking environments. Both devices attached to a connector can be
programmed for bus master transfers, but only one device per connector can
be active at a time.
<<clip>>
The last sentence suggests that two devices attached to _different_
connectors should work simultaneously (be active?).

* Kernel version: both 2.4.21 and 2.6.0-test3. Other kernels not tried.
Linux version 2.6.0-test3 (tuukkat@powerzone) (gcc version 2.95.4 20011002
(Debian prerelease)) #19 SMP Tue Aug 19 21:08:03 EEST 2003

* Software versions, although hardly matters:
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.15
e2fsprogs              1.27
reiserfsprogs          3.x.1b
nfs-utils              1.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 100.
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
(Debian 3.0)

* CPU information: this is
Dual Pentium 3 933 MHz. 1 GB ECC RAM.
Dell Precision 420.

* System configuration:
IDE interface: Intel Corp. 82801AA IDE (rev 2).
      I/O at 0xffa0 [0xffaf]. (ICH)
/dev/hda: Samsung V80 5400 RPM 120 GB ATA/133 (just purchased)
/dev/hdb: Quantum Fireball 3.6 GB Mword2 (older)
/dev/hdc: Samsung V80 5400 RPM 120 GB ATA/133 (identical to hda)
/dev/hdd: ATAPI CD-ROM drive (also tried unplugging this)
/dev/sda: Seagate Cheetah 18 GB

* PCI information (/proc/pci)
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82840 840 (Carmel) C (rev 2).
      Prefetchable 32 bit memory at 0xf0000000 [0xf3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82840 840 (Carmel) C (rev 2).
      Master Capable.  Latency=64.  Min Gnt=14.
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 2).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801AA ISA Bridge ( (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801AA IDE (rev 2).
      I/O at 0xffa0 [0xffaf].
  Bus  0, device  31, function  2:
    USB Controller: Intel Corp. 82801AA USB (rev 2).
      IRQ 19.
      I/O at 0xff80 [0xff9f].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82801AA SMBus (rev 2).
      IRQ 17.
      I/O at 0xccd0 [0xccdf].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc MGA G400 AGP (rev 130).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xf4000000 [0xf5ffffff].
      Non-prefetchable 32 bit memory at 0xfcffc000 [0xfcffffff].
      Non-prefetchable 32 bit memory at 0xfc000000 [0xfc7fffff].
  Bus  2, device   4, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Torn (rev 120).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=10.Max Lat=10.
      I/O at 0xdc80 [0xdcff].
      Non-prefetchable 32 bit memory at 0xf8fffc00 [0xf8fffc7f].
  Bus  2, device   6, function  0:
    Multimedia audio controller: Cirrus Logic CS 4614/22/24 [Cryst (rev 1).
      IRQ 18.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=24.
      Non-prefetchable 32 bit memory at 0xf8ffe000 [0xf8ffefff].
      Non-prefetchable 32 bit memory at 0xf8e00000 [0xf8efffff].
  Bus  2, device   9, function  0:
    Multimedia video controller: Brooktree Corporatio Bt878 Video Capture
(rev 2).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xf6001000 [0xf6001fff].
  Bus  2, device   9, function  1:
    Multimedia controller: Brooktree Corporatio Bt878 Audio Capture (rev
2).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xf6000000 [0xf6000fff].
  Bus  2, device  14, function  0:
    PCI bridge: Digital Equipment Co DECchip 21152 (rev 3).
      Master Capable.  Latency=64.  Min Gnt=6.
  Bus  3, device   5, function  0:
    Ethernet controller: Realtek Semiconducto RTL-8139/8139C/8139C (rev
16).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xfafffc00 [0xfafffcff].
  Bus  3, device  10, function  0:
    SCSI storage controller: Adaptec AIC-7899P U160/m (rev 1).
      IRQ 18.
      Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
      I/O at 0xe800 [0xe8ff].
      Non-prefetchable 64 bit memory at 0xfaffe000 [0xfaffefff].
  Bus  3, device  10, function  1:
    SCSI storage controller: Adaptec AIC-7899P U160/m (#2) (rev 1).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=40.Max Lat=25.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 64 bit memory at 0xfaffd000 [0xfaffdfff].

* Benchmarks in different configurations:
(reformatted slightly for clarity)

- Both /dev/hda and /dev/hdc in multiword mode 2, kernel 2.6.0-test3:
/dev/hda:
 Timing buffered disk reads:  64 MB in  4.86 seconds = 13.17 MB/sec
/dev/hdc:
 Timing buffered disk reads:  64 MB in  4.83 seconds = 13.24 MB/sec
 Timing buffered disk reads:   Timing buffered disk reads:
64 MB in  8.61 seconds =  7.43 MB/sec
64 MB in  8.63 seconds =  7.42 MB/sec

- Both disks in PIO-0 mode (hdparm -p0 -d0), 2.4.21:
/dev/hda:
 Timing buffered disk reads:  64 MB in 16.80 seconds =  3.81 MB/sec
/dev/hda:
 Timing buffered disk reads:  64 MB in 16.80 seconds =  3.81 MB/sec
 Timing buffered disk reads:   Timing buffered disk reads:
64 MB in 36.58 seconds =  1.75 MB/sec
64 MB in 36.86 seconds =  1.74 MB/sec

- Another disk in PIO-0 and another in UDMA-66, 2.4.21:
/dev/hdc:
 Timing buffered disk reads:  64 MB in  1.32 seconds = 48.48 MB/sec
/dev/hda:
 Timing buffered disk reads:  64 MB in 16.82 seconds =  3.80 MB/sec
 Timing buffered disk reads:   Timing buffered disk reads:
64 MB in 10.69 seconds =  5.99 MB/sec
64 MB in 21.87 seconds =  2.93 MB/sec

- Another disk in Mword2 and another in UDMA-66, 2.4.21:
/dev/hdb:
 Timing buffered disk reads:  64 MB in  9.43 seconds =  6.79 MB/sec
/dev/hdc:
 Timing buffered disk reads:  64 MB in  1.32 seconds = 48.48 MB/sec
 Timing buffered disk reads:   Timing buffered disk reads:
64 MB in 2.41 seconds = 26.56 MB/sec
64 MB in 9.54 seconds =  6.71 MB/sec

- Both disks in UDMA-33, writing to one disk at a time, 2.4.21:
(1 GB of zeros)
powerzone:/mnt/mnt1# rm -f zeros; sync; time sh -c 'sync; dd
      if=/dev/zero of=zeros bs=102400 count=10240; sync'
/dev/hda:
real    0m34.305s	0m34.188s
user    0m0.020s	0m0.080s
sys     0m4.890s	0m4.800s
/dev/hdc:
real    0m34.273s	0m34.165s
user    0m0.020s	0m0.070s
sys     0m5.060s	0m4.840s
(did twice, results reformatted for clarity)

- Both in UDMA-33, simultaneous writing, 2.4.21:
UDMA33, 2.4.21 two simul writes:
powerzone:/mnt/mnt1# time /root/wtst.sh
(1 GB of zeros for both disks = 2*1 GB)
10240+0 records in
10240+0 records out
10240+0 records in
10240+0 records out
real    1m9.903s	1m10.537s
user    0m0.100s	0m0.100s
sys     0m11.320s	0m10.970s
(did twice, results reformatted for clarity)

- Without PIIX/SCSI/SMP support in kernel, 2.4.21:
/dev/hdb:
 Timing buffered disk reads:  64 MB in 15.32 seconds =  4.18 MB/sec
/dev/hdc:
 Timing buffered disk reads:  64 MB in 17.00 seconds =  3.76 MB/sec
 Timing buffered disk reads:   Timing buffered disk reads:
64 MB in 29.69 seconds =  2.16 MB/sec
64 MB in 30.58 seconds =  2.09 MB/sec

- Upgraded flash BIOS, UDMA-2 and UDMA-4, 2.6.0-test3:
/dev/hdc:
 Timing buffered disk reads:  64 MB in  1.72 seconds = 37.26 MB/sec
/dev/hda:
 Timing buffered disk reads:  64 MB in  2.67 seconds = 23.95 MB/sec
 Timing buffered disk reads:   Timing buffered disk reads:
64 MB in 4.07 seconds = 15.72 MB/sec
64 MB in 4.10 seconds = 15.59 MB/sec

- Reported by other people on sfnet.atk.linux [Lasse Launis]:
hdparm -t /dev/hda & hdparm -t /dev/hdc
9.71 MB/sec and 9.61 MB/sec
hdparm -t /dev/hd[ac]:
21.12 MB/sec and 20.78 MB/sec
The disks are identical.
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)

- Also reported by other people for VIA chipsets: no similar performance
loss.
