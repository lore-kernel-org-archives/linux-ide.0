From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 7/10] ide: add ->chipset field to ide_pci_device_t
Date: Mon, 17 Sep 2007 13:09:30 +0200
Message-ID: <200709171309.30705.bzolnier@gmail.com>
References: <200709112339.34991.bzolnier@gmail.com> <46EC1459.8000709@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:28266 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886AbXIQLHH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 07:07:07 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1117543nfb
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 04:07:07 -0700 (PDT)
In-Reply-To: <46EC1459.8000709@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 15 September 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> > Add ->chipset field to ide_pci_device_t and use it in ide_hwif_configure()
> > to set hwif->chipset.  Convert cmd64x, cy82c693, rz1000 and trm290 host
> > drivers to use this new ability.
> 
> > While at it define hwif_chipset_t as u8 to save some space in hw_regs_t,
> > ide_hwif_t and ide_pci_device_t instances.
> 
>     I( wonder what's so special about say cmd64x_chipset -- why it's got its 
> own value?  Some histerical raisins? :-)

It seems that ide_cmd646 causes serialization of interfaces in init_irq()...
Would be great if somebody could comment more on the reasons for ide_cmd646.

Thanks,
Bart
