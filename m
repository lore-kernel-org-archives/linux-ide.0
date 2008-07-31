From: "KueiHuan Chen" <khchen@synology.com>
Subject: Re: SATA port multiplier(Marvell 6121 with ahci) and Marvell 4140, simg 3726
Date: Thu, 31 Jul 2008 21:12:13 +0800
Message-ID: <788014650807310612x70347f8dt56ed650dc6b8c5ca@mail.gmail.com>
References: <788014650807302022j30cea641wcfe4105ac8702b8c@mail.gmail.com>
	 <48918D52.3010404@gmail.com> <48918DD9.9050603@kernel.org>
Reply-To: khchen@synology.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:23798 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbYGaNMN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jul 2008 09:12:13 -0400
Received: by rv-out-0506.google.com with SMTP id k40so544635rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 31 Jul 2008 06:12:13 -0700 (PDT)
In-Reply-To: <48918DD9.9050603@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

  Thanks your reply Tejun, i would try it  ^__^.

  Before that, Could i ask a question that had you ever try to using
port multiplier(sil 3726 or marvel 4140) with 6121/6145
succefully(with ahci.c) ?

Thanks.

2008/7/31 Tejun Heo <tj@kernel.org>:
> Tejun Heo wrote:
>> KueiHuan Chen wrote:
>>> Hello,
>>>
>>>   We got some problem while evaluation port multipiler with libata, we
>>> had tested with two sata chip, one is sil-3132, the another is Marvell
>>> 6121. And we also have two port multiplie: Marvell 4140 and Sil-3726.
>>> Our kernel version is kernel-2.6.24 with Marvell 5281 platform.
>>>
>>>   Testing result:
>>>
>>>   Sil 3132 with 3726 and 4140: everything looks like fine.
>>>
>>>   Marvell 6121 with 3726 and 4140(using ahci.c): both port multipiler
>>> would got problem. It can't be detected whether hotplug or at boot time.
>>> But the disk detection is fine without port multiplier.
>>>
>>>   Because we can't upgrade kernel to latest version so quickly, is there
>>> any hint or solution for us ?
>>
>> mv PMP support was added very recently.  2.6.26 has it.
>
> Heh.. didn't read the last line.  If you can't upgrade the kernel,
> you'll need to backport.  We had to fix core PMP support quite a bit to
> get mv working, so you'll need to backport whole libata, which usually
> isn't too difficult.  Someone knowledgeable would be able to pull it in
> a few days but if you don't know what you're doing it can be pretty
> hairy.  :-)
>
> --
> tejun
>



-- 
---
Thanks,
KueiHuan-Chen
