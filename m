From: Jens Axboe <axboe@suse.de>
Subject: Re: buffer size in the elevator
Date: Mon, 27 Mar 2006 14:25:52 +0200
Message-ID: <20060327122551.GJ8186@suse.de>
References: <5d96567b0603261341g35192532r165ca38ddb8c3a3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:58632 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750960AbWC0MZm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Mar 2006 07:25:42 -0500
Content-Disposition: inline
In-Reply-To: <5d96567b0603261341g35192532r165ca38ddb8c3a3d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sun, Mar 26 2006, Raz Ben-Jehuda(caro) wrote:
> Hello guys.
> first, since there is no mailing lists for the linux elevators i posting
> this mailing lists.
> 
> I am testing the deadline elevator ( 2.6.15 ). i am sending
> buffer sizes of 1M to the target but it seems that buffer no bigger than
> 1/2 MB are reaching the elevator and sometimes page sized buffers.
> 
> Why is that ? Does the bio vector size caueses it?

Hardware inflicted limits, probably. As you don't mention what you are
testing on, one can only guess.

-- 
Jens Axboe

