From: Erik Andersen <andersen@codepoet.org>
Subject: Re: [PATCH] ide-cd mini cleanup of casts (mainly)
Date: Tue, 4 Oct 2005 17:43:24 -0600
Message-ID: <20051004234323.GA7045@codepoet.org>
References: <200510040017.57168.jesper.juhl@gmail.com> <9a8748490510031557q26f41f78s84ad936d9e78756c@mail.gmail.com> <20051004062146.GD3511@suse.de> <200510050019.44256.jesper.juhl@gmail.com>
Reply-To: andersen@codepoet.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from codepoet.org ([166.70.99.138]:42902 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S965051AbVJEAlz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 20:41:55 -0400
Content-Disposition: inline
In-Reply-To: <200510050019.44256.jesper.juhl@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wed Oct 05, 2005 at 12:19:43AM +0200, Jesper Juhl wrote:
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

Revised patch looks ok to me.  I stopped maintaining this
code years ago, but since I was CC'd...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
