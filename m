From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC][DOC] writing IDE driver guidelines
Date: Sat, 15 May 2004 18:23:04 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40A69848.9020304@pobox.com>
References: <200405151923.50343.bzolnier@elka.pw.edu.pl> <20040515173430.GA28873@havoc.gtf.org> <200405151958.03322.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32937 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264759AbUEOWXS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 18:23:18 -0400
In-Reply-To: <200405151958.03322.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Marc Singer <elf@buici.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Saturday 15 of May 2004 19:34, Jeff Garzik wrote:
>>On Sat, May 15, 2004 at 07:23:50PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>>- host drivers should request/release IO resource
>>>  themelves and set hwif->mmio to 2
>>
>>Don't you mean, hwif->mmio==2 for MMIO hardware?
> 
> 
> It is was historically for MMIO, now it means that driver
> handles IO resource itself (per comment in <linux/ide.h>).

Maybe then create a constant HOST_IO_RESOURCES (value==2) to make that 
more obvious?


>>>- define ide_default_irq(), ide_init_default_irq()
>>>  and ide_default_io_base() to (0)
>>
>>Maybe provide generic definitions, so that new arches don't even
>>have to care about this?
> 
> 
> Please explain.

Your document appears to imply that each new arch should define the 
above three symbols.

My suggestion is to devise a method by which new arches don't have to 
care about those symbols at all, unless required to do so by the 
underlying hardware.

	Jeff



