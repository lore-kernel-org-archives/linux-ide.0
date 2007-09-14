From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 5/10] hpt366: remove ->init_setup
Date: Fri, 14 Sep 2007 21:49:04 +0200
Message-ID: <200709142149.04782.bzolnier@gmail.com>
References: <200708292321.03722.bzolnier@gmail.com> <200709112327.16294.bzolnier@gmail.com> <46EAC9CF.9080102@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:26829 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506AbXINTrM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Sep 2007 15:47:12 -0400
Received: by ug-out-1314.google.com with SMTP id z38so563894ugc
        for <linux-ide@vger.kernel.org>; Fri, 14 Sep 2007 12:47:11 -0700 (PDT)
In-Reply-To: <46EAC9CF.9080102@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Friday 14 September 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>>* Split off hpt{374,371,366}_init() helper from init_setup_hpt{374,371,366}().
> 
> >>>* Merge init_setup_{374,372n,371,372a,302,366}() into hpt366_init_one().
> 
> >>>While at it:
> 
> >>>* Use "HPT36x" name for HPT366/HPT368 chipsets.
> 
> >>>* Add .chip_name to struct hpt_info and use it to set set d->name.
> 
> >>>* Convert .max_ultra in struct hpt_info to .udma_mask and use it to set
> >>>  d->udma_mask.
> 
> >>>* Fix hpt302 to use HPT302_ALLOW_ATA133_6 define.
> 
> >>    I haven't found that change...
> 
>     After wearing better goggles, I had found it. ;-)
> 
> >  static struct hpt_info hpt302 __devinitdata = {
> > +       .chip_name      = "HPT302",
> >         .chip_type      = HPT302,
> > -       .max_ultra      = HPT372_ALLOW_ATA133_6 ? 6 : 5,
> > +       .udma_mask      = HPT302_ALLOW_ATA133_6 ? ATA_UDMA6 : ATA_UDMA5,
> >         .dpll_clk       = 66,
> >         .settings       = hpt37x_settings
> >  };
> 
> >>>* Use the second hpt366_chipsets[] entry for HPT37x chipsets using HPT36x PCI
> >>>  device ID and fix .enablebits/.host_flags for HPT36x hpt366_chipsets[] entry.
> 
> >>    Well, if you're ruining my nearly perfect desigh...
> 
> > I was just adjusting hpt366 for ->init_setup removal, the other changes
> 
>     Well, the code was looked good enough w/it although it wasn't really a 
> method being called only by in the module_init() time...
> 
> > happened by the way... 8)
> 
>     I wanted to both use the newly introduced init. time 'udma_mask' field, 
> and needed this later -- but somehow disliked repeating the masks, so kept the 
> max UDMA mode in the 'struct hpt_info'...
> 
> >>>* Bump driver version.
> 
> >>    ... it's worth to label it 1.20. :-)
> 
> > updated
> 
> >>>+	d = hpt366_chipsets[idx];
> >>>+
> >>>+	d.name = /info->chip_name;
> >>>+	d.udma_mask = info->udma_mask;
> >>>+
> >>>+	pci_set_drvdata(dev, info);
> >>>+
> >>>+	if (info == &hpt36x || info == &hpt374)
> >>>+		dev2 = pci_get_slot(dev->bus, dev->devfn + 1);
> >>>+
> >>>+	if (dev2) {
> >>>+		int ret;
> >>>+
> >>>+		pci_set_drvdata(dev2, info);
> >>>+
> >>>+		if (info == &hpt374)
> >>>+			hpt374_init(dev, dev2);
> >>>+		else {
> >>>+			if (hpt36x_init(dev, dev2))
> >>>+				d.host_flags |= IDE_HFLAG_BOOTABLE;
> >>>+		}
> >>>+
> >>>+		ret = ide_setup_pci_devices(dev, dev2, &d);
> >>>+		if (ret < 0)
> >>>+			pci_dev_put(dev2);
> >>>+		return ret;
> >>>+	}
> >>> 
> >>>-	return d.init_setup(dev, &d);
> >>>+	return ide_setup_pci_device(dev, &d);
> >>> }
> 
> >>    NAK the patch because it's breaking the HPT374 code. Those chips are 
> >>*signle* function, and sit in perfect copule (and why I alsway mistype in this 
> >>word :o) on 2 DEVSELs behind i960.
> 
>     Sigh... I've just mixed it all up with PDC202xx chips, after looking at 

Ok, thanks for rechecking this.

> their init_setup() code -- I'm making a Promise not to do it anymore. :-)

:-)

> > Please explain - there shouldn't be any behavior change for HPT374 caused
> > by this patch.
> 
> > Could it be that HPT374 code was already buggy
> 
>     Hehe, we *know* that it's buggy, what we do not know is where and why. ;-)

Indeed, I managed to forgot about that... :-/

Bart
