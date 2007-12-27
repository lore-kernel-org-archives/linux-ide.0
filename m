From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: HSM violation erros on sata_promise
Date: Thu, 27 Dec 2007 13:51:08 +0100
Message-ID: <18291.40892.305215.837950@harpo.it.uu.se>
References: <200712270036.06531.tbaumgartner@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:44990 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbXL0MvP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Dec 2007 07:51:15 -0500
In-Reply-To: <200712270036.06531.tbaumgartner@swissonline.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Theo Baumgartner <tbaumgartner@swissonline.ch>
Cc: linux-ide@vger.kernel.org

Theo Baumgartner writes:
 > Hello List
 > 
 > I'm getting these HSM violation's too on all the SATA 300 TX4 ports with Seagate ST3250824NS disks.
 > In the files attached are informations about the system with logs included and the kernel .config.
 > 
 > 
 > Theo
 > This is on Promise SATA300 TX4 and sata_promise

(snip)

 > uname -rpm
 > 2.6.23-gentoo-r3 i686 AMD Athlon(tm) XP 2200+

First, we don't support random hacked vendor kernels,
so please try a vanilla kernel, preferably 2.6.24-rc2 or newer.
If you must use 2.6.23, apply this patch first:
<http://user.it.uu.se/~mikpe/linux/patches/sata_promise/patch-sata_promise-1-asic-sg-bug-fix-v3-2.6.23>

(snip)

 > lspci
 > 00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
 > 00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
 > 00:06.0 Mass storage controller: Promise Technology, Inc. PDC40718 (SATA 300 TX4) (rev 02)
 > 00:07.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
 > 00:08.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 01)
 > 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
 > 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
 > 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
 > 00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
 > 00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
 > 00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
 > 01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 440] (rev a3)

You have three hard drive controllers. How many disks does this old
mainboard have? It's not uncommon for disks to fail under load due to
overloaded power supplies.

(snip)

 > sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
 > sd 1:0:0:0: [sdb] Write Protect is off
 > sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
 > sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 > ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
 > ata4.00: port_status 0x20080000
 > ata4.00: cmd c8/00:08:3f:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 in
 >          res 50/00:00:46:00:00/00:00:00:00:00/e0 Emask 0x2 (HSM violation)

This is a familiar issue, one that may be fixed or at least
made less frequent in recent kernels -- see above.

But your kernel log is incomplete. You have an nVidia graphics chip:
if you've loaded the nvidia proprietary kernel module then all bets are off.

/Mikael
