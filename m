From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Thu, 1 Jan 2004 15:02:09 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10401011456210.32122-100000@master.linux-ide.org>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1072977507.4170.14.camel@leto.cs.pocnet.net>
To: Christophe Saout <christophe@saout.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org


Christophe,

You have to walk either the active or scratch BIO to satitsfy the FSM for
completion of a "DATA_BLOCK".  Where "DATA_BLOCK" is variable in lenght.
Also you may not update or acknowledge the return of any BIOS regardless
until the status of the "DATA_BLOCK" is known.  Status is always checked
after the transfer but you are not permitted to check it then in pio
period (excluding soft-poll completions, unsupported in Linux).  Only
after the next interrupt returns can you querry the status of the previous
"DATA_BLOCK" transfer.  Then and only then can you leave the FSM to deal
with  the needs of BLOCK.

Trust that Bartlomiej gets the point, I spent a long time making sure
somebody did before I burned out.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 1 Jan 2004, Christophe Saout wrote:

> Hi!
> 
> I was just investigating where bio->bi_idx gets modified in the kernel.
> 
> I found these lines in ide-disk.c in ide_multwrite (DMA off, TASKFILE_IO
> off):
> 
> > if (++bio->bi_idx >= bio->bi_vcnt) {
> >     bio->bi_idx = 0;
> >     bio = bio->bi_next;
> > }
> 
> (rq->bio also gets changed but it's protected by the scratch buffer)
> 
> I think changing the bi_idx here is dangerous because
> end_that_request_first needs this value to be unchanged because it
> tracks the progress of the bio processing and updates bi_idx itself.
> 
> And bio->bi_idx = 0 is probably wrong because the bio can be submitted
> with bio->bi_idx > 0 (if the bio was splitted and there are clones that
> share the bio_vec array, like raid or device-mapper code).
> 
> If it really needs to play with bi_idx itself care should be taken to
> reset bi_idx to the original value, not to zero.
> 
> I wasn't able to trigger a problem though, I don't know why exactly,
> perhaps there are paths in __end_that_request_first that are not
> interested in bi_dx. I still think there is something wrong with it.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
