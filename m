From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: worst via_sata performance
Date: Thu, 01 Apr 2004 01:13:54 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <406BB322.8060509@pobox.com>
References: <200404010357.57111.jkillius@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48520 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262721AbUDAGOI
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Apr 2004 01:14:08 -0500
In-Reply-To: <200404010357.57111.jkillius@arcor.de>
List-Id: linux-ide@vger.kernel.org
To: Jan Killius <jkillius@arcor.de>
Cc: linux-ide@vger.kernel.org

Jan Killius wrote:
> Hello,
> I have some problems with the via_sata driver. The performance is really bad. 
> I'm getting about 20Mb/s which is really slow compared with the generic ide 
> driver(50 MB/s). Is there any way to speed up it a bit? I use the two discs 
> together with the drive mapper for raid0 but the performance is bad and not 
> constant it's stuttering at disc writing to the raid device. Here are some 
> system information.
> 
> 
> Mainboard: asus k8v se
> kernel: 2.6.5-rc3-mm3 with 2.6.5-rc3-libata2
> dmesg:
> libata version 1.02 loaded.
> sata_via version 0.20
> sata_via(0000:00:0f.0): routed to hard irq line 10
> ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 10
> ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 10
> ata1: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3e02 87:4023 
> 88:203f
> ata1: dev 0 ATA, max UDMA/100, 321672960 sectors (lba48)
> ata1: dev 0 configured for UDMA/100
> scsi0 : sata_via
> ata2: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3e02 87:4023 
> 88:203f
> ata2: dev 0 ATA, max UDMA/100, 321672960 sectors (lba48)
> ata2: dev 0 configured for UDMA/100
> scsi1 : sata_via
>   Vendor: ATA       Model: HDS722516VLSA80   Rev: 1.02
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata1: dev 0 max request 32MB (lba48)
>   Vendor: ATA       Model: HDS722516VLSA80   Rev: 1.02
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> ata2: dev 0 max request 32MB (lba48)

Do things change if you back out the "speed up SATA" patch?

Also, device information from hdparm, when using the IDE generic driver, 
would be useful.

Is this in 32-bit or 64-bit mode?

	Jeff




