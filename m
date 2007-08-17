From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Fri, 17 Aug 2007 21:43:25 +0400
Message-ID: <46C5DE3D.8040204@ru.mvista.com>
References: <200708060006.35511.sshtylyov@ru.mvista.com> <200708111907.29501.bzolnier@gmail.com> <46BDF08C.1070508@ru.mvista.com> <200708112331.14270.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:50972 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757918AbXHQRlB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Aug 2007 13:41:01 -0400
In-Reply-To: <200708112331.14270.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>>>>>>>>>>>>+		if (chip_type == HPT374 && (PCI_FUNC(dev->devfn) & 1)) {
>>>>>>>>>>>>+			struct pci_dev	*dev1 = pci_get_slot(dev->bus,
>>>>>>>>>>>>+							     dev->devfn - 1);

>>>>>>>>>>>Can be NULL

>>>>>>>>>>Not really. This may not be called if it's NULL -- see hpt374_init_setup().
>>>>>>>>>>Maybe worth a comment though...

>>>>>>>>>>>>+			unsigned long io_base = pci_resource_start(dev1, 4);

>>>>>>>>>>>Kaboom

>>>>>>>>>>That was a dud bomb. ;-)

>>>>>>>>>What stops a hot unplug of a 374 from causing that to occur. I don't see

>>>>>>>> Pinned as in pci_get_device()? If so, see setup-ide.c:ide_scan_pcibus().
>>>>>>>>The IDE core does that for me.

>>>>>>>ide_scan_pcibus() is used iff IDE is built-in.

>>>>>>>Moreover pci_get_device() holds reference _only_ to the current PCI device
>>>>>>>(the reference count to @from PCI device is _always_ decremented).

>>>>>>  Indeed... doesn't it look like a buglet in the IDE core?

>>>>>It is OK, when ide_scan_pcibus() is not used

>>>>   But whan it is used?

>>>Then it keeps the reference to PCI device itself by using pci_get_device()...

>>    Well, that I know. What I was asking is where the reference is kept after 
>>the driver init time -- we're still working with the PCI device, so unplagging 
>>it would be wrong thing to do. Actually, we should never call pci_dev_put() 
>>since IDE drivers are not unloadable, right?

> Now that I look at pci_device_probe() it seems that there should be additional
> pci_dev_get() call in ide_scan_pcidev() if d->probe() succeeds.  Care to fix it?

    Yeah. OK to convert it to kernel style by the same patch?

MBR, Sergei
