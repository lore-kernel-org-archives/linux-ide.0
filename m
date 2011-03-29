From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: Commit 7eaceaccab5f40 causing boot hang.
Date: Tue, 29 Mar 2011 08:35:29 +0200
Message-ID: <4D917DB1.9030300@fusionio.com>
References: <4D9179EE.9040707@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D9179EE.9040707@parallels.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rlandley@parallels.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On 2011-03-29 08:19, Rob Landley wrote:
> Using the attached config (run through oldconfig and holding down
> enter), 2.6.38 boots but current -git hangs.  I've bisected it to this
> commit:
> 
> 7eaceaccab5f40bbfda044629a6298616aeaed50 is the first bad commit
> commit 7eaceaccab5f40bbfda044629a6298616aeaed50
> Author: Jens Axboe <jaxboe@fusionio.com>
> Date:   Thu Mar 10 08:52:07 2011 +0100
> 
>     block: remove per-queue plugging
> 
>     Code has been converted over to the new explicit on-stack plugging,
>     and delay users have been converted to use the new API for that.
>     So lets kill off the old plugging along with aops->sync_page().
> 
>     Signed-off-by: Jens Axboe <jaxboe@fusionio.com>
> 
> I suspect it broke CONFIG_IDE_GD_ATA.  (The symptoms change a bit in
> later versions, when that was first introduced it hung right after
> discovering hda, now it makes it to freeing kernel memory and then hangs
> trying to launch init.  But "the disk hangs a lot" still seems to
> describe the problem.)

That is the case even with 9ced0b95b3993660e7990cf6bf68c1a80f31544e,
which was otherwise supposed to fix this queue stall?

-- 
Jens Axboe
