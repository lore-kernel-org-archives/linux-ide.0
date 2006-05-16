From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 11:15:11 +0900
Message-ID: <446935AF.5030904@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515182919.GA16070@irc.pl> <4468CBC7.2030900@garzik.org> <44690F91.2070206@gmail.com> <44691392.2030906@garzik.org> <44691700.3020903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:57056 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751057AbWEPCPS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 22:15:18 -0400
Received: by nz-out-0102.google.com with SMTP id 4so33259nzn
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 19:15:17 -0700 (PDT)
In-Reply-To: <44691700.3020903@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Jeff Garzik wrote:
>>>> Tomasz Torcz wrote:
>>>>> On Mon, May 15, 2006 at 01:00:06PM -0400, Jeff Garzik wrote:
>>>>>> After much development and review, I merged a massive pile of libata
>>>>>> patches from Tejun Heo and Albert Lee.  This update contains the
>>>>>> following major libata
>>>>>
>>>>>   Any plans to merge http://home-tj.org/wiki/index.php/Sil_m15w ? Or
>>>>> maybe it's merged already?
>>>>>   Seagate firmware update seems to be available only for OEMs, so this
>>>>> quirk is pretty helpful for end users.
>>>>
>>>> Its a question of staging.  This still lives in the 'sii-m15w' 
>>>> branch of libata-dev.git, but if we throw too many _classes_ of 
>>>> changes into the same big lump, then it becomes much more difficult 
>>>> to discern which changes caused which failures.
>>>>
>>>> Since sata_sil has seen several changes, and since the sii-m15w 
>>>> problems are so difficult to diagnose properly, its easier to 
>>>> separate that out.
>>>
>>> Are you planning on merging sil_m15w workaround?
>>
>> Yes, but after 2.6.18.
> 
> Cool.
> 
>>> FYI, from the first time it was submitted (last summer) till 2.6.16, 
>>> it took very little effort to maintain it.  The current big update 
>>> would necessitate some changes to it but I don't think it will be too 
>>> much work.  My experience says m15w doesn't add too much maintenance 
>>> overhead.
>>
>> Its actively maintained in the 'sii-m15w' branch of libata-dev.git.
>>
> 
> I have been maintaining my own.  :)  BTW, with 2.6.16, m15_cxt has to 
> move from qc->private_data to ap->private_data.

Okay, we've been talking about different things.  You're talking about 
excluding non-affected drives from m15w blacklist while I'm talking 
about the handle-large-writes-by-qc-rewrite m15w workaround.  The URL 
Tomasz Torcz wrote contains the workaround.

-- 
tejun
