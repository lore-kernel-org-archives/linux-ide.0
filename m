From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: 2.6.30-rc4 kernel
Date: Thu, 21 May 2009 09:45:12 +0200
Message-ID: <20090521074509.GA18031@liondog.tnic>
References: <20090519230714.3E030567C@p4.dav.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50111 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbZEUHpP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2009 03:45:15 -0400
Received: by fxm2 with SMTP id 2so865210fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 21 May 2009 00:45:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090519230714.3E030567C@p4.dav.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: pete@drackon.com
Cc: linux-ide@vger.kernel.org

Hi,

please CC linux-ide@vger.kernel.org when answering to that thread.

On Wed, May 20, 2009 at 12:07:14AM +0100, pete@drackon.com wrote:
> On Mon, May 18, 2009 at 09:05:58PM +0100, rob@housetosell.net wrote:
> via82cxxx 0000:00:11.1: VIA vt8235 (rev 00) IDE UDMA133
> via82cxxx 0000:00:11.1: IDE controller (0x1106:0x0571 rev 0x06)
> VIA_IDE 0000:00:11.1: can't derive routing for PCI INT A
> via82cxxx 0000:00:11.1: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xfc00-0xfc07
>     ide1: BM-DMA at 0xfc08-0xfc0f
> Probing IDE interface ide0...
> hda: Maxtor 2F040L0, ATA DISK drive
> hdb: Maxtor 4D040H2, ATA DISK drive
> hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hda: host side 80-wire cable detection failed, limiting max speed to UDMA33
> hda: UDMA/33 mode selected
> hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hdb: host side 80-wire cable detection failed, limiting max speed to UDMA33
> hdb: UDMA/33 mode selected
> Probing IDE interface ide1...
> hdc: ATAPI DVD-ROM 16XMax, ATAPI CD/DVD-ROM drive
> hdd: SONY DVD RW AW-G170A, ATAPI CD/DVD-ROM drive
> hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hdc: UDMA/33 mode selected
> hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> hdd: UDMA/66 mode selected
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide_generic: please use "probe_mask=0x3f" module parameter for probing all legacy ISA IDE ports
> ide-gd driver 1.18
> hda: max request size: 128KiB
> hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
> hdb: max request size: 128KiB
> hdb: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63
> hdb: cache flushes not supported
>  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
>  hdb2: <openbsd:bad subpartition - ignored
> bad subpartition - ignored
> bad subpartition - ignored
> bad subpartition - ignored
>  >
>  hdb3: <bsd: >
> ide-cd driver 5.00
> ide-cd: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
> Uniform CD-ROM driver Revision: 3.20
> ide-cd: hdd: ATAPI 48X DVD-ROM DVD-R/RAM CD-R/RW drive, 2048kB Cache

Here are several things you could try:

1. this patch: http://patchwork.kernel.org/patch/24790/ - it has fixed two
similar bugs already.

2. Also, try connecting your hdc and hdd devices with an 80-conductor
IDE cable (those with the blue connector on the motherboard side) and
see whether that fixes the problem.

3. send the output of 'hdparm --Istdout /dev/hdc'

Thanks.

-- 
Regards/Gruss,
    Boris.
