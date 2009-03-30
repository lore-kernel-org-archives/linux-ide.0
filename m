From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Removing PCI dependency of ahci and making it amba bus
  compatible
Date: Sun, 29 Mar 2009 22:26:49 -0400
Message-ID: <49D02DE9.4080106@garzik.org>
References: <3fb94e50903260700r36365d4ue27edf43b5ee9efd@mail.gmail.com> <49CFFA61.8000107@pobox.com> <3fb94e50903291900x2caac3c7nc30c842015570089@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42475 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756167AbZC3C0y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Mar 2009 22:26:54 -0400
In-Reply-To: <3fb94e50903291900x2caac3c7nc30c842015570089@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: Linux IDE mailing list <linux-ide@vger.kernel.org>

Sagar Borikar wrote:
> Thanks Jeff! Much appreciated all your comments.
> Shall send the modified patch soon.
> 
> On Mon, Mar 30, 2009 at 4:16 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
>> Comments:
>>
>> * I am concerned at the unmodified duplication of so much code.  Given that
>> so little core AHCI modification was done, I would be interested in
>> exploring alternatives to wholesale code duplication.
> 
> So do you want to have a new file for ahci amba changes?

Well, two alternatives come to mind:

* add amba changes to ahci.c.  Plenty of drivers are multi-bus, and AHCI 
need not be any different.  sata_mv works on PCI and SoC embedded, for 
example.

* create libahci.c containing most of the code, and let ahci.c and 
ahci-amba.c contain only bus-specific code.

I would lean towards the first solution.


>> * ahci_configure_dma_masks() is wrong.  You must call generic DMA mapping
>> API or amba bus DMA mapping API (if exists), since you cannot call PCI DMA
>> mapping API.
> 
> amba doesn't have dma mapping. So that's why I explicitly set the dma
> mapping stuff for platform specific although I haven't done that port
> specific.

All Linux architectures must support the generic DMA mapping interface, 
even if it is a no-op implementation like i386.

If you peek "under the hood", the PCI DMA mapping interface is really 
just a wrapper for the generic DMA interface.

The right thing to do is convert AHCI's DMA mask setup code from PCI DMA 
mapping to generic DMA mapping API, and then make sure that amba fully 
implements the generic DMA mapping API.

Regards,

	Jeff



