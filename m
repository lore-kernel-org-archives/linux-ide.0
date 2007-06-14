From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata interface fatal error
Date: Thu, 14 Jun 2007 18:43:56 +0900
Message-ID: <46710DDC.1030900@gmail.com>
References: <46580134.7010107@effenberger.org> <465BEF50.8050207@gmail.com> <466725E5.9030405@effenberger.org> <4667D4F5.1060302@gmail.com> <466FC901.4060907@effenberger.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:10191 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbXFNJoE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jun 2007 05:44:04 -0400
Received: by nz-out-0506.google.com with SMTP id n1so529763nzf
        for <linux-ide@vger.kernel.org>; Thu, 14 Jun 2007 02:44:03 -0700 (PDT)
In-Reply-To: <466FC901.4060907@effenberger.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Effenberger <florian@effenberger.org>
Cc: linux-ide@vger.kernel.org, jeff@garzik.org

Florian Effenberger wrote:
> Hi Tejun,
> 
>> Okay, there was a bug in link speed limit logic.  That's probably why
>> speed down to 1.5Gbps didn't kick in.  The attached patch contains the
>> fix and hack to force 1.5Gbps.  Please give it a shot.
> 
> thanks a lot for your patch, it seems to work, at least better than
> without patch. :-)
> 
> When rsyncing about 12 GB, no trouble occured. When doing heavy stress
> tests, I receive errors again, but okay, maybe that's due to a hardware
> bug.
> 
> Will your patch go into the vanilla kernel?

I'm currently not sure what the root cause is

1. if the controller is at fault, we need to force 1.5Gbps on the
controller.

2. if the drive model is broken, we need to blacklist the drives.

3. if your specific configuration is broken (faulty hw, PSU, bad karma),
the upstream speed limit fix patch should be enough.

Can you post the result of 'hdparm -I /dev/sdX'?

-- 
tejun
