From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: highmem pages
Date: Thu, 06 Oct 2005 07:20:58 -0400
Message-ID: <4345089A.9020006@pobox.com>
References: <43438258.9080706@pobox.com> <4344FDED.1080402@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:25825 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750837AbVJFLVC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2005 07:21:02 -0400
In-Reply-To: <4344FDED.1080402@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Thanks for the advice. The kmap_atomic() usage optimization patches are 
> ready:
> 
>   patch 1/3: reorganize ata_pio_sector() and __atapi_pio_bytes()
>   patch 2/3: reorganize "buf + offset"
>   patch 3/3: use PageHighMem() to optimize the kmap_atomic() usage

Thanks for the patches.  All three patches look OK, but did not apply 
(probably due to mailer problems):

> [jgarzik@pretzel libata-dev]$ patch -sp1 < /g/tmp/mbox 
> 3 out of 3 hunks FAILED -- saving rejects to file drivers/scsi/libata-core.c.rej

FWIW the most reliable email solution is to use a script to generate an 
RFC822 header and email message:

	To: jgarzik@pobox.com (Jeff Garzik)
	CC: linux-ide@vger.kernel.org (Linux IDE mailing list)
	Subject: [patch 1/3] irq-pio: ...
	[blank line, as required by RFC822]
	[patch description]
	[patch]

and then send that to '/usr/bin/sendmail -t < msg.txt' for delivery.

	Jeff


