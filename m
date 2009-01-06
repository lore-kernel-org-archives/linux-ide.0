From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Tue, 6 Jan 2009 20:54:12 +0100
Message-ID: <200901062054.12835.bzolnier@gmail.com>
References: <49615667.9020408@iwl.com> <4963557D.1020504@ru.mvista.com> <20090106192155.40addc92@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:30404 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbZAFT6V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 14:58:21 -0500
Received: by mu-out-0910.google.com with SMTP id g7so3117831muf.1
        for <linux-ide@vger.kernel.org>; Tue, 06 Jan 2009 11:58:19 -0800 (PST)
In-Reply-To: <20090106192155.40addc92@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com

On Tuesday 06 January 2009, Alan Cox wrote:
> >    Judging on what you have posted, IDE driver would not probably give 
> > any speed improvement, only soewhat lesser memory footprint...
> 
> Except he is also using USB storage so the shared stack with the libata
> code is already loaded ...

Doesn't really matter because libata itself is quite heavy:

$ size drivers/ata/built-in.o drivers/ide/built-in.o
   text    data     bss     dec     hex filename
  84100    6584    4196   94880   172a0 drivers/ata/built-in.o
  50198    1032     240   51470    c90e drivers/ide/built-in.o

[ I'm pretty sure that runtime memory footprint is also lower for IDE. ]

Possible additional gains if usb-storage wouldn't be needed:

$ size drivers/scsi/built-in.o

   text    data     bss     dec     hex filename
  61136    4660     532   66328   10318 drivers/scsi/built-in.o

This is with Linus' tree from today plus "IDE updates part 3" pull request
posted today + CS5536 IDE host driver.  Enabled config options:

* libata

CONFIG_ATA=y
CONFIG_ATA_ACPI=y
CONFIG_ATA_SFF=y
CONFIG_PATA_CS5536=y

* IDE

CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
CONFIG_BLK_DEV_IDEACPI=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_BLK_DEV_IDEDMA_SFF=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_CS5536=y
CONFIG_BLK_DEV_IDEDMA=y

* SCSI

CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_BLK_DEV_SD=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_WAIT_SCAN=m

--
Thanks,
Bart
