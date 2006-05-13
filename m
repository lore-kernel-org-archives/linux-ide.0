From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/11] libata-eh: implement ata_ering
Date: Sun, 14 May 2006 08:36:56 +0900
Message-ID: <44666D98.1000503@gmail.com>
References: <11473536871340-git-send-email-htejun@gmail.com> <44665AAB.7000806@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:62529 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964801AbWEMXhD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 19:37:03 -0400
Received: by wr-out-0506.google.com with SMTP id i28so587708wra
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 16:37:02 -0700 (PDT)
In-Reply-To: <44665AAB.7000806@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> +struct ata_ering {
>> +    int            cursor;
>> +    int            size;
>> +    struct ata_ering_entry    ring[];
>> +};
>> +
>> +#define DEFINE_ATA_ERING(name, size)    \
>> +    struct ata_ering    name;    \
>> +    struct ata_ering_entry    name_entries[size];
> 
> ACK, but this is creeping dangerously close to C abuse :)
> 
> This sort of code will confuse debuggers and source checkers.
> 

Well, as ering is currently used in only one place and it will stay in 
libata in the future, it might be better to remove the macro and shove 
the allocation into where it's used; however, I prefer the macro because 
it's safer and I don't use any debuggers or source checkers.

Linux source has lots of cpp macros like above and IMHO the above 
doesn't even rank among C abuses.  lxr and sparse would be fine.

-- 
tejun
