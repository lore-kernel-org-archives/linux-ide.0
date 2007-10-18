From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: FW: LIBATA issue with SATA drive
Date: Thu, 18 Oct 2007 20:52:26 +0200
Message-ID: <64bb37e0710181152j7d070258w9b9eeb59cf1f0a1d@mail.gmail.com>
References: <AF1760336DB49F43983B755855C2A46702AF744B@troe2k1.cs.myharris.net>
	 <4716DC7D.6050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:25626 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbXJRSw1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 14:52:27 -0400
Received: by py-out-1112.google.com with SMTP id u77so491864pyb
        for <linux-ide@vger.kernel.org>; Thu, 18 Oct 2007 11:52:26 -0700 (PDT)
In-Reply-To: <4716DC7D.6050007@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Ip, Clarence" <CIP@harris.com>, linux-ide@vger.kernel.org, jens.axboe@oracle.com

On 10/18/07, Tejun Heo <htejun@gmail.com> wrote:
> Hello, all.
>
> Torsten, Clarence is reporting similar problem on 2.6.22.  The original
> message follows.

I don't think it matches.

> > I'm using the 2.6.22 sources with a Sii3132 SATA controller and a Seagate HDD.
> > What I've noticed is that it often fails to boot with this configuration.
> > Warm boots appear to always fail while cold boots (power-cycles) fail maybe
> > 20%-50% of the time. Here's a log from my last attempt:

For me warm boots always worked and even cold boots only failed after
turning the power off for several minutes. (I tested with ~1 hour
downtime)
But the failures on cold boot where "relativ" reliable, I would guess >50%.

> > Loading iSCSI transport class v2.0-724.
> > PCI: Enabling device 0000:01:00.0 (0000 -> 0003)
> > scsi0 : sata_sil24
> > scsi1 : sata_sil24
> > ata1: SATA max UDMA/100 cmd 0xe1258000 ctl 0x00000000 bmdma 0x00000000 irq 0
> > ata2: SATA max UDMA/100 cmd 0xe125a000 ctl 0x00000000 bmdma 0x00000000 irq 0
> > ata1: SATA link down (SStatus 0 SControl 0)
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
> > ata2.00: qc timeout (cmd 0xec)
> > ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> > ata2: failed to recover some devices, retrying in 5 secs
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
> > ata2.00: qc timeout (cmd 0xec)
> > ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> > ata2: limiting SATA link speed to 1.5 Gbps
> > ata2.00: limiting speed to UDMA7:PIO5

My failure also came much later. It seemed the first write command (to
a md raid) triggered it.
All of my drives where always detected correctly.

> > ata2: failed to recover some devices, retrying in 5 secs
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> > ata2.00: qc timeout (cmd 0xec)
> > ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> > ata2: failed to recover some devices, retrying in 5 secs
> > ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
> > ata2: EH pending after completion, repeating EH (cnt=4)
> > i2c /dev entries driver
> > IBM IIC driver v2.1
> >
> > If the boot succeeds, I have no further problems with HDD access.
> > I also did not see this problem with the 2.6.17 kernel. Do you have
> > any ideas as to what may be happening? We're running on a PPC440SPE
> > processor.

I'm using x86_64 on an Opteron system.

> The symptom seems very similar to yours but the kernel is 2.6.22 which
> doesn't have the SG change which you found out to be broken.  Can you
> update us on how the testing of patched kernel went?

Sorry I didn't realize that you where still waiting for a 'confirm
good'. I intended only to mail, if I got the error again, as the debug
output about SGE_TRM confirmed, that this fix changes the behavior of
sata_sil24 and there was no really 200% sure method of detecting that
this bug was gone.

Anyway, after fixing ata_sg_is_last() by adding the +1 I did not had a
single failure.

I'm currently using 2.6.23-mm1 and 16 boots where all good.
(Apart from the unrelated failure with sata_nv and swncq...)

Torsten
