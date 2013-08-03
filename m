From: Marc C <marc.ceeeee@gmail.com>
Subject: Re: [PATCH 1/2] libata: Add support for SEND/RECEIVE FPDMA QUEUED
Date: Sat, 03 Aug 2013 09:30:01 -0700
Message-ID: <51FD3009.5020909@gmail.com>
References: <1375500896-22955-1-git-send-email-marc.ceeeee@gmail.com> <1375500896-22955-2-git-send-email-marc.ceeeee@gmail.com> <51FD1930.3000909@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:64044 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3HCQaJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Aug 2013 12:30:09 -0400
Received: by mail-ob0-f176.google.com with SMTP id uz19so3079194obc.21
        for <linux-ide@vger.kernel.org>; Sat, 03 Aug 2013 09:30:07 -0700 (PDT)
In-Reply-To: <51FD1930.3000909@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Hello,
>    Real name is required in signoff.
Got it. I will update it in the resubmission.

>> diff --git a/include/linux/ata.h b/include/linux/ata.h
>> index ee0bd95..dd26211 100644
>> --- a/include/linux/ata.h
>> +++ b/include/linux/ata.h
> [...]
>> @@ -509,6 +525,8 @@ struct ata_taskfile {
>>       u8            device;
>>
>>       u8            command;    /* IO operation */
>> +
>> +    u32            auxiliary;
>
>    The 'struct ata_taskfile' has been moved to libata.h for 3.12, so
> you are basing your work off of the wrong branch.
My bad! I'll rebase my tree to 3.12.

>    And what does this new field have to do with the classical ATA
> taskfile registers? Can't we place it into 'struct ata_queued_cmd'? 
Actually, nothing, since it's impossible to transport the new field via
a legacy TF.  'struct ata_queued_cmd' is a more appropriate place to put
it. Thank you for pointing that out.

Regards,
Marc
