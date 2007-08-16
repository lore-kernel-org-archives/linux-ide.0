From: sommere <sommere@gustavus.edu>
Subject: Re: booting from MD raid using libata
Date: Thu, 16 Aug 2007 06:55:54 -0500
Message-ID: <46C43B4A.4000308@gustavus.edu>
References: <46C2FA67.5060005@gac.edu> <46C42D65.9030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wraith.gac.edu ([138.236.128.65]:37243 "EHLO wraith.gac.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbXHPMRG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 08:17:06 -0400
In-Reply-To: <46C42D65.9030607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ethan Sommer <sommere@gac.edu>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Ethan Sommer wrote:
>   
>> I've been trying to diagnose a problem we've been having for a few days
>> and I think I've found the problem. (I'm hoping you might have the
>> solution.)
>>
>> I have a system which has a intel 965 MB and a couple SIL based SATA
>> cards one of which is hooked up to a few PMPs.
>>
>> If I try to boot the system normally after installing the libata-tj
>> patch, it can't find the root partition because MD can't find any raid
>> devices because the kernel hasn't detected the SATA partitions yet.
>>     
>
> Do you load sd before or after md?
>
>   
How would I affect that?

I've since tried installing linux without using raid for the system 
disks, and it still doesn't detect the partitions for the sata drives 
before trying to mount the root partition when using the libata-tj patch 
against 2.6.22.1

Ethan

