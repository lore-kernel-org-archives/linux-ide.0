From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.25-rc6] sata_promise: fix hardreset hotplug events,
 take 2
Date: Tue, 25 Mar 2008 12:32:49 +0900
Message-ID: <47E87261.4020603@gmail.com>
References: <200803221421.m2MEL1oY021558@harpo.it.uu.se> <18406.38445.717175.664615@harpo.it.uu.se> <47E70FB4.4010802@gmail.com> <47E86442.8030708@garzik.org> <47E86580.6050206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758275AbYCYDdW@vger.kernel.org>
In-Reply-To: <47E86580.6050206@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, kurt@roeckx.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Acked-by: Tejun Heo <htejun@gmail.com>
>>>
>>> Jeff, do you want to merge this first?  If so, I'll update the
>>> prefer-hardreset and cleanup-sht-ops patchsets; otherwise, I'll massage
>>> this patch a bit so that it fits on top of those two patchsets.
>>
>> I just merged it into #upstream-fixes (answering your question)...  what
>> is your preferred method of sync'ing at this point?
> 
> Heh... me refreshing the patchset again.  Doing it right now.

Okay, updated.  Please pull from

  http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=cleanup-sht-ops
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git cleanup-sht-ops

It's now on top of the current #upstream-fixes (4cde32fc) and contains
the followings.

* prefer-hardreset patchset
* PCI-device-should-be-powered-up-before-being-accssed patch
* cleanup-sht-ops patchset

Thanks.

-- 
tejun
