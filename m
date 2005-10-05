From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ide-cd mini cleanup of casts (mainly)
Date: Wed, 5 Oct 2005 13:34:14 +0200
Message-ID: <20051005113413.GK3511@suse.de>
References: <200510040017.57168.jesper.juhl@gmail.com> <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com> <20051004062146.GD3511@suse.de> <200510050019.44256.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:19789 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965114AbVJELdo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 07:33:44 -0400
Content-Disposition: inline
In-Reply-To: <200510050019.44256.jesper.juhl@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andersen@codepoet.org

On Wed, Oct 05 2005, Jesper Juhl wrote:
> On Tuesday 04 October 2005 08:21, Jens Axboe wrote:
> [snip]
> > This is a mess. So NACK on this patch. And why are you changing the
> [snip]
> 
> Hi Jens,
> 
> Sorry about the messy previous patch.  Would you consider something like the
> one below instead?  It only makes a few changes, not lots of different ones in
> the same patch and it also only makes changes that I hope you'll agree are 
> useful. :)
> 
> 
> Remove some unneeded casts.
> Avoid an assignment in the case of kmalloc failure.
> Break a few instances of  if (foo) whatever;  into two lines.

Looks much better, thanks.

-- 
Jens Axboe

