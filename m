From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries
 CD drives
Date: Fri, 16 Feb 2007 18:06:03 +0300
Message-ID: <45D5C85B.7070201@ru.mvista.com>
References: <20070210203512.GA25586@aepfle.de> <200702161553.54550.bzolnier@gmail.com> <45D5C5CC.9070406@ru.mvista.com> <200702161609.07899.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:51247 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932403AbXBPPGW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Feb 2007 10:06:22 -0500
In-Reply-To: <200702161609.07899.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Olaf Hering <olaf@aepfle.de>, Jeff Garzik <jeff@garzik.org>, Paul Mackeras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>>   I'm sorry, how those 2 drivers can be equivalent?! The pata_winbond driver 
>>>>is for VLB only, sl81c105 was for PCI only -- you certainly want to use 
>>>>pata_sl82c105 (indeed better version of sl82c105 driver).

>>>I was under the impression that with your fixes these drivers
>>>(sl82c105 and pata_sl82c105) are functionally equivalent.

>>    They're not yet equivalent. pata_sl82c105 supports all MWDMA modes, 
>>sl82c105 still supports only MWDMA2.

> Indeed and it seems that IDE core needs ->dma_mode to fix this.

    Not really.  It just needs the proper DMA timings to be set by adding the 
missing speedproc() method (and also DMA timings possibly merged with PIO like 
libata does generally -- except in this driver).

> Thanks,
> Bart

MBR, Sergei
