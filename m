From: Tejun Heo <htejun@gmail.com>
Subject: Re: About forcing 32bit DMA patch for AMD690G(SB600)
Date: Sat, 26 Jan 2008 10:24:47 +0900
Message-ID: <479A8BDF.1090908@gmail.com>
References: <B90463BC30D2E446BA423D888DC85E501BF3CB@sshaexmb1.amd.com> <47992BA3.3070104@gmail.com> <76366b180801242019h382fd604vd1458dab8b64dd4c@mail.gmail.com> <4799788E.1030600@gmail.com> <20080125205743.GA26124@lks.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:10264 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755073AbYAZBY5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jan 2008 20:24:57 -0500
Received: by rv-out-0910.google.com with SMTP id k20so917770rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 25 Jan 2008 17:24:54 -0800 (PST)
In-Reply-To: <20080125205743.GA26124@lks.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Andrew Paprocki <andrew@ishiboo.com>, Shane Huang <Shane.Huang@amd.com>, sriharivijayaraghavan@yahoo.com.au, linux-ide@vger.kernel.org

Hello, Konstantin.

Konstantin A. Lepikhov wrote:
> $ lspci -nn
> 00:00.0 Host bridge [0600]: ATI Technologies Inc RD580 [CrossFire Xpress 3200] Chipset Host Bridge [1002:5952]
> 00:02.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI-X Root Port [1002:5a34]
> 00:05.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI Bridge [1002:5a37]
> 00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380]
> ...
> 
> Is this hardware enough for testing? I can add 2G to existing 4G of RAM
> and post dmesg.

Srihari's system which couldn't do 64bit DMA was ASUS M2A-VM.  I'm
including the result of lspci below.  Shane verified 64bit works on a
configuration which has SB600 and different bridge, RS690, but Shane's
test result wasn't perfect either.  AHCI triggers SERR_INTERNAL if
quirk_disable_all_msi is not used.  quirk_disable_all_msi removes the
problem but specifying "pci=nomsi" doesn't.

It's unknown whether the difference between Srihari's and Shane's is
on the AHCI controller itself (different revisions?) or stemming from
the differences in the rest of the system (host/pci bridges).

The test results point to varied kinds and degrees of problems.  At
the moment.  To avoid turning off anything fancy on systems involving
SB600/700, we definitely need more info.

Shane, can you please summarize chipset product lines and revisions
and how they're configured together (e.g. SB600 Axx goes together with
RSxxx kind of stuff)?

Currently the following issues have been discovered and we need to
find out what's caused by which.

* MSI doesn't work at all.  Possibly host or PCI bridge issue.  Should
  be worked around by quirk_disable_all_msi.  Shane has verified some
  systems do have this problem.  It's still not clear which
  configurations have the problem and in such configurations which
  part.  Currently quirk is applied if the system contains RS400_200
  or RS480 (these are host bridges, right?).

* Disabling INTx disables MSI too.  Should be worked around with
  quirk_msi_intx_disable_bug.  This one seems to be mostly taken care
  of.  New revs of SB700 and all SB800s will have this fixed and Shane
  recently submitted patch to apply quirk to only affected machines.
  Let's wait and see if anything blows.

* 64bit DMA doesn't work.  Should be worked around by adding
  AHCI_HFLAG_32BIT_ONLY in ahci driver.  Srihari's system showed
  failures firmly pointing to this problem.  Shane tested different
  system with SB600 and 64bit DMA itself seemed to work although there
  were some issues.  As written above, it's unclear what causes the
  difference.

* Shane's test with RS690 + SB600 triggered a weird SERR_INTERNAL
  error condition if pci=nomsi is used insted of
  quirk_disable_all_msi.  This is super-weird.  Maybe difference in
  memory layout and 64bit DMA acutally didn't work?  Shane, can you
  please do some data write/read/verify test on the setup?

Thanks.

-[0000:00]-+-00.0  ATI Technologies Inc Unknown device [1002:7910]
           +-02.0-[0000:01]--+-00.0  ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] [1002:5b60]
           |                 \-00.1  ATI Technologies Inc RV370 [Radeon X300SE] [1002:5b70]
           +-07.0-[0000:02]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168B PCI Express Gigabit Ethernet controller [10ec:8168]
           +-12.0  ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380]
           +-13.0  ATI Technologies Inc SB600 USB (OHCI0) [1002:4387]
           +-13.1  ATI Technologies Inc SB600 USB (OHCI1) [1002:4388]
           +-13.2  ATI Technologies Inc SB600 USB (OHCI2) [1002:4389]
           +-13.3  ATI Technologies Inc SB600 USB (OHCI3) [1002:438a]
           +-13.4  ATI Technologies Inc SB600 USB (OHCI4) [1002:438b]
           +-13.5  ATI Technologies Inc SB600 USB Controller (EHCI) [1002:4386]
           +-14.0  ATI Technologies Inc SB600 SMBus [1002:4385]
           +-14.1  ATI Technologies Inc SB600 IDE [1002:438c]
           +-14.2  ATI Technologies Inc SB600 Azalia [1002:4383]
           +-14.3  ATI Technologies Inc SB600 PCI to LPC Bridge [1002:438d]
           +-14.4-[0000:03]--
           +-18.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
           +-18.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map [1022:1101]
           +-18.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller [1022:1102]
           \-18.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control [1022:1103]


00:14.1 IDE interface: ATI Technologies Inc SB600 IDE (prog-if 82 [Master PriP])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step ping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort - <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 01f0 [size=8]
        Region 1: I/O ports at 03f4 [size=1]
        Region 2: I/O ports at 0170 [size=8]
        Region 3: I/O ports at 0374 [size=1]
        Region 4: I/O ports at f900 [size=16]
        Capabilities: [70] Message Signalled Interrupts: Mask- 64bit- Queue=0/0  Enable-
                Address: 00000000  Data: 0000

-- 
tejun
