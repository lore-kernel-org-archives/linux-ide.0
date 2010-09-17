From: Tejun Heo <htejun@gmail.com>
Subject: Re: ahci rmmodable and shouldn't
Date: Fri, 17 Sep 2010 11:53:19 +0200
Message-ID: <4C933A8F.2080305@gmail.com>
References: <201009162256.04765.pedrogfrancisco@gmail.com> <47010.148.87.67.141.1284674336.squirrel@www.xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33087 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0IQJxY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2010 05:53:24 -0400
In-Reply-To: <47010.148.87.67.141.1284674336.squirrel@www.xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Pedro Francisco <pedrogfrancisco@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hello,

On 09/16/2010 11:58 PM, Randy Dunlap wrote:
>> `rmmod ahci' works even if the module is being used (`lsmod' thinks it's
>> not being used but rmmoding ahci triggers filesystem erros and I've to
>> force a reboot).
>>
>> I've been told it's the same as plugging a cable. IMO that's what
>> /sys/stuff/eject_or_similar is to, not `rmmod ahci'.
>>
>>
>> I *assume* it was caused by the split between libahci & ahci, since in
>> 2.6.32
>> `rmmod ahci' is impossible because it's marked as being in use. Didn't try
>>  `rmmod -f ahci' but that's not the point.
>>
>>
>> I'm posting again about this because it doesn't make sense to me the
>> actual behaviour.

Just don't rmmod a module which is serving a live filesystem.  Why
does it even matter?

-- 
tejun
