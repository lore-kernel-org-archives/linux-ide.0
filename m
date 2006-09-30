From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to 1
Date: Sat, 30 Sep 2006 20:04:00 +0200
Message-ID: <20060930180359.GP4163@kernel.dk>
References: <20060930104439.GP25800@htj.dyndns.org> <20060930104500.GQ25800@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:23313 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751342AbWI3R6g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Sep 2006 13:58:36 -0400
Content-Disposition: inline
In-Reply-To: <20060930104500.GQ25800@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, ric@emc.com

On Sat, Sep 30 2006, Tejun Heo wrote:
> Turn off NCQ if queue depth is adjusted to 1.

I had thought of that too but discarded it - it would be nicer to have
an independent way of turning off NCQ. Say you are debugging a weird FIS
issue, NCQ depth 1 is still a different beast to non-NCQ. I see Jeff
already applied the patches, but just thought I'd voice my opinion.

-- 
Jens Axboe

