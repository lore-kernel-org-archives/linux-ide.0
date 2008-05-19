From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 2/5] libata: consistently use msecs for time durations
Date: Tue, 20 May 2008 00:35:23 +0200
Message-ID: <873aodx6qc.fsf@denkblock.local>
References: <12112174741373-git-send-email-htejun@gmail.com>
	<12112174751988-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:41573 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755466AbYESWfU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 May 2008 18:35:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca

Tejun Heo <htejun@gmail.com> wrote:
> libata has been using mix of jiffies and msecs for time druations.
> This is getting confusing.  As writing sub HZ values in jiffies is
> PITA and msecs_to_jiffies() can't be used as initializer, unify unit
> for all time durations to msecs.  So, durations are in msecs and
> deadlines are in jiffies.  ata_deadline() is added to compute deadline
> from a start time and duration in msecs.
>
> While at it, drop now superflous _msec suffix from arguments and
> rename @timeout to @deadline if it represents a fixed point in time
> rather than duration.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
[...]
> +static inline unsigned long ata_deadline(unsigned long from_jiffies,
> +					 unsigned long timeout_msecs)
							      ^^^^^^
Wouldn't that be against the newly adopted convention? Just a thought.

Regards,

Elias
