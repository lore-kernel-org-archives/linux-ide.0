From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Another Maxtor drive with broken NCQ
Date: Sat, 07 Jul 2007 10:51:14 -0400
Message-ID: <468FA862.6030701@garzik.org>
References: <468E8DE1.9010405@redhat.com> <468E9360.4070504@garzik.org> <468E9469.4090007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35220 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbXGGOvT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 7 Jul 2007 10:51:19 -0400
In-Reply-To: <468E9469.4090007@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Chuck Ebbert wrote:
> On 07/06/2007 03:09 PM, Jeff Garzik wrote:
>>> {"Maxtor 6B200M0",      "BANC1BM0",     ATA_HORKAGE_NONCQ }
>>>
>>> Or should *all* Maxtor 6B200M0 be blacklisted, since there's already
>>> one of them in the list?
>> Wanna send that as a patch, with attribution and sign-offs?  :)
>>
> 
> For all revisions, or just that one new one?

I don't think all 6B200M0 should be blacklisted, but BANC* is probably 
bad.  I don't think the code can do wildcard matching, so just the one 
revision is probably the best we can do at the moment.

	Jeff



