From: Fang Wenqi <anton.fang@gmail.com>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Fri, 23 Apr 2010 14:48:00 +0800
Message-ID: <4BD142A0.2020600@gmail.com>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn> <20100421152404.62699040@lxorguk.ukuu.org.uk> <4BCF1247.8080508@gmail.com> <4BCFA50E.80800@gmail.com> <4BD13E84.2040204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:59057 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab0DWGrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Apr 2010 02:47:20 -0400
Received: by pzk32 with SMTP id 32so6099361pzk.21
        for <linux-ide@vger.kernel.org>; Thu, 22 Apr 2010 23:47:20 -0700 (PDT)
In-Reply-To: <4BD13E84.2040204@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Fang Wenqi <anton.fang@gmail.com>, jgarzik@redhat.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>


On 04/23/2010 02:30 PM, Tejun Heo wrote:
> On 04/22/2010 03:23 AM, Fang Wenqi wrote:
>> Sorry that the title should be:
>>   "fix uninitialized variable warning"
>>
>> not
>> "fix unused variable warning"
>>
>> Need I re-send the patch mail ?
>
> Yes, please do so.  gcc 4.4.1 generates a spurious warning on it too.

The same warning message as I met ?

>
> Acked-by: Tejun Heo<tj@kernel.org>
>
> Thanks.
>
