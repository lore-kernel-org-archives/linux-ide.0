From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/02] sata_mv: warn on PIO with multiple DRQs
Date: Thu, 19 Jun 2008 02:28:52 -0400
Message-ID: <4859FCA4.5000208@pobox.com>
References: <485933A4.3010409@rtr.ca> <4859340E.60203@rtr.ca> <4859A886.8000509@pobox.com> <4859B9E2.4060909@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42139 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755087AbYFSG24 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jun 2008 02:28:56 -0400
In-Reply-To: <4859B9E2.4060909@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> In practice, I haven't managed to trigger the issue here,
> but the errata descriptions indicate that it should be a major
> issue for any volume of multi-sector PIO commands.


To be specific:  multi-sector or multi-DRQ?

	Jeff


