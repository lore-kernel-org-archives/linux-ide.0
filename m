From: Tejun Heo <htejun@gmail.com>
Subject: Re: [Regression] 2.6.25-rc4-git3: Handling of audio CDs broken on
 pata_ali
Date: Mon, 10 Mar 2008 16:42:07 +0900
Message-ID: <47D4E64F.5070106@gmail.com>
References: <200803082246.47987.rjw@sisk.pl> <20080309073824.902DC82CF2E@smtp04.mtu.ru> <200803100012.27520.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:39818 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbYCJHmO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 03:42:14 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1755234wff.4
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 00:42:13 -0700 (PDT)
In-Reply-To: <200803100012.27520.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Rafael J. Wysocki wrote:
>>> where ata1 is:
>>>
>>> scsi0 : pata_ali
>>> scsi1 : pata_ali
>> Oh, is it only with audio CDs? I am unable to use DVD on pata_ali in DMA at
>> all. Have you tried to disable ATAPI DMA (libata.dma=1)?
> 
> Data CDs seem to work fine here.

* Does booting into runlevel 1, putting in an audio cd and running
cdparanoia give the same result?

* Does setting module parameter libata.force to "1.00:pio4" make any
difference?

Thanks.

-- 
tejun
