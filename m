From: Ian Bruce <ian_bruce@fastmail.fm>
Subject: DMA problem with HighPoint R100 and DVD drive
Date: Mon, 13 Aug 2007 22:36:06 -0700
Message-ID: <20070813223606.bec3d7c3.ian_bruce@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:28778 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933054AbXHNFeS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Aug 2007 01:34:18 -0400
Received: from pd2mr4so.prod.shaw.ca
 (pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JMR008JI0S31B70@l-daemon> for linux-ide@vger.kernel.org; Mon,
 13 Aug 2007 23:33:40 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
 by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JMR0011W0RT1470@pd2mr4so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 13 Aug 2007 23:33:40 -0600 (MDT)
Received: from localhost ([24.82.94.115])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JMR00I8O0RSZTM0@l-daemon> for linux-ide@vger.kernel.org; Mon,
 13 Aug 2007 23:33:28 -0600 (MDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm trying to build a DVD duplication box with ATAPI DVD burners and a
HighPoint Rocket-100 controller card. For some reason, this combination
will not allow DMA transfers to the DVD drives, limiting write (and
read) speed to about 1X, even though the drives are capable of 16X
writing.


OS: Linux v2.6.21/i386 with module hpt366 loaded


# hdparm -d1 /dev/hde

/dev/hde:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Input/output error
 using_dma     =  0 (off)

# hdparm -I /dev/hde

/dev/hde:

ATAPI CD-ROM, with removable media
        Model Number:       TSSTcorpCD/DVDW SH-S182F                
        Serial Number:      
        Firmware Revision:  SB01    
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: mdma0 mdma1 *mdma2 udma0 udma1 udma2 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=227ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
HW reset results:
        CBLID- below Vih
        Device num = 0


boot messages:

HPT302N: IDE controller at PCI slot 0000:00:09.0
ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
HPT302N: chipset revision 2
HPT302N: DPLL base: 77 MHz, f_CNT: 70, assuming 33 MHz PCI
HPT302N: using 66 MHz DPLL clock
HPT302N: 100% native mode on irq 5
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: TSSTcorpCD/DVDW SH-S182F, ATAPI CD/DVD-ROM drive
hdf: TSSTcorpCD/DVDW SH-S182F, ATAPI CD/DVD-ROM drive
ide2 at 0xac00-0xac07,0xb002 on irq 5
Probing IDE interface ide3...


(The HighPoint BIOS menu fails to detect any drives, so there doesn't
seem to be any way to change this BIOS PIO setting.)

Any suggestions? (Please copy responses to me, as I'm not subscribed to
the list.)


-- Ian Bruce
