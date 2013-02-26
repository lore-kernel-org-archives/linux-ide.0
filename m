From: Jan Sembera <fis@bofh.cz>
Subject: Re: Regression between v3.5 and v3.6 in libata
Date: Tue, 26 Feb 2013 23:07:02 +0100
Message-ID: <20130226220702.GC25087@abydos.bofh.cz>
References: <20130226200348.GA25087@abydos.bofh.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anise.cz ([81.0.246.76]:42409 "EHLO anise.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553Ab3BZWHE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2013 17:07:04 -0500
Content-Disposition: inline
In-Reply-To: <20130226200348.GA25087@abydos.bofh.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: mjg@redhat.com, holger@homac.de, ming.m.lin@intel.com, 1126766@bugs.launchpad.net

So I apparently missed two most important differences between good and bad
boots.

On Tue, Feb 26, 2013 at 09:03:48PM +0100, Jan Sembera wrote:
> [    2.877438] scsi6 : pata_atiixp
> [    2.881369] scsi7 : pata_atiixp
> 
> [    2.391535] scsi6 : pata_acpi
> [    2.391994] scsi7 : pata_acpi

pata-acpi doesn't play very well with this controller. Disabling it in
kernel and rebooting (even with 3.8) provided completely working kernel.
So either this driver shouldn't bind pata-acpi and leave it on pata-atiixp
as before (some kind of blacklisting needed?), or it needs some fixing to
work nicely with this controller.

As a workaround for now, I'll just not compile PATA_ACPI into the kernel.

00:14.1 IDE interface: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 IDE Controller (rev 40) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. Device 8496
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at f100 [size=16]
	Kernel driver in use: pata_atiixp

