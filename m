From: Tejun Heo <htejun@gmail.com>
Subject: Re: booting from MD raid using libata
Date: Thu, 16 Aug 2007 21:04:46 +0900
Message-ID: <46C43D5E.8000403@gmail.com>
References: <46C2FA67.5060005@gac.edu> <46C42D65.9030607@gmail.com> <46C43B4A.4000308@gustavus.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:8351 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313AbXHPMEx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Aug 2007 08:04:53 -0400
Received: by wa-out-1112.google.com with SMTP id v27so258388wah
        for <linux-ide@vger.kernel.org>; Thu, 16 Aug 2007 05:04:53 -0700 (PDT)
In-Reply-To: <46C43B4A.4000308@gustavus.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sommere <sommere@gustavus.edu>
Cc: Ethan Sommer <sommere@gac.edu>, linux-ide@vger.kernel.org

sommere wrote:
> Tejun Heo wrote:
>> Ethan Sommer wrote:
>>  
>>> I've been trying to diagnose a problem we've been having for a few days
>>> and I think I've found the problem. (I'm hoping you might have the
>>> solution.)
>>>
>>> I have a system which has a intel 965 MB and a couple SIL based SATA
>>> cards one of which is hooked up to a few PMPs.
>>>
>>> If I try to boot the system normally after installing the libata-tj
>>> patch, it can't find the root partition because MD can't find any raid
>>> devices because the kernel hasn't detected the SATA partitions yet.
>>>     
>>
>> Do you load sd before or after md?
>>
>>   
> How would I affect that?
> 
> I've since tried installing linux without using raid for the system
> disks, and it still doesn't detect the partitions for the sata drives
> before trying to mount the root partition when using the libata-tj patch
> against 2.6.22.1

Are libata, sd and md modules?  If you don't know what's going on, just
build all needed drivers into the kernel.

-- 
tejun
