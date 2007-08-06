From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] pata_hpt37x: actually clock HPT374 by 50 MHz DPLL
Date: Mon, 06 Aug 2007 21:16:43 +0400
Message-ID: <46B7577B.8010003@ru.mvista.com>
References: <200708052245.16406.sshtylyov@ru.mvista.com> <1186419223.23890.3.camel@orchid.arb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:10792 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757526AbXHFROm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 13:14:42 -0400
In-Reply-To: <1186419223.23890.3.camel@orchid.arb.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bob Ham <rah@bash.sh>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Bob Ham wrote:

>>The DPLL tuning code always set up it for 66 MHz due to wrong UltraDMA mask
>>including mode 5 used to check for the necessity of 66 MHz clocking -- This
>>caused 66 MHz clock to be used for HPT374 chip that does not tolerate it.
>>While fixing this, also remove PLL mode from the TODO list -- I don't think
>>it's still relevant item.

>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>---
>>This is against the current Linus tree.
>>Bob, please test it and report what you'll find out...

> para_hpt37x: bus clock 33MHz, using 50MHz DPLL.

    Aha, note that 33 MHz PCI clock is now reported.

> ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 17
> scsi2: pata_hpt37x
> scsi3: pata_hpt37x
> ata3: PATA max UDMA/100 cmd 0x0001efa0 ctl 0x0001ef9e bmdma 0x0001ec00 irq 17
> ata4: PATA max UDMA/100 cmd 0x0001ef90 ctl 0x0001ef9a bmdma 0x0001ec00 irq 17

> followed by a hard lock

    Well, so it's tougher than just that but the patches are good anyway. 
Wait... doesn't it get stuck trying to pick up the HPT374 chip's function 1?

MBR, Sergei
