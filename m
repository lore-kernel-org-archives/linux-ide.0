From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE: Fix platform device registration in Swarm IDE	driver
Date: Sun, 28 Sep 2008 17:12:27 +0400
Message-ID: <48DF82BB.8070604@ru.mvista.com>
References: <20080922122853.GA15210@linux-mips.org> <48DA1F9D.6000501@ru.mvista.com> <200809271859.55304.bzolnier@gmail.com> <20080928113931.GA9207@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:12843 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751938AbYI1NLb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 09:11:31 -0400
In-Reply-To: <20080928113931.GA9207@linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

Hello.

Ralf Baechle wrote:

>>>>-	swarm_ide_resource.start = offset;
>>>>-	swarm_ide_resource.end = offset + size - 1;
>>>>-	if (request_resource(&iomem_resource, &swarm_ide_resource)) {

>>>   Why drop request_resource() completely? Replace it by 
>>>request_mem_region().

>>Yes, this needs fixing (otherwise everything looks good).

> No, platform_device_add which is called by platform_device_register*
> will take care of adding the resources - but only if if's told about them
> which the old driver didn't.

    Ah, I've missed that the platform device was registered without resources 
(ugh) -- request_resource() call wasn't pointless then.  Note however that 
request_mem_region() does somewhat different thing: it pins the memory 
resource for the driver, setting IORESOURCE_BUSY flag on the resource (and it 
also walks the resource tree in depth, using __request_resource() on each 
level.  That's the thing that drivers do routinely on intialization.

>   Ralf

MBR, Sergei
