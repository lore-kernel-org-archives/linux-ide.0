From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/02] sata_mv: warn on PIO with multiple DRQs
Date: Wed, 18 Jun 2008 21:56:56 -0400
Message-ID: <4859BCE8.4060408@pobox.com>
References: <485933A4.3010409@rtr.ca> <4859340E.60203@rtr.ca> <4859A886.8000509@pobox.com> <4859B9E2.4060909@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56607 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbYFSB5A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 21:57:00 -0400
In-Reply-To: <4859B9E2.4060909@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> Just about everything can do some form of DMA nowadays,
> but regardless of that the sata_mv chipsets have errata
> for PIO of anything more than a single sector.
> 
> In practice, I haven't managed to trigger the issue here,
> but the errata descriptions indicate that it should be a major
> issue for any volume of multi-sector PIO commands.


I need to review the state of PIO-multi, but IIRC it's not used by default.

We should be able to handle this errata without banning all PIO...

	Jeff



