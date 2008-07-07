From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/8] ide: add ide_set_irq() inline helper
Date: Mon, 7 Jul 2008 20:05:41 +0200
Message-ID: <200807072005.42187.bzolnier@gmail.com>
References: <200711290104.21376.bzolnier@gmail.com> <48723A9B.6030309@ru.mvista.com> <48724BB0.3080008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:14731 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbYGGSLK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 14:11:10 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1034424ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 11:11:01 -0700 (PDT)
In-Reply-To: <48724BB0.3080008@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Mikhail Cherkashin <mcherkashin@ru.mvista.com>

On Monday 07 July 2008, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> >    We're getting "ide0: unexpected interrupt, status=0x58, count=1" with 
> > palm_bk3710 driver when running hdparm with option -X. That interrupt 
> > has beenidentidied to occur while ide_driveid_update() waits for non-BSY 
> > status polling the alt. status reg.  After looking at the code there, I 
> > couldn't help wondering why I never saw that before with any other 
> > controller since the code looked like it was bound to produce the 
> > unexpected interrupts -- unless I'm missing something?..
> 
>      Ah, I know why: unexpected_intr() just is never called for PCI chips. 
> Here's an related excerpt from ide_intr():
> 
> #ifdef CONFIG_BLK_DEV_IDEPCI
>                  if (hwif->chipset != ide_pci)
> #endif  /* CONFIG_BLK_DEV_IDEPCI */
>                  {
>                          /*
>                           * Probably not a shared PCI interrupt,
>                           * so we can safely try to do something about it:
>                           */
>                          unexpected_intr(irq, hwgroup);
> #ifdef CONFIG_BLK_DEV_IDEPCI
>                  } else {
>                          /*
>                           * Whack the status register, just in case
>                           * we have a leftover pending IRQ.
>                           */
>                          (void) hwif->INB(hwif->io_ports.status_addr);
> #endif /* CONFIG_BLK_DEV_IDEPCI */

Yes, we may consider removing #ifdef-s and always calling unexpected_intr()
(ide_driveid_update() needs fixing first though).

Thanks,
Bart
