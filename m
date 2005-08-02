From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: Crash in ide_do_request() on card removal
Date: Tue, 02 Aug 2005 15:03:20 +0200
Message-ID: <42EF6F18.4090905@imc-berlin.de>
References: <20050802104859.GG22569@suse.de> <42EF5488.9020802@imc-berlin.de> <20050802111302.GH22569@suse.de> <42EF5651.1040905@imc-berlin.de> <20050802112804.GJ22569@suse.de> <42EF594C.7090902@imc-berlin.de> <20050802113328.GK22569@suse.de> <42EF626B.6090103@imc-berlin.de> <20050802122609.GM22569@suse.de> <42EF69AD.30201@imc-berlin.de> <20050802125437.GA11967@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:48398 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S261509AbVHBNDW
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Aug 2005 09:03:22 -0400
In-Reply-To: <20050802125437.GA11967@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Jens Axboe wrote:

> It's not the right way, it only solves a little part of the problem.
> Killing a request with an error usually looks like this:
> 
> 	blkdev_dequeue_request(rq);
> 	end_that_request_first(rq, 0, rq->hard_nr_sectors);
> 	end_that_request_last(rq);

How do I get the request? do_ide_request() only get the complete request_queue_t 
*q. Shell I use elv_next_request() ?

-- 
Steven
