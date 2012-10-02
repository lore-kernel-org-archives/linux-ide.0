From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [git patches] libata fixes for 3.7
Date: Tue, 02 Oct 2012 15:59:39 -0400
Message-ID: <506B47AB.9020506@pobox.com>
References: <20121002194053.GA11100@havoc.gtf.org> <506B4404.20100@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64340 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2JBT7n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2012 15:59:43 -0400
In-Reply-To: <506B4404.20100@msgid.tls.msk.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 10/02/2012 03:44 PM, Michael Tokarev wrote:
> On 02.10.2012 23:40, Jeff Garzik wrote:
>
>> Minor libata updates, nothing notable.
>>
>> 1) Apply -- and then revert -- the FUA feature.  Caused
>>     disk corruption in linux-next, proving it cannot be turned on by
>>     default.
>
> Any details on that?  Disk corruprion is rather a nasty
> side-effect indeed.

One thread with reports is

	Storage related regression in linux-next 20120824

Regards,

	Jeff



