From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 0/15 v2] ide-atapi: remove pc->buf and misc cleanups
Date: Sat, 16 May 2009 21:23:19 +0200
Message-ID: <20090516192319.GB6202@liondog.tnic>
References: <1242364293-29223-1-git-send-email-petkovbb@gmail.com> <200905162107.38332.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:58420 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879AbZEPTXX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 May 2009 15:23:23 -0400
Content-Disposition: inline
In-Reply-To: <200905162107.38332.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>

Hi,

On Sat, May 16, 2009 at 09:07:38PM +0200, Bartlomiej Zolnierkiewicz wrote:
> I would love to merge it but I'm hitting merge conflicts...
> 
> I can pull tj/block-peek-fetch into for-next but not block/for-2.6.31...
> 
> tj's top commit:
> 
> author	Tejun Heo <tj@kernel.org>
> 	Fri, 8 May 2009 23:45:23 +0000 (08:45 +0900)
> committer	Tejun Heo <tj@kernel.org>
> 	Fri, 8 May 2009 23:45:23 +0000 (08:45 +0900)
> commit	18c551bb4944dec0ce2c0a854b6694ed39ab58f6
> tree	a2a59fd27626e930809a20546c0c02e1df498056
> parent	88fd264e94d01b23339ce614be9141eb2db98e10
> 
> corresponding blocks's commit:
> 
> author	Tejun Heo <tj@kernel.org>
> 	Fri, 8 May 2009 02:54:16 +0000 (11:54 +0900)
> committer	Jens Axboe <jens.axboe@oracle.com>
> 	Mon, 11 May 2009 07:52:18 +0000 (09:52 +0200)
> commit	9934c8c04561413609d2bc38c6b9f268cba774a4
> tree	30dd8f7be54f9b2e03094de9cd03b6a9ee2909cd
> parent	2343046826a8ca426b07601d9593ee046c298b68
> 
> Looking at creation dates I suspect that somewhere along the way
> something was rebased?
> 
> One quick temporary solution would be to recreate bp/pc-remove-buf
> on top of tj/block-peek-fetch...

will do that first thing in the morning and push it for merging.

Thanks.

-- 
Regards/Gruss,
    Boris.
