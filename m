From: Tuomas Jormola <tj@solitudo.net>
Subject: Re: PROBLEM: SATA hotplugging not working with nForce MCP61
Date: Sat, 2 Feb 2008 19:37:23 +0200
Message-ID: <20080202173723.GA26461@solitudo.net>
References: <20080128074336.GB2736@solitudo.net> <47A3FFB4.2010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.solitudo.net ([213.157.84.60]:55085 "EHLO
	mail.solitudo.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbYBBRh1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Feb 2008 12:37:27 -0500
Content-Disposition: inline
In-Reply-To: <47A3FFB4.2010509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sat, Feb 02, 2008 at 02:29:24PM +0900, Tejun Heo wrote:
> Tuomas Jormola wrote:
> > Hello,
> > 
> > [1.] One line summary of the problem:
> > SATA hotplugging does not seem to work with NVIDIA nForce MCP61.
> > 
> > [2.] Full description of the problem/report:
> > I have a machine with ASRock 939NF6G-VSTA motherboard (more info:
> > http://www.asrock.com/mb/overview.asp?Model=939NF6G-VSTA). The SATA
> > functionality of the board is enabled by sata_nv driver. However, when I
> > tested hot plugging of a SATA hard disk, no hotplugging events were
> > generated when I detached the SATA cable from the disk. I tested the same
> > disk with an older machine which has MSI Neo Platinium motherboard with
> > nForce3 250Gb chipset, also driven by sata_nv driver, and hot plugging
> > was ok. Both experiments were done on the same kernel, Ubuntu gutsy
> > desktop installer/live CD was used to boot the machines. The attached
> > file sata_nv_hotplug_ok.txt is the kernel log of the latter system. At
> > around 814 the cable was detached from the drive and by 827 the disk was
> > removed from the running configuration. Then at around 871 the cable was
> > re-attached, and by 887 the disk was usable again. The file
> > sata_nv_hotplug_not_ok.txt contains kernel log of the machine with the
> > MCP61 chipset. When the cable is detached, nothing will be printed to the
> > log. I hope there is a solution to this problem.
> 
> Can you please post the result of 'lspci -nn'?
Sure. Here it is.

00:00.0 RAM memory [0500]: nVidia Corporation MCP61 Memory Controller [10de:03ea] (rev a1)
00:01.0 ISA bridge [0601]: nVidia Corporation MCP61 LPC Bridge [10de:03e0] (rev a2)
00:01.1 SMBus [0c05]: nVidia Corporation MCP61 SMBus [10de:03eb] (rev a2)
00:01.2 RAM memory [0500]: nVidia Corporation MCP61 Memory Controller [10de:03f5] (rev a2)
00:02.0 USB Controller [0c03]: nVidia Corporation MCP61 USB Controller [10de:03f1] (rev a2)
00:02.1 USB Controller [0c03]: nVidia Corporation MCP61 USB Controller [10de:03f2] (rev a2)
00:04.0 PCI bridge [0604]: nVidia Corporation MCP61 PCI bridge [10de:03f3] (rev a1)
00:05.0 Audio device [0403]: nVidia Corporation MCP61 High Definition Audio [10de:03f0] (rev a2)
00:06.0 IDE interface [0101]: nVidia Corporation MCP61 IDE [10de:03ec] (rev a2)
00:07.0 Bridge [0680]: nVidia Corporation MCP61 Ethernet [10de:03ef] (rev a2)
00:08.0 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)
00:08.1 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)
00:09.0 PCI bridge [0604]: nVidia Corporation MCP61 PCI Express bridge [10de:03e8] (rev a2)
00:0b.0 PCI bridge [0604]: nVidia Corporation MCP61 PCI Express bridge [10de:03e9] (rev a2)
00:0c.0 PCI bridge [0604]: nVidia Corporation MCP61 PCI Express bridge [10de:03e9] (rev a2)
00:0d.0 VGA compatible controller [0300]: nVidia Corporation GeForce 6100 nForce 430 [10de:03d0] (rev a2)
00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map [1022:1101]
00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller [1022:1102]
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control [1022:1103]

-- 
Tuomas Jormola <tj@solitudo.net>
