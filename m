From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: CPRM ?? Re: Possibly wrong BIO usage in ide_multwrite
Date: Fri, 2 Jan 2004 23:53:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10401022352031.31033-100000@master.linux-ide.org>
References: <20040102113018.GP5523@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040102113018.GP5523@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Christophe Saout <christophe@saout.de>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Jens,

Cute, so when will it be Jens Axboe <axboe@novell.com>.

When I ask for your opinion I will reach around and wipe for it :-)

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 2 Jan 2004, Jens Axboe wrote:

> On Thu, Jan 01 2004, Andre Hedrick wrote:
> > 
> > Christophe,
> > 
> > I am sorry but adding in a splitter to CPRM is not acceptable.
> > Digital Rights Management in the kernel is not acceptable to me, period.
> > 
> > Maybe I have misread your intent and the contents on your website.
> > 
> > Device-Mappers are one thing, intercepting buffers in the taskfile FSM
> > transport is another.  This stinks of CPRM at this level, regardless of
> > your intent.  Do correct me if I am wrong.
> 
>        0   2   4   6   8   10
>                         /
>                        /
>                       /
>                      /
>                     /
>                    /
>                   /
>            PARANOIA-METER
> 
> -- 
> Jens Axboe
> 
