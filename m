From: Erik Andersen <andersen@codepoet.org>
Subject: Re: [sata] Promise PATA port on PDC2037x SATA
Date: Thu, 25 Mar 2004 20:16:19 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040326031619.GA1755@codepoet.org>
References: <40638943.9010206@pobox.com>
Reply-To: andersen@codepoet.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from codepoet.org ([166.70.99.138]:1772 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263304AbUCZDQq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2004 22:16:46 -0500
Content-Disposition: inline
In-Reply-To: <40638943.9010206@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Thu Mar 25, 2004 at 08:37:07PM -0500, Jeff Garzik wrote:
> 
> Anybody wanna give this a quick test?  It doesn't actually _do_ anything 
> yet, except attempt to detect the PATA port.

With a Promise SATA150 TX2plus installed and no devices attached:

    libata version 1.02 loaded.
    sata_promise version 0.91
    ata1: SATA max UDMA/133 cmd 0xFC83B200 ctl 0xFC83B238 bmdma 0x0 irq 20
    ata2: SATA max UDMA/133 cmd 0xFC83B280 ctl 0xFC83B2B8 bmdma 0x0 irq 20
    ata1: no device found (phy stat 00000000)
    ata1: thread exiting
    ata2: no device found (phy stat 00000000)
    ata2: thread exiting
    scsi0 : sata_promise
    scsi1 : sata_promise

With a Promise SATA150 TX2plus installed, plus 1 PATA drive:

    libata version 1.02 loaded.
    sata_promise version 0.91
    ata1: SATA max UDMA/133 cmd 0xFC83B200 ctl 0xFC83B238 bmdma 0x0 irq 20
    ata2: SATA max UDMA/133 cmd 0xFC83B280 ctl 0xFC83B2B8 bmdma 0x0 irq 20
    ata1: no device found (phy stat 00000000)
    ata1: thread exiting
    ata2: no device found (phy stat 00000000)
    ata2: thread exiting
    scsi0 : sata_promise
    scsi1 : sata_promise

With a Promise SATA150 TX2plus installed, plus 1 PATA and 1 SATA drive:

    libata version 1.02 loaded.
    sata_promise version 0.91
    ata1: SATA max UDMA/133 cmd 0xFC83B200 ctl 0xFC83B238 bmdma 0x0 irq 20
    ata2: SATA max UDMA/133 cmd 0xFC83B280 ctl 0xFC83B2B8 bmdma 0x0 irq 20
    ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
    ata1: dev 0 ATA, max UDMA/133, 234441648 sectors (lba48)
    ata1: dev 0 configured for UDMA/133
    ata2: no device found (phy stat 00000000)
    ata2: thread exiting
    scsi0 : sata_promise
    scsi1 : sata_promise
      Vendor: ATA       Model: ST3120026AS       Rev: 1.02
      Type:   Direct-Access                      ANSI SCSI revision: 05

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
