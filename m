From: Mark Lord <liml@rtr.ca>
Subject: Re: libata NCQ implementation questions
Date: Mon, 12 May 2008 11:58:48 -0400
Message-ID: <48286938.1090301@rtr.ca>
References: <18471.32504.953679.399689@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3064 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbYELP6t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 May 2008 11:58:49 -0400
In-Reply-To: <18471.32504.953679.399689@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jgarzik@pobox.com, htejun@gmail.com, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> I've started working on NCQ support for sata_promise,
> and I have a few questions regarding NCQ and libata:
> 
> 1. Can I rely not seeing any non-NCQ commands while there
>    are uncompleted NCQ commands on a port?
..

No, you cannot.  So you'll have to code a .qc_defer() method
to hold them off in that case.  For a *really* good example,
see my recently deployed mv_qc_defer() function in sata_mv.c
as of linux-2.6.26-rc2.

> 3. Is qc->tag defined (to zero for instance) for non-NCQ commands?
..

The tag always has a valid value, NCQ or not.

> 4. What are these "internal commands" that map to ATA_TAG_INTERNAL?
>    Are they NCQ or not?
..

Not NCQ, but a valid tag number regardless.
libata reserves one tag for use during error-handling (EH),
primarily for issing the READ_LOG_EXT_10H command to find out which
NCQ command failed and what sector it failed on.


>    Does the existence of ATA_TAG_INTERNAL limit queue depth for NCQ?
..

Yup.  Max depth is 31 instead of 32 for most devices.

> 5. Does dmam_alloc_coherent() give the same alignment guarantees
>    that pci_alloc_consistent() does? That is, both CPU and bus
>    addresses will be aligned to the smallest PAGE_SIZE order that
>    fits the requested size.
..

In sata_mv, I ran into those same concerns, and ended up creating
a couple of pools for local use by the driver.  It uses dmam_pool_create()
(note the extra "m" in "dmam_"), dma_pool_alloc(), and dma_pool_free().

If you just search for "_pool" in sata_mv, you'll find all of the calls
(not many).  The use of "dmam_pool_create()" assures that things will be
cleaned up properly/automatically if the controller ever "goes away".

Cheers
