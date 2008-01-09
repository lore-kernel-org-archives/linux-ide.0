From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [CALL-FOR-HELP] pata_ali: can't get MWDMA working!
Date: Wed, 9 Jan 2008 23:55:34 +0100
Message-ID: <200801092355.34934.bzolnier@gmail.com>
References: <4784FBC1.7070804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:58034 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736AbYAIWp0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 17:45:26 -0500
Received: by ug-out-1314.google.com with SMTP id z38so150762ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 09 Jan 2008 14:45:25 -0800 (PST)
In-Reply-To: <4784FBC1.7070804@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE/ATA development list <linux-ide@vger.kernel.org>, andre@linux-ide.org


Hi Tejun,

On Wednesday 09 January 2008, Tejun Heo wrote:
> Hello, all.
> 
> Broken MWDMA on pata_ali has caused a number of bug reports.  I've been
> trying to fix it for some time now && finally got a machine with
> pata_ali and non-working MWDMA2 ATAPI device on my desk a few weeks ago.
>  Testing confirms what users have been reporting - MWDMA2 works fine
> with the IDE alim15x3 driver while any DMA data transfer on pata_ali
> times out.
> 
> At first I thought this was simple timing programming error, but no.
> pata_ali's mode programming wasn't wrong although it was different in
> how it programs empty slots.  Even after making pata_ali to program the
> controller exactly the same as alim15x3 (identical lspci -xxx results),
> MWDMA didn't work. (attached)
> 
> I wondered whether the device was configured differently, so compared
> hdparm --Istdout results.  They were identical too. (attached)

ATA device, with non-removable media
        Model Number:       IC25N040ATMR04-0
        Serial Number:      MRG208K2K3A37H
        Firmware Revision:  MO2OAD5A
...

Could you also send hdparm output for ATAPI device?  Does it use CDB intr?

> I walked through IDE and libata codes and found some differences in the
> order registers are accessed and which values are written (e.g. libata
> never turns on device 0/1 DMA capable bits in BMDMA status register
> while IDE does).  I made them access the registers in the same order and
> write the same values.  Still no go.
> 
> Then, I made libata probing sequence very close to IDE such that no
> reset is performed and NIEN isn't tempered with.  No go.
> 
> I thought maybe the drive should just be blacklisted.  I took the laptop
> apart, took out the DVD combo drive to ICH7 ata_piix.  It works just fine.
> 
> So, I'm out of ideas at this point.  Any suggestions?  Ideas?

If ATAPI device uses CDB intr then ->irq_clear will be called by
ata_host_intr() on CDB IRQ and may confuse DMA engine (it shouldn't
on most chipsets but older ALi-s are pretty weird)...?

Thanks,
Bart
