From: Michael Thonke <iogl64nx@gmail.com>
Subject: Re: Playing with SATA NCQ
Date: Sat, 28 May 2005 00:30:59 +0200
Message-ID: <42979FA3.1010106@gmail.com>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:49446 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262503AbVE0WbD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 May 2005 18:31:03 -0400
Received: by wproxy.gmail.com with SMTP id 68so932848wri
        for <linux-ide@vger.kernel.org>; Fri, 27 May 2005 15:31:02 -0700 (PDT)
In-Reply-To: <42979C4F.8020007@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik schrieb:

> Michael Thonke wrote:
>
>> Hello Jens,
>>
>> I tried to play with your patch on ICH6R and ICH7R chipset also on
>> Sil3124R Controller
>> with 2xSamsung HD160JJ SATAII drives. But the performance gain stay
>> out..
>> anything special to set to get it working? I used a vanilla-kernel
>> 2.6.12-rc5-git2 for it.
>
>
> SiI 3124 driver needs to be updated to support NCQ.
>
>     Jeff
>
>
>
>
Hello Jeff,

thanks for the info, and whats about Intel ICH6R and ICH7R anything
special there?
I played a bit with the patch and tried to tune it a bit. But there is
no Documentation
for AHCI in kernel.with parameter I can handover or can be changed.
Maybe I've missed them?
If so can you please refer me to one?

Thanks in advance and for help

Greets
     Michael
