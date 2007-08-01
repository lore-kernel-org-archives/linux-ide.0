From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Thu, 02 Aug 2007 01:08:28 +0400
Message-ID: <46B0F64C.7050706@ru.mvista.com>
References: <1185880124.3483.25.camel@localhost>	 <46AF76D7.8050800@ru.mvista.com> <1185916925.8484.23.camel@orchid.arb.net>	 <200707312332.10820.bzolnier@gmail.com>  <46B08D63.4040205@ru.mvista.com>	 <1185983536.16340.3.camel@orchid.arb.net>  <46B0ADB6.60207@ru.mvista.com> <1186002225.16340.11.camel@orchid.arb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:27607 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751481AbXHAVGa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Aug 2007 17:06:30 -0400
In-Reply-To: <1186002225.16340.11.camel@orchid.arb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Bob Ham wrote:

>>>hpt37x: DPLL did not stabilize.
>>>pata_hpt37x: BIOS has not set timing clocks.
>>>hpt37x: DPLL did not stabilize.

>>   Yes, this ia a known issue, and the fix for it is in the -mm tree:

> I applied just that pata_hpt37x.c patch, not the whole -mm tree.  It
> locks the machine hard again.  Here is the transcribed output:

> hpt37x: Bus clock 66 MHz, using DPLL.

    Oh?! hpt366.c detected 33 MHz... :-O

> ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 17
> scsi2: pata_hpt37x
> scsi3: pata_hpt37x
> ata3: PATA max UDMA/100 cmd 0x0001efa0 ctl 0x0001ef9e bmdma 0x0001ec00 irq 17
> ata4: PATA max UDMA/100 cmd 0x0001ef90 ctl 0x0001ef9a bmdma 0x0001ec00 irq 17

MBR, Sergei
