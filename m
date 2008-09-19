From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 2/4 v2] libata: Implement disk shock protection support
Date: Fri, 19 Sep 2008 16:06:40 +0200
Message-ID: <87ljxokz67.fsf@denkblock.local>
References: <87d4j2n3dn.fsf@denkblock.local>
	<20080917163144.9870.97008.stgit@denkblock.local>
	<48D147E2.3020601@gmail.com> <87skrwmpng.fsf@denkblock.local>
	<48D3979F.10305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:33817 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbYISOG5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Sep 2008 10:06:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
> Hello, Elias.
>
> Elias Oltmanns wrote:
[...]
>> so I'm just resending the whole patch. Please let me know what
>> you think.
>> 
>> @@ -2830,6 +2878,51 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>>  		}
>>  	}
>>  
>> +	do {
>> +		unsigned long now;
>> +
>> +		ata_eh_pull_park_action(ap);
>> +		deadline = jiffies;
>> +		ata_port_for_each_link(link, ap) {
>> +			ata_link_for_each_dev(dev, link) {
>> +				struct ata_eh_context *ehc = &link->eh_context;
>> +				unsigned long tmp;
>> +
>> +				if (dev->class != ATA_DEV_ATA)
>> +					continue;
>> +				if (!(ehc->i.dev_action[dev->devno] &
>> +				      ATA_EH_PARK))
>> +					continue;
>> +				tmp = dev->unpark_deadline;
>> +				if (time_before(deadline, tmp))
>> +					deadline = tmp;
>> +				else if (time_before_eq(tmp, jiffies))
>> +					continue;
>> +				if (ehc->unloaded_mask & (1 << dev->devno))
>> +					continue;
>> +
>> +				ata_eh_park_issue_cmd(dev, 1);
>> +			}
>> +		}
>> +
>> +		now = jiffies;
>> +		if (time_before_eq(deadline, now))
>> +			break;
>> +
>> +		deadline = wait_for_completion_timeout(&ap->park_req_pending,
>> +						       deadline - now);
>> +	} while (deadline);
>
> This should basically work but completion isn't really designed for
> this type of continuous events where single consumption should clear
> all pending events.  INIT_COMPLETION comes close but it doesn't lock,
> so can't guarantee anything.  What's necessary is the counterpart for
> complete_all() for the wait.

You are right that it isn't designed for this use case and my approach
is somewhat hackish. Still, it really does exactly what we want. Please
note that ap->park_req_pending is protected by the host lock; the call
to complete() is atomic wrt the setting of ATA_EH_PARK for one of the
devices on the port and so is the call to INIT_COMPLETION() wrt clearing
ATA_EH_PARK requests for *all* devices on the port.

>
> Well, anyways, I think the issue is slightly out of scope for this
> patch and the only side effect is possibly looping over the do {}
> while () block several times unnecessarily on certain cases, so I
> think just noting about it should be enough for now.
>
> Can you please add explanation above wait_for_complete_timeout() that
> all done counts should be cleared here but aren't and as a result the
> loop might repeat determinate number of times unnecessarily and resend
> as proper patch?

Well, we don't really care about the done count after
wait_for_completion_timeout() has returned. All that matters is that the
done counter is cleared when all ATA_EH_PARK actions have been pulled in
which happens at the start of each cycle over the loop.

Perhaps I should add comments to this effect before
wait_for_completion_timeout() as well as INIT_COMPLETION()?

Regards,

Elias
