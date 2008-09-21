From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 2/2 v3] libata: Implement disk shock protection support
Date: Sun, 21 Sep 2008 11:51:56 +0200
Message-ID: <871vzd6d37.fsf@denkblock.local>
References: <87tzcb7r0r.fsf@denkblock.local>
	<20080919214400.7183.64611.stgit@denkblock.local>
	<48D4805A.3090707@kernel.org> <87abe37462.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:39026 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbYIUJwJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Sep 2008 05:52:09 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Elias Oltmanns <eo@nebensachen.de> wrote:
> Tejun Heo <tj@kernel.org> wrote:
[...]
>>> +static ssize_t ata_scsi_park_store(struct device *device,
>>> +				   struct device_attribute *attr,
>>> +				   const char *buf, size_t len)
>>> +{
>> ...
>>> +		complete_all(&ap->park_req_pending);
>>
>> Sorry to catching this this late but calling complete_all() twice will
>> overflow the done counter.  I think complete() should just work here,
>> no?
[...]
> The reason why I'd like to call complete_all() rather than complete() is
> this: if two drives on seperate ports have been parked and userspace
> updates the timeout for one of them, then complete() will only wake up
> the thread that comes first in the wait queue park_req_pending.wait --
> please note that complete() and complete_all() pass different arguments
> to __wake_up_common(). 

What utter nonsense, I can't have been thinking straight here. Since we
have per-port completion structs park_req_pending and since there is
always at most a single EH thread per port, complete() is quite
sufficient. I even remember thinking about all this when I wrote this
code originally. Don't know why I forgot all about it later. Sorry for
causing this confusion and all the noise over the last two days.

I'll repost the exact same patch which you have acked except for the
change from complete_all() back to complete() again.

Thanks for your patience,

Elias
