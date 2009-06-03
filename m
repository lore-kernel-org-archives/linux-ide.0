From: Grozdan <neutrino8@gmail.com>
Subject: Re: Kernel 2.6.30rc7 limits IDE to UDMA33
Date: Wed, 3 Jun 2009 14:52:46 +0200
Message-ID: <c5bd819b0906030552w6f23185etb394f83c8b630e6@mail.gmail.com>
References: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
	 <4A25F688.9000407@gmail.com>
	 <c5bd819b0906030435w466368cbsd48be91a97597437@mail.gmail.com>
	 <20090603131407.57c490ed@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f162.google.com ([209.85.219.162]:42171 "EHLO
	mail-ew0-f162.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbZFCMwq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jun 2009 08:52:46 -0400
In-Reply-To: <20090603131407.57c490ed@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hancockrwd@gmail.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

2009/6/3 Alan Cox <alan@lxorguk.ukuu.org.uk>:
>> ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
>> ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
>> pata_via 0000:00:0f.0: PCI INT A -> Link[ALKA] -> GSI 20 (level, low) -> IRQ 20
>> scsi0 : pata_via
>> scsi1 : pata_via
>> ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xdc00 irq 14
>> ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xdc08 irq 15
>> ata1.00: ATA-7: Maxtor 6Y080L0, YAR41BW0, max UDMA/133
>> ata1.00: 160086528 sectors, multi 16: LBA
>> ata1.01: ATA-5: ST340016A, 3.10, max UDMA/100
>> ata1.01: 78165360 sectors, multi 16: LBA
>> ata1.00: limited to UDMA/33 due to 40-wire cable
>> ata1.01: limited to UDMA/33 due to 40-wire cable
>
> The via driver hasn't changed its cable detect handling between 2.6.27
> and now. The actual detection is done by the BIOS either by setting flags
> or via ACPI.
>
> To trace it down I'd need to at minimum to know exactly which kernel the
> behaviour you see changed.
>

Hi Alan,

The limiting only appears on kernel 2.6.30-rc7-git4. I downloaded the
source RPM package from the SUSE build service and compiled it myself,
enabling/tweaking a few things (higher Hz, full preempt, stack
protector enabled, CPU set to Opteron/Athlon64). During configuration,
I did not change any block device or IDE options (except for selecting
anticipatory disk scheduler to be the default), nor any ACPI related
ones. My distro default kernel, which is 2.6.27.21, correctly sets the
UDMA for my disks on this machine. Only kernel 2.6.30-rc7-git4 (which
is the only 2.6.30 kernel I tried so far) limits them to UDMA33. My
IDE cables are alright (I use high-quality black AOpen 80-wires
cables)
