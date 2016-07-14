From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 06/10] libata-eh: decode all taskfile protocols
Date: Thu, 14 Jul 2016 16:08:43 -0700
Message-ID: <20160714230843.GA14093@infradead.org>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
 <1468454751-12466-7-git-send-email-hch@lst.de>
 <20160714144809.GH15005@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36379 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbcGNXIq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2016 19:08:46 -0400
Content-Disposition: inline
In-Reply-To: <20160714144809.GH15005@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

On Thu, Jul 14, 2016 at 10:48:09AM -0400, Tejun Heo wrote:
> On Thu, Jul 14, 2016 at 09:05:47AM +0900, Christoph Hellwig wrote:
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > Some taskfile protocol values where missing in ata_eh_link_report().
> > 
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Applied 5-6 to libata/for-4.8.
> 
> For the rest, I'll wait for the response on 4.

FYI, 8-10 are totally independent of 4.  While 5 kinda depends on 4
to work correctly, but I also don't actually see it in your tree.
