From: Mark Lord <liml@rtr.ca>
Subject: Re: libata-passthrough problem.
Date: Sat, 12 Nov 2005 18:40:37 -0500
Message-ID: <43767D75.6090204@rtr.ca>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <4376786F.2090503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:59615 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964880AbVKLXkj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Nov 2005 18:40:39 -0500
In-Reply-To: <4376786F.2090503@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>
> ata_tf_init() in include/linux/libata.h.
> 
> I admit with guilt that I had to search around a bit for it, too :)

Thanks, Jeff.

In that case, the bug with passthru is obvious:

static unsigned int
ata_scsi_pass_thru(struct ata_queued_cmd *qc, const u8 *scsicmd)
{
...
		tf->device = scsicmd[13];    <<--- always forces ATA "master" unit 0
...
		tf->device = scsicmd[13];    <<--- always forces ATA "master" unit 0
...


Those lines should each do this instead:

		tf->device = qc->dev->devno ? (scsicmd[13] |  ATA_DEV1)
					    : (scsicmd[13] & ~ATA_DEV1);

I'll see about a patch for that shortly.

Cheers
