From: Tejun Heo <htejun@gmail.com>
Subject: Re: FW: LIBATA issue with SATA drive
Date: Thu, 18 Oct 2007 13:09:33 +0900
Message-ID: <4716DC7D.6050007@gmail.com>
References: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:64149 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768AbXJREJk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 00:09:40 -0400
Received: by rv-out-0910.google.com with SMTP id k20so44379rvb
        for <linux-ide@vger.kernel.org>; Wed, 17 Oct 2007 21:09:40 -0700 (PDT)
In-Reply-To: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Ip, Clarence" <CIP@harris.com>
Cc: linux-ide@vger.kernel.org, just.for.lkml@googlemail.com, jens.axboe@oracle.com

Hello, all.

Torsten, Clarence is reporting similar problem on 2.6.22.  The original
message follows.

> I'm using the 2.6.22 sources with a Sii3132 SATA controller and a Seagate HDD.
> What I've noticed is that it often fails to boot with this configuration.
> Warm boots appear to always fail while cold boots (power-cycles) fail maybe
> 20%-50% of the time. Here's a log from my last attempt:
> 
> Loading iSCSI transport class v2.0-724.
> PCI: Enabling device 0000:01:00.0 (0000 -> 0003)
> scsi0 : sata_sil24
> scsi1 : sata_sil24
> ata1: SATA max UDMA/100 cmd 0xe1258000 ctl 0x00000000 bmdma 0x00000000 irq 0
> ata2: SATA max UDMA/100 cmd 0xe125a000 ctl 0x00000000 bmdma 0x00000000 irq 0
> ata1: SATA link down (SStatus 0 SControl 0)
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2: failed to recover some devices, retrying in 5 secs
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2: limiting SATA link speed to 1.5 Gbps
> ata2.00: limiting speed to UDMA7:PIO5
> ata2: failed to recover some devices, retrying in 5 secs
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> ata2: failed to recover some devices, retrying in 5 secs
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> ata2: EH pending after completion, repeating EH (cnt=4)
> i2c /dev entries driver
> IBM IIC driver v2.1
> 
> If the boot succeeds, I have no further problems with HDD access.
> I also did not see this problem with the 2.6.17 kernel. Do you have
> any ideas as to what may be happening? We're running on a PPC440SPE
> processor.
> 
> Thanks in advance, 

The symptom seems very similar to yours but the kernel is 2.6.22 which
doesn't have the SG change which you found out to be broken.  Can you
update us on how the testing of patched kernel went?

-- 
tejun
