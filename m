From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv performance; impact of NCQ
Date: Mon, 28 Apr 2008 13:41:13 -0400
Message-ID: <48160C39.6000701@rtr.ca>
References: <20080426001657.GD17369@modernduck.com> <da824cf30804252013l3a62166bk5ef03fb034fd47d5@mail.gmail.com> <20080428171449.GI17369@modernduck.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3452 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936019AbYD1RlL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Apr 2008 13:41:11 -0400
In-Reply-To: <20080428171449.GI17369@modernduck.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jody McIntyre <scjody@sun.com>
Cc: Grant Grundler <grundler@google.com>, linux-ide@vger.kernel.org

Jody McIntyre wrote:
>
> We turn write caching off for data integrity reasons (write reordering
> does bad things to journalling file systems if power is interrupted -
> and at the scale of many Lustre deployments, it happens often enough to
> be a concern.)  I'm also concerned about the effects of NCQ in this area
> so we'll probably turn it off anyway.
..

I haven't done a detailed examination lately, but..

Both write-caching and NCQ re-ordering should be safe on Linux.
The kernel will issue FLUSH_CACHE_EXT commands as required to checkpoint
data to the disk.

Or at least that's how I understood Tejun's last explanation of it.
It is possible that the drive firmware in some brands may not follow
spec for FLUSH_CACHE_EXT, but I don't know of a specific instance of this.

Cheers
