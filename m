From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2 v3] libata: Implement disk shock protection support
Date: Fri, 19 Sep 2008 21:47:22 -0700
Message-ID: <48D4805A.3090707@kernel.org>
References: <87tzcb7r0r.fsf@denkblock.local> <20080919214400.7183.64611.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43599 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbYITEvH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Sep 2008 00:51:07 -0400
In-Reply-To: <20080919214400.7183.64611.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello, Elias.

Ah... we're so close but no ack yet.  Just a few nits.

It would be nice if there's explanation why action pulling is
necessary in the first place.

> +static inline void ata_eh_pull_park_action(struct ata_port *ap)
> +{
> +	struct ata_link *link;
> +	struct ata_device *dev;
> +	unsigned long flags;
> +
> +	/*
> +	 * All write accesses to &ap->park_req_pending through
> +	 * INIT_COMPLETION() (see below) or complete_all() (see
> +	 * ata_scsi_park_store()) are protected by the host lock. As a
> +	 * result we have that park_req_pending.done is zero on exit
> +	 * from this function, i.e. when ATA_EH_PARK actions for *all*
> +	 * devices on port ap have been pulled into the respective
> +	 * eh_context structs. If, and only if, park_req_pending.done
> +	 * is non-zero by the time we reach
> +	 * wait_for_completion_timeout(), another ATA_EH_PARK action
> +	 * has been scheduled for at least one of the devices on port
> +	 * ap and we have to cycle over the do { } while () loop in
> +	 * ata_eh_recover() again.
> +	 */
...
> +	do {
> +		unsigned long now;
> +
> +		ata_eh_pull_park_action(ap);

How about adding the folloiwng to the above line?
						/* clears park_req_pending */

> +static ssize_t ata_scsi_park_store(struct device *device,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
...
> +		complete_all(&ap->park_req_pending);

Sorry to catching this this late but calling complete_all() twice will
overflow the done counter.  I think complete() should just work here,
no?

Thanks.

-- 
tejun

