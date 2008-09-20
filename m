From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 2/2 v3] libata: Implement disk shock protection support
Date: Sat, 20 Sep 2008 07:54:45 +0200
Message-ID: <87abe37462.fsf@denkblock.local>
References: <87tzcb7r0r.fsf@denkblock.local>
	<20080919214400.7183.64611.stgit@denkblock.local>
	<48D4805A.3090707@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:41768 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbYITFy4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Sep 2008 01:54:56 -0400
In-Reply-To: <48D4805A.3090707@kernel.org> (Tejun Heo's message of "Fri, 19
	Sep 2008 21:47:22 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Tejun Heo <tj@kernel.org> wrote:
> Hello, Elias.
>
> Ah... we're so close but no ack yet.  Just a few nits.

A pity ;-) but you are quite right.

>
> It would be nice if there's explanation why action pulling is
> necessary in the first place.

Right.

>
>> +static inline void ata_eh_pull_park_action(struct ata_port *ap)
>> +{
>> +	struct ata_link *link;
>> +	struct ata_device *dev;
>> +	unsigned long flags;
>> +
>> +	/*
>> +	 * All write accesses to &ap->park_req_pending through
>> +	 * INIT_COMPLETION() (see below) or complete_all() (see
>> +	 * ata_scsi_park_store()) are protected by the host lock. As a
>> +	 * result we have that park_req_pending.done is zero on exit
>> +	 * from this function, i.e. when ATA_EH_PARK actions for *all*
>> +	 * devices on port ap have been pulled into the respective
>> +	 * eh_context structs. If, and only if, park_req_pending.done
>> +	 * is non-zero by the time we reach
>> +	 * wait_for_completion_timeout(), another ATA_EH_PARK action
>> +	 * has been scheduled for at least one of the devices on port
>> +	 * ap and we have to cycle over the do { } while () loop in
>> +	 * ata_eh_recover() again.
>> +	 */
> ...
>> +	do {
>> +		unsigned long now;
>> +
>> +		ata_eh_pull_park_action(ap);
>
> How about adding the folloiwng to the above line?
> 						/* clears park_req_pending */

Yes. I take it that this is in addition to some explanation within
ata_eh_pull_park_action() you have asked for above?

>
>> +static ssize_t ata_scsi_park_store(struct device *device,
>> +				   struct device_attribute *attr,
>> +				   const char *buf, size_t len)
>> +{
> ...
>> +		complete_all(&ap->park_req_pending);
>
> Sorry to catching this this late but calling complete_all() twice will
> overflow the done counter.  I think complete() should just work here,
> no?

Sorry for missing that in the first place, rather embarrassing that. I
had just assumed that the done counter was set to an absolute value
rather than added to. I really think that this is what we actually want,
so, perhaps, a seperate patch for Ingo or someone is in order?

The reason why I'd like to call complete_all() rather than complete() is
this: if two drives on seperate ports have been parked and userspace
updates the timeout for one of them, then complete() will only wake up
the thread that comes first in the wait queue park_req_pending.wait --
please note that complete() and complete_all() pass different arguments
to __wake_up_common(). 

Regards,

Elias
