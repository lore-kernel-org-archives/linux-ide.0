From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [git patches] libata fixes for 3.7
Date: Wed, 03 Oct 2012 09:23:42 +0400
Message-ID: <506BCBDE.2020402@msgid.tls.msk.ru>
References: <20121002194053.GA11100@havoc.gtf.org> <506B4404.20100@msgid.tls.msk.ru> <506B47AB.9020506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isrv.corpit.ru ([86.62.121.231]:56436 "EHLO isrv.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755498Ab2JCFXp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Oct 2012 01:23:45 -0400
In-Reply-To: <506B47AB.9020506@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 02.10.2012 23:59, Jeff Garzik wrote:
> On 10/02/2012 03:44 PM, Michael Tokarev wrote:
>> On 02.10.2012 23:40, Jeff Garzik wrote:
>>
>>> Minor libata updates, nothing notable.
>>>
>>> 1) Apply -- and then revert -- the FUA feature.  Caused
>>>     disk corruption in linux-next, proving it cannot be turned on by
>>>     default.
>>
>> Any details on that?  Disk corruprion is rather a nasty
>> side-effect indeed.
> 
> One thread with reports is
> 
>     Storage related regression in linux-next 20120824

Eg, https://lkml.org/lkml/2012/8/27/66 (two reports).
Thank you!

/mjt
