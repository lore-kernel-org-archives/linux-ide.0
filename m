From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: Subject: [PATCH] block: fix __blkdev_get() for removable
	devices
Date: Wed, 5 Nov 2008 10:04:50 +0100
Message-ID: <20081105090449.GA9269@gollum.tnic>
References: <20081029071319.GA9205@gollum.tnic> <20081101201419.GA29462@gollum.tnic> <490F1AC6.8000109@kernel.org> <9ea470500811030956k209b2f2ci10bcde1ea4ac7334@mail.gmail.com> <490FCC87.1070205@kernel.org>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:51751 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbYKEJEv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Nov 2008 04:04:51 -0500
Content-Disposition: inline
In-Reply-To: <490FCC87.1070205@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: axboe@kernel.dk, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 04, 2008 at 01:16:07PM +0900, Tejun Heo wrote:
> Commit 0762b8bde9729f10f8e6249809660ff2ec3ad735 moved disk_get_part()
> in front of recursive get on the whole disk, which caused removable
> devices to try disk_get_part() before rescanning after a new media is
> inserted, which might fail legit open attempts or give the old
> partition.
> 
> This patch fixes the problem by moving disk_get_part() after
> __blkdev_get() on the whole disk.
> 
> This problem was spotted by Borislav Petkov.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: <Borislav Petkov> petkovbb@googlemail.com
> ---
> Borislav, can you please verify this patch?  Thanks.

Yep, it works. Thanks.

Tested-by: Borislav Petkov <petkovbb@gmail.com>

-- 
Regards/Gruss,
    Boris.
