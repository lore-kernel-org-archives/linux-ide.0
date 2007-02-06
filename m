From: Fredrik Rinnestam <fredrik@obra.se>
Subject: Re: SIL3512 lockup problem using driver verion 0.9 and Linux 2.6.14
Date: Tue, 6 Feb 2007 18:55:41 +0100
Message-ID: <20070206175541.GA20533@useful.obra.se>
References: <74342.74582.qm@web52304.mail.yahoo.com> <457E040D.2020707@gmail.com> <20070203201449.GA1222@useful.obra.se> <20070203231757.GA2035@useful.obra.se> <45C82F6C.90604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep02.bredband.com ([195.54.107.73]:60304 "EHLO
	mxfep02.bredband.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153AbXBFRzp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Feb 2007 12:55:45 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20070206175543.KPMU2832.mxfep02.bredband.com@ironport.bredband.com>
          for <linux-ide@vger.kernel.org>; Tue, 6 Feb 2007 18:55:43 +0100
Content-Disposition: inline
In-Reply-To: <45C82F6C.90604@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

> Sorry but can't really find anything specific in your log.  Please...
> 
> 1. give a host at 2.6.20.  It will give us yet more info about errors.
> 
> 2. turn on "Kernel hacking -> Show timing information on printks."
> 
> 3. report the result of "lspci -nn"
> 
> 4. try to connect harddrives to separate power supply or use other
> hardware debugging tactics.  There have been a lot of SATA bug reports
> which turned out to be hardware problems.  SATA seems to be the first to
> get hit when there is generic hardware problem (e.g. insufficient / bad
> power supply).
> 

I replaced the SiL card with a Promise SATA 300 TX4 - no errors.

I plugged the SiL card in another computer and managed to produce the
same errors.

lspci -nn

00:00.0 Host bridge [0600]: Intel Corporation 82P965/G965 Memory
Controller Hub [8086:29a0] (rev 02)
00:01.0 PCI bridge [0604]: Intel Corporation 82P965/G965 PCI Express
Root Port [8086:29a1] (rev 02)
00:1a.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI #4 [8086:2834] (rev 02)
00:1a.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI #5 [8086:2835] (rev 02)
00:1a.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB2 EHCI #2 [8086:283a] (rev 02)
00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8 Family) HD
Audio Controller [8086:284b] (rev 02)
00:1c.0 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 1 [8086:283f] (rev 02)
00:1c.5 PCI bridge [0604]: Intel Corporation 82801H (ICH8 Family) PCI
Express Port 6 [8086:2849] (rev 02)
00:1d.0 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI #1 [8086:2830] (rev 02)
00:1d.1 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI #2 [8086:2831] (rev 02)
00:1d.2 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB UHCI #3 [8086:2832] (rev 02)
00:1d.7 USB Controller [0c03]: Intel Corporation 82801H (ICH8 Family)
USB2 EHCI #1 [8086:2836] (rev 02)
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge
[8086:244e] (rev f2)
00:1f.0 ISA bridge [0601]: Intel Corporation 82801HB/HR (ICH8/R) LPC
Interface Controller [8086:2810] (rev 02)
00:1f.2 SATA controller [0106]: Intel Corporation 82801HR/HO/HH
(ICH8R/DO/DH) 6 port SATA AHCI Controller [808
6:2821] (rev 02)
00:1f.3 SMBus [0c05]: Intel Corporation 82801H (ICH8 Family) SMBus
Controller [8086:283e] (rev 02)
01:00.0 VGA compatible controller [0300]: nVidia Corporation G70
[GeForce 7300 GT] [10de:0393] (rev a1)
02:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd.
88E8056 PCI-E Gigabit Ethernet Controller [1
1ab:4364] (rev 12)
04:02.0 Mass storage controller [0180]: Silicon Image, Inc. SiI 3512
[SATALink/SATARaid] Serial ATA Controller
 [1095:3512] (rev 01)
04:03.0 FireWire (IEEE 1394) [0c00]: Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link) [104c
:8023]
04:04.0 Ethernet controller [0200]: Marvell Technology Group Ltd.
88E8001 Gigabit Ethernet Controller [11ab:43
20] (rev 14)

dmesg can be found at http://fredrik.obra.se/dmesg-fubar

-- 
Fredrik Rinnestam
