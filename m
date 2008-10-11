From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/7] ide: locking improvements
Date: Sat, 11 Oct 2008 13:39:44 +0200
Message-ID: <200810111339.44998.bzolnier@gmail.com>
References: <fa.Ke90oacfRjgiI4x5LejzjssRBEg@ifi.uio.no> <fa.8TkQ+xA96EhlNKL9gIbVTxVrcUE@ifi.uio.no> <48F010AB.7010009@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:12424 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbYJKLl4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Oct 2008 07:41:56 -0400
Received: by mu-out-0910.google.com with SMTP id g7so814886muf.1
        for <linux-ide@vger.kernel.org>; Sat, 11 Oct 2008 04:41:54 -0700 (PDT)
In-Reply-To: <48F010AB.7010009@shaw.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 11 October 2008, Robert Hancock wrote:
> Bartlomiej Zolnierkiewicz wrote:
> >> Sorry, but I just have to ask 'why'? IDE is seeing a whole lot of churn
> >> for something that should essentially be a stable code base in
> >> maintenance mode, and now scalability improvements?
> > 
> > It is the stable code but being in "maintenance only mode" has never
> > been true and as long as there are active users & developers there is
> > really no reason to change it.
> 
> Are there really many active users at this point? I'm not aware of any 
> new distributions that are using it. The only people I can see that 
> might still want to be using it would be people with old setups or old 
> embedded devices.. many of those wouldn't be using newer kernels anyway.

Like I said before: as long as there are any active users/developers
there is no real reason to stop IDE improvements (especially since there
is no complete replacement available).

I also wouldn't worry that much about what some distros are doing.  They
are free to make their own decisions based on whatever criteria they like.

> These kinds of changes only will really help scalability on multi-core 
> machines which are unlikely to be using this code anyway.. They seem 

>From my perspective the main gain of these patches is the increased
maintainability and sanity of the code, scalability improvements are
just an added bonus.

> rather like putting makeup on a corpse to me..

Please refrain from such comments.  Not only the metaphor is completely
bogus but it may sound disrespectful to some IDE developers.

Thanks,
Bart
