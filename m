From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.25-rc6] sata_promise: fix hardreset hotplug events,
 take 2
Date: Tue, 25 Mar 2008 11:37:52 +0900
Message-ID: <47E86580.6050206@gmail.com>
References: <200803221421.m2MEL1oY021558@harpo.it.uu.se> <18406.38445.717175.664615@harpo.it.uu.se> <47E70FB4.4010802@gmail.com> <47E86442.8030708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:52301 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbYCYCiC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2008 22:38:02 -0400
Received: by wr-out-0506.google.com with SMTP id c48so2047402wra.1
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 19:38:01 -0700 (PDT)
In-Reply-To: <47E86442.8030708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, kurt@roeckx.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Acked-by: Tejun Heo <htejun@gmail.com>
>>
>> Jeff, do you want to merge this first?  If so, I'll update the
>> prefer-hardreset and cleanup-sht-ops patchsets; otherwise, I'll massage
>> this patch a bit so that it fits on top of those two patchsets.
> 
> 
> I just merged it into #upstream-fixes (answering your question)...  what
> is your preferred method of sync'ing at this point?

Heh... me refreshing the patchset again.  Doing it right now.

-- 
tejun
