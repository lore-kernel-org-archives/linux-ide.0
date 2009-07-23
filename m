From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA port multiplier support in 2.6.21
Date: Thu, 23 Jul 2009 20:53:45 +0900
Message-ID: <4A684F49.3020904@gmail.com>
References: <24580821.post@talk.nabble.com> <20090721025034.GA15894@psychosis.jim.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f192.google.com ([209.85.222.192]:50557 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbZGWL5y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jul 2009 07:57:54 -0400
Received: by pzk30 with SMTP id 30so428597pzk.33
        for <linux-ide@vger.kernel.org>; Thu, 23 Jul 2009 04:57:54 -0700 (PDT)
In-Reply-To: <20090721025034.GA15894@psychosis.jim.sh>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Paris <jim@jtan.com>
Cc: Learner Study <learner.study@gmail.com>, linux-ide@vger.kernel.org

Jim Paris wrote:
> Learner Study wrote:
>> Hello:
>>
>> I understand that SATA port multiplier support was added in 2.6.24.
>> I would like to use 2.6.21 and still use port multilplier. Can someone point
>> me to a patch I may use to do this? Any other ideas?
> 
> There were patches from Tejun (libata-tj-stable) for 2.6.18 and 2.6.22
> at one point, but I don't know where you'd find them anymore (the
> original site at http://home-tj.org/wiki/index.php/Libata-tj-stable
> is down).  You may have some luck googling around for those.

Here are old patches.

  http://htj.dyndns.org/export/libata-tj-old/

> 2.6.21 is over two years old, so your best bet would be to upgrade to
> a more recent version, or, if you're stuck with some distribution
> kernel, talk to your vendor for support.

But, yeah, seriously, if at all possible, please use newer kernels.
There have been a lot of updates.

Thanks.

-- 
tejun
