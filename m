From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE driver assined IRQ for disabled IDE channel
Date: Sat, 2 Aug 2008 18:28:50 +0200
Message-ID: <200808021828.50665.bzolnier@gmail.com>
References: <200807261358.59667.bzolnier@gmail.com> <200807271556.52270.bzolnier@gmail.com> <20080731.025745.74750491.takada@mbf.nifty.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:7589 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253AbYHBRJc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Aug 2008 13:09:32 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1266116fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2008 10:09:32 -0700 (PDT)
In-Reply-To: <20080731.025745.74750491.takada@mbf.nifty.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: TAKADA Yoshihito <takada@mbf.nifty.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 30 July 2008, TAKADA Yoshihito wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: Re: IDE driver assined IRQ for disabled IDE channel
> Date: Sun, 27 Jul 2008 15:56:52 +0200
> 
> > ide_generic has no enablebits checking but 'ide_generic.probe_mask=1'
> > kernel parameter can be used to limit probing to the first port only.
> 
> Ok, I understood.
> 
> > However shouldn't a designated IDE PCI host driver be used instead?
> 
> I feel drivers/ide/cs5520 is unstable with TuxOnIce. So I use ide_generic
> instead of cs5520 and looked at the state

This may be because cs5520 lacks proper PCI Power Management support
(which will be addressed really soon - 2.6.27-rc1 has the needed
infrastructure and I will post the follow up patch addding it today).

> > [ if this is Cx5520 PCI IDE, the cs5520 host driver misses enablebits
> >   checking, untested fix attached ]
> 
> Yes, My little box has cs5520. I applied the patch, it works fine.
> dmesg says:
> 
> Uniform Multi-Platform E-IDE driver
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> Cyrix 5520: IDE controller (0x1078:0x0002 rev 0x00) at  PCI slot 0000:00:12.0
> PCI: Setting latency timer of device 0000:00:12.0 to 64
> Cyrix 5520: IDE port disabled
>     ide0: BM-DMA at 0x5000-0x5007
> Probing IDE interface ide0...
> hda: IC25N030ATCS04-0, ATA DISK drive

Thanks, for testing it.

I'll push the fix to Linus and once it is in I'll ping the -stable
team to merge 2.6.26 version.

Thanks,
Bart
