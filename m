From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/02] libata: implement ata_eh_wait()
Date: Thu, 08 Jun 2006 23:58:01 -0400
Message-ID: <4488F1C9.7090303@pobox.com>
References: <20060531101932.GA8106@htj.dyndns.org> <20060531102005.GB8106@htj.dyndns.org> <44888D59.9010000@pobox.com> <4488F0C9.7040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38117 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965134AbWFID6D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Jun 2006 23:58:03 -0400
In-Reply-To: <4488F0C9.7040002@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> +    spin_lock_irqsave(&ap->host_set->lock, flags);
>>> +
>>> +    while (ap->flags & (ATA_FLAG_EH_PENDING | 
>>> ATA_FLAG_EH_IN_PROGRESS)) {
>>> +        prepare_to_wait(&ap->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
>>> +        spin_unlock_irqrestore(&ap->host_set->lock, flags);
>>> +        schedule();
>>> +        spin_lock_irqsave(&ap->host_set->lock, flags);

DUH.  Ignore my objection, I read the code incorrectly, thinking it was 
just a simple polling delay, when obviously it is not.

ACK.

	Jeff



