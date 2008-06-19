From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/02] sata_mv: warn on PIO with multiple DRQs
Date: Thu, 19 Jun 2008 16:23:47 -0400
Message-ID: <485AC053.9040905@rtr.ca>
References: <485933A4.3010409@rtr.ca> <4859340E.60203@rtr.ca> <4859A886.8000509@pobox.com> <4859B9E2.4060909@rtr.ca> <4859FCA4.5000208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2125 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbYFSUXt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jun 2008 16:23:49 -0400
In-Reply-To: <4859FCA4.5000208@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> Mark Lord wrote:
>> In practice, I haven't managed to trigger the issue here,
>> but the errata descriptions indicate that it should be a major
>> issue for any volume of multi-sector PIO commands.
> 
> 
> To be specific:  multi-sector or multi-DRQ?
..

Multi-DRQ.  There's also an 8-sector blocksize limit on READ/WRITE_MULTI.

Cheers
