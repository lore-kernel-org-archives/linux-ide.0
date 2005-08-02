From: Jens Axboe <axboe@suse.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 2 Aug 2005 15:06:48 +0200
Message-ID: <20050802130646.GA7519@suse.de>
References: <20050802111302.GH22569@suse.de> <42EF5651.1040905@imc-berlin.de> <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de> <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de> <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de> <20050802125437.GA11967@suse.de> <42EF6F18.4090905@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:21707 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261472AbVHBNEq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Aug 2005 09:04:46 -0400
Content-Disposition: inline
In-Reply-To: <42EF6F18.4090905@imc-berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

On Tue, Aug 02 2005, Steven Scholz wrote:
> Jens Axboe wrote:
> 
> >It's not the right way, it only solves a little part of the problem.
> >Killing a request with an error usually looks like this:
> >
> >	blkdev_dequeue_request(rq);
> >	end_that_request_first(rq, 0, rq->hard_nr_sectors);
> >	end_that_request_last(rq);
> 
> How do I get the request? do_ide_request() only get the complete 
> request_queue_t *q. Shell I use elv_next_request() ?

Yes.

-- 
Jens Axboe

