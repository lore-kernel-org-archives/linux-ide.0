From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 9/15] ide: add PIO masks
Date: Thu, 05 Jul 2007 20:40:18 -0400
Message-ID: <468D8F72.3030505@garzik.org>
References: <200706302107.42458.bzolnier@gmail.com> <468A89FE.1040806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52344 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760269AbXGFAkV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Jul 2007 20:40:21 -0400
In-Reply-To: <468A89FE.1040806@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
>> * Add ATA_PIO[0-6] defines to <linux/ata.h>.
> 
>> * Add ->pio_mask field to ide_pci_device_t and ide_hwif_t.
> 
>> * Add PIO masks to host drivers.
> 
>    Hm, the next logical step would be to use the mask constants in
> <linux/ata.h> for the drivers' DMA caps too...

Certainly it is my hope to have share-able stuff in linux/ata.h that we 
all can use.  With ata_* (or ATA_*) prefix of course :)

	Jeff



