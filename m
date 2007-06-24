From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/6] ide: add ide_pci_device_t.host_flags
Date: Sun, 24 Jun 2007 21:10:46 +0400
Message-ID: <467EA596.8000003@ru.mvista.com>
References: <200706232005.50076.bzolnier@gmail.com> <467D7231.7080701@ru.mvista.com> <200706240022.56055.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:18633 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751278AbXFXRJF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Jun 2007 13:09:05 -0400
In-Reply-To: <200706240022.56055.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>Index: b/drivers/ide/pci/serverworks.c
>>>===================================================================
>>>--- a/drivers/ide/pci/serverworks.c
>>>+++ b/drivers/ide/pci/serverworks.c
>>>@@ -448,9 +448,12 @@ static int __devinit init_setup_csb6 (st
>>> 			d->bootable = ON_BOARD;
>>> 	}
>>> 
>>>-	d->channels = ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
>>>-			dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&
>>>-		       (!(PCI_FUNC(dev->devfn) & 1))) ? 1 : 2;
>>>+	if ((dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE ||
>>>+	    dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2) &&

>>    I'd have left that aligning space alone. :-)

>>>+	    (!(PCI_FUNC(dev->devfn) & 1)))
>>>+		d->host_flags |= IDE_HFLAG_SINGLE;
>>>+	else
>>
>> > +		d->host_flags &= IDE_HFLAG_SINGLE;
>>
>>    Here's the offending code! Should've been:
>>
>>		d->host_flags &= ~IDE_HFLAG_SINGLE;

> Thanks for catching this.

    Such things usually just spring into the eye. :-)

> Fixed, new patch below.

> [PATCH] ide: add ide_pci_device_t.host_flags (take 2)
> 
> * Rename ide_pci_device_t.flags to ide_pci_device_t.host_flags
>   and IDEPCI_FLAG_ISA_PORTS flag to IDE_HFLAG_ISA_PORTS.
> 
> * Add IDE_HFLAG_SINGLE flag for single channel devices.
> 
> * Convert core code and all IDE PCI drivers to use IDE_HFLAG_SINGLE
>   and remove no longer needed ide_pci_device_t.channels field.
> 
> v2:
> * Fix issues noticed by Sergei:
>   - correct code alignment in scc_pata.c
>   - s/IDE_HFLAG_SINGLE/~IDE_HFLAG_SINGLE/ in serverworks.c

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
