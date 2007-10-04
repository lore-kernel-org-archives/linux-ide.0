From: idurdanovic@comcast.net (Igor Durdanovic)
Subject: Re: sata_sil24 and sil-4726
Date: Thu, 4 Oct 2007 09:49:37 -0400
Message-ID: <18180.61297.423410.538906@kitty1.shrimp.net>
References: <18180.26625.216781.626572@kitty1.shrimp.net>
	<470468EE.909@gmail.com>
	<18180.30643.554165.292012@kitty1.shrimp.net>
	<4704790C.7060901@gmail.com>
	<18180.31651.305092.579581@kitty1.shrimp.net>
	<470480C9.9030309@gmail.com>
	<18180.34107.704754.565573@kitty1.shrimp.net>
	<47048C2B.1060202@gmail.com>
	<47049344.6010603@gmail.com>
	<18180.38483.139258.690293@kitty1.shrimp.net>
	<47049799.3030509@gmail.com>
	<18180.39323.750969.577889@kitty1.shrimp.net>
	<47049A74.3080000@gmail.com>
Reply-To: idurdanovic@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alnrmhc11.comcast.net ([206.18.177.51]:43693 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667AbXJDNym (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Oct 2007 09:54:42 -0400
In-Reply-To: <47049A74.3080000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: idurdanovic@comcast.net, linux-ide@vger.kernel.org

There is definitely a problem with hdparm and the 
SIL-3132 <-> SIL-4726

Now I can not turn the write caching off:

pts/1#> hdparm -W 0 /dev/sdb

/dev/sdb:
 setting drive write-caching to 0 (off)
pts/1#> hdparm -i /dev/sdb

/dev/sdb:

 Model=ST3750640AS                             , FwRev=3.AAE   , SerialNo=            5QD106AK
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=16384kB, MaxMultSect=16, MultSect=?16?
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: Unspecified:  ATA/ATAPI-1 ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6 ATA/ATAPI-7

 * signifies the current active mode

Igor
