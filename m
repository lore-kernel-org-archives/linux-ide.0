From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/5] pata-rb532-cf: replace rb532_pata_finish_io()
Date: Mon, 02 Feb 2009 23:19:37 -0500
Message-ID: <4987C5D9.3020007@garzik.org>
References: <20090127133329.3A3F04CD65@mail.nwl.cc> <20090127133616.8A6C14CD65@mail.nwl.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42543 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbZBCETl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Feb 2009 23:19:41 -0500
In-Reply-To: <20090127133616.8A6C14CD65@mail.nwl.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, florian@openwrt.org

Phil Sutter wrote:
> Since the delay used internally is just the same as ata_sff_pause()
> uses, rb532_pata_finish_io() does exactly the same as ata_sff_pause()
> and thus can be replaced by the later one.
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>

applied 2-5


