From: Jens Axboe <axboe@suse.de>
Subject: Re: Linux 2.5.73 - panic (freed memory) on CD-Recorder errors
Date: Mon, 23 Jun 2003 10:09:12 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030623080912.GA7383@suse.de>
References: <Pine.LNX.4.44.0306230111270.1694-400000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:26303 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264938AbTFWHzN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2003 03:55:13 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306230111270.1694-400000@localhost.localdomain>
List-Id: linux-ide@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jun 23 2003, Pavel Roskin wrote:
> Hello!
> 
> I have been experiencing kernel panics with 2.5.x kernels when writing
> oversized images like Knoppix to low-quality CDs using the IDE driver
> without SCSI emulation.
> 
> Finally I have found a very simple way to reproduce the panic immediately
> and without sacrificing a blank CD.  Just try writing over a recorded disc
> in the dummy mode (i.e. with the laser turned off).
> 
> I have captured the panic on the serial console.  cdrecord was running on
> that terminal as well, so you see the order in which it happened.  The
> kernel .config file and the kernel messages (without serial console being
> active) are attached.
> 
> This panic occurred on Linux 2.5.73, but I remember the same function
> names in the stack trace with older 2.5.x kernels when I was writing
> Knoppix.
> 
> Note 6b6b6b6b in the eax and esi registers and on the stack.  That must be
> freed memory. __end_that_request_first() is a static function in
> drivers/block/ll_rw_blk.c

That doesn't look good. I'll try and reproduce + fix here, thanks for
the report.

-- 
Jens Axboe

