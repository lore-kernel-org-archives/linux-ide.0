From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.27-rc1 (2fca5c): libata: kernel cant boot
Date: Fri, 24 Oct 2008 09:09:56 +0200
Message-ID: <20081024070955.GN22217@kernel.dk>
References: <a4423d670810240004t2d7c3bdah2bea77a6a49bb7c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:51461 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbYJXHK4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 03:10:56 -0400
Content-Disposition: inline
In-Reply-To: <a4423d670810240004t2d7c3bdah2bea77a6a49bb7c4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: tj@kernel.org, torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Fri, Oct 24 2008, Alexander Beregalov wrote:
> Hi
> 
> commit 2fca5ccf97d2c28bcfce44f5b07d85e74e3cd18e
> Author: Jens Axboe <jens.axboe@oracle.com>
> Date:   Wed Oct 22 09:34:49 2008 +0200
> 
>     libata: switch to using block layer tagging support
> 
> 
> This kernel can not read even 0 sector on disk with rootfs. It
> initialized disk, but cant read it at all.
>  CMD646 on Sparc
> 
> Rverting helped.

Doh, how annoying! What driver does that controller use? PATA doesn't
even use NCQ, so it's a bit of an oddity that it makes a difference at
all.

Can you provide the boot messages?

-- 
Jens Axboe

