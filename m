From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 09:04:16 +0900
Message-ID: <44691700.3020903@gmail.com>
References: <20060515170006.GA29555@havoc.gtf.org> <20060515182919.GA16070@irc.pl> <4468CBC7.2030900@garzik.org> <44690F91.2070206@gmail.com> <44691392.2030906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:62147 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750841AbWEPAEV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 20:04:21 -0400
Received: by py-out-1112.google.com with SMTP id x31so1506432pye
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 17:04:21 -0700 (PDT)
In-Reply-To: <44691392.2030906@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> Tomasz Torcz wrote:
>>>> On Mon, May 15, 2006 at 01:00:06PM -0400, Jeff Garzik wrote:
>>>>> After much development and review, I merged a massive pile of libata
>>>>> patches from Tejun Heo and Albert Lee.  This update contains the
>>>>> following major libata
>>>>
>>>>   Any plans to merge http://home-tj.org/wiki/index.php/Sil_m15w ? Or
>>>> maybe it's merged already?
>>>>   Seagate firmware update seems to be available only for OEMs, so this
>>>> quirk is pretty helpful for end users.
>>>
>>> Its a question of staging.  This still lives in the 'sii-m15w' branch 
>>> of libata-dev.git, but if we throw too many _classes_ of changes into 
>>> the same big lump, then it becomes much more difficult to discern 
>>> which changes caused which failures.
>>>
>>> Since sata_sil has seen several changes, and since the sii-m15w 
>>> problems are so difficult to diagnose properly, its easier to 
>>> separate that out.
>>
>> Are you planning on merging sil_m15w workaround?
> 
> Yes, but after 2.6.18.

Cool.

>> FYI, from the first time it was submitted (last summer) till 2.6.16, 
>> it took very little effort to maintain it.  The current big update 
>> would necessitate some changes to it but I don't think it will be too 
>> much work.  My experience says m15w doesn't add too much maintenance 
>> overhead.
> 
> Its actively maintained in the 'sii-m15w' branch of libata-dev.git.
> 

I have been maintaining my own.  :)  BTW, with 2.6.16, m15_cxt has to 
move from qc->private_data to ap->private_data.

> 
>> Also, what's the merge plan for hotplug/PM?  Together into 2.6.18?  Or 
>> are we looking further down?
> 
> Hotplug is reasonable for 2.6.18, but after that its getting a bit much. 
>  We need to have some reasonable testing points in the midst of all this 
> development :)  I'm happy to maintain an upstream-2.6.19 branch for such 
> things, though.  I use tiered branches anyway.

Good enough for me.  I want to see hotplug in 2.6.18 but link/PM stuff 
can definitely wait for 2.6.19.

-- 
tejun
