From: =?utf-8?b?RnJhbsOnb2lzLUp1bGllbg==?= Marbaud <fbourget@irisa.fr>
Subject: Slow perfs with IDE SSD
Date: Wed, 12 Jul 2006 08:49:14 +0000 (UTC)
Message-ID: <loom.20060712T102252-777@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:26311 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751012AbWGLJKW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Jul 2006 05:10:22 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G0ajK-0001yZ-Fk
	for linux-ide@vger.kernel.org; Wed, 12 Jul 2006 11:10:02 +0200
Received: from duvalix.irisa.fr ([131.254.12.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 12 Jul 2006 11:10:02 +0200
Received: from fbourget by duvalix.irisa.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Wed, 12 Jul 2006 11:10:02 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi !

I'm doing an internship in a research lab, and we are trying to use a P=
=2EATA SSD
in order to speed-up a genome computation software.

We got a performance problem, expecially with access time : access time=
 is about
800us, and according to the manufacturer it should be about 40us. The b=
andwith
is OK.

The SSD is a 2.5' flash hard drive, the slave of the first IDE channel.

We wonder if that could be the because P.ATA driver is not really done =
for small
access times, so we got such a poor time. In that case, I guess we woul=
d have to
have a closer look at the driver ...=20

We are also going to do some tests with the SSD on a windows computer, =
maybe
that's a problem with the firmware of the SSD ...

Thank you for your help !

Here are some details about the configuration.


[rootlav@remix lavenier]# /sbin/hdparm -i /dev/hdb

/dev/hdb:

  Model=3DM-Systems FFD ULTRA ATA, FwRev=3D1.13, SerialNo=3D515240001
  Config=3D{ Fixed }
  RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D4
  BuffType=3Dunknown, BuffSize=3D0kB, MaxMultSect=3D2, MultSect=3Doff
  CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D1288=
17152
  IORDY=3Dyes, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  sdma0 sdma1 mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
  AdvancedPM=3Dno WriteCache=3Denabled
  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 1:

  * signifies the current active mode=20

The computer is a DELL precision360 P4 3Ghz
Hard drives : sda SCSI 67MB, hda 80MB, hdb 67MB (the SSD)

OS : Linux Fedora 2 : 2.6.6-1=20

The drive is a M-Systems 2,5' FFD ultra-ata flash disk (complies with A=
TA-6)

http://www.m-systems.com/site/en-US/

3.3. Characteristics
3.3.1. ATA Modes
The Ultra ATA supports the following ATA modes:
=E2=80=A2 PIO mode 0, 1, 2, 3, 4
=E2=80=A2 DMA mode 0, 1, 2
=E2=80=A2 Ultra DMA mode 0, 1, 2, 3, 4, 5
3.3.2. Burst Read/Write Performance
The Ultra ATA burst read/write rate is 100 MB/sec.
3.3.3. Sustained Read/Write Performance
The Ultra ATA meets the performance requirements specified in Table 1.
Performance was measured on a computer using the following setup:
=E2=80=A2 Capacity: 4GB
=E2=80=A2 Configuration: Ultra DMA Mode 5, with 128K blocks aligned on =
128K boundaries
=E2=80=A2 Platform: ASUS P4T533-C with Intel 2.4 GHz
=E2=80=A2 Testing utilities:
o H2Bench (DOS)
o H2benchW (Windows XP)
Table 1: FFD 2.5=E2=80=9D Ultra ATA Ultra DMA Mode 5 Transfer Rates
Operation
Burst Rate1 (MB/sec)
Sustained2 Rate 128KBs Blocks (MB/sec)
Read
100.0
45.0
Write
100.0
40.0
3.3.4. Access Time
Maximum access time for the Ultra ATA is < 0.04 msec.
3.3.5. Seek Time
The Ultra ATA has no seek time.
3.3.6. Memory Capacity
Ultra ATA memory capacity information is described in Table 2.



=20

