From: Austin Zhang <austin_zhang@linux.intel.com>
Subject: Re: Laptop shock detection and harddisk protection
Date: Thu, 11 Sep 2008 06:26:37 -0400
Message-ID: <1221128797.30437.4.camel@azhang.bj.intel.com>
References: <48C7FCEE.8060404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:15039 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752173AbYIKKaL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Sep 2008 06:30:11 -0400
In-Reply-To: <48C7FCEE.8060404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: multinymous@gmail.com, Elias Oltmanns <eo@nebensachen.de>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Wed, 2008-09-10 at 18:59 +0200, Tejun Heo wrote:

> 2. If we're gonna unify interface, how much can we unify the backend?
>    Some devices are based on polling, others interrupt.  For polling,
>    is it better to delegate the whole polling to userland or is it
>    better to do some of it in kernel (tp_smapi seems to be doing
>    this)?
Shock protection should be time-sensitive, if we put the whole polling 
into userland, will it be possible that the damage had happened before 
userland app can signal ATA idle command timely?

> 3. What about the userland daemon?  It would be best to have a unified
>    daemon which can handle all instead of one for hdaps and another
>    for hp (and so on).  If we can unify the interface, this will be
>    much easier.
> 
> Thanks.

Can this process "acceleration-detect --> inform ATA shock protect --> 
issue idle command" be done totally in kernel, avoiding to consume too 
many time for "acceleration-detect --> sysfs --> userland app --> sysfs 
--> inform ATA shock protect --> issue idle command" before HD was damaged? 
The userland daemon should be just a indicator (but of course it can pass 
params to driver) for the protection status rather than a judge.



