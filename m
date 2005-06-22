From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata-dev queue, ATA passthru updated
Date: Wed, 22 Jun 2005 16:33:45 -0400
Message-ID: <42B9CB29.5060303@pobox.com>
References: <42B9C616.9030101@pobox.com> <42B9C886.6010106@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:56239 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262215AbVFVUdv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Jun 2005 16:33:51 -0400
In-Reply-To: <42B9C886.6010106@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brett Russ <russb@emc.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Brett Russ wrote:
> Jeff Garzik wrote:
> 
>>
>> I have updated the 'chs-support' and 'passthru' branches of
>> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>>
>> to be current for the latest kernel.
>>
>> Additionally, I have uploaded the contents of the 'passthru' branch as 
>> a patch, at
>> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.12-git4-passthru1.patch.bz2 
> 
> 
> 
> Wasn't T10 supposed to standardize passthru at the March meeting?  Any 
> idea when this can go mainstream?

Yes, T10 standardized things AFAIK.

However, there are outstanding reports that passthru causes device 
timeouts and other problems.  Investigating those, and a final review of 
the patch are all that's needed before passthru can go upstream.

	Jeff


