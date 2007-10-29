From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATAPI devices in AHCI mode not working
Date: Mon, 29 Oct 2007 22:13:32 +0000
Message-ID: <20071029221332.1c9525a9@the-village.bc.nu>
References: <39B20DF628532344BC7A2692CB6AEE0701EA6E7D@orsmsx420.amr.corp.intel.com>
	<20071029203028.35645f26@the-village.bc.nu>
	<39B20DF628532344BC7A2692CB6AEE0701EA6FBF@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40788 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752198AbXJ2WLf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 18:11:35 -0400
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0701EA6FBF@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org

> ata1: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101100 irq 216
> ata2: SATA max UDMA/133 abar m1024@0xd9101000 port 0xd9101180 irq 216
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATAPI: ATAPI   DVD D  DH16D2S, EP52, max UDMA/100
> ata1.00: configured for UDMA/100

Much better - no misdetected link type, no device claiming to be PATA
when its SATA.


Right that eliminates all the obvious goings on being caused by broken
devices which is a start. Doesn't shed any light on the rest of it. What
happens if you boot with irqpoll enabled ? (wondering if the timeouts are
ACPI or IRQ routing stuff)
