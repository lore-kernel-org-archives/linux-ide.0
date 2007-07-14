From: Jeff Garzik <jeff@garzik.org>
Subject: Re: sata_inic162x issue - PCMCIA card
Date: Sat, 14 Jul 2007 14:55:01 -0400
Message-ID: <46991C05.3000408@garzik.org>
References: <11593734.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46187 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760921AbXGNSzE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jul 2007 14:55:04 -0400
In-Reply-To: <11593734.post@talk.nabble.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jm_928 <jm_928@jmtechnology.com>
Cc: linux-ide@vger.kernel.org

jm_928 wrote:
> Hi,
> 
> I have an esata PCMCIA card based on the Initio 1620 chipset. When inserting
> this into my Dell D600 laptop (running Ubuntu 7.04 with the 2.6.20-16
> kernel) I get the following error messages:
> 
> [   27.660000] sata_inic162x 0000:03:00.0: version 0.1
> [   27.660000] PCI: Enabling device 0000:03:00.0 (0000 -> 0003)
> [   27.660000] ACPI: PCI Interrupt 0000:03:00.0[A] -> Link [LNKD] -> GSI 11
> (level, low) -> IRQ 11
> [   27.660000] ACPI: PCI interrupt for device 0000:03:00.0 disabled
> [   27.660000] sata_inic162x: probe of 0000:03:00.0 failed with error -22
> 
> Does anyone have any hints on what this message (particularly error -22)
> means?

-EINVAL

Maybe it's an interrupt problem, like the previous message indicates.

	Jeff



