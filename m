From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel 2.6.30rc7 limits IDE to UDMA33
Date: Wed, 3 Jun 2009 13:14:07 +0100
Message-ID: <20090603131407.57c490ed@lxorguk.ukuu.org.uk>
References: <c5bd819b0906021525l13ee9282j1fb270e141985f66@mail.gmail.com>
	<4A25F688.9000407@gmail.com>
	<c5bd819b0906030435w466368cbsd48be91a97597437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51682 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752385AbZFCMNE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Jun 2009 08:13:04 -0400
In-Reply-To: <c5bd819b0906030435w466368cbsd48be91a97597437@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grozdan <neutrino8@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> ACPI: PCI Interrupt Link [ALKA] disabled and referenced, BIOS bug
> ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
> pata_via 0000:00:0f.0: PCI INT A -> Link[ALKA] -> GSI 20 (level, low) -> IRQ 20
> scsi0 : pata_via
> scsi1 : pata_via
> ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xdc00 irq 14
> ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xdc08 irq 15
> ata1.00: ATA-7: Maxtor 6Y080L0, YAR41BW0, max UDMA/133
> ata1.00: 160086528 sectors, multi 16: LBA
> ata1.01: ATA-5: ST340016A, 3.10, max UDMA/100
> ata1.01: 78165360 sectors, multi 16: LBA
> ata1.00: limited to UDMA/33 due to 40-wire cable
> ata1.01: limited to UDMA/33 due to 40-wire cable

The via driver hasn't changed its cable detect handling between 2.6.27
and now. The actual detection is done by the BIOS either by setting flags
or via ACPI.

To trace it down I'd need to at minimum to know exactly which kernel the
behaviour you see changed.
