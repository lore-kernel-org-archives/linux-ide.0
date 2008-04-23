From: "kyle" <kylewong@southa.com>
Subject: ahci performance problem? (much slower than sil24)
Date: Wed, 23 Apr 2008 09:29:33 +0800
Message-ID: <000a01c8a4e1$7c9a6830$0a01a8c0@kylecea1512a3f>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sitar.i-cable.com ([203.83.115.100]:41661 "HELO
	sitar.i-cable.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758467AbYDWBgS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 21:36:18 -0400
Received: from kylecea1512a3f (cm218-254-60-144.hkcable.com.hk [218.254.60.144])
	by xenon.i-cable.com (8.13.5/8.13.5) with SMTP id m3N1TZP1025733
	for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2008 09:29:36 +0800 (CST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've built a new machine with Intel Desktop Board DQ35JO, Intel E2160 CPU, 
and 8 x Seagate ST3500320AS 500MB SATA harddisks. 6 of the 8 harddisks are 
connected to the motherboard's SATA ports, while the remaining 2 are 
connected to a 2 ports PCI-E card with sil24.

kernel is 2.6.24.5, have tried fedora kernel 2.6.23.1-42 and 2.6.24.4-64, 
all give the same result.

sda,b,c .... to sdf are running ahci driver, sdg and sdh are running sil24 
driver

hdparm -t /dev/sd{a-f} give around 45-46MB/sec
hdparm -t /dev/sdg and sdh give over 105MB/sec

had updated to latest BIOS, no change in hdparm test b4/after update.
hdparm -i:

[root@localhost boot]# hdparm -i /dev/sda
/dev/sda:
 Model=ST3500320AS                             , FwRev=SD15    , SerialNo=
      9QM2Q7F4
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: unknown:  ATA/ATAPI-4,5,6,7
 * signifies the current active mode




