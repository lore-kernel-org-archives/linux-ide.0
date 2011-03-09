From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 04/16] ide: Convert to bdops->check_events()
Date: Wed, 09 Mar 2011 14:17:29 -0800 (PST)
Message-ID: <20110309.141729.35046292.davem@davemloft.net>
References: <1299662016-7721-1-git-send-email-tj@kernel.org>
	<1299662016-7721-5-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38223
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752970Ab1CIWQw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Mar 2011 17:16:52 -0500
In-Reply-To: <1299662016-7721-5-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, kay.sievers@vrfy.org, hch@infradead.org, linux-ide@vger.kernel.org

From: Tejun Heo <tj@kernel.org>
Date: Wed,  9 Mar 2011 10:13:24 +0100

> Convert ->media_changed() to the new ->check_events() method.  The
> conversion is mostly mechanical.  The only notable change is that
> cdrom now doesn't generate any event if @slot_nr isn't CDSL_CURRENT.
> It used to return -EINVAL which would be treated as media changed.  As
> media changer isn't supported anyway, this doesn't make any
> difference.
> 
> This makes ide emit the standard disk events and allows kernel event
> polling.  Currently, only MEDIA_CHANGE event is implemented.  Adding
> support for EJECT_REQUEST shouldn't be difficult; however, given that
> ide driver is already deprecated, it probably is best to leave it
> alone.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Acked-by: Jens Axboe <axboe@kernel.dk>

Acked-by: David S. Miller <davem@davemloft.net>
