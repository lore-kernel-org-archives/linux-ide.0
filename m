From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: enable GHC.AE bit before set GHC.HR
Date: Wed, 26 Sep 2007 12:20:46 -0400
Message-ID: <46FA86DE.70204@garzik.org>
References: <200709211327569648280@gmail.com>	<46F9DA07.4080201@garzik.org>	<20070926122332.39351382@the-village.bc.nu>	<46FA4587.4070105@garzik.org>	<20070926153028.6fc5b2ce@the-village.bc.nu>	<46FA6DB8.70508@garzik.org> <20070926171030.6b07fa42@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41349 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491AbXIZQUw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Sep 2007 12:20:52 -0400
In-Reply-To: <20070926171030.6b07fa42@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peer Chen <peerchen@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Wed, 26 Sep 2007 10:33:28 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Alan Cox wrote:
>>>>> NAK - mmio is an iomap so writel and readl are the wrong things to use
>>>> The patch is consistent with the rest of the driver.
>>>> You are welcome to submit a patch to convert ahci to using ioremap.
>>> You could just flip the relevant function to use ioread while you are
>>> tidying it up, instead of spreading new bugs into the code.
>> No, as I just noted above, the proper fix for this driver is to use 
>> ioremap rather than pci_iomap.
>>
>> Adding support to ahci for legacy PIO is completely pointless.
> 
> iomap isn't just for legacy PIO. It allows us to handle future weird
> mappings in ways ioremap cannot.

Well, when needs dictate, we can re-evaluate.

Until some future date arrives where it matters for all these MMIO-only 
drivers and hardware, it's just a bunch of pointless overhead for ahci 
and many other drivers.  It's also just not the Linux way to punish 
everybody for some edge case that so far only exists in email conversations.

The beauty of libata is that you don't have to enforce such a pogrom 
across all libata drivers.  The libata high level API is completely free 
from ioread/iowrite junk, leaving each driver to make its own decision.

	Jeff



