From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Tue, 08 May 2007 13:12:22 +0200
Message-ID: <46405B16.3000502@gmail.com>
References: <41255.7661.qm@web52612.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:46772 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934238AbXEHLMc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 07:12:32 -0400
Received: by py-out-1112.google.com with SMTP id a29so1445416pyi
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 04:12:32 -0700 (PDT)
In-Reply-To: <41255.7661.qm@web52612.mail.re2.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

Hello,

Srihari Vijayaraghavan wrote:
> --- Tejun Heo <htejun@gmail.com> wrote:
>> It just seems sb600 claims that it can do DMA above 4G while it actually
>> can't.  Can you test the attached patch?
> 
> Makes sense now. Gladly check the patch. Checking ...
> 
> Great news: everything just works without any parameters :-)). True genious.
> 
> With your patch, with 4 GB of RAM, all SATA drives are detected & working
> normally. For the record dmesg is attached.

Thanks for testing.

> There's always a catch isn't it? Now no DMA over 32 bit memory space for SATA,
> right? CPU will have to work harder, I presume. Perhaps putting more pressure.
> While with 4 GB that might not be a problem, perhaps when I upgrade it to over
> 4 GB, it might be?? I see, even now, because a chunk of 512 MB is mapped over
> 4 GB (starting at 0x100000000), those are no good for the SATA's DMA access.
> If so, too sad :-(.

Oh well, that's the price you have to pay when you 1. have a device
which can't access memory above 4G but 2. don't have IOMMU to do it for
the device.  If performance becomes problem, you can always get a
not-so-expensive external controller which can do 64.

> (I'll leave the patch for the poor souls stumble upon these emails some far
> future :-))
> 
> PS: if this turns out to a hardware limitation, then perhaps may I request
> this patch in better form (as not to impact on other ahci users) find its way
> to mainstream? Even to -stable if I'm lucky, such that Fedora 7 etc. might
> work out of the box for poor souls (not counting me; I'm used to quirky
> things) trying out Linux on this chipset.

Yeap, I'll forward it upstream and probably to -stable too.  The problem
here is that I'm not sure whether the problem is in the ahci controller
itself or some bridge chip above it.  It would be best if Conke Hu can
verify this but you can also test it by buying a ATA controller which
can do 64bit and whether it works properly on the machine.  :-)

-- 
tejun
