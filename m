From: Tejun Heo <htejun@gmail.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Sat, 18 Aug 2007 03:06:30 +0900
Message-ID: <46C5E3A6.9020907@gmail.com>
References: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:40150 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbXHQSGi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2007 14:06:38 -0400
Received: by rv-out-0910.google.com with SMTP id k20so523530rvb
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2007 11:06:38 -0700 (PDT)
In-Reply-To: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rusty Conover <rconover@infogears.com>
Cc: linux-ide@vger.kernel.org

Rusty Conover wrote:
> Hello Tejun,
> 
> Thanks for your reply.
> 
> 
>> * Please post kernel log including boot messages and errors.
>>
> 
> I've included the full log at the bottom of this message.
> 
>> * Please post the result of 'hdparm -I /dev/sdX' where sdX is the
>> offending device.
>>
>> * Are the errors localized to ata3.04 or are other drives affected too?
>>
> 
> 
> Its interesting because its not consistent, I've seen exceptions in this
> recent log with:
> 
> ata5.00 - ATA bus error
> ata5.03 - media error (hdparm below for sdg), timeout
> ata5.04 - timeout
> ata3.00 - timeout

Aieeee....  Definitely looks like some sort of hardware problem to me.
Please re-seat and re-cable stuff and remove drives from the machine
other than the one necessary to boot.  Please test things while adding
disk-by-disk.

Thanks.

-- 
tejun
