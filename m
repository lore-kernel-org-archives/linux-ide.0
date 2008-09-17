From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2/4 v2] libata: Implement disk shock protection support
Date: Wed, 17 Sep 2008 11:03:39 -0700
Message-ID: <48D1467B.2070301@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local> <20080917163144.9870.97008.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.184]:62329 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbYIQSGN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 14:06:13 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1856323tic.23
        for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 11:06:11 -0700 (PDT)
In-Reply-To: <20080917163144.9870.97008.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Elias.

Looks generally good.  Just a few points.

Elias Oltmanns wrote:
> +static void ata_eh_pull_action(struct ata_link *link, struct ata_device *dev,
> +			unsigned int action)
> +{
> +	struct ata_port *ap = link->ap;
> +	struct ata_eh_info *ehi = &link->eh_info, *ehci = &link->eh_context.i;
> +	struct ata_device *tdev;
> +	unsigned int taction;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(ap->lock, flags);
> +
> +	if (dev) {
> +		taction = action & (ehi->action | ehi->dev_action[dev->devno]);
> +		ehci->dev_action[dev->devno] |= taction & ATA_EH_PERDEV_MASK;
> +		ehci->action |= taction & ~ATA_EH_PERDEV_MASK;
> +	} else {
> +		if (WARN_ON(action & ATA_EH_PERDEV_MASK))
> +			action &= ~ATA_EH_PERDEV_MASK;
> +		ata_link_for_each_dev(tdev, link)
> +			taction |= ehi->dev_action[tdev->devno] & action;

taction seems to be being used uninitialized.

> +	do {
> +		unsigned long now;
> +
> +		deadline = jiffies;
> +		ata_port_for_each_link(link, ap) {
> +			ata_link_for_each_dev(dev, link) {
> +				struct ata_eh_info *ehi = &link->eh_context.i;
> +
> +				if (dev->class != ATA_DEV_ATA)
> +					continue;
> +
> +				ata_eh_pull_action(link, dev, ATA_EH_PARK);
> +				if (ehi->dev_action[dev->devno] & ATA_EH_PARK) {
> +					unsigned long tmp =
> +						dev->unpark_deadline;
> +
> +					if (time_before(deadline, tmp))
> +						deadline = tmp;
> +					else if (time_before_eq(tmp, jiffies))
> +						continue;
> +				}
> +
> +				ata_eh_park_issue_cmd(dev, 1);
> +			}
> +		}
> +		now = jiffies;
> +		if (time_before_eq(deadline, now))
> +			break;
> +		prepare_to_wait(&ata_scsi_park_wq, &wait, TASK_UNINTERRUPTIBLE);

Doesn't prepare_to_wait() have to come before pull_action and timeout
check?  Which in turn means that it should be a completion instead of
wait combined with INIT_COMPLETION because thread state can't be used
to track wake up as ata_eh_park_issue_cmd() sleeps.

Thanks.  :-)

-- 
tejun
