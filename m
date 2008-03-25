From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.25-rc6] sata_promise: fix hardreset hotplug events,
 take 2
Date: Mon, 24 Mar 2008 22:32:34 -0400
Message-ID: <47E86442.8030708@garzik.org>
References: <200803221421.m2MEL1oY021558@harpo.it.uu.se> <18406.38445.717175.664615@harpo.it.uu.se> <47E70FB4.4010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56446 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757518AbYCYCcg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Mar 2008 22:32:36 -0400
In-Reply-To: <47E70FB4.4010802@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, kurt@roeckx.be, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Acked-by: Tejun Heo <htejun@gmail.com>
> 
> Jeff, do you want to merge this first?  If so, I'll update the
> prefer-hardreset and cleanup-sht-ops patchsets; otherwise, I'll massage
> this patch a bit so that it fits on top of those two patchsets.


I just merged it into #upstream-fixes (answering your question)...  what 
is your preferred method of sync'ing at this point?

	Jeff


