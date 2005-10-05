From: Jeff Garzik <jgarzik@pobox.com>
Subject: highmem pages
Date: Wed, 05 Oct 2005 03:35:52 -0400
Message-ID: <43438258.9080706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:1750 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932553AbVJEHf6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 03:35:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


Here is an interesting code snippet from ide-scsi, that could be useful 
in libata:

>                 count = min(pc->sg->length - pc->b_count, bcount);
>                 if (PageHighMem(pc->sg->page)) {
>                         unsigned long flags;
> 
>                         local_irq_save(flags);
>                         buf = kmap_atomic(pc->sg->page, KM_IRQ0) + pc->sg->offse
> t;
>                         drive->hwif->atapi_input_bytes(drive, buf + pc->b_count,
>  count);
>                         kunmap_atomic(buf - pc->sg->offset, KM_IRQ0);
>                         local_irq_restore(flags);
>                 } else {
>                         buf = page_address(pc->sg->page) + pc->sg->offset;
>                         drive->hwif->atapi_input_bytes(drive, buf + pc->b_count,
>  count);
>                }

