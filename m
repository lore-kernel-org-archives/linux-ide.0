From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: 2.6.27-rc1 (2fca5c): libata: kernel cant boot
Date: Fri, 24 Oct 2008 10:44:11 +0200
Message-ID: <873aimv0v8.fsf@denkblock.local>
References: <a4423d670810240004t2d7c3bdah2bea77a6a49bb7c4@mail.gmail.com>
	<20081024070955.GN22217@kernel.dk> <20081024071329.GO22217@kernel.dk>
	<20081024071608.GA3879@linux-sh.org>
	<20081024072428.GP22217@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:36392 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493AbYJXIod (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 04:44:33 -0400
In-Reply-To: <20081024072428.GP22217@kernel.dk> (Jens Axboe's message of "Fri,
	24 Oct 2008 09:24:29 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Alexander Beregalov <a.beregalov@gmail.com>, tj@kernel.org, torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Jens Axboe <jens.axboe@oracle.com> wrote:
> From e598055dde1951c47c8b3522616f6ebff0ed9847 Mon Sep 17 00:00:00 2001
> From: Jens Axboe <jens.axboe@oracle.com>
> Date: Fri, 24 Oct 2008 09:22:42 +0200
> Subject: [PATCH] libata: fix bug with non-ncq devices
>
> The recent commit 201f1b98822078c808b5e2d379a6ddbfc0a06ee1 to enable

Wouldn't that be commit 2fca5ccf97d2c28bcfce44f5b07d85e74e3cd18e?

Regards,

Elias
