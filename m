From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fix blk-exec.c compile error: always define  'sysctl_hung_task_timeout_secs'
 (resend)
Date: Sat, 25 Sep 2010 11:18:29 +0200
Message-ID: <4C9DBE65.6040606@kernel.dk>
References: <1285271646-2768-1-git-send-email-vgoyal@redhat.com> <4C9CEFD6.3000106@kernel.dk>  <20100924202106.GC7145@redhat.com> <1285364797.12723.1.camel@corey>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 0122700014.0.fullrate.dk ([95.166.99.235]:49767 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754454Ab0IYJSc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 25 Sep 2010 05:18:32 -0400
In-Reply-To: <1285364797.12723.1.camel@corey>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org, hch@lst.de, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2010-09-24 23:46, Mark Lord wrote:
> Ensure that 'sysctl_hung_task_timeout_secs' is defined
> even when CONFIG_DETECT_HUNG_TASK is not set.
> This way we can safely reference it without need for
> ifdefs in the code elsewhere.  eg. in block/blk-exec.c

Thanks Mark, applied.

-- 
Jens Axboe

