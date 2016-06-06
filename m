From: Tejun Heo <tj@kernel.org>
Subject: Re: Lenovo A740 gave up waiting for root device with kernels >= 4.3
Date: Mon, 6 Jun 2016 08:54:22 -0500
Message-ID: <20160606135422.GU31708@htj.duckdns.org>
References: <87vb1mwz73.fsf@fsfe.org>
 <CAA=40861-zFKancJ3w5Zia2v9bpaN4TY3bw7Hi8G=97z_30qVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33370 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcFFNyZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jun 2016 09:54:25 -0400
Received: by mail-oi0-f49.google.com with SMTP id k23so226812603oih.0
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2016 06:54:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAA=40861-zFKancJ3w5Zia2v9bpaN4TY3bw7Hi8G=97z_30qVA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Navin P.S" <navinp1912@gmail.com>
Cc: Kevin Brubeck Unhammer <unhammer@fsfe.org>, linux-ide@vger.kernel.org

Hello,

On Mon, Jun 06, 2016 at 04:56:59PM +0530, Navin P.S wrote:
> Some more things to note from 4.2 dmesg it prints not sure if it is relevant.
> 
> [    0.716610] ahci 0000:00:1f.2: version 3.0
> [    0.716620] ahci 0000:00:1f.2: can't find IRQ for PCI INT B;
> probably buggy MP table
> 
> [    0.735267] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 4 ports 6
> Gbps 0x1 impl SATA mode
> 
> [    0.746033] ata1: SATA max UDMA/133 abar m2048@0xb5618000 port
> 0xb5618100 irq 44
> 
> [    1.068001] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 
> [    1.134029] ata1.00: ATA-8: ST1000LM014-1EJ164-SSHD-8GB, LIV6, max UDMA/133
> [    1.134030] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
> [    1.178470] ata1.00: configured for UDMA/133
> [    1.178620] scsi 0:0:0:0: Direct-Access     ATA
> ST1000LM014-1EJ1 LIV6 PQ: 0 ANSI: 5
> [    1.178853] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks:
> (1.00 TB/931 GiB)
> [    1.178855] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [    1.178879] sd 0:0:0:0: [sda] Write Protect is off
> [    1.178881] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> 
> 
> where as 4.6 and later doesn't print these messages.dmesg | grep
> ata[0-4] gives no output.

Can you please cc full dmesg after boot on both 4.2 and 4.6?

Thanks.

-- 
tejun
