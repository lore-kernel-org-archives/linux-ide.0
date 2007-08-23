From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Problem with pata_via and HL-DT-ST GCE-8525B cdrom with kernels 2.6.22+
Date: Thu, 23 Aug 2007 12:11:26 +0200
Message-ID: <200708231211.26490.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.telefonica.net ([213.4.149.66]:16213 "EHLO
	ctsmtpout4.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759404AbXHWKL2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2007 06:11:28 -0400
Received: from jar.dominio (80.25.230.35) by ctsmtpout4.frontal.correo (7.2.056.6) (authenticated as jareguero$telefonica.net)
        id 46C07BCD001137DC for linux-ide@vger.kernel.org; Thu, 23 Aug 2007 12:11:27 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I have a problem with pata_via and a  HL-DT-ST GCE-8525B cdrom, with kernels 
2.6.22 and 2.6.23-rc3. When burning cds, the burning speed drop down to ~ 1.
Also I have problems readind cds.
With kernel 2.6.21, the cdrom work well.
There are not error messages in dmesg and /var/log/messages, only some error 
when shutdown de pc(reseting port, ...).
I have also a HL-DT-ST DVDRAM GSA-4167B DVD that work well.

DVD(work well):
[root@jar ~]# hdparm -i /dev/scd0

/dev/scd0:

 Model=HL-DT-ST DVDRAM GSA-4167B               , FwRev=DL10    , 
SerialNo=C70B8EB84B89
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no
 Drive conforms to: Unspecified:  ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 
ATA/ATAPI-5

 * signifies the current active mode

CDROM
[root@jar ~]# hdparm -i /dev/scd1

/dev/scd1:

 Model=HL-DT-ST GCE-8525B                      , FwRev=1.05    , SerialNo=      
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no

 * signifies the current active mode

Thanks.
Jose Alberto
