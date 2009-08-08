From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: CF to SATA bridge support
Date: Fri, 07 Aug 2009 21:21:31 -0600
Message-ID: <4A7CEF3B.9090506@gmail.com>
References: <43479bc90908071059o2ce5ac94v1d9d959e3af44326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f175.google.com ([209.85.210.175]:40183 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932873AbZHHDVe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2009 23:21:34 -0400
Received: by yxe5 with SMTP id 5so2532254yxe.33
        for <linux-ide@vger.kernel.org>; Fri, 07 Aug 2009 20:21:34 -0700 (PDT)
In-Reply-To: <43479bc90908071059o2ce5ac94v1d9d959e3af44326@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu GELI <mathieu.geli@gmail.com>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

On 08/07/2009 11:59 AM, Mathieu GELI wrote:
> Hello,
>
> I'm having detection problems with a CF to SATA bridge on a 2.6.30
> kernel (2.6.30-1-orion5x). Platform is Orion SoC (DNS-323 Dlink NAS)
> The bridge is a "made in china" device with no real name : "CF TO SATA
> Converter" can be read on the package. They mention "Linux support
> whitout any additional drivers",
> and DMA and Ultra DMA support (if CF supports it)
>
> Tests have been done with a 128MB CFI et a 1GB CFII, no differences.
>
> dmesg gives :
>
> [    1.960000] SCSI subsystem initialized
> [    2.180000] libata version 3.00 loaded.
> [    2.230000] sata_mv sata_mv.0: version 1.28
> [    2.230000] sata_mv sata_mv.0: slots 32 ports 2
> [    2.240000] scsi0 : sata_mv
> [    2.240000] scsi1 : sata_mv
> [    2.250000] ata1: SATA max UDMA/133 irq 29
> [    2.250000] ata2: SATA max UDMA/133 irq 29
> [    2.770000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    2.800000] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
> [    8.280000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    8.310000] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
> [    8.310000] ata1: limiting SATA link speed to 1.5 Gbps
> [   13.790000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   13.820000] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
> [   19.300000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   19.300000] ata1: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x1 t4
> [   19.310000] ata1: edma_err_cause=00001000 pp_flags=00000000
> [   19.820000] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   19.840000] ata2.00: ATA-7: SAMSUNG HD103UJ, 1AA01118, max UDMA7
> [   19.840000] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> [   19.870000] ata2.00: configured for UDMA/133

Hmm.. err_mask 0x2 seems to be HSM violation, and 
edma_err_cause=00001000 seems to be.. IORDY timeout? Not sure what that 
is supposed to indicate on this controller..

Mark, any ideas?

>
> (I have the system root on a regular samsung disk attached to the
> second SATA slot)
>
> loaded modules related to storage :
> sd_mod                 34340  3
> sata_mv                29300  3
> libata                169188  1 sata_mv
> scsi_mod              151332  2 sd_mod,libata
>
> Looking at libata options I saw :
> parm:           dma:DMA enable/disable (0x1==ATA, 0x2==ATAPI, 0x4==CF) (int)
> I then tried option libata dma=3. No luck, same error log.
>
> I'm unsure if the problem comes from the orion architecture (marvell
> low-level sata driver ?) or is generic with 2.6.30 (I don't have SATA
> PC hardware here to disambiguate that).
> Any hints, directions I could look for are much appreciated !
>
> Cheers
>
> PS: bridge looks  rigorously like this
> http://ucables.com/img/extra/CF-TO-SATA-CONVERTER-R45822-1.jpg
>

