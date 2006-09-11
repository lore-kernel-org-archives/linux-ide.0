From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: What's in libata-dev.git
Date: Mon, 11 Sep 2006 18:53:51 -0400
Message-ID: <87f94c370609111553m102cc128tf30058e5fff9e887@mail.gmail.com>
References: <20060911132250.GA5178@havoc.gtf.org> <450566A2.1090009@garzik.org>
	 <450568F3.3020005@ru.mvista.com>
	 <1157986974.23085.147.camel@localhost.localdomain>
	 <45057651.8000404@garzik.org>
	 <1157988513.23085.159.camel@localhost.localdomain>
	 <20060911153706.GE4955@suse.de>
	 <Pine.LNX.4.64.0609110850380.27779@g5.osdl.org>
	 <20060911195106.GA6775@kernel.dk>
	 <1158015636.23085.218.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:5588 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932292AbWIKWxx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Sep 2006 18:53:53 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1368400ugc
        for <linux-ide@vger.kernel.org>; Mon, 11 Sep 2006 15:53:52 -0700 (PDT)
In-Reply-To: <1158015636.23085.218.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>, Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

On 9/11/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-09-11 am 21:51 +0200, ysgrifennodd Jens Axboe:
> > Well, as I said, I don't think we ever saw a case that was demonstrably
> > due to the 256 sector issue. And I really don't think it is as obscure a
> > fact that people seem to think it is.
>
> One of the ones I've got saved here is this thread. Paul goes on to
> demonstrate that changing the 255<->256 limit makes 2.0/2.2/2.4 break or
> not break.
>
<snip>

The whole thread is at http://lkml.org/lkml/2001/3/18/29

Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
