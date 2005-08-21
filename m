From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH linux-2.6.13-rc3] Mod15Write quirk against v2.6.13
Date: Sun, 21 Aug 2005 17:10:13 -0400
Message-ID: <4308EDB5.6060102@pobox.com>
References: <1121894035.4885.15.camel@drevil.aslab.com> <20050728141242.GA10010@htj.dyndns.org> <4308D3D0.50504@pobox.com> <4308E7F4.3000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:42441 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751096AbVHUVKS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Aug 2005 17:10:18 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7LLAHmc023050
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 14:10:18 -0700
In-Reply-To: <4308E7F4.3000509@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Michael Madore <Michael.Madore@aslab.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Also, Jeff, I know you're very busy, but what do you think about
>>> taking m15w workaround into ata tree?  It's been around for a while
>>> now and I haven't received any complaints (except for this one) yet.
>>> The workaround is ugly but it surely helps and I'm willing to maintain
>>> it.

>> I think your mod15write solution is too messy to deal with long-term. 
>> Maintenance burden is much lower on us without it.  It's not too 
>> difficult to simply avoid certain combinations of hardware.

>  No problem, I'll maintain it out of tree.

You're welcome to maintain it as an independent branch of 
libata-dev.git, if you would prefer.


>> Note!  As Carlos @ Silicon Image points out, the blacklist should only 
>> apply to SiI 3112, not 3512/3114/etc.  That's an open FIXME that would 
>> benefit users.

>  Cool, I'll submit a patch right away.

Thanks,

	Jeff


