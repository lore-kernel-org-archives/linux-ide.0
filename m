From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] ata: ata-samsung_cf: Trivial cleanup in header file
Date: Mon, 17 Feb 2014 09:08:06 +0530
Message-ID: <CAK9yfHx+fg2vgvtd1YGdKk6iZtrROxMgQ2TBBYNOjgXidw22yw@mail.gmail.com>
References: <1392359102-6997-1-git-send-email-sachin.kamat@linaro.org>
	<52FE19FC.7010905@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:51674 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaBQDiH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Feb 2014 22:38:07 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so16419114obc.36
        for <linux-ide@vger.kernel.org>; Sun, 16 Feb 2014 19:38:06 -0800 (PST)
In-Reply-To: <52FE19FC.7010905@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, Jiri Kosina <trivial@kernel.org>, tj@kernel.org

On 14 February 2014 18:58, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 14-02-2014 10:25, Sachin Kamat wrote:
>
>> Commit 436d42c61c3e ("ARM: samsung: move platform_data definitions")
>> moved the files to the current location but forgot to remove the pointer
>> to its previous location. Clean it up. While at it also change the header
>> file protection macros appropriately.
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
>
>> ---
>>   include/linux/platform_data/ata-samsung_cf.h |    9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>
>
>> diff --git a/include/linux/platform_data/ata-samsung_cf.h
>> b/include/linux/platform_data/ata-samsung_cf.h
>> index 2a3855a8372a..064f86329219 100644
>> --- a/include/linux/platform_data/ata-samsung_cf.h
>> +++ b/include/linux/platform_data/ata-samsung_cf.h
>
> [...]
>
>> @@ -10,8 +9,8 @@
>>    * published by the Free Software Foundation.
>>   */
>>
>> -#ifndef __ASM_PLAT_ATA_H
>> -#define __ASM_PLAT_ATA_H __FILE__
>> +#ifndef __ATA_SAMSUNG_CF_ATA_H
>> +#define __ATA_SAMSUNG_CF_ATA_H __FILE__
>
>
>    Why not just __ATA_SAMSUNG_CF_H?

Yes that should have been it. Not sure why I added one more ATA.
Thanks for pointing out.

-- 
With warm regards,
Sachin
