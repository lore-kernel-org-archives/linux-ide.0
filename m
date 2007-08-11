From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Sat, 11 Aug 2007 20:03:59 +0400
Message-ID: <46BDDDEF.9080001@ru.mvista.com>
References: <200708060006.35511.sshtylyov@ru.mvista.com> <20070810181907.61fd514d@the-village.bc.nu> <46BCA06A.8040609@ru.mvista.com> <200708102354.21897.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:61066 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750741AbXHKQBs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Aug 2007 12:01:48 -0400
In-Reply-To: <200708102354.21897.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, rah@bash.sh, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>>>>+		if (chip_type == HPT374 && (PCI_FUNC(dev->devfn) & 1)) {
>>>>>>+			struct pci_dev	*dev1 = pci_get_slot(dev->bus,
>>>>>>+							     dev->devfn - 1);

>>>>>Can be NULL

>>>>   Not really. This may not be called if it's NULL -- see hpt374_init_setup().
>>>>Maybe worth a comment though...

>>>>>>+			unsigned long io_base = pci_resource_start(dev1, 4);

>>>>>Kaboom

>>>>   That was a dud bomb. ;-)

>>>What stops a hot unplug of a 374 from causing that to occur. I don't see

>>    Pinned as in pci_get_device()? If so, see setup-ide.c:ide_scan_pcibus().
>>The IDE core does that for me.

> ide_scan_pcibus() is used iff IDE is built-in.

> Moreover pci_get_device() holds reference _only_ to the current PCI device
> (the reference count to @from PCI device is _always_ decremented).

    Indeed... doesn't it look like a buglet in the IDE core?

>>>where you have the other pci_dev pinned on a hotplug on a box set to scan
>>>the devices in reverse order

>>    Function 1 will always be skipped, regardless of the scan order.

> Yes, but init_chipset_hpt366() will still try to access Function 1

    No!  Re-read the code please: init_chipset_hpt366() won't be called for 
function 1 if that one is not detected, and only in this case it does function 
0 access to read the saved f_CNT value.

> even if earlier init_setup_hpt374() failed to obtain reference to it.

>>>(yes its an extremely obscure case ;))

>>    "Security through obscurity". :-)

> Not in this case. :-)

    Yeah, here we have another case. ;-)

> Bart

WBR, Sergei
