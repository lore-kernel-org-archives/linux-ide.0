From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH #upstream] sata_sil24: always set protocol override for
 non-ATAPI data commands
Date: Sat, 22 Aug 2009 11:28:07 -0400
Message-ID: <4A900E87.5060207@rtr.ca>
References: <4A71FE71.7040002@gmail.com> <4A8F88CC.1000406@gmail.com> <4A8FFA9A.2020904@rtr.ca> <4A8FFC8A.1000500@garzik.org> <4A900DE6.2020802@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:53762 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbZHVP2B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 22 Aug 2009 11:28:01 -0400
In-Reply-To: <4A900DE6.2020802@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> On 08/22/2009 10:03 AM, Mark Lord wrote:
..
>>> Hasn't this gone upstream yet??
>>> Heck, it should even go out for -stable, too.
>>
>> It's queued for 2.6.32...  I'd rather be more conservative and get 
>> wider testing before pushing such a fundamental change to sata_sil24 
>> data xfer path upon everyone.
> ..
> 
> Whatever.  It's very well tested (and in continuous use) here on two systems
> with siI-3132 controllers.  So we'll want to hear from users of the 3124
> and 3131/3531 chips for completeness, then.
..

Mmm.. I wonder if something like this patch might also be applicable
to the sata_sil.c driver too?

I've got a couple of those chips around here someplace,
so maybe I'll give that a spin.
