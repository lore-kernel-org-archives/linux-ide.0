From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Sun, 05 Aug 2007 22:10:21 +0400
Message-ID: <46B6128D.8050101@ru.mvista.com>
References: <1185880124.3483.25.camel@localhost>	<46AF76D7.8050800@ru.mvista.com>	<1185916925.8484.23.camel@orchid.arb.net>	<200707312332.10820.bzolnier@gmail.com>	<46B08D63.4040205@ru.mvista.com>	<1185983536.16340.3.camel@orchid.arb.net>	<46B0ADB6.60207@ru.mvista.com>	<1186002225.16340.11.camel@orchid.arb.net>	<46B0F64C.7050706@ru.mvista.com> <20070801234229.1e330ad0@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:63680 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751112AbXHESIT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 5 Aug 2007 14:08:19 -0400
In-Reply-To: <20070801234229.1e330ad0@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bob Ham <rah@bash.sh>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

>>>hpt37x: Bus clock 66 MHz, using DPLL.

>>    Oh?! hpt366.c detected 33 MHz... :-O

> Interesting as it should be using the same algorithm as hpt366 now.

    Actually not: when pata_hpt37x decides to use DPLL, it reports the chosen 
*DPLL* clock instead of the PCI clock.  The question is why it chose 66 MHz on 
HPT374... Looks like it's because of this wrong mask which should be 0xc0:

		dpll = 2;
                 if (port->udma_mask & 0xE0)
                         dpll = 3;

>>>ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 17
>>>scsi2: pata_hpt37x
>>>scsi3: pata_hpt37x
>>>ata3: PATA max UDMA/100 cmd 0x0001efa0 ctl 0x0001ef9e bmdma 0x0001ec00 irq 17
>>>ata4: PATA max UDMA/100 cmd 0x0001ef90 ctl 0x0001ef9a bmdma 0x0001ec00 irq 17

> and it also knows about the bridge knobbling stuff. Most curious

    Not curious at all now. ;-) The former HPT374 clocking fix just remained 
ineffective.

MBR, Sergei
