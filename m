From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Question about PATA Sil680 Cache Line Size and Performance Degradation
 on ARM XScale
Date: Thu, 22 Feb 2007 13:18:16 -0500
Message-ID: <45DDDE68.8070609@garzik.org>
References: <8202f4270702211456h52498bbdk560d9d47e2e319d7@mail.gmail.com>	<20070222000400.2c220b8f@lxorguk.ukuu.org.uk>	<8202f4270702211721o1629aa63q3670823b7348df1f@mail.gmail.com> <20070222185202.03121afc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39158 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751601AbXBVSSV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Feb 2007 13:18:21 -0500
In-Reply-To: <20070222185202.03121afc@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Fajun Chen <fajunchen@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Alan wrote:
>> Since Sil3124 has better PCI read/write performance, as a reference,
>> could someone explain or point me to the PCI configuration code for
>> Sil3124? I couldn't find it in sata_sil24.c.
> 
> Are you sure the values used are not the power on ones in this case ?

The values used, most likely, are BIOS-programmed.

sata_sil24.c does not call pci_set_mwi(), which is the only code in the 
kernel (besides driver-specific, hand-coded stuff) that adjusts the PCI 
cacheline register value.

	Jeff



