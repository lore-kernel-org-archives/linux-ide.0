From: Markku Pesonen <tourula@gmail.com>
Subject: Re: pata_atiixp regression in 4.11-rc1
Date: Tue, 28 Mar 2017 12:57:42 +0300
Message-ID: <d9c9cb23-e67f-779d-240d-e02f7d87e405@gmail.com>
References: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
 <20170327175550.GB13353@htj.duckdns.org>
 <49cdecb0846.6a8a0888@auth.smtp.1and1.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35975 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754846AbdC1J6A (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Mar 2017 05:58:00 -0400
Received: by mail-wr0-f195.google.com with SMTP id u1so21106780wra.3
        for <linux-ide@vger.kernel.org>; Tue, 28 Mar 2017 02:57:54 -0700 (PDT)
In-Reply-To: <49cdecb0846.6a8a0888@auth.smtp.1and1.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darren Stevens <darren@stevens-zone.net>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On 28.03.2017 11:24, Darren Stevens wrote:
> Hello Tejun
>
> On 27/03/2017, Tejun Heo wrote:
>> From a431ecd2d459da3c91a612061f09eb422ffe78e2 Mon Sep 17 00:00:00 2001
>> From: Tejun Heo <tj@kernel.org>
>> Date: Mon, 27 Mar 2017 13:52:00 -0400
>> Subject: [PATCH] Revert "pata_atiixp: Don't use unconnected secondary
>>  port on SB600/SB700"
>>
>> This reverts commit 5946fdaee4ba449e8fbb5d403e1ed69437f916e8.
>>
>> The original commit's assumption that the secondary port is
>> unconnected turns out to be false.
>
> Not entirely. I based my patch on information in AMD's document
> 43366_sb7xx_bdg_pub_1.00.p

I found this in the AMD SB710 Databook, rev 1.60, p. 56:
"The integrated parallel ATA controller contains a single channel but
can be configured as primary or secondary channel."

The IDE connector on my Asrock 980DE3/U3S3 motherboard is configured as
the secondary channel. The primary channel is used by the optional
SATA-IDE emulation mode.

I don't know much about kernel programming, southbridges, or ata 
controllers, but I hope this bit of information helps.


