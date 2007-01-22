From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] ide: Fix ATAPI DMA lost irq problem with CDB intr devices
Date: Mon, 22 Jan 2007 16:45:54 +0800
Message-ID: <45B479C2.7090300@tw.ibm.com>
References: <45AF57BE.7060505@tw.ibm.com> <58cb370e0701191133m3dd584ffna5b231b00392c13d@mail.gmail.com> <45B12318.9000704@gmail.com> <45B467A9.6040404@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:34802 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbXAVIqC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 03:46:02 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l0LMiQaD010860
	for <linux-ide@vger.kernel.org>; Sun, 21 Jan 2007 17:44:26 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id l0M8jvU5519912
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 01:45:57 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0M8jvTP017818
	for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 01:45:57 -0700
In-Reply-To: <45B467A9.6040404@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, "Adam W. Hawks" <awhawks@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Albert Lee wrote:
> Hi Bart,
> 
>>Albert Lee wrote:
>>
>>
>>>Problem: IDE ATAPI DMA lost irq with CDB intr devices on Intel ICHx
>>>machines.
>>>
>>>This patch clears the INTR and ERROR bits of DMA status before starting
>>>BMDMA to fix the problem.
>>
>>
>>[PATCH] ide-cd: Handle strange interrupt on the Intel ESB2
>>http://lkml.org/lkml/2006/12/4/201
>>
>>The above patch was already merged so it seems that the list
>>of PCI IDs requiring ->atapi_irq_bogon needs to be expanded...
> 
> 
> Instead of adding PCI IDs to the blacklist, could we just unconditionally
> clear the dma_status:INTR in ide_dma_start()?
> 

Sorry I did not read through the ICH7 irq storm problem well.

It seems clearing dma_status:INTR in ide_dma_start() is only good for
  1. Spurious interrupt problem (http://lkml.org/lkml/2006/12/4/201) and
  2. This CDB intr device + ICHx irq lost problem
    (http://www.mail-archive.com/linux-ide@vger.kernel.org/msg02934.html)
But it does not fix
  3. ICH7 native mode irq storm problem (http://lkml.org/lkml/2006/11/15/94).

Maybe we should clearing the INTR in the interrupt handler, no matter it is
DMA/PIO/ATA/ATAPI, just like what libata does.

Will check ide_intr() to see if we can clear the bmdma_status:INTR there.
--
albert

