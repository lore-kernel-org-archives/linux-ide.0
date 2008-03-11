From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream] libata: make EH fail gracefully if no reset
 method is available
Date: Tue, 11 Mar 2008 12:45:05 +0900
Message-ID: <47D60041.5060803@gmail.com>
References: <47A040E2.1050801@gmail.com> <47B0A128.4020002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:43299 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbYCKDpK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 23:45:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2612975wah.23
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 20:45:10 -0700 (PDT)
In-Reply-To: <47B0A128.4020002@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> When no reset method is available, libata currently oopses.  Although
>> the condition can't happen unless there's a bug in a low level driver,
>> oopsing isn't the best way to report the error condition.  Complain,
>> dump stack and fail reset instead.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>> This patch is on top of
>>
>> upstream (a984f58dd97f22f5113700322fed311a0ee29947)
>> + prefer-hardreset patchset
>>   http://thread.gmane.org/gmane.linux.ide/27447
>>
>>  drivers/ata/libata-eh.c |    7 ++++++-
>>  1 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>> index 64418f1..8d82b06 100644
>> --- a/drivers/ata/libata-eh.c
>> +++ b/drivers/ata/libata-eh.c
>> @@ -2135,9 +2135,14 @@ int ata_eh_reset(struct ata_link *link, int
>> classify,
>>      if (hardreset) {
>>          reset = hardreset;
>>          ehc->i.action = ATA_EH_HARDRESET;
>> -    } else {
>> +    } else if (softreset) {
>>          reset = softreset;
>>          ehc->i.action = ATA_EH_SOFTRESET;
>> +    } else {
>> +        ata_link_printk(link, KERN_ERR, "BUG: no reset method, "
>> +                "please report to linux-ide@vger.kernel.org\n");
>> +        dump_stack();
>> +        return -EINVAL;
> 
> ACK, but holding due to hold on prefer-hardreset patch (pinging device
> manufacturers)

Please drop this one.  #upstream-fixes now has a patch to allow drivers
w/o any reset method.

-- 
tejun
