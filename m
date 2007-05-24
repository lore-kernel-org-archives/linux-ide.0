From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 07:09:56 -0400
Message-ID: <46557284.3050301@pobox.com>
References: <20070515061239.611A2DDEE9@ozlabs.org>	<1179209697.32247.153.camel@localhost.localdomain>	<20070523144217.5abd9fdf@the-village.bc.nu>	<1179960518.32247.948.camel@localhost.localdomain>	<20070524003123.77b9c81c@the-village.bc.nu>	<1179963820.32247.996.camel@localhost.localdomain>	<20070524001302.GA18571@devserv.devel.redhat.com>	<1179978137.32247.1035.camel@localhost.localdomain>	<20070524105407.64514929@the-village.bc.nu>	<46556E5D.3070203@pobox.com> <20070524120915.40b594a8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42505 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755424AbXEXLKA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 07:10:00 -0400
In-Reply-To: <20070524120915.40b594a8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Thu, 24 May 2007 06:52:13 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> Alan Cox wrote:
>>>> Currently libata does the 400ns thingy in the inline ata_pause() which
>>>> unconditionally does ata_altstatus(); ndelay(400); (and thus does it on
>>>> PIO, MMIO, anything ...).
>>> It might actually improve performance for PATA if we did as we'll get rid
>>> of an excess (expensive) PCI read access for non MMIO cases.
>> The spec says you should read AltStatus.  I am definitely not inclined 
>> to change that part.
> 
> Which spec says that and where ?

It's buried in the host state diagrams IIRC.  I'll dig it up tomorrow if 
nobody beats me to it.

	Jeff



