From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Fri, 10 Aug 2007 21:29:14 +0400
Message-ID: <46BCA06A.8040609@ru.mvista.com>
References: <200708060006.35511.sshtylyov@ru.mvista.com>	<20070806202958.25670cc1@the-village.bc.nu>	<46BC8747.4020307@ru.mvista.com> <20070810181907.61fd514d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56463 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756442AbXHJR1E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Aug 2007 13:27:04 -0400
In-Reply-To: <20070810181907.61fd514d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, rah@bash.sh, linux-ide@vger.kernel.org

Alan Cox wrote:

>>>>+		if (chip_type == HPT374 && (PCI_FUNC(dev->devfn) & 1)) {
>>>>+			struct pci_dev	*dev1 = pci_get_slot(dev->bus,
>>>>+							     dev->devfn - 1);

>>>Can be NULL

>>    Not really. This may not be called if it's NULL -- see hpt374_init_setup().
>>Maybe worth a comment though...

>>>>+			unsigned long io_base = pci_resource_start(dev1, 4);
>>
>>>Kaboom
>>
>>    That was a dud bomb. ;-)

> What stops a hot unplug of a 374 from causing that to occur. I don't see

    Pinned as in pci_get_device()? If so, see setup-ide.c:ide_scan_pcibus().
The IDE core does that for me.

> where you have the other pci_dev pinned on a hotplug on a box set to scan
> the devices in reverse order

    Function 1 will always be skipped, regardless of the scan order.

> (yes its an extremely obscure case ;))

    "Security through obscurity". :-)

MBR, Sergei
