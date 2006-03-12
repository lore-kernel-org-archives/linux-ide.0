From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] AHCI prefetch
Date: Sat, 11 Mar 2006 19:32:19 -0500
Message-ID: <44136C13.4020002@garzik.org>
References: <20060304173505.GA28643@havoc.gtf.org> <20060310043717.GA7510@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:63415 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751354AbWCLAcV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 19:32:21 -0500
In-Reply-To: <20060310043717.GA7510@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> On Sat, Mar 04, 2006 at 12:35:05PM -0500, Jeff Garzik wrote:
> 
>>This patch has been sitting in my tmp directory for ages.
>>
>>We should probably turn this on, though the practical difference is
>>probably minimal.
>>
> 
> 
> The patch works okay on my machine (ICH7R) although the patch didn't
> apply to #upstream.  I'm not very sure about this change though.
> 
> 1. Why apply it only to ATAPI devices?  ATA devices can benefit to.
>    If it's because this bit shouldn't be turned on for NCQ, we can
>    turn it on conditionally.  We'll probably need similar condition
>    for ATAPI devices too if we support FIS-based PM switching.

Main reason is that it will largely only have benefits on ATAPI devices, 
and I've only tested it on ATAPI devices.


> 2. I'm a bit skeptical whether this change will bring any noticeable
>    performance improvement.  OTOH, this seems to be a good source for

Agreed.


>    obscure problems on some controllers which might not implement/test
>    this feature properly.  As more controllers implement AHCI spec,
>    the possibility grows.

Agreed.


> Anyways, here's the patch regenerated against #upstream.

Could I trouble you for a resend, with a proper signed-off-by and patch 
description?

	Jeff



