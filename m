From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Fix ATAPI DMA lost irq problem with CDB intr devices
Date: Mon, 22 Jan 2007 17:05:56 +0100
Message-ID: <58cb370e0701220805i783dddafse768e500b27fff36@mail.gmail.com>
References: <45AF57BE.7060505@tw.ibm.com>
	 <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com>
	 <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>
	 <45B479C2.7090300@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:44986 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbXAVQF5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 11:05:57 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1089607uga
        for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 08:05:56 -0800 (PST)
In-Reply-To: <45B479C2.7090300@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi,

On 1/22/07, Albert Lee <albertcc@tw.ibm.com> wrote:
> Albert Lee wrote:
> > Hi Bart,
> >
> >>Albert Lee wrote:
> >>
> >>
> >>>Problem: IDE ATAPI DMA lost irq with CDB intr devices on Intel ICHx
> >>>machines.
> >>>
> >>>This patch clears the INTR and ERROR bits of DMA status before starting
> >>>BMDMA to fix the problem.
> >>
> >>
> >>[PATCH] ide-cd: Handle strange interrupt on the Intel ESB2
> >>http://lkml.org/lkml/2006/12/4/201
> >>
> >>The above patch was already merged so it seems that the list
> >>of PCI IDs requiring ->atapi_irq_bogon needs to be expanded...
> >
> >
> > Instead of adding PCI IDs to the blacklist, could we just unconditionally
> > clear the dma_status:INTR in ide_dma_start()?
> >
>
> Sorry I did not read through the ICH7 irq storm problem well.
>
> It seems clearing dma_status:INTR in ide_dma_start() is only good for
>   1. Spurious interrupt problem (http://lkml.org/lkml/2006/12/4/201) and
>   2. This CDB intr device + ICHx irq lost problem
>     (http://www.mail-archive.com/linux-ide@vger.kernel.org/msg02934.html)
> But it does not fix
>   3. ICH7 native mode irq storm problem (http://lkml.org/lkml/2006/11/15/94).
>
> Maybe we should clearing the INTR in the interrupt handler, no matter it is
> DMA/PIO/ATA/ATAPI, just like what libata does.

Seems like a generic and clean way to fix the issue.
Keeping IDE code similar to libata is an additional bonus.

> Will check ide_intr() to see if we can clear the bmdma_status:INTR there.

Please keep me in the loop.

Thanks,
Bart
