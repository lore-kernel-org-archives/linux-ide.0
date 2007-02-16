From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries CD drives
Date: Fri, 16 Feb 2007 16:09:07 +0100
Message-ID: <200702161609.07899.bzolnier@gmail.com>
References: <20070210203512.GA25586@aepfle.de> <200702161553.54550.bzolnier@gmail.com> <45D5C5CC.9070406@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:32360 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbXBPPDW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 10:03:22 -0500
Received: by ug-out-1314.google.com with SMTP id 44so169933uga
        for <linux-ide@vger.kernel.org>; Fri, 16 Feb 2007 07:03:20 -0800 (PST)
In-Reply-To: <45D5C5CC.9070406@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Olaf Hering <olaf@aepfle.de>, Jeff Garzik <jeff@garzik.org>, Paul Mackeras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


On Friday 16 February 2007 15:55, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>    I'm sorry, how those 2 drivers can be equivalent?! The pata_winbond driver 
> >>is for VLB only, sl81c105 was for PCI only -- you certainly want to use 
> >>pata_sl82c105 (indeed better version of sl82c105 driver).
> 
> > I was under the impression that with your fixes these drivers
> > (sl82c105 and pata_sl82c105) are functionally equivalent.
> 
>     They're not yet equivalent. pata_sl82c105 supports all MWDMA modes, 
> sl82c105 still supports only MWDMA2.

Indeed and it seems that IDE core needs ->dma_mode to fix this.

Thanks,
Bart
