From: "Grant Grundler" <grundler@google.com>
Subject: Re: libata NCQ implementation questions
Date: Sun, 11 May 2008 21:05:05 -0700
Message-ID: <da824cf30805112105x4444f38cxb31f5f0e5a105c5e@mail.gmail.com>
References: <18471.32504.953679.399689@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:11532 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbYELEFQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 May 2008 00:05:16 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id m4C457jq032210
	for <linux-ide@vger.kernel.org>; Mon, 12 May 2008 05:05:08 +0100
Received: from ug-out-1314.google.com (ugfc2.prod.google.com [10.66.180.2])
	by zps75.corp.google.com with ESMTP id m4C456DG028391
	for <linux-ide@vger.kernel.org>; Sun, 11 May 2008 21:05:06 -0700
Received: by ug-out-1314.google.com with SMTP id c2so799925ugf.44
        for <linux-ide@vger.kernel.org>; Sun, 11 May 2008 21:05:06 -0700 (PDT)
In-Reply-To: <18471.32504.953679.399689@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jgarzik@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org

On Sun, May 11, 2008 at 4:19 PM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> I've started working on NCQ support for sata_promise,
> and I have a few questions regarding NCQ and libata:
...
> 5. Does dmam_alloc_coherent() give the same alignment guarantees
>   that pci_alloc_consistent() does? That is, both CPU and bus
>   addresses will be aligned to the smallest PAGE_SIZE order that
>   fits the requested size.
>
>   On x86, pci_alloc_consistent() is implemented directly on top of
>   dma_alloc_coherent(), which would imply that dma_alloc_coherent()
>   has at least as strong alignment guarantees as pci_alloc_consistent().
>   And since dmam_alloc_coherent() is documented to be exactly like
>   dma_alloc_coherent() except for being managed, similar alignment
>   guarantees for dmam_alloc_coherent() should be true. However, this
>   refers to one platform's implementation; I can't find any generic
>   documentation about alignment for dma_alloc_coherent().

There is no guarantee on alignment. :(


>   I've looked at pci_set_dma_mask(), but as far as I can tell, it
>   can only express size limits of addresses, it cannot express alignment
>   constraints.

Correct. The section on dma_pool_create() in Documentation/DMA-API.txt
does provide a means for the driver to express alignment requirements.
But I suspect this only solves part of your problem.

>   The issue is that NCQ on Promise SATA is done by an FPDMA engine
>   that unfortunately has a rather annoying addressing limitation:
>   it requires that all NCQ packet and SG data for all active tags
>   on a port is located in a single physical memory region that does
>   not cross a 64KB physical memory boundary.

Could the driver map 64KB space and test if the DMA mapping is
properly aligned?

I'm not sure if it would have to fall back to a bounce-buffer like scheme
to copy the data to a "well aligned" buffer that has the right alignment.
That's obviously not desirable since it's a huge perf hit.

Anyway, This issue was raised by Fujita Tomonori at LSF2008:
    http://iou.parisc-linux.org/lsf2008/IO-DMA_Representations-fujita_tomonori.pdf

I posted a summary of the discussion here (search for "DMA" in the file):
    http://iou.parisc-linux.org/lsf2008/SUMMARY-Storage.txt

The relevant text is:
    Slide 7 proposes adding a new "struct device_dma_parameters" in order
    to put all the DMA related parameters into one place and make
    them visible to IOMMUs. This idea was rejected as over kill.
    The preferred solution (jejb and others) was to just add the
    missing fields to struct device.  Slide 10 summarized where all
    the various parameters currently live and adding another
    struct to deal with it was just adding more pointers that
    we didn't really need. Most devices do DMA and adding the
    fields directly to "struct device".

I don't have access at the moment to a current git tree but
I'm sure someone else can determine if any of the above has
happened in 2.6.26 yet.

hth,
grant
