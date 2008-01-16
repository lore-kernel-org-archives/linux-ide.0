From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/4] printk: implement merging printk
Date: Wed, 16 Jan 2008 12:08:01 +0900
Message-ID: <478D7511.8000607@gmail.com>
References: <1200445210549-git-send-email-htejun@gmail.com>	<12004452113770-git-send-email-htejun@gmail.com> <20080115190257.f0546a63.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:60769 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757007AbYAPDII (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 22:08:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so153031wah.23
        for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2008 19:08:07 -0800 (PST)
In-Reply-To: <20080115190257.f0546a63.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, daniel.ritz-ml@swissonline.ch, jeff@garzik.org, linux-ide@vger.kernel.org

Randy Dunlap wrote:
> On Wed, 16 Jan 2008 10:00:09 +0900 Tejun Heo wrote:
> 
> 
>> ---
>>  include/linux/kernel.h |   71 ++++++++++++++++
>>  kernel/printk.c        |  215 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 286 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
>> index ade3ac9..f92a4a1 100644
>> --- a/include/linux/kernel.h
>> +++ b/include/linux/kernel.h
>> @@ -175,6 +175,29 @@ extern struct pid *session_of_pgrp(struct pid *pgrp);
>>  extern void dump_thread(struct pt_regs *regs, struct user *dump);
>>  
>>  #ifdef CONFIG_PRINTK
>> +struct mprintk {
>> +	char *		header;
>> +	char *		body;
>> +	char *		cur;
>> +	char *		prv;
>> +	char *		end;
> 
> We aren't very consistent about this, but I think that we would prefer
> 
> 	char		*header;
> 
> etc. there.

That's my preference too.  Dunno why I wrote like the above here.  Will
change.

Thanks.

-- 
tejun
