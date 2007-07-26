From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Re+: SATA hard drive no longer comes up as /dev/sda on 2.6.22 with Intel ICH6M
Date: Thu, 26 Jul 2007 21:11:35 +0200
Message-ID: <200707262111.35691.bzolnier@gmail.com>
References: <469E2F81.8080002@alcatel-lucent.com> <46A661C9.4010900@alcatel-lucent.com> <46A8393E.4040603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:63978 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010AbXGZT7m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591345ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:41 -0700 (PDT)
In-Reply-To: <46A8393E.4040603@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "P.C.Chan" <pc.chan@alcatel-lucent.com>, linux-ide@vger.kernel.org


Hi,

On Thursday 26 July 2007, Tejun Heo wrote:
> Hello,
> 
> P.C.Chan wrote:
> > The last straw which breaks the SATA support is
> > "CONFIG_IDE_GENERIC=y".   Please see enclosed config files.
> > 
> > The description being:
> > 
> > *generic/default IDE chipset support (IDE_GENERIC)
> > 
> > If unsure, say Y.*
> > 
> > The linux distributions would have a hard time in preparing a kernel for
> > general use,  when CONFIG_IDE_GENERIC and libata are somewhat mutally
> > exclusive for Intel chipset.
> 
> Distros usually know better and don't build in the generic driver.  It's
> built as a module and used only as the last resort.
> 
> > I guess it should at least say:
> > 
> > *If unsure, say N.*
> > 
> > It did no harm prior to 2.6.22 though.
> 
> That didn't to any harm probably because ATA quirk code reserved the
> area for libata during PCI initialization, so the generic driver
> couldn't grab the port before libata.  Now that the quirk is gone, the
> generic driver grabs the first IDE channel before libata and you don't
> have dma for your drive.
> 
> cc'ing Bartlomiej.  Bartlomiej, I think it would be better not to
> default to Y for CONFIG_IDE_GENERIC.  For most cases, it just causes
> misconfiguration and confusion these days.

Fully agreed, care to submit a patch?

Thanks,
Bart
