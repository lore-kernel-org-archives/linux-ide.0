From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: AHCI suspend/resume patch can't work with latest #upstream
Date: Mon, 12 Jun 2006 17:17:54 +0800
Message-ID: <1150103874.7132.13.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11449 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751347AbWFLJaJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 05:30:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hi, Tejun

Let me describe the problem step by step:

1 AHCI suspend/resume patch can work very well with #upstream
[ef2824073fba9def3cf122e89cc485f66dd71f70], we call this kernel1

2 AHCI suspend/resume patch can't work with #upstream
[1049cb478783c74ca8c99ef70e7d2bf920b9335b], AHCI suspend/resume patch
can be easily applied to current #upstream with only some hunk offset,
no logic modification is needed; we call this kernel2

3 The following are related log messages from failed AHCI suspend/resume
of kernel2:
......

ata1: exception Emask 0x52 SAct 0x0 SErr 0xffffffff action 0x2 frozen
ata1: (irq_stat 0x00400000, PHY RDY changed)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
......
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 5 (level, low)
-> IRQ5
ata1: hard resetting port
ACPI: PCI Interrupt 0000:00:1f.2[B] -> Link [LNKD] -> GSI 11 (level,
low) -> IRQ 11
......
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
Restarting tasks... done
e1000: eth0: e1000_watchdog_task: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_watchdog_task: 10/100 speed: disabling TSO
input: AT Translated Set 2 keyboard as /class/input/input1
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1: EH complete

>From above log, we observed that during suspend a PHYRDY interrupt is
generated, then EH followed. This is reproducible. From AHCI spec1.1, I
don't find any information that specify "a PHYRDY should follow a
software-initiated power state transition".

4 Then I comment out the power transition code(in ahci_port_standby())
of kernel2, this way AHCI suspend/resume can succeed. And no PHYRDY is
generated.

5 Suspend/resume of kernel1 can always succeed with the power transition
code in. No PHYRDY is generated.

6 So I suspend the pre-condition of suspend in kernel1 and kernel2 is
different, but I don't know how to dig deeper from here.......

Do you have any ideas about this problem?

Thanks,
Forrest
