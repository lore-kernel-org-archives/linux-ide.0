From: "Steffen D." <ml@saxnet.de>
Subject: CF-Card DMA problem
Date: Tue, 04 Sep 2007 23:02:42 +0200
Message-ID: <46DDC7F2.8080502@saxnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from saxnet.de ([85.10.198.206]:57182 "EHLO coredumb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753746AbXIDVOE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Sep 2007 17:14:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by coredumb.de (Postfix) with ESMTP id D9CB91C805C
	for <linux-ide@vger.kernel.org>; Tue,  4 Sep 2007 23:02:56 +0200 (CEST)
Received: from coredumb.de ([127.0.0.1])
	by localhost (saxnet.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pF053PDIe9FE for <linux-ide@vger.kernel.org>;
	Tue,  4 Sep 2007 23:02:52 +0200 (CEST)
Received: from [192.168.2.24] (p54B4CF6C.dip.t-dialin.net [84.180.207.108])
	by coredumb.de (Postfix) with ESMTP id C15B11C805B
	for <linux-ide@vger.kernel.org>; Tue,  4 Sep 2007 23:02:52 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

im building a kernel for my db800 development board running with linux.

In short "words", here is the problem:

-----------------------------------copy------------------------------------------------- 

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD5536: IDE controller at PCI slot 0000:00:0f.2
AMD5536: chipset revision 1
AMD5536: not 100% native mode: will probe irqs later
AMD5536: 0000:00:0f.2 (rev 01) UDMA100 controller
  ide0: BM-DMA at 0x1ca0-0x1ca7, BIOS settings: hda:pio, hdb:pio
hda: SanDisk SDCFH-2048, CFA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 4001760 sectors (2048 MB) w/1KiB Cache, CHS=3970/16/63, DMA
hda:<4>hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
hda1
-----------------------------------/copy------------------------------------------------- 


Here are some more information...

Full bootlog - http://nopaste.info/5498e6335b.html

Kernel .config - http://rootbox.de/kernelconf

Im very that it is a real sandisk, hdparm says the DMA is disabled. The 
card supports MWDMA modes 0 to 2...
Does anybody have i idea what todo here?

Any tipps are very welcome :)

Regards,

Steffen



