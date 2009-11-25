From: Gorgone <gorgone@gmx.de>
Subject: not full working ata_piix
Date: Wed, 25 Nov 2009 09:16:56 +0100
Message-ID: <931603659.20091125091656@gmx.de>
Reply-To: Gorgone <gorgone@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:59533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751834AbZKYIRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 03:17:00 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello mr. Jeff Garzik,

I had a conversation with Dave Hansen dave@sr71.net
and he confirmed the problem with the Intel SS4200
the ata_piix dont detect the ide ports only ide-generic
and with ide generic is no ide-dma possible.
is there any solution(quirks) out there ?

    nas:~# hdparm -tT /dev/hda

    /dev/hda:
    Timing cached reads:   840 MB in  2.00 seconds = 419.87 MB/sec
    Timing buffered disk reads:    6 MB in  3.24 seconds =   1.85 MB/sec

    nas:~# lspci
    00:00.0 Host bridge: Intel Corporation 82945G/GZ/P/PL Memory Controller Hub (rev 02)
    00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
    00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 01)
    00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #1 (rev 01)
    00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #2 (rev 01)
    00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #3 (rev 01)
    00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #4 (rev 01)
    00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
    00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
    00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
    00:1f.2 SATA controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA AHCI Controller (rev 01)
    00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
    01:00.0 Ethernet controller: Intel Corporation 82573V Gigabit Ethernet Controller (Copper) (rev 03)
    02:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)

    nas:~# hdparm -i /dev/hda
    /dev/hda:
    Model=CF Card, FwRev=Ver2.32, SerialNo=843B0799080700308500
    Config={ HardSect NotMFM Fixed DTR>10Mbs }
    RawCHS=15636/16/63, TrkSize=32256, SectSize=512, ECCbytes=4
    BuffType=DualPort, BuffSize=1kB, MaxMultSect=1, MultSect=off
    CurCHS=15636/16/63, CurSects=15761088, LBA=yes, LBAsects=15761088
    IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
    PIO modes:  pio0 pio1 pio2 pio3 pio4
    DMA modes:  mdma0 mdma1 mdma2
    UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
    AdvancedPM=no WriteCache=disabled
    * signifies the current active mode

    nas:~# hdparm -d1 /dev/hda
    /dev/hda:
    setting using_dma to 1 (on)
    HDIO_SET_DMA failed: Operation not permitted
    using_dma     =  0 (off)

    nas:~# lspci -n
    00:00.0 0600: 8086:2770 (rev 02)
    00:02.0 0300: 8086:2772 (rev 02)
    00:1c.0 0604: 8086:27d0 (rev 01)
    00:1c.2 0604: 8086:27d4 (rev 01)
    00:1d.0 0c03: 8086:27c8 (rev 01)
    00:1d.1 0c03: 8086:27c9 (rev 01)
    00:1d.2 0c03: 8086:27ca (rev 01)
    00:1d.3 0c03: 8086:27cb (rev 01)
    00:1d.7 0c03: 8086:27cc (rev 01)
    00:1e.0 0604: 8086:244e (rev e1)
    00:1f.0 0601: 8086:27b8 (rev 01)
    00:1f.2 0106: 8086:27c1 (rev 01)
    00:1f.3 0c05: 8086:27da (rev 01)
    01:00.0 0200: 8086:108b (rev 03)
    02:00.0 0180: 1095:3132 (rev 01)

---------------------------------------------------
On Tue, 2009-11-24 at 00:31 +0100, Gorgone wrote:
> excuse me if I'm going to annoy
> 
> but i cant enable the ide dma
> 
> is there a trick ?

I tried a bunch of different stuff and was never
able to get it to turnon.  I suspect the chipset
is crippled.  Even the EMC software didn't
read from the IDE port after boot.

-- Dave
--------------------------------------------------

h.a.n.d 
mailto:gorgone@gmx.de

