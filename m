From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] atapi request sense work
Date: Fri, 21 May 2004 19:55:00 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40AE96D4.8060009@pobox.com>
References: <1084717146.3576.3.camel@patibmrh9> <40AD7FB2.10506@pobox.com><1	 085153750.6103.33.camel@patibmrh9><200405211746.35015.bzolnier@elka.pw.edu	 .	pl><1085162347.4791.24.camel@patibmrh9> <1085170025.3083.91.camel@patibm	r h9><40AE79E1.9020005@pobox.com> <1085181861.3266.11.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20707 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265108AbUEUXzP
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 21 May 2004 19:55:15 -0400
In-Reply-To: <1085181861.3266.11.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Pat LaVarre <p.lavarre@ieee.org>
Cc: linux-ide@vger.kernel.org

Pat LaVarre wrote:
> In the example here, we tell the host to expect to copy out x1000 = 4 Ki
> bytes, but we tell the device to agree to copy out only x0001 blocks
> i.e. x800 = 2 Ki bytes.


That's considered a "don't do that" condition :)

When the kernel generates an IO request, it always generates 
correctly-formed CDBs.  Therefore, the only time this condition will 
occur is if a priveleged user intentionally generates an IO request that 
will kill the hardware.

It is not our intention to load down the kernel with all sorts of checks 
and balances, attempting to prevent certain types of priveleged-user 
insanity :)  As an example, it is required to provide the data phase 
(pio-in, pio-out, dma-in, dma-out, etc.) for libata's taskfile 
interface, as it is for IDE's.

If the sysadmin supplies a PIO-in data phase for the WRITE DMA QUEUED 
command, the sysadmin will most likely kill the driver, or the hardware, 
or both.

The sysadmin can also use /dev/mem to randomly modify bits of kernel 
memory, or read/write to any IO location.  They have plenty of power to 
kill the machine :)

	Jeff


