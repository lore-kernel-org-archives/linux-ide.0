From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 09/10] sata_sil24: don't use NCQ if marvell 4140 PMP is
 attached
Date: Sun, 18 May 2008 17:14:01 -0400
Message-ID: <48309C19.8090807@rtr.ca>
References: <12111273141039-git-send-email-htejun@gmail.com> <12111273202036-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3521 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069AbYERVOF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 May 2008 17:14:05 -0400
In-Reply-To: <12111273202036-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> When 4140 PMP is attached to sil24, NCQ commands to fan out port 1 and
> 2 (0 based) often stall if commands are in progress to other ports.
> I've tried a number of things but can't tell what's going on.  It
> never happens w/ ahci and reportedly sata_mv which can issue NCQ
> commands to multiple devices simultaneously like sil24 does.
..

Mmm.. I wonder if sil24 is somehow triggering the "proprietary switching"
mode of the 4140 -- this mode allows command-based-switching controllers
to actually do something similar to FIS-based switching with the 4140.

But I don't know how the 4140 decides to enter that mode..

I'll ping the Marvell folks again on that.

Cheers
