From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: hpt374 sata (Highpoint Rocket 1540)
Date: Wed, 1 Aug 2007 23:42:29 +0100
Message-ID: <20070801234229.1e330ad0@the-village.bc.nu>
References: <1185880124.3483.25.camel@localhost>
	<46AF76D7.8050800@ru.mvista.com>
	<1185916925.8484.23.camel@orchid.arb.net>
	<200707312332.10820.bzolnier@gmail.com>
	<46B08D63.4040205@ru.mvista.com>
	<1185983536.16340.3.camel@orchid.arb.net>
	<46B0ADB6.60207@ru.mvista.com>
	<1186002225.16340.11.camel@orchid.arb.net>
	<46B0F64C.7050706@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48388 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754096AbXHAWfZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 18:35:25 -0400
In-Reply-To: <46B0F64C.7050706@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bob Ham <rah@bash.sh>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

> > hpt37x: Bus clock 66 MHz, using DPLL.
> 
>     Oh?! hpt366.c detected 33 MHz... :-O

Interesting as it should be using the same algorithm as hpt366 now.

> > ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 17
> > scsi2: pata_hpt37x
> > scsi3: pata_hpt37x
> > ata3: PATA max UDMA/100 cmd 0x0001efa0 ctl 0x0001ef9e bmdma 0x0001ec00 irq 17
> > ata4: PATA max UDMA/100 cmd 0x0001ef90 ctl 0x0001ef9a bmdma 0x0001ec00 irq 17
> 

and it also knows about the bridge knobbling stuff. Most curious
