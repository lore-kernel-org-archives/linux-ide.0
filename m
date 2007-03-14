From: Tejun Heo <htejun@gmail.com>
Subject: Re: DVD drive fails in 2.6.20.2
Date: Wed, 14 Mar 2007 12:57:55 +0900
Message-ID: <45F772C3.9050606@gmail.com>
References: <45F631F7.6020106@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:3179 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbXCND6C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 23:58:02 -0400
Received: by ug-out-1314.google.com with SMTP id 44so456837uga
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 20:58:00 -0700 (PDT)
In-Reply-To: <45F631F7.6020106@mail.utexas.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vlad Codrea <VladCodrea@mail.utexas.edu>
Cc: linux-ide@vger.kernel.org

Vlad Codrea wrote:
> Hi,
> 
> The DVD-ROM drive on my laptop does not work with the vanilla 2.6.20.2
> kernel using drivers/ata. The attached file dmesg.txt contains the full
> dmesg output including the error messages. I have also attached the
> .config file I used when compiling the kernel. The DVD device does not
> appear under /dev (only /dev/sda shows up, which is the hard drive).
> 
> The ATA-related errors seem to start with:
> 
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x25)
> ata2.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x12 data 36 in
>         res 58/00:02:00:24:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
> ata2: soft resetting port
> ata2: port is slow to respond, please be patient (Status 0xd8)
> ata2: port failed to respond (30 secs, Status 0xd8)
> ATA: abnormal status 0xD8 on port 0x177
> ATA: abnormal status 0xD8 on port 0x177
> 
> I should point out that this DVD drive hasn't worked with drivers/ide
> either, but it works perfectly under Windows 98. For background on this
> bug, please see:
> 
> https://bugzilla.novell.com/show_bug.cgi?id=177050
> http://bugzilla.kernel.org/show_bug.cgi?id=6710
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=197477
> https://launchpad.net/ubuntu/+source/linux-source-2.6.17/+bug/50161

To add more info, the drive is...

 Model=TORiSAN DVD-ROM DRD-N216, FwRev=1.080000,
SerialNo=00000000000000000001
 Config={ SpinMotCtl Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 *mdma2
 AdvancedPM=no

and as written above it also doesn't work with the ide drivers.  If DMA
is turned off using hdparm -d 0, it seems to work better but still
doesn't seem to work reliably.

-- 
tejun
