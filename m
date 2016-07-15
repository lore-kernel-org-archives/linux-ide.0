From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/10] ata: add ata_is_fpdma() accessor
Date: Fri, 15 Jul 2016 09:26:38 +0200
Message-ID: <20160715072637.GA26689@lst.de>
References: <1468454751-12466-1-git-send-email-hch@lst.de> <1468454751-12466-5-git-send-email-hch@lst.de> <20160714143756.GF15005@htj.duckdns.org> <20160715061319.GA22469@lst.de> <08e4196d-b2c8-a4c9-1910-f8e31cab4e93@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:36675 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbcGOH0k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Jul 2016 03:26:40 -0400
Content-Disposition: inline
In-Reply-To: <08e4196d-b2c8-a4c9-1910-f8e31cab4e93@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org

On Fri, Jul 15, 2016 at 09:07:30AM +0200, Hannes Reinecke wrote:
> > Damien and I spent some time going over this patch today and we think
> > it's best to simply drop it.  
> > 
> Sure, fine with me.

Great.  I've verified that the remaining patches will apply and work
fine when simply dropping it.
