From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: highmem pages
Date: Fri, 07 Oct 2005 14:00:36 +0800
Message-ID: <43460F04.1040003@tw.ibm.com>
References: <43438258.9080706@pobox.com> <4344FDED.1080402@tw.ibm.com> <4345089A.9020006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:30156 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751108AbVJGGBW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2005 02:01:22 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9761Fvl003864
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:01:15 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9761Fvf094354
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:01:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j9761ETU011924
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:01:15 -0400
In-Reply-To: <4345089A.9020006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Jeff Garzik wrote:
> Albert Lee wrote:
> 
>> Thanks for the advice. The kmap_atomic() usage optimization patches
>> are ready:
>>
>>   patch 1/3: reorganize ata_pio_sector() and __atapi_pio_bytes()
>>   patch 2/3: reorganize "buf + offset"
>>   patch 3/3: use PageHighMem() to optimize the kmap_atomic() usage
> 
> 
> Thanks for the patches.  All three patches look OK, but did not apply
> (probably due to mailer problems):
> 
>> [jgarzik@pretzel libata-dev]$ patch -sp1 < /g/tmp/mbox 3 out of 3
>> hunks FAILED -- saving rejects to file drivers/scsi/libata-core.c.rej
> 
> 

Sorry for the mangled patch. :(

It seems Thunderbird add an extra space to the beginning of the line.
e.g.
[space][tab]local_irq_save(flags);
was changed to
[space][space][tab]local_irq_save(flags);

I've reconfigured the Thunderbird according to

http://www.gelato.unsw.edu.au/archives/git/0508/7750.html

Will resubmit the patches later.

Albert

