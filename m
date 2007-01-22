From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] ide: Fix ATAPI DMA lost irq problem with CDB intr devices
Date: Mon, 22 Jan 2007 15:28:41 +0800
Message-ID: <45B467A9.6040404@tw.ibm.com>
References: <45AF57BE.7060505@tw.ibm.com> <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com> <45B12318.9000704@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:35302 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbXAVH25 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 02:28:57 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l0LLRPLh002692
	for <linux-ide@vger.kernel.org>; Sun, 21 Jan 2007 16:27:25 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0M7SuCn470448
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 00:28:56 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0M7SuaA018348
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 00:28:56 -0700
In-Reply-To: <45B12318.9000704@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Hi Bart,
> 
> Albert Lee wrote:
> 
>>Problem: IDE ATAPI DMA lost irq with CDB intr devices on Intel ICHx
>>machines.
>>
>>This patch clears the INTR and ERROR bits of DMA status before starting
>>BMDMA to fix the problem.
> 
> 
> [PATCH] ide-cd: Handle strange interrupt on the Intel ESB2
> http://lkml.org/lkml/2006/12/4/201
> 
> The above patch was already merged so it seems that the list
> of PCI IDs requiring ->atapi_irq_bogon needs to be expanded...

Instead of adding PCI IDs to the blacklist, could we just unconditionally
clear the dma_status:INTR in ide_dma_start()?

Reason: Currently the INTR bit is cleared in ide_dma_setup(). Later the
PIO data transfer is used to send ATAPI CDB. The BMDMA is started last.
The bmdma INTR bit might be changed either by spurious irq (as seen by
Alan/Stratus) or by CDB-intr CD-ROM drives (as seen by Adam) etc. during
the time frame before bmdma is actually started.
It looks safer if we can clear INTR right before dma is started.

> 
> Adam, which ICH version is it?
> 
> <snip>
> Does the problem also happen on ICH4?
> 
> 

Adam's box is an ICH (8086:2411) and mine ICH4 (8086:24cb). Yes, this
problem also happen on ICH4. I suspect that all Intel ICHx has such
behavior (i.e. DMA irq lost if INTR is already 1).

BTW, this problem does not reproduce on libata since libata always
clears bmdma INTR in ata_host_intr().

Thanks,

Albert





