From: Andrei Martynov <andrei.martynov@web.de>
Subject: Re[2]: porting IDE patches to PATA driver
Date: Thu, 25 Jun 2009 12:30:21 +0200
Message-ID: <951976828.20090625123021@web.de>
References: <323951117.20090625100956@web.de>
 <20090625092324.2dd4de5a@lxorguk.ukuu.org.uk> <14164712.20090625103834@web.de>
 <20090625100542.525dba02@lxorguk.ukuu.org.uk>
Reply-To: Andrei Martynov <andrei.martynov@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:49571 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbZFYKaY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jun 2009 06:30:24 -0400
In-Reply-To: <20090625100542.525dba02@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hi Alan,

Thursday, June 25, 2009, 11:05:42 AM, you wrote:

> bmdma_setup is called at the start of the DMA command
> bmdma_start is called to begin a DMA transfer
> bmdma_stop is called to end one

thank you for the hint. Maybe I misunderstand something, but this
functions do not look like equivalents of old ide_dma_off,
ide_dma_off_quietly and ide_dma_on commands. The logic implemented in
the old code is "stop DMA transfer but do not disable DMA in case of errors".

I've implemented UDMA support for EM8511 but cannot get MW-DMA working
on EM8500. Either it is as slow as PIO mode or kernel
complains about unhandled IRQ:

platform: Probing driver pata_jasper with device pata_jasper
JASPER PATA (IDE) chipset 8500: UDMA is not supported
scsi0 : pata_jasper
DEV: registering device: ID = 'host0'
CLASS: registering class device: ID = 'host0'
ata1: PATA max MWDMA2 irq 11
jasper_tune_chipset: slave = 0 speed = 0x08
jasper_tune_chipset: slave = 1 speed = 0x08
ata1.00: ATAPI: 9929D05E59V1.500P3311077, , max MWDMA2
jasper_tune_chipset: slave = 0 speed = 0x0c
jasper_tune_chipset: slave = 0 speed = 0x22
ata1.00: configured for MWDMA2
DEV: registering device: ID = 'target0:0:0'
scsi 0:0:0:0: CD-ROM 9929D05E 59V1.500P3311077 3311 PQ: 0 ANSI: 5
DEV: registering device: ID = '0:0:0:0'
bus scsi: add device 0:0:0:0
scsi: Matched Device 0:0:0:0 with Driver sd
scsi: Probing driver sd with device 0:0:0:0
scsi: Matched Device 0:0:0:0 with Driver sr
scsi: Probing driver sr with device 0:0:0:0
irq 11: nobody cared (try booting with the "irqpoll" option)
Function entered at [<011545e0>] from [<01046c98>]
Function entered at [<01046c60>] from [<01046f24>]



-- 
Best regards,
 Andrei                            mailto:andrei.martynov@web.de

