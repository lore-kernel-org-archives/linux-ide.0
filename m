From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/15 v2] ide-atapi: remove pc->buf and misc cleanups
Date: Sun, 17 May 2009 07:08:35 +0900
Message-ID: <4A0F3963.8050000@kernel.org>
References: <1242364293-29223-1-git-send-email-petkovbb@gmail.com> <200905162107.38332.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49976 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754299AbZEPWHU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 May 2009 18:07:20 -0400
In-Reply-To: <200905162107.38332.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Borislav Petkov <petkovbb@googlemail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>

Bartlomiej Zolnierkiewicz wrote:
>> It also got rebased ontop of block/for-2.6.31 after Tejun's stuff got merged.
...
> Looking at creation dates I suspect that somewhere along the way
> something was rebased?
> 
> One quick temporary solution would be to recreate bp/pc-remove-buf
> on top of tj/block-peek-fetch...

Oh.. please use block commit.  Jens didn't pull in my tree but applied
patches on top of the block tree, so my commits shouldn't be in any
official trees.

Thanks.

-- 
tejun
