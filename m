From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream] libata: implement libata.force module parameter
Date: Tue, 12 Feb 2008 18:07:15 +0900
Message-ID: <47B161C3.7040200@gmail.com>
References: <47A3375F.80101@gmail.com> <47A356C3.3010904@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:42702 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759350AbYBLJHZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 04:07:25 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2662006wah.23
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 01:07:23 -0800 (PST)
In-Reply-To: <47A356C3.3010904@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>Sam Ravnborg <sam@ravnborg.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> This patch implements libata.force module parameter which can
>> selectively override ATA port, link and device configurations
>> including cable type, SATA PHY SPD limit, transfer mode and NCQ.
>>
>> For example, you can say "use 1.5Gbps for all fan-out ports attached
>> to the second port but allow 3.0Gbps for the PMP device itself, oh,
>> the device attached to the third fan-out port chokes on NCQ and
>> shouldn't go over UDMA4" by the following.
>>
>>  libata.force=2:1.5g,2.15:3.0g,2.03:noncq,udma4
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> I guess it's about time we add something like this.  More than
>> anything else this should help debugging and can serve as a last
>> resort to work around problems.
>>
>> Thanks.
>>
>>  Documentation/kernel-parameters.txt |   35 +++
>>  drivers/ata/libata-core.c           |  375
>> +++++++++++++++++++++++++++++++++++-
>>  drivers/ata/libata-eh.c             |    8
>>  drivers/ata/libata.h                |    1  4 files changed, 415
>> insertions(+), 4 deletions(-)
> 
> ACK, but it breaks the build due to section type conflicts:
> 
> drivers/ata/libata-core.c:108: error: ata_force_param_buf causes a
> section type conflict
> 
> Given that the data is marked __initdata and the code is marked __init,
> I cannot see the problem.

Jeff, this no longer causes build failure whether libata is configured
built-in or as a module.  I have no idea what's going on but there
doesn't seem to be a proper solution on the horizon yet.  I think we can
go ahead and commit this one and convert it to __initdataconst when it
becomes available.

Thanks.

-- 
tejun
