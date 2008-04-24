From: Tejun Heo <htejun@gmail.com>
Subject: Re: Regression: kernel 2.6.24 ahci problem, does not boot (doesn't
 find SATA disk, i.e. failed to IDENTIFY)
Date: Fri, 25 Apr 2008 06:38:34 +0900
Message-ID: <4810FDDA.5020907@gmail.com>
References: <1209002065.17082.30.camel@corfu>  <480FF550.50802@gmail.com> <1209060137.21811.6.camel@corfu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:21772 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbYDXVip (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Apr 2008 17:38:45 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2110613wra.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Apr 2008 14:38:43 -0700 (PDT)
In-Reply-To: <1209060137.21811.6.camel@corfu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Guenther Thomsen <guenthert@gmail.com>
Cc: kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Shane Huang <Shane.Huang@amd.com>

Guenther Thomsen wrote:
> On Thu, 2008-04-24 at 11:49 +0900, Tejun Heo wrote:
>> Guenther Thomsen wrote:
>> > Not sure, if this issue has been resolved meanwhile. The thread I found 
>> > indicated only that it is believed to be an interrupt routing issue.
>> > 
>> > I ran into this issue, when upgrading Ubuntu from 7.10 (kernel 
>> > 2.6.22-14) to 8.04rc (kernel 2.6.24-16) and added my findings to bug 
>> > 219312 (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/219312) .
>> > 
>> > --8<--
>> > [ 56.463297] SCSI subsystem initialized
>> > [ 56.477843] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 21 (level, low) 
>> > -> IRQ 21
>> > [ 56.478127] ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
>> > [ 56.478178] ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
>> > [...]
>> > [ 57.480373] ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3Gbps 
>> > 0xf impl SATA mode
>> > [ 57.480427] ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum 
>> > part
>> > [ 57.481394] scsi0 : ahci
>> > [ 57.481710] scsi1 : ahci
>> > [ 57.481873] scsi2 : ahci
>> > [ 57.482040] scsi3 : ahci
>> > [ 57.955539] ata1: SATA link up 1.5Gbps (SStatus 113 SControl 300)
>> > [ 87.904552] ata1.00: qc timeout (cmd 0xec)
>> > [ 87.904608] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
>> > [ 87.904653] ata1: failed to recover some devices, retrying in 5 secs
>> > -->8--
>> > 
>> > A "pci=nomsi" got this kernel on its feet again, but if there is still 
>> > interest in kernel messages or other traces, then please let me know.
>>
>> Can you please attach full boot log and the result of "lspci -nn"?
>>
> Attached (please ignore the OOM killer towards the end - there is still 
> some Gnome badness in Ubuntu 8.04rc).

Shane can you please advise on this?  How did your previous
investigation go?  We need to blacklist it one way or the other.

Thanks.

00:00.0 Host bridge [0600]: ATI Technologies Inc RD580 [CrossFire Xpress 3200] Chipset Host Bridge [1002:5952]
00:02.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI-X Root Port [1002:5a34]
00:05.0 PCI bridge [0604]: ATI Technologies Inc RS480 PCI Bridge [1002:5a37]
00:12.0 SATA controller [0106]: ATI Technologies Inc SB600 Non-Raid-5 SATA [1002:4380]
00:13.0 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI0) [1002:4387]
00:13.1 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI1) [1002:4388]
00:13.2 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI2) [1002:4389]
00:13.3 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI3) [1002:438a]
00:13.4 USB Controller [0c03]: ATI Technologies Inc SB600 USB (OHCI4) [1002:438b]
00:13.5 USB Controller [0c03]: ATI Technologies Inc SB600 USB Controller (EHCI) [1002:4386]
00:14.0 SMBus [0c05]: ATI Technologies Inc SBx00 SMBus Controller [1002:4385] (rev 13)
00:14.1 IDE interface [0101]: ATI Technologies Inc SB600 IDE [1002:438c]
00:14.2 Audio device [0403]: ATI Technologies Inc SBx00 Azalia [1002:4383]
00:14.3 ISA bridge [0601]: ATI Technologies Inc SB600 PCI to LPC Bridge [1002:438d]
00:14.4 PCI bridge [0604]: ATI Technologies Inc SBx00 PCI to PCI Bridge [1002:4384]
00:18.0 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration [1022:1100]
00:18.1 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map [1022:1101]
00:18.2 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller [1022:1102]
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control [1022:1103]
01:00.0 VGA compatible controller [0300]: ATI Technologies Inc RV530 [Radeon X1600] [1002:71c2]
01:00.1 Display controller [0380]: ATI Technologies Inc RV530 [Radeon X1600] (Secondary) [1002:71e2]
02:00.0 SATA controller [0106]: JMicron Technologies, Inc. JMicron 20360/20363 AHCI Controller [197b:2360] (rev 02)
03:03.0 FireWire (IEEE 1394) [0c00]: VIA Technologies, Inc. IEEE 1394 Host Controller [1106:3044] (rev c0)
03:04.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller [11ab:4320] (rev 13)

-- 
tejun
