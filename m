From: Michael Tokarev <mjt@tls.msk.ru>
Subject: pata_via(?): cdrom is recognized as hard drive
Date: Wed, 17 Oct 2007 19:35:52 +0400
Message-ID: <47162BD8.1010109@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.94.6]:24886 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759956AbXJQPfy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 11:35:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

And one more issue with my attempt to switch
from via82cxxx to pata_via.

I noticied that on all machines I tried to convert,
CD-Rom devices are recognized as hard disks.

With via82cxxx and ide-cd, it was like
hdc: IDE cdrom model=FX4830T s/n=4JV6F7Q4 fw=8.01 udma5

But with pata_via and 2.6.23, it's handled by sd_mod:

# ls /sys/block
sda/  sdb/  sdc/  sdd/
# cat /sys/block/sdc/removable
0
# cat /sys/block/sdc/device/type
0
# echo "'$(cat /sys/block/sdc/device/model)'"
 '                '
# echo "'$(cat /sys/block/sdc/device/vendor)'"
'        '

# hdparm -i /dev/sdc

/dev/sdc:

 Model=FX4830T                                 , FwRev=R02E    , SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=128kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

 * signifies the current active mode


Is it how the things supposed to be, or is something wrong with
the detection?  Note that this happens on several machines,
however all of them so far has via82cxxx controller:

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(VT8633 chipset)

(I use pata_via driver on a home machine for a long time, with another
controller (CN700/VN800/P4M800CE/Pro chipset)), and everything there
works as expected, since early pata days).

2.6.20, 2.6.22, 2.6.23 behaves the same.

Thanks.

/mjt
