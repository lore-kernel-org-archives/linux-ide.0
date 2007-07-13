From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Problem with SiS Ide/Pata/Sata on 2.6.22-rc7-git4
Date: Fri, 13 Jul 2007 23:32:59 +0200
Message-ID: <200707132332.59245.bzolnier@gmail.com>
References: <4692A7C3.9030802@mandriva.org> <20070709232742.004def28@the-village.bc.nu> <4693F16A.4050709@mandriva.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:9157 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756775AbXGMVbN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:31:13 -0400
Received: by nf-out-0910.google.com with SMTP id g13so42357nfb
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:31:10 -0700 (PDT)
In-Reply-To: <4693F16A.4050709@mandriva.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Backlund <tmb@mandriva.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Tuesday 10 July 2007, Thomas Backlund wrote:
> Alan Cox skrev:
> >> If you modprobe only sis5513
> >>   OR
> >> If you modprobe only sis5513 and then sata_sis/pata_sis:
> >>   - you get this:
> >>     (the hdb drive does not get detected/usable)
> > 
> > Don't mix old and new IDE like that. We allow both so you can use old SIS
> > and new Jmicron etc for example but there are some cases where trying to
> > load both old and new IDE support for the same chip will do strange
> > things.
> > 
> 
> But there is still a regression here compared to 2.6.17...
> 
> If you load only sis5513 on a 2.6.22 you still get:
> --- quote ---
> <6>SIS5513: chipset revision 1
> <6>SIS5513: not 100% native mode: will probe irqs later
> <6>SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
> <6>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
> <6>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> <7>Probing IDE interface ide0...
> <4>hdb: QUANTUM FIREBALLlct15 07, ATA DISK drive
> <4>hdb: host side 80-wire cable detection failed, limiting max speed to 
> UDMA33
> <7>hdb: selected mode 0x42
> --- quote ---
> 
> wich does not happend on 2.6.17...

I'm a bit confused here.  Do you mean that the warning message
is not printed or that disk is not limited to UDMA33?

Could you send "hdb" part of 2.6.17 dmesg?

> The disk in question is ATA66 capable

Please send output of "hdparm --Istdout /dev/hdb" command.

This is probably one of the early ATA66 disks with the buggy device side
cable detection.  CONFIG_IDEDMA_IVB=y should help but I'm currently working
on adding automatic detection of such disks.

Thanks,
Bart
