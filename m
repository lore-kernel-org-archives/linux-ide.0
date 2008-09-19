From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4 v2] libata: Implement disk shock protection support
Date: Fri, 19 Sep 2008 05:14:23 -0700
Message-ID: <48D3979F.10305@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local>	<20080917163144.9870.97008.stgit@denkblock.local>	<48D147E2.3020601@gmail.com> <87skrwmpng.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:45330 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbYISMPx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Sep 2008 08:15:53 -0400
Received: by wa-out-1112.google.com with SMTP id j37so314414waf.23
        for <linux-ide@vger.kernel.org>; Fri, 19 Sep 2008 05:15:52 -0700 (PDT)
In-Reply-To: <87skrwmpng.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Elias.

Elias Oltmanns wrote:
>>> +	do {
>>> +		unsigned long now;
>>> +
>>> +		deadline = jiffies;
>>> +		ata_port_for_each_link(link, ap) {
>>> +			ata_link_for_each_dev(dev, link) {
>>> +				struct ata_eh_info *ehi = &link->eh_context.i;
>>> +
>>> +				if (dev->class != ATA_DEV_ATA)
>>> +					continue;
>>> +
>>> +				ata_eh_pull_action(link, dev, ATA_EH_PARK);
>>> +				if (ehi->dev_action[dev->devno] & ATA_EH_PARK) {
>>> +					unsigned long tmp =
>>> +						dev->unpark_deadline;
>>> +
>>> +					if (time_before(deadline, tmp))
>>> +						deadline = tmp;
>>> +					else if (time_before_eq(tmp, jiffies))
>>> +						continue;
>>> +				}
>>> +
>>> +				ata_eh_park_issue_cmd(dev, 1);
>>> +			}
>>> +		}
>>> +		now = jiffies;
>>> +		if (time_before_eq(deadline, now))
>>> +			break;
>>> +		prepare_to_wait(&ata_scsi_park_wq, &wait, TASK_UNINTERRUPTIBLE);
>> Doesn't prepare_to_wait() have to come before pull_action and timeout
>> check?  Which in turn means that it should be a completion instead of
>> wait combined with INIT_COMPLETION because thread state can't be used
>> to track wake up as ata_eh_park_issue_cmd() sleeps.
> 
> Very well spotted, I obviously have to get to know more about these
> things.

Yay, even I am right sometimes.  :-)

> Now, even though I believe that I got the general point you are
> making, I'm not quite sure about what you are saying about wait combined
> with INIT_COMPLETION not being the right thing. In fact, that's
> precisely what I'm going to propose as a solution to our problem. Please
> tell me if I got something fundamentally wrong here.
> 
> The thing grew into a rather more complex problem than I had thought at
> first,

The code itself isn't too bad, I think.

> so I'm just resending the whole patch. Please let me know what
> you think.
> 
> @@ -2830,6 +2878,51 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
>  		}
>  	}
>  
> +	do {
> +		unsigned long now;
> +
> +		ata_eh_pull_park_action(ap);
> +		deadline = jiffies;
> +		ata_port_for_each_link(link, ap) {
> +			ata_link_for_each_dev(dev, link) {
> +				struct ata_eh_context *ehc = &link->eh_context;
> +				unsigned long tmp;
> +
> +				if (dev->class != ATA_DEV_ATA)
> +					continue;
> +				if (!(ehc->i.dev_action[dev->devno] &
> +				      ATA_EH_PARK))
> +					continue;
> +				tmp = dev->unpark_deadline;
> +				if (time_before(deadline, tmp))
> +					deadline = tmp;
> +				else if (time_before_eq(tmp, jiffies))
> +					continue;
> +				if (ehc->unloaded_mask & (1 << dev->devno))
> +					continue;
> +
> +				ata_eh_park_issue_cmd(dev, 1);
> +			}
> +		}
> +
> +		now = jiffies;
> +		if (time_before_eq(deadline, now))
> +			break;
> +
> +		deadline = wait_for_completion_timeout(&ap->park_req_pending,
> +						       deadline - now);
> +	} while (deadline);

This should basically work but completion isn't really designed for
this type of continuous events where single consumption should clear
all pending events.  INIT_COMPLETION comes close but it doesn't lock,
so can't guarantee anything.  What's necessary is the counterpart for
complete_all() for the wait.

Well, anyways, I think the issue is slightly out of scope for this
patch and the only side effect is possibly looping over the do {}
while () block several times unnecessarily on certain cases, so I
think just noting about it should be enough for now.

Can you please add explanation above wait_for_complete_timeout() that
all done counts should be cleared here but aren't and as a result the
loop might repeat determinate number of times unnecessarily and resend
as proper patch?

Thanks for your patience.

-- 
tejun
