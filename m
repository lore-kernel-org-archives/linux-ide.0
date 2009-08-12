From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] pata_at91: fix resource release
Date: Wed, 12 Aug 2009 06:25:36 -0400
Message-ID: <4A8298A0.2080709@garzik.org>
References: <4A7B8E38.3010300@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52522 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428AbZHLKZn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Aug 2009 06:25:43 -0400
In-Reply-To: <4A7B8E38.3010300@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Sergey Matyukevich <geomatsi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, julia@diku.dk

Tejun Heo wrote:
> Julias Lawall discovered that pata_at91 wasn't freeing a memory region
> allocated with kzalloc() on init failure paths.  Upon review,
> pata_at91 also seems to be doing unnecessary explicit resource
> releases for managed resources too.  Convert memory allocation to
> managed one and drop unnecessary explicit resource releases.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Julia Lawall <julia@diku.dk>
> Cc: Sergey Matyukevich <geomatsi@gmail.com>
> ---
>  drivers/ata/pata_at91.c |   17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)

applied


