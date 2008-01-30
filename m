From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/13] sata_mv ncq Use DMA memory pools for hardware memory
 tables
Date: Wed, 30 Jan 2008 04:54:28 -0500
Message-ID: <47A04954.7010306@pobox.com>
References: <479BC217.60709@rtr.ca> <479BC31D.1050206@rtr.ca> <479F5E1F.8030508@pobox.com> <479F6F40.7040401@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55900 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753042AbYA3Jya (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jan 2008 04:54:30 -0500
In-Reply-To: <479F6F40.7040401@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>> Create host-owned DMA memory pools, for use in allocating/freeing 
>>> per-port
>>> command/response queues and SG tables.  This gives us a way to 
>>> guarantee we
>>> meet the hardware address alignment requirements, and also reduces 
>>> memory that
>>> might otherwise be wasted on alignment gaps.
>>>
>>> Signed-off-by: Mark Lord <mlord@pobox.com>
>>
>> ACK patches 1-13
>>
>> applied patches 1-9 to #upstream.  patch #10 failed, with git-am 
>> reporting it as a corrupt patch.
> ..
> 
> That's weird.  I can save the email from linux-ide here,
> and apply as a patch (after 01-09) with no issues at all.
> 
> Jeff got mail reader problems?
> 
> Here it is again, in case it got corrupted in transit to you.

Nope, not corrupted in transit or on this side.  It falls into a 
familiar pattern:

* git-am(1) fails
* patch(1) succeeds
* when applying patch, patch(1) drops a .orig turd

So while patch(1) succeeds because patch(1) is highly forgiving and 
git-am(1) is more strict, something was definitely strange on that 
incoming email.  patch(1) lets you know by giving you a .orig file, 
something not normally created if the patch operation was 100% sound.

ISTR Linus or Junio explaining why git-am(1) was more strict and why it 
was a good thing... As I did in this case, I usually just run patch(1), 
look carefully at the result using 'git diff HEAD', and then 
commit/resolve the changes.

	Jeff






