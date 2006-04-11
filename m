From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: libata-pata works on ICH4-M
Date: Tue, 11 Apr 2006 20:46:15 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0604112044340.25940@yvahk01.tjqt.qr>
References: <443B9EBB.6010607@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from linux01.gwdg.de ([134.76.13.21]:12449 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750892AbWDKSqX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 14:46:23 -0400
In-Reply-To: <443B9EBB.6010607@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello list,

>just a quick note to tell you that with ATA_ENABLE_PATA my
>system works fine and does even survive suspend-to-ram.
>This is a Samsung P35 laptop with one builtin 80 GB harddisk
>and one builtin DVD-RAM drive.
>libata patches are the ones included in 2.6.17-rc1-mm2 with
>an additional one-liner:
>
>ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1860 irq 14
>ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:6003 85:3c69 86:3f01 87:6003 88:203f
>ata1: dev 0 ATA-7, max UDMA/100, 156368016 sectors: LBA48
>ata1: dev 0 configured for UDMA/100
>scsi0 : ata_piix
>  Vendor: ATA       Model: SAMSUNG MP0804H   Rev: UE10
>  Type:   Direct-Access                      ANSI SCSI revision: 05
>SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
[...]

So libata has the overhead of using SCSI commands? At least 
that's what it suggests to the normal user.



Jan

