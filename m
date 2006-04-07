From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH/RFC] libata: turn on the ATAPI DMA DIR support per word
 62
Date: Fri, 07 Apr 2006 18:21:34 +0800
Message-ID: <44363D2E.7010700@tw.ibm.com>
References: <CF6023AC-C62F-4BA8-A1DA-5CF6100B9608@verizon.net> <44360922.8050801@tw.ibm.com> <44360B05.6050509@garzik.org>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:61656 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751124AbWDGKWB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Apr 2006 06:22:01 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k37ALtMI023924
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 06:21:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k37AIWTA260026
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 04:18:33 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k37ALsUD025530
	for <linux-ide@vger.kernel.org>; Fri, 7 Apr 2006 04:21:55 -0600
In-Reply-To: <44360B05.6050509@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Jonathan Benson <airbatica@verizon.net>, Tejun Heo <htejun@gmail.com>, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Doug Maxey <dwm@maxeymade.com>

Jeff Garzik wrote:
> 
> Two comments:
> 
> * I would like to find a device that's compliant with the spec, and test
> the patch, before committing.

I'm trying to get an Acard AEC-7900A and a Sunplus 3811A (which looks like
a SiI 3811 rebrand) for test. Since the DMADIR is SiImage's idea,
hopefully the Sunplus 3811A may support DMADIR. For bridges from other
vendors, I guess the chance is low.

> 
> * DMADIR not only includes a bit flag indicating its presence, it also
> moves all the DMA capability bits from their standard places.  You'll
> have to audit every place that reads dev->id[]'s mwdma/udma masks and
> make sure they look at the DMADIR-special-case location, when DMADIR is
> set.
> 

Fortunately only ata_id_xfermask() uses the mwdma/udma bits. Revised
patch to follow. Thanks for the advice.

--
albert

